using UnityEngine;
using System;
using UnityEditor;
using PiXYZ.Interface;
using PiXYZ.Config;
using System.Linq;

namespace PiXYZ.Editor {

    /// <summary>
    /// Licensing Window.
    /// </summary>
    public class LicensingWindow : SingletonEditorWindow {

        public override string WindowTitle => "PiXYZ License Manager";

        private string _username = "";
        private string _password = "";
        private int _selectedTab = 0;

        private bool _doRequest = false;
        private bool _doRelease = false;

        private int _licenseIndex = 0;

        private string _address = null;
        private int _port = 64990;
        private bool _flexLM = false;
        private Vector2 _scrollViewPosition = new Vector2(0, 0);

        private void OnEnable() {
            minSize = new Vector2(450, 250);
            if (String.IsNullOrEmpty(_address) || _address == "127.0.0.1") {
                _address = (Configuration.CurrentLicenseServer != null) ? Configuration.CurrentLicenseServer.serverAddress : "127.0.0.1";
                _port = (Configuration.CurrentLicenseServer != null) ? Configuration.CurrentLicenseServer.serverPort : 64990;
                _flexLM = (Configuration.CurrentLicenseServer != null) ? Configuration.CurrentLicenseServer.useFlexLM : false;
            }
        }

        private void OnGUI() {

            GUILayout.Space(10);
            EditorGUILayout.BeginHorizontal();
            GUILayout.FlexibleSpace();
            string[] titles = { "Current License", "Online", "Offline", "License Server", "Tokens" };
            _selectedTab = GUILayout.Toolbar(_selectedTab, titles, "LargeButton", GUI.ToolbarButtonSize.FitToContents);
            GUILayout.FlexibleSpace();
            EditorGUILayout.EndHorizontal();

            GUILayout.Space(10);
            EditorGUIExtensions.DrawLine(1.5f);

            GUIStyle style = new GUIStyle();
            _scrollViewPosition = GUILayout.BeginScrollView(_scrollViewPosition, GUILayout.MaxHeight(Screen.height - 30));
            style.margin = new RectOffset(10, 10, 10, 10);
            EditorGUILayout.BeginVertical(style);
            switch (_selectedTab) {
                case 0:
                    drawCurrentLicense();
                    break;
                case 1:
                    if (!Configuration.IsConnectedToWebServer())
                        drawLogin();
                    else
                        drawOnline();
                    break;
                case 2:
                    drawOffline();
                    break;
                case 3:
                    drawLicenseServer();
                    break;
                case 4:
                    drawTokens();
                    break;
            }
            EditorGUILayout.EndVertical();
            GUILayout.EndScrollView();

            // Outer calls
            if (_doRelease) {
                _doRelease = false;
                if (Configuration.ReleaseWebLicense(Configuration.Licenses[_licenseIndex]))
                    EditorUtility.DisplayDialog("Release Complete", "The license release has been completed.", "Ok");
                else
                    EditorUtility.DisplayDialog("Release Failed", "An error has occured while releasing the license: " + Configuration.GetLastError(), "Ok");
                Configuration.RefreshAvailableLicenses();
            } else if (_doRequest) {
                _doRequest = false;
                if (Configuration.RequestWebLicense(Configuration.Licenses[_licenseIndex]))
                    EditorUtility.DisplayDialog("Installation Complete", "The license installation has been completed.", "Ok");
                else
                    EditorUtility.DisplayDialog("Installation Failed", "An error occured while installing the license: " + Configuration.GetLastError(), "Ok");
                Configuration.RefreshAvailableLicenses();
            }
        }

        private void drawCurrentLicense() {
            AboutWindow.ShowLicenseInfos();
        }

        private void drawOnline() {

            var licenses = Configuration.Licenses.list.Where(x => x.validity.ToUnityObject() > DateTime.UtcNow).ToArray();
            int lastIndex = _licenseIndex;

            string[] formattedLicenses = new string[licenses.Length];
            for (int i = 0; i < licenses.Length; ++i) {
                formattedLicenses[i] = licenses[i].product + "  [" + licenses[i].validity.ToUnityObject().ToString("yyyy-MM-dd") + "]";
                if (licenses[i].onMachine) {
                    formattedLicenses[i] += "  (current)";
                }
            }

            EditorGUILayout.LabelField("Logged as", EditorStyles.boldLabel);
            EditorGUILayout.LabelField("Username", Configuration.Username);
            EditorGUILayout.BeginHorizontal();
            GUILayout.FlexibleSpace();
            bool logout = GUILayout.Button("Logout", GUILayout.Height(18), GUILayout.Width(80));
            EditorGUILayout.EndHorizontal();
            GUILayout.Space(10);

            if (logout) {
                _password = null;
                Configuration.DisconnectFromWebServer();
                return;
            }

            if (formattedLicenses.Length == 0) {
                EditorGUILayout.HelpBox("There are no licenses available in your account.\nTo get a trial or purchase a license, please go to the PiXYZ website : ", MessageType.Warning);
                EditorGUIExtensions.DrawHyperlink(Configuration.WebsiteURL + "/login", Configuration.WebsiteURL + "/login");
                return;
            }

            EditorGUILayout.LabelField("Licenses", EditorStyles.boldLabel);
            GUILayout.BeginHorizontal();
            var style = new GUIStyle(EditorStyles.popup);
            style.fixedHeight = 18;
            _licenseIndex = EditorGUILayout.Popup(_licenseIndex, formattedLicenses, style);
            GUILayout.Space(8);
            if (GUILayout.Button("Refresh", GUILayout.Height(18), GUILayout.Width(80))) {
                Configuration.RefreshAvailableLicenses();
            }
            GUILayout.EndHorizontal();

            if (lastIndex != _licenseIndex) {
                // Another license was selected. We go out the force a redraw.
                return;
            }

            GUILayout.Space(5);

            if (_licenseIndex < formattedLicenses.Length) {
                EditorGUILayout.BeginVertical("box");
                EditorStyles.label.richText = true;
                EditorGUILayout.LabelField("Product Name", licenses[_licenseIndex].product);
                EditorGUILayout.LabelField("Valid Until", licenses[_licenseIndex].validity.ToEndDateRichText());
                EditorGUILayout.LabelField("License Uses", "" + (int)licenses[_licenseIndex].inUse + " / " + (int)licenses[_licenseIndex].count);
                EditorGUILayout.LabelField("Currently Installed", licenses[_licenseIndex].onMachine ? "On this machine" : (licenses[_licenseIndex].inUse == 1 ? "On another machine" : "Not installed"));
                GUI.skin.label.richText = false;
                EditorGUILayout.EndVertical();
            } else {
                _licenseIndex = formattedLicenses.Length - 1;
                return;
            }

            GUILayout.Space(5);

            EditorGUILayout.BeginHorizontal();
            GUILayout.FlexibleSpace();
            if (GUILayout.Button(licenses[_licenseIndex].onMachine ? "Reinstall" : "Install", GUILayout.Height(18), GUILayout.Width(80))) {
                _doRequest = true;
            }

            if (licenses[_licenseIndex].onMachine && licenses[_licenseIndex].current) {
                GUILayout.Space(8);
                if (GUILayout.Button("Release", GUILayout.Height(18), GUILayout.Width(80))) {
                    if (EditorUtility.DisplayDialog("Warning", "Release (or uninstall) current license lets you install it on another computer. This action is available only once.\n\nAre you sure you want to release this license ?", "Yes", "No")) {
                        //Unity don't like calls to precompiled function while in layout
                        // => delayed call to outside of layouts
                        _doRelease = true;
                    }
                }
            }
            EditorGUILayout.EndHorizontal();
        }

        private void drawOffline() {

            GUILayout.FlexibleSpace();
            GUILayout.Label("Generate an activation code and upload it on PiXYZ website");
            if (GUILayout.Button("Generate Activation Code")) {
                var path = EditorUtility.SaveFilePanel(
                     "Save activation code",
                     "",
                     "PiXYZ_activationCode.bin",
                     "Binary file;*.bin");

                if (Configuration.GenerateActivationCode(path))
                    EditorUtility.DisplayDialog("Generation Succeed", "The activation code has been successfully generated.", "Ok");
                else
                    EditorUtility.DisplayDialog("Generation Failed", "An error occured while generating the file: " + Configuration.GetLastError(), "Ok");
            }
            GUILayout.FlexibleSpace();
            GUILayout.Label("Install a New License");
            if (GUILayout.Button("Install License")) {
                var path = EditorUtility.OpenFilePanel(
                        "Open installation code (*.bin) or license file (*.lic)",
                        "",
                        "Install file;*.bin;*.lic");
                if (Configuration.InstallActivationCode(path))
                    EditorUtility.DisplayDialog("Installation Succeed", "The installation code has been installed.", "Ok");
                else
                    EditorUtility.DisplayDialog("Installation Failed", "An error occured while installing: " + Configuration.GetLastError(), "Ok");
            }
            GUILayout.FlexibleSpace();
            GUILayout.Label("Generate a release code and upload it on PiXYZ website");
            if (GUILayout.Button("Generate Release Code")) {
                if (EditorUtility.DisplayDialog("Warning", "Release (or uninstall) current license lets you install it on another computer. This action is available only once.\n\nAre you sure you want to release this license ?", "Yes", "No")) {
                    var path = EditorUtility.SaveFilePanel(
                     "Save release code as BIN",
                     "",
                     "PiXYZ_releaseCode.bin",
                     "Binary file;*.bin");

                    if (Configuration.GenerateDeactivationCode(path))
                        EditorUtility.DisplayDialog("Generation Succeed", "The release code has been successfully generated.", "Ok");
                    else
                        EditorUtility.DisplayDialog("Generation Failed", "An error occured while generating the file: " + Configuration.GetLastError(), "Ok");
                }
            }
            GUILayout.FlexibleSpace();
        }

        private string serverError;

        private void drawLicenseServer() {

            _address = EditorGUILayout.TextField("Address", _address);
            GUILayout.Space(5);
            _port = EditorGUILayout.IntField("Port", _port);
            GUILayout.Space(5);
            _flexLM = EditorGUILayout.Toggle("Use FlexLM", _flexLM);
            GUILayout.Space(10);

            //bool enabled = (Configuration.CurrentLicenseServer != null && ((_address != Configuration.CurrentLicenseServer.serverAddress) // Or if the current license server address if different than address above
            //    || (_port != Configuration.CurrentLicenseServer.serverPort) // Or if port is different
            //    || (_flexLM != Configuration.CurrentLicenseServer.useFlexLM))); // Or if now we stop or begin using FlexLM

            EditorGUI.BeginDisabledGroup(false);
            if (GUILayout.Button("Connect")) {
                if (Configuration.ConfigureLicenseServer(_address, (ushort)_port, _flexLM)) {
                    serverError = null;
                    EditorUtility.DisplayDialog("Success", "License server has been successfuly configured", "OK");
                }
                else {
                    serverError = Configuration.GetLastError();
                }
            }
            EditorGUI.EndDisabledGroup();

            if (!string.IsNullOrEmpty(serverError)) {
                EditorGUILayout.HelpBox("Server Configuration Error : " + serverError, MessageType.Error);
            }
        }

        private static GUIStyle tokenStyleValid;
        private static GUIStyle TokenStyleValid {
            get {
                if (tokenStyleValid == null) {
                    tokenStyleValid = new GUIStyle();
                    tokenStyleValid.normal.textColor = Color.white;
                    tokenStyleValid.normal.SetHiResBackground("PiXYZBlank", new Color(0.1f, 0.6f, 0.1f));
                    tokenStyleValid.margin = new RectOffset(8, 8, 8, 8);
                    tokenStyleValid.padding = new RectOffset(6, 6, 2, 2);
                    tokenStyleValid.alignment = TextAnchor.MiddleCenter;
                    tokenStyleValid.fontStyle = FontStyle.Bold;
                }
                return tokenStyleValid;
            }
        }

        private static GUIStyle tokenStyleNotValid;
        private static GUIStyle TokenStyleNotValid {
            get {
                if (tokenStyleNotValid == null) {
                    tokenStyleNotValid = new GUIStyle(TokenStyleValid);
                    tokenStyleNotValid.normal.SetHiResBackground("PiXYZBlank", new Color(0.6f, 0.1f, 0.1f));
                }
                return tokenStyleNotValid;
            }
        }

        private static GUIStyle tokenStyleMandatory;
        private static GUIStyle TokenStyleMandatory {
            get {
                if (tokenStyleMandatory == null) {
                    tokenStyleMandatory = new GUIStyle(TokenStyleValid);
                    tokenStyleMandatory.normal.SetHiResBackground("PiXYZBlank", new Color(0.1f, 0.1f, 0.6f));
                }
                return tokenStyleMandatory;
            }
        }

        private void drawTokens() {

            if (!Configuration.CheckLicense()) {
                EditorGUILayout.BeginVertical("box");
                EditorGUILayout.LabelField("There is no valid license installed.");
                EditorGUILayout.LabelField("An valid license must be installed to display the tokens list.");
                if (!string.IsNullOrEmpty(Configuration.GetLastError()))
                    EditorGUILayout.LabelField("Error : " + Configuration.GetLastError(), new GUIStyle(EditorStyles.miniLabel) { wordWrap = true });
                EditorGUILayout.EndVertical();
                return;
            }

            EditorGUILayout.BeginHorizontal();
            float stackedWidth = 0;
            float sideMargins = (TokenStyleValid.margin.left) * 2;

            for (int t = 0; t < Configuration.Tokens.Length; t++) {

                Token token = Configuration.Tokens[t];
                var content = new GUIContent(token.name);
                Vector2 size = TokenStyleValid.CalcSize(content);

                if (stackedWidth + size.x + sideMargins > position.width) {
                    stackedWidth = 0;
                    EditorGUILayout.EndHorizontal();
                    EditorGUILayout.BeginHorizontal();
                }

                GUILayout.Label(content, token.mandatory ? TokenStyleMandatory : (token.valid ? TokenStyleValid : TokenStyleNotValid), GUILayout.Width(size.x));
                stackedWidth += size.x + sideMargins;
            }

            EditorGUILayout.EndHorizontal();
        }

        private string loginError;

        private void drawLogin() {

            _username = EditorGUILayout.TextField("Username", _username);
            GUILayout.Space(5);
            _password = EditorGUILayout.PasswordField("Password", _password);
            GUILayout.Space(10);

            bool keyboardShortcutPressed = Event.current.isKey &&
                 (Event.current.keyCode == KeyCode.KeypadEnter || Event.current.keyCode == KeyCode.Return);

            EditorGUI.BeginDisabledGroup(string.IsNullOrEmpty(_username) || string.IsNullOrEmpty(_password));
            if (keyboardShortcutPressed || GUILayout.Button("Connect")) {
                if (Configuration.ConnectToWebServer(_username, _password)) {
                    loginError = null;
                } else {
                    loginError = Configuration.GetLastError();
                }
                Repaint();
            }
            EditorGUI.EndDisabledGroup();

            if (!string.IsNullOrEmpty(loginError)) {
                EditorGUILayout.HelpBox("Login Error : " + loginError, MessageType.Error);
            }
        }
    }
}