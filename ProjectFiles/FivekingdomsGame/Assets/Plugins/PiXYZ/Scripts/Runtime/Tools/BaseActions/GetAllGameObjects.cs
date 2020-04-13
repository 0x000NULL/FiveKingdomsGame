using System.Collections.Generic;
using UnityEngine;

namespace PiXYZ.Tools.Builtin {

      public class GetAllGameObjects : ActionOut<IList<GameObject>> {

        public override int id => 887274667;
        public override string menuPathRuleEngine => "Get/All GameObjects";
        public override string menuPathToolbox => null;
        public override string tooltip => "Get all GameObjects in the current Scene, at any level.";

        public override IList<GameObject> run() {
            return GameObject.FindObjectsOfType<GameObject>();
        }
    }
}