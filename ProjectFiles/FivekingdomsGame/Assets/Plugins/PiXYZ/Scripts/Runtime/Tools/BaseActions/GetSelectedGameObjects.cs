using System.Collections.Generic;
using UnityEngine;

namespace PiXYZ.Tools.Builtin
{
    public class GetSelectedGameObjects : ActionOut<IList<GameObject>> {

        public override int id => 64811152;
        public override string menuPathRuleEngine => "Get/Selected GameObjects";
        public override string menuPathToolbox => null;
        public override string tooltip => "Get GameObjects selected in the Unity Editor";

        public override IList<GameObject> run() {
#if UNITY_EDITOR
            return UnityEditor.Selection.gameObjects;
#else
            return new GameObject[0];
#endif
        }
    }
}