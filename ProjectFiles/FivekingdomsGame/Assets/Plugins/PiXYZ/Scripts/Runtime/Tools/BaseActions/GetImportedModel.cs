using PiXYZ.Import;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using PiXYZ.Config;
using PiXYZ.Utils;

namespace PiXYZ.Tools.Builtin {

      public class GetImportedModel : ActionOut<IList<GameObject>> {

        [UserParameter]
        public bool includeWholeHierarchy = true;

        public override int id { get { return 977108498; } }
        public override string menuPathRuleEngine => "Get/Imported Models";
        public override string menuPathToolbox => null;
        public override string tooltip => "Returns Models Imported with PiXYZ"; 

        public override IList<GameObject> run() {
            if (!Configuration.CheckLicense()) throw new NoValidLicenseException();

            HashSet<GameObject> gameObjects = new HashSet<GameObject>();
            foreach (GameObject gameObject in GameObject.FindObjectsOfType<ImportStamp>().Select(x => x.gameObject)) {
                gameObjects.Add(gameObject);
                if (includeWholeHierarchy) {
                    foreach (GameObject child in gameObject.GetChildren(true, false)) {
                        gameObjects.Add(child);
                    }
                }
            }
            return gameObjects.ToArray();
        }
    }
}