using UnityEngine;
using System;

using UnityEditor;
using PiXYZ.Interface;
using PiXYZ.Config;
using PiXYZ.Plugin4Unity;

namespace PiXYZ.Editor
{
    public class AboutWindow : SingletonEditorWindow
    {
        public override string WindowTitle => "About PiXYZ PLUGIN for Unity";

        void OnEnable()
        {
            minSize = new Vector2(400, 400);
            maxSize = new Vector2(400, 400);
        }

        private float _height = 400;

        private void OnGUI()
        {

            GUI.DrawTexture(new Rect(0, 0, 400, 400), TextureCache.GetTexture("PixyzBanner"));

            GUILayout.Space(400);

            Rect rect = EditorGUILayout.BeginVertical();
            {
                ShowLicenseInfos();

                GUILayout.Space(50);

                string pluginVersion = "Plugin version: " + Configuration.PiXYZVersion;
                if (Configuration.IsBetaVersion())
                    pluginVersion += " [BETA]";

                EditorGUILayout.LabelField(pluginVersion, new GUIStyle(EditorStyles.label) { alignment = TextAnchor.MiddleCenter });
                EditorGUIExtensions.DrawHyperlink("Terms & Conditions", Configuration.WebsiteURL + "/general-and-products-terms-and-conditions/", centered: true);
                EditorGUILayout.LabelField("PiXYZ Software solutions are edited by Metaverse Technologies France", new GUIStyle(EditorStyles.miniLabel) { alignment = TextAnchor.MiddleCenter });
            }
            EditorGUILayout.EndVertical();
            float newHeight = rect.height + 400 + 10;
            if (Event.current.type == EventType.Repaint && _height != newHeight) {
                _height = newHeight;
                minSize = new Vector2(400, newHeight);
                maxSize = new Vector2(400, newHeight);
            }
        }

        public static void ShowLicenseInfos()
        {
            EditorGUILayout.BeginVertical("box");
            EditorGUIUtility.labelWidth = 110;

            if (Configuration.CheckLicense()) {
                if (Configuration.IsFloatingLicense()) {
                    EditorGUILayout.LabelField("License Type", "Floating");
                    EditorGUILayout.LabelField("Server Host", Configuration.CurrentLicenseServer.serverAddress);
                    EditorGUILayout.LabelField("Server Port", Configuration.CurrentLicenseServer.serverPort.ToString());
                } else {
                    EditorGUILayout.LabelField("Start Date", Configuration.CurrentLicense.startDate.ToUnityObject().ToString("yyyy-MM-dd"));
                    EditorGUILayout.LabelField("End Date", Configuration.CurrentLicense.endDate.ToEndDateRichText(), EditorGUIExtensions.RichTextStyle);
                    EditorGUILayout.LabelField("Company Name", Configuration.CurrentLicense.customerCompany);
                    EditorGUILayout.LabelField("User Name", Configuration.CurrentLicense.customerName);
                    EditorGUILayout.LabelField("User Email", Configuration.CurrentLicense.customerEmail);
                }
            } else {
                EditorGUILayout.LabelField("There is no valid license installed.");
                if (!string.IsNullOrEmpty(Configuration.GetLastError()))
                    EditorGUILayout.LabelField("Error : " + Configuration.GetLastError(), new GUIStyle(EditorStyles.miniLabel) { wordWrap = true });
                GUILayout.Space(10);
                EditorGUILayout.LabelField("• If you have a license, please install it using the License Manager");
                EditorGUILayout.LabelField("• If you need a license, please visit :");
                EditorGUIExtensions.DrawHyperlink(Configuration.WebsiteURL + "/plugin", Configuration.WebsiteURL + "/plugin/#pricing", centered: true);
            }

            EditorGUILayout.EndVertical();
        }
    }
}