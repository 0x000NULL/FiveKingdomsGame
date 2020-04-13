using PiXYZ.Editor;
using PiXYZ.Tools;
using UnityEditor;
using UnityEngine;
using UnityImporters = UnityEditor.Experimental.AssetImporters;

namespace PiXYZ.Import.Editor {

    [CustomEditor(typeof(ScriptedImporter), true, isFallback = false)]
    public class ScriptedImporterEditor : UnityImporters.AssetImporterEditor
    {
        private ScriptedImporter importer => target as ScriptedImporter;
        private bool _isSettingsOpen = true;
        private bool _isDirty = false;

        public override void OnInspectorGUI() {

            // Settings
            _isSettingsOpen = EditorGUIExtensions.DrawCategory(ImportSettingsEditor.Style, "Settings", true, () => {
                var prevImportSettings = importer.importSettings;
                importer.importSettings = (ImportSettings)EditorGUILayout.ObjectField("Preset", importer.importSettings, typeof(ImportSettings), false);
                if (!_isDirty && importer.importSettings != prevImportSettings)
                    _isDirty = true;
                if (_isSettingsOpen) {
                    ImportSettingsEditor settingsEditor = importer.importSettings.GetEditor<ImportSettingsEditor>();
                    settingsEditor?.drawGUI(Importer.GetSettingsTemplate(importer.file));
                    if (!_isDirty && settingsEditor != null && settingsEditor.isChangedInLastFrame)
                        _isDirty = true;
                }
            }, "",
            _isSettingsOpen);

            // Rules
            EditorGUIExtensions.DrawCategory(ImportSettingsEditor.Style, "Post-Processing", true, () => {
                importer.rules = (RuleSet)EditorGUILayout.ObjectField("Rules", importer.rules, typeof(RuleSet), false);
            }, "");

            // Mandatory !!!
            EditorUtility.SetDirty(target);
            serializedObject.ApplyModifiedPropertiesWithoutUndo();

            EditorGUILayout.BeginHorizontal();
            GUILayout.FlexibleSpace();
            bool reimportClicked = GUILayout.Button("Reimport", GUILayout.Height(18), GUILayout.Width(100));
            if (reimportClicked) {
                AssetDatabase.WriteImportSettingsIfDirty(importer.file);
                ApplyAndImport();
                // Refresh selection pour eviter les erreurs
                //ActiveEditorTracker.sharedTracker.ForceRebuild(); // Marche pas
                Selection.objects = new Object[] { AssetDatabase.LoadAssetAtPath<Object>(importer.assetPath) };
            }
            EditorGUILayout.EndHorizontal();

            EditorGUI.EndDisabledGroup();
        }

        public override bool HasModified() {
            return _isDirty;
        }

        protected override void ResetValues() {

        }

        protected override void Apply() {
            _isDirty = false;
            base.Apply();
        }

        public override bool HasPreviewGUI() {
            return true;
            //return base.HasPreviewGUI();
        }

        public override void DrawPreview(Rect previewArea) {
            //EditorGUILayout.LabelField("NO");
            base.DrawPreview(previewArea);
        }

        public override void OnPreviewGUI(Rect r, GUIStyle background) {
            base.OnPreviewGUI(r, background);
        }

        public override Texture2D RenderStaticPreview(string assetPath, UnityEngine.Object[] subAssets, int width, int height) {
            return base.RenderStaticPreview(assetPath, subAssets, width, height);
        }
    }
}