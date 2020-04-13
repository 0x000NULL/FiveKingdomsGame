using UnityEngine;
using UnityEditor;
using System;
using PiXYZ.Import.Editor;
using PiXYZ.Import;
using PiXYZ.Config;

namespace PiXYZ.Editor {

    /// <summary>
    /// Toolbar Menu in Unity Editor.
    /// Main access point for the PiXYZ Plugin for Unity.
    /// </summary>
    internal static class Menus {

        [MenuItem("PiXYZ/Import Model", false, 7)]
        private static void ImportCADInScene() {
            string file = null;

            try {
                file = EditorExtensions.SelectFile(Formats.SupportedFormatsForFileBrowser);
            } catch (Exception exception) {
                Debug.LogError(exception);
            }

            if (string.IsNullOrEmpty(file))
                return;

            if (!Formats.IsFileSupported(file)) {
                Debug.LogError("Unsupported file format");
                return;
            }

            ImportWindow.Open(file);
        }

        [MenuItem("PiXYZ/Create Import Settings", false, 9)]
        [MenuItem("Assets/Create/PiXYZ/Import Settings", priority = 1)]
        private static void CreateImportSettingsAsset() {
            EditorExtensions.CreateAsset<ImportSettings>("Import Settings");
        }

        [MenuItem("PiXYZ/Open Plugin Documentation", false, 145)]
        private static void OpenDocumentation() {
            if (Application.internetReachability == NetworkReachability.NotReachable) {
                EditorUtility.DisplayDialog("Information", $"The PiXYZ Documentation webpage can't be reached. Please visit {Configuration.DocumentationURL} for the PiXYZ Plugin for Unity documentation.", "Ok");
            } else {
                Application.OpenURL(Configuration.DocumentationURL);
            }
        }

        [MenuItem("PiXYZ/License Manager", false, 146)]
        private static void OpenLicenseManager() {
            EditorExtensions.OpenWindow<LicensingWindow>();
        }

        [MenuItem("PiXYZ/Check Compatibility", false, 147)]
        private static bool CheckCompatibility() {
            string message;
            var compatibility = Configuration.IsPluginCompatible(out message);
            if (EditorUtility.DisplayDialog("PiXYZ Compatibility Check", message, "See Compatibility", "OK")) {
                Application.OpenURL("https://www.pixyz-software.com/documentations/html/2019.2/plugin4unity/Compatibility.html");
            }
            return compatibility == Compatibility.COMPATIBLE;
        }

        [MenuItem("PiXYZ/Check For Update", false, 148)]
        private static void OpenUpdateWindow() {
            EditorExtensions.OpenWindow<UpdateWindow>();
        }

        [MenuItem("PiXYZ/Support...", false, 200)]
        private static void OpenSupport()
        {
            bool success;
            if (Application.internetReachability == NetworkReachability.NotReachable) {
                success = false;
            } else {
                try {
                    Application.OpenURL("https://pixyzsoftware.freshdesk.com/support/solutions/folders/43000555618");
                    success = true;
                } catch {
                    success = false;
                }
            }
            if (!success) {
                EditorUtility.DisplayDialog("Information", $"The PiXYZ Support webpage can't be reached. Please visit {Configuration.WebsiteURL} and go to the support category.", "Ok");
            }
        }

        [MenuItem("PiXYZ/About PiXYZ...", false, 201)]
        private static void OpenAboutWindow() {
            EditorExtensions.OpenWindow<AboutWindow>();
        }
    }
}