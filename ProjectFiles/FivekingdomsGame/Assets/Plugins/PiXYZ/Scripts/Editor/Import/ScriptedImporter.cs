using UnityEngine;
using PiXYZ.Tools;
using UnityEditor;
using PiXYZ.Editor;
using PiXYZ.Utils;
using UnityImporters = UnityEditor.Experimental.AssetImporters;
using System.Collections;
using PiXYZ.Config;

namespace PiXYZ.Import.Editor {

    public class ScriptedImporterAttribute : UnityImporters.ScriptedImporterAttribute
    {
        public static string[] SupportedFormats {
            get {
                switch (Preferences.ScriptedImporterBehaviour) {
                    case ScriptedImporterBehaviour.Always:
                    case ScriptedImporterBehaviour.OnlyIfSettings:
                        return Formats.SupportedFormatsScriptedImporter;
                    case ScriptedImporterBehaviour.Never:
                    default:
                        return new string[0];
                }
            }
        }

        public ScriptedImporterAttribute() : base(1, SupportedFormats) {
           
        }
    }

    [ScriptedImporter]
    public class ScriptedImporter : UnityImporters.ScriptedImporter {

        public string file { get; private set; }

        public ImportSettings importSettings;
        public RuleSet rules;

        private UnityImporters.AssetImportContext _context;

        public override void OnImportAsset(UnityImporters.AssetImportContext context) {

            if (!Configuration.CheckLicense()) {
                Debug.LogWarning($"A PiXYZ license is required to import '{context.assetPath}'");
                return;
            }

            // Context is deleted after. Keep some references.
            file = context.assetPath;
            _context = context;

            if (importSettings == null) {
                if (Preferences.ScriptedImporterBehaviour == ScriptedImporterBehaviour.Always) {
                    Debug.LogWarning($"No ImportSettings were specified for file '{context.assetPath}'." +
                        $"Default ImportSettings are used." +
                        $"The behaviour can be changed under 'Preferences > PiXYZ > Import Files in Assets folder'.");
                    importSettings = ImportWindow.ImportSettings;
                } else {
                    Debug.LogWarning($"No ImportSettings were specified for file '{context.assetPath}'." +
                        $"You need to assign ImportSettings to import it." +
                        $"The behaviour can be changed under 'Preferences > PiXYZ > Import Files in Assets folder'.");
                    return;
                }
            }

            Selection.objects = new Object[0];

            Importer importer = new Importer(context.assetPath, importSettings);
            importer.printMessageOnCompletion = Preferences.LogImportTime;
            importer.isAsynchronous = false; // The ScriptedImporter doesn't seems to work with Async stuff. As soon as it gets out of OnImportAsset, context reference is lost.
            importer.completed += importEnded;
            importer.progressed += importProgressed;
            importer.run();
        }

        private void importEnded(GameObject gameObject) {

            try {
                if (rules != null) {
                    rules.progressed = delegate { };
                    rules.progressed += rulesProgressed;
                    rules.run();
                }
            } catch(System.Exception exception) {
                Debug.LogException(exception);
            }

            EditorUtility.ClearProgressBar();

            // Names have to be unique to avoid warnings...
            // Now we mimick Unity's fbx scripted importer behavior
            var uniqueNames = new System.Collections.Generic.HashSet<string>();
            string GetUniqueName(string guid)
            {
                int i = 1;
                string currentGuid = guid;
                while (!uniqueNames.Add(currentGuid)) {
                    currentGuid = guid + ' ' + i;
                    i++;
                }
                return currentGuid;
            }

            // ScriptedImporter-only. This is mandatory to avoid warnings.
            foreach (GameObject go in gameObject.GetChildren(true, true)) {
                go.name = GetUniqueName(go.name);
            }

            _context.AddObjectToAsset(gameObject.name, gameObject, Resources.Load<Texture2D>("PiXYZPrefabModel"));
            _context.SetMainObject(gameObject);

            ImportStamp stamp = gameObject.GetComponent<ImportStamp>();
            _context.AddObjectToAsset("importStamp", stamp);
            _context.AddObjectToAsset("importSettings", stamp.importSettings);

            Object[] volatileDependencies = EditorExtensions.GetVolatileDependencies(gameObject);
            foreach (Object dependency in volatileDependencies) {
                _context.AddObjectToAsset(GetUniqueName(dependency.name), dependency);
            }

            // We refresh the selection. Such operation must be done over multiple frames.
            Dispatcher.StartCoroutine(RefreshSelection(_context.assetPath));
        }

        private IEnumerator RefreshSelection(string assetPath)
        {
            yield return Dispatcher.DelayFrames(1);
            Selection.objects = new Object[0];
            yield return Dispatcher.DelayFrames(2);
            Selection.activeObject = AssetDatabase.LoadAssetAtPath<UnityEngine.Object>(assetPath);
        }

        private void importProgressed(float progress, string message) {
            if (progress >= 1f)
                EditorUtility.ClearProgressBar();
            else
                EditorUtility.DisplayProgressBar("Importing", message, progress);
        }

        private void rulesProgressed(float progress, string message) {
            if (progress >= 1f)
                EditorUtility.ClearProgressBar();
            else
                EditorUtility.DisplayProgressBar("Rule Engine", message, progress);
        }
    }
}