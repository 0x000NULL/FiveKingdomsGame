using UnityEngine;
using UnityEditor;
using System.IO;
using System;
using PiXYZ.Tools;
using PiXYZ.Editor;
using PiXYZ.Tools.Editor;
using PiXYZ.Interface;
using PiXYZ.Config;
using PiXYZ.Utils;
using PiXYZ.Plugin4Unity;
using System.Collections;

namespace PiXYZ.Import.Editor {

    /// <summary>
    /// Editor Window for the Import Window
    /// </summary>
    [ExecuteInEditMode]
    public class ImportWindow : SingletonEditorWindow
    {
        public override string WindowTitle => "Import Model in Scene";

        private string _fileToImport = null;
        private ProgressBar _progressBar;
        private bool _isSettingsOpen = true;
        private bool _isPreprocessOpen = true;
        private Vector2 _scrollPosition;
        private UnityEditor.Editor _settingsEditor;
        private Importer _importer;
        private const string DEFAULT_IMPORT_SETTINGS_PATH = "Assets/Plugins/PiXYZ";
        private const string DEFAULT_IMPORT_SETTINGS_NAME = "Default Import Settings";

        private bool isReady => !(string.IsNullOrEmpty(_fileToImport) || !Formats.IsFileSupported(_fileToImport) || !File.Exists(_fileToImport));

        public static void Open(string file)
        {
            var window = EditorExtensions.OpenWindow<ImportWindow>();
            window._fileToImport = file;

            if (Preferences.AutomaticUpdate)
                UpdateWindow.AutoPopup();
        }

        private static bool? _CreatePrefab;
        public static bool CreatePrefab {
            get {
                if (_CreatePrefab == null) {
                    _CreatePrefab = EditorPrefs.GetBool("PiXYZ_CreatePrefab", false);
                }
                return (bool)_CreatePrefab;
            }
            set {
                if (CreatePrefab != value) {
                    _CreatePrefab = value;
                    EditorPrefs.SetBool("PiXYZ_CreatePrefab", value);
                }
            }
        }

        private static ImportSettings _ImportSettings;
        public static ImportSettings ImportSettings {
            get {
                if (_ImportSettings == null) {
                    _ImportSettings = AssetDatabase.LoadAssetAtPath<ImportSettings>(DEFAULT_IMPORT_SETTINGS_PATH + '/' + DEFAULT_IMPORT_SETTINGS_NAME + ".asset");
                    if (_ImportSettings == null) {
                        _ImportSettings = ScriptableObject.CreateInstance<ImportSettings>();
                        _ImportSettings.name = DEFAULT_IMPORT_SETTINGS_NAME;
                        EditorExtensions.SaveAsset(_ImportSettings, DEFAULT_IMPORT_SETTINGS_NAME, false, DEFAULT_IMPORT_SETTINGS_PATH);
                    }
                }
                return _ImportSettings;
            }
            set {
                if (_ImportSettings == value)
                    return;
                _ImportSettings = value;
            }
        }

        void OnEnable()
        {
            setSize();
            titleContent.image = TextureCache.GetTexture("IconBrowse"); // Not working for some reasons ?
        }

        void setSize()
        {
            minSize = new Vector2(430f, 500f);
            maxSize = new Vector2(430f, 1000f);
            //this.SetSize(430, 870);
        }

        public RuleSet RuleSet;

        void OnGUI()
        {
            EditorGUIUtility.labelWidth = 190;

            EditorGUILayout.BeginVertical();

            // DRAW BACKGROUND PIXYZ BACKGROUND
            GUI.DrawTexture(new Rect(position.width - 430, position.height - 430, 500, 500), TextureCache.GetTexture("IconPiXYZWatermark"));

            GUIStyle margin = new GUIStyle { margin = new RectOffset(10, 2, 4, 4) };
            _scrollPosition = EditorGUILayout.BeginScrollView(_scrollPosition);
            {
                var compatibility = Configuration.IsPluginCompatible();
                if (compatibility != Compatibility.COMPATIBLE) {
                    EditorGUILayout.BeginVertical(new GUIStyle { margin = new RectOffset(6, 6, 6, 0) });
                    string message = "";
                    if (compatibility == Compatibility.UNTESTED) {
                        message += $"Your PiXYZ Plugin for Unity version ({Configuration.PiXYZVersion}) hasn't been tested on your Unity version ({Configuration.UnityVersion}).";
                        if (Configuration.UpdateStatus?.newVersionAvailable == true) { // This won't trigger the check itself. If the check was done, it will be skipped.
                            message += "\nHowever, another version of the PiXYZ Plugin for Unity is available online.";
                        }
                    } else {
                        message += $"Your PiXYZ Plugin for Unity version ({Configuration.PiXYZVersion}) is not compatible with your Unity version ({Configuration.UnityVersion}).";
                    }
                    EditorGUILayout.HelpBox(message, MessageType.Warning);
                    EditorGUILayout.EndVertical();
                }

                if (Configuration.CurrentLicense != null && !Configuration.IsFloatingLicense()) {
                    int remainingDays = (Configuration.CurrentLicense.endDate.ToUnityObject() - DateTime.Today).Days;
                    if (remainingDays < 30 && remainingDays > 0) {
                        EditorGUILayout.BeginHorizontal(new GUIStyle { padding = new RectOffset(10, 10, 10, 0) });
                        GUIStyle myStyle = GUI.skin.GetStyle("HelpBox");
                        myStyle.richText = true;

                        EditorGUILayout.HelpBox("Your PiXYZ license will expire in <color=orange>" + remainingDays + " days</color>\nPlease contact us at sales@pi.xyz for renewal.", MessageType.Warning);
                        EditorGUILayout.EndHorizontal();
                    }
                }

                EditorGUILayout.BeginVertical(margin);

                // File Block
                EditorGUIExtensions.DrawCategory(ImportSettingsEditor.Style, "File", () => {
                    EditorGUILayout.BeginHorizontal();
                    _fileToImport = EditorGUILayout.TextField((FilePath)_fileToImport);
                    GUI.SetNextControlName("BrowseButton");
                    if (GUILayout.Button("Browse", UnityEditor.EditorStyles.miniButton, GUILayout.Width(50))) {
                        FilePath file = (FilePath)EditorExtensions.SelectFile(Formats.SupportedFormatsForFileBrowser);
                        if (!String.IsNullOrEmpty(file))
                            _fileToImport = file;
                        GUI.FocusControl("BrowseButton");
                    }
                    EditorGUILayout.EndHorizontal();
                }, "File to import in Unity");

                if (!File.Exists(_fileToImport) || !Formats.IsFileSupported(_fileToImport)) {
                    goto skipUI;
                }

                // Preprocess
                var preprocess = Importer.GetPreprocess(_fileToImport);
                if (preprocess != null) {
                    preprocess.onBeforeDraw(ImportSettings);
                    _isPreprocessOpen = EditorGUIExtensions.DrawCategory(ImportSettingsEditor.Style, preprocess.name, true, () => {
                        if (_isPreprocessOpen)
                            preprocess.fieldInstances.DrawGUILayout();
                    }, "Preprocess to run",
                    _isPreprocessOpen);
                }

                // Settings Block
                _isSettingsOpen = EditorGUIExtensions.DrawCategory(ImportSettingsEditor.Style, "Settings", true, () => {

                    EditorGUILayout.BeginHorizontal();

                    if (!ImportSettings.IsSerialized()) {
                        var newSettings = (ImportSettings)EditorGUILayout.ObjectField("Preset", null, typeof(ImportSettings), false);
                        if (newSettings != null)
                            ImportSettings = newSettings;
                        // Save the preset
                        if (GUILayout.Button("Create", UnityEditor.EditorStyles.miniButton, GUILayout.Width(50))) {
                            EditorExtensions.SaveAsset(ImportSettings, null, true); // Bug relou de naming ici (très mineur)
                        }
                    } else {
                        ImportSettings = (ImportSettings)EditorGUILayout.ObjectField("Preset", ImportSettings, typeof(ImportSettings), false);
                    }
                    EditorGUILayout.EndHorizontal();
                    if (_isSettingsOpen) {
                        // Draw Settings Editor GUI
                        var editor = ImportSettings.GetEditor<ImportSettingsEditor>();
                        editor.drawGUI(Importer.GetSettingsTemplate(_fileToImport));
                        if (_settingsEditor != editor) {
                            _settingsEditor = editor;
                            editor.changed += editorChanged;
                        }
                    }
                }, "Settings are stored in a ImportSettings object. Click create to save the settings below in an ImportSettings file (in the Assets) for later reuse.",
                _isSettingsOpen);

                // Post-Processing Block
                EditorGUIExtensions.DrawCategory(ImportSettingsEditor.Style, "Post-Processing", () => {

                    RuleSet = (RuleSet)EditorGUILayout.ObjectField(new GUIContent("Rules", "If a RuleEngine set of rule (RuleSet) is referenced here, it will be used to automatically process the imported data.\n" +
            "The processing occurs before the prefab creation (if the prefab option is ticked)."), RuleSet, typeof(RuleSet), false);

                    CreatePrefab = EditorGUILayout.Toggle("Create Prefab", CreatePrefab);
                    if (CreatePrefab)
                        EditorGUILayout.HelpBox("This process might take a long time depending on the complexity of the imported model.", MessageType.Warning);
                }, "Post-Processing operations that happen after the file has been importer. Only works in editor mode.");

                skipUI:;

                EditorGUILayout.EndVertical();

                EditorGUILayout.EndScrollView();

                EditorGUIExtensions.DrawLine(1.5f);

                // IMPORT BUTTON
                EditorGUILayout.BeginVertical();
                {
                    GUILayout.Space(46);
                    EditorGUI.BeginDisabledGroup(!isReady);
                    if (GUI.Button(new Rect(position.width / 2 - 100, position.height - 40, 200, 30), "Import")) {
                        OnImportClicked();
                    }
                    EditorGUI.EndDisabledGroup();
                }
                EditorGUILayout.EndVertical();
            }
            EditorGUILayout.EndVertical();
        }

        private void editorChanged()
        {
            Repaint();
        }

        public void OnImportClicked()
        {

            _progressBar = new ProgressBar(true);
            _progressBar.canceled += importCanceled;

            NativeInterface.SetAliasApiDllPath(Preferences.AliasExecutable);
            NativeInterface.SetVREDExecutablePath(Preferences.VREDExecutable);

            _importer = new Importer(_fileToImport, ImportSettings);
            _importer.printMessageOnCompletion = Preferences.LogImportTime;
            _importer.completed += importEnded;
            _importer.progressed += importProgressed;

            _importer.run();

            Close();
        }

        private void importCanceled()
        {
            _importer?.stop();
        }

        private void importEnded(GameObject gameObject)
        {

            if (gameObject == null) {
                Debug.LogError("Import Failed.");
                return;
            }

            Dispatcher.StartCoroutine(runPostProcesses(gameObject));
        }

        private IEnumerator runPostProcesses(GameObject gameObject)
        {
            yield return Dispatcher.DelayFrames(1);

            /// Creating Frozen ImportSettings, with import times.
            ImportStamp importedModel = gameObject.GetComponent<ImportStamp>();

            // Rules
            if (RuleSet != null) {
                _progressBar = new ProgressBar(false);
                try {
                    RuleSet.progressed = delegate { };
                    RuleSet.progressed += rulesProgressed;
                    RuleSet.run();
                } catch (Exception rulesException) {
                    /// An exception has occured in the rules
                    Debug.LogException(rulesException);
                    _progressBar.setProgress(1f, "Failed");
                }
            }

            /// Prefab
            if (CreatePrefab) {
                /// Creating a prefab
                try {
                    importProgressed(0.8f, "Creating prefab...");

                    string path = "Assets/" + Preferences.PrefabFolder + "/" + gameObject.name;
                    var tree = new GameObject[] { gameObject }.GetChildren(true, true);

                    switch (Preferences.PrefabDependenciesDestination) {
                        case PrefabDependenciesDestination.InPrefab:
                            var volatileDependencies = EditorExtensions.GetVolatileDependencies(tree);
                            if (!AssetDatabase.Contains(importedModel.importSettings))
                                CollectionExtensions.Append(ref volatileDependencies, importedModel.importSettings);
                            gameObject = gameObject.CreatePrefab(path, volatileDependencies); 
                            break;
                        case PrefabDependenciesDestination.InFolder:
                            var volatileDependencies2 = EditorExtensions.GetVolatileDependencies(tree);
                            foreach (var dep in volatileDependencies2) {
                                string depPath = path + "/" + dep.name;
                                dep.CreateAsset(depPath);
                            }
                            gameObject = gameObject.CreatePrefab(path, AssetDatabase.Contains(importedModel.importSettings) ? null : new UnityEngine.Object[] { importedModel.importSettings });
                            break;
                    }
                } catch (Exception prefabException) {
                    /// An exception has occured while making prefab
                    importProgressed(1f, "Extraction exception");
                    Debug.LogException(prefabException);
                }
            }

            importProgressed(1f, null);
        }

        private void rulesProgressed(float progress, string message)
        {
            _progressBar.setProgress(progress, message);
        }

        private void importProgressed(float progress, string message)
        {
            _progressBar.setProgress(progress, message);
        }
    }
}