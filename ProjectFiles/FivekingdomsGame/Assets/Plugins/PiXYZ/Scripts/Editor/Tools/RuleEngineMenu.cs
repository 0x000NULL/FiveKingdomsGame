using PiXYZ.Editor;
using UnityEditor;

namespace PiXYZ.Tools.Editor {

    public static class RuleEngineMenu {

        [MenuItem("PiXYZ/RuleEngine/Create New Rule Set", priority = 101)]
        [MenuItem("Assets/Create/PiXYZ/RuleEngine Rule Set", priority = 1)]
        public static void CreateRuleEngineRules() {
            EditorExtensions.CreateAsset<RuleSet>("New Rule Set");
        }

        [MenuItem("PiXYZ/RuleEngine/Create New Custom Action", priority = 102)]
        public static void CreateNewRuleEngineAction() {
            ToolsEditor.CreateNewAction(true, false);
        }
    }
}