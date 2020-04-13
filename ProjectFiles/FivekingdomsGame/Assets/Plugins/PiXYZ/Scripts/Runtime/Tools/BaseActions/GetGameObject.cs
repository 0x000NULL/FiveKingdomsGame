using System.Collections.Generic;
using UnityEngine;
using PiXYZ.Config;
using PiXYZ.Utils;

namespace PiXYZ.Tools.Builtin {

      public class GetGameObject : ActionOut<IList<GameObject>> {

        [UserParameter]
        public GameObject gameobject;

        [UserParameter]
        public bool includeWholeHierarchy = true;

        public override int id => 941545872;
        public override string menuPathRuleEngine => "Get/GameObject";
        public override string menuPathToolbox => null;
        public override string tooltip => "Starts with the given scene GameObject. Use 'Include Whole Hierarchy' to also include all of its children.";

        public override IList<GameObject> run() {
            if (!Configuration.CheckLicense())
                throw new NoValidLicenseException();

            if (includeWholeHierarchy) {
                return gameobject.GetChildren(true, true);
            } else {
                return new GameObject[] { gameobject };
            }
        }

        public override string[] getErrors() {
            if (gameobject == null) {
                return new string[] { "You need to specify a GameObject." };
            }
            return null;
        }
    }
}