using UnityEngine;
using UnityEditor;
using PiXYZ.Plugin4Unity;

namespace PiXYZ.Editor {

    internal class PreferencesProvider : SettingsProvider
    {
        public PreferencesProvider(string path, SettingsScope scopes) : base(path, scopes)
        {

        }

        public override void OnGUI(string searchContext)
        {
            // Draw background pixyz transparent logo
            GUI.DrawTexture(new Rect(50, 75, 500, 500), TextureCache.GetTexture("IconPiXYZWatermark"));

            EditorGUIUtility.labelWidth = 260;

            EditorGUILayout.LabelField("Import", EditorStyles.boldLabel);
            GUILayout.Space(5);
            Preferences.AliasExecutable = EditorGUILayout.TextField("Alias Executable (Alias.exe)", Preferences.AliasExecutable);
            Preferences.VREDExecutable = EditorGUILayout.TextField("VRED Executable (VREDPro.exe)", Preferences.VREDExecutable);
            GUILayout.Space(5);
            Preferences.PrefabFolder = EditorGUILayout.TextField("Prefab Save Folder", Preferences.PrefabFolder);
            Preferences.OverridePrefabs = EditorGUILayout.Toggle("Override Prefabs", Preferences.OverridePrefabs);
            Preferences.PrefabDependenciesDestination = (PrefabDependenciesDestination)EditorGUILayout.EnumPopup(new GUIContent("Prefab Dependencies Destination", "It is possible to choose where to save dependencies when creating a prefab of a model imported with PiXYZ. This is useful for very large models or to have more control over dependencies."), Preferences.PrefabDependenciesDestination);
            Preferences.FileDragAndDropInScene = EditorGUILayout.Toggle("File Drag and Drop in Scene", Preferences.FileDragAndDropInScene);
            Preferences.ScriptedImporterBehaviour = (ScriptedImporterBehaviour)EditorGUILayout.EnumPopup(new GUIContent("Import Files in Assets folder", "PiXYZ can import files in the Asset folder. Supported formats are all formats supported by PiXYZ that are not supported by Unity"), Preferences.ScriptedImporterBehaviour);
            GUILayout.Space(5);
            Preferences.UXImprovementStats = EditorGUILayout.Toggle(new GUIContent("UX Improvement Stats", "Enables the PiXYZ PLUGIN for Unity to collect data that will be sent anonymously for UX improvements"), Preferences.UXImprovementStats);
            Preferences.LogImportTime = EditorGUILayout.Toggle("Log Import Time", Preferences.LogImportTime);
            GUILayout.Space(10);

            EditorGUILayout.LabelField("Tools", EditorStyles.boldLabel);
            GUILayout.Space(5);
            Preferences.RightClickInSceneForToolbox = EditorGUILayout.Toggle("Show Toolbox on Right Click in Scene", Preferences.RightClickInSceneForToolbox);
            Preferences.LogTimeWithToolbox = EditorGUILayout.Toggle("Log Toolbox Processing Time", Preferences.LogTimeWithToolbox);
            Preferences.LogTimeWithRuleEngine = EditorGUILayout.Toggle("Log RuleEngine Processing Time", Preferences.LogTimeWithRuleEngine);
            GUILayout.Space(10);

            bool hasTokenUnityRuntime = NativeInterface.IsTokenValid("UnityRuntime");
            EditorGUILayout.LabelField("Include PiXYZ in Builds", EditorStyles.boldLabel);
            Rect rect = GUILayoutUtility.GetLastRect();
            rect.width = rect.height = rect.height + 6;
            rect.y -= 3;
            rect.x = 170;
            GUI.Button(rect, new GUIContent("", "On platforms below, PiXYZ is able to .pxz models at runtime. However, this requires the PiXYZ libraries to be included in the build.\n" +
                "To include librairies for a specific plateform, tick the checkbox for the corresponding platform.\n" +
                "PiXYZ librairies weights about a few hundred megabytes." + (!hasTokenUnityRuntime ? "\nThis feature requires special licensing. Please contact us at sales@pi.xyz for more information" : null)), StaticStyles.IconInfoSmall);
            GUILayout.Space(5);
            EditorGUI.BeginDisabledGroup(!hasTokenUnityRuntime);
            Preferences.IncludeForRuntimeWindows = EditorGUILayout.Toggle("Windows Standalone", Preferences.IncludeForRuntimeWindows);
            EditorGUI.EndDisabledGroup();
            GUILayout.Space(10);

            EditorGUILayout.LabelField("Update", EditorStyles.boldLabel);
            GUILayout.Space(5);
            Preferences.AutomaticUpdate = EditorGUILayout.Toggle("Automatically check for PiXYZ update", Preferences.AutomaticUpdate);
        }
    }

    public enum ScriptedImporterBehaviour
    {
        Never = 0,
        OnlyIfSettings = 1,
        Always = 2,
    }

    public enum PrefabDependenciesDestination
    {
        InPrefab = 0,
        InFolder = 1
    }

    public static class Preferences {

        [SettingsProvider]
        private static SettingsProvider MyNewPrefCode()
        {
            return new PreferencesProvider("Preferences/PiXYZ", SettingsScope.User);
        }

        // Import
        public static string PrefabFolder {
            get { return EditorPrefs.GetString("PiXYZ_PrefabFolder", "3DModels"); }
            set { EditorPrefs.SetString("PiXYZ_PrefabFolder", value); }
        }
        
        public static string AliasExecutable {
            get {
                return EditorPrefs.GetString("PiXYZ_AliasExecutable", "");
            }
            set {
                EditorPrefs.SetString("PiXYZ_AliasExecutable", value);
            }
        }

        public static string VREDExecutable {
            get {
                return EditorPrefs.GetString("PiXYZ_VREDExecutable", @"C:\Program Files\Autodesk\VREDPro-12.0\Bin\WIN64\VREDPro.exe");
            }
            set {
                EditorPrefs.SetString("PiXYZ_VREDExecutable", value);
            }
        }

        public static bool OverridePrefabs {
            get { return EditorPrefs.GetBool("PiXYZ_OverridePrefabs", false); }
            set { EditorPrefs.SetBool("PiXYZ_OverridePrefabs", value); }
        }

        public static bool FileDragAndDropInScene {
            get { return EditorPrefs.GetBool("PiXYZ_EnableFileDragAndDropInScene", true); }
            set { EditorPrefs.SetBool("PiXYZ_EnableFileDragAndDropInScene", value); }
        }

        public static bool LogImportTime {
            get { return EditorPrefs.GetBool("PiXYZ_LogImportTime", false); }
            set { EditorPrefs.SetBool("PiXYZ_LogImportTime", value); }
        }

        public static ScriptedImporterBehaviour ScriptedImporterBehaviour {
            get { return (ScriptedImporterBehaviour)EditorPrefs.GetInt("PiXYZ_ScriptedImporterBehaviour", (int)ScriptedImporterBehaviour.OnlyIfSettings); }
            set { EditorPrefs.SetInt("PiXYZ_ScriptedImporterBehaviour", (int)value); }
        }

        public static PrefabDependenciesDestination PrefabDependenciesDestination {
            get { return (PrefabDependenciesDestination)EditorPrefs.GetInt("PiXYZ_PrefabDependenciesDestination", (int)PrefabDependenciesDestination.InPrefab); }
            set { EditorPrefs.SetInt("PiXYZ_PrefabDependenciesDestination", (int)value); }
        }

        public static bool UXImprovementStats {
            get { return PlayerPrefs.GetInt("PiXYZ_UXImprovementStats", 1) == 1; }
            set {
                if (UXImprovementStats != value) {
                    PlayerPrefs.SetInt("PiXYZ_UXImprovementStats", value ? 1 : 0);
                }
            }
        }

        // Toolbox
        public static bool RightClickInSceneForToolbox {
            get { return EditorPrefs.GetBool("PiXYZ_RightClickInSceneForToolbox", true); }
            set { EditorPrefs.SetBool("PiXYZ_RightClickInSceneForToolbox", value); }
        }

        public static bool LogTimeWithToolbox {
            get { return EditorPrefs.GetBool("PiXYZ_LogTimeWithToolbox", false); }
            set { EditorPrefs.SetBool("PiXYZ_LogTimeWithToolbox", value); }
        }

        // RuleEngine
        public static bool LogTimeWithRuleEngine {
            get { return EditorPrefs.GetBool("PiXYZ_LogTimeWithRuleEngine", false); }
            set { EditorPrefs.SetBool("PiXYZ_LogTimeWithRuleEngine", value); }
        }

        // CheckForUpdate
        public static bool AutomaticUpdate {
            get { return EditorPrefs.GetBool("PiXYZ_AutomaticUpdate", true); }
            set { EditorPrefs.SetBool("PiXYZ_AutomaticUpdate", value); }
        }

        public static bool IncludeForRuntimeWindows {
            get {
                if (!NativeInterface.IsTokenValid("UnityRuntime"))
                    return false;
                return EditorPrefs.GetBool("PiXYZ_IncludeForRuntimeWindows", true);
            }
            set { EditorPrefs.SetBool("PiXYZ_IncludeForRuntimeWindows", value); }
        }
    }
}