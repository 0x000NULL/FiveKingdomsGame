using System.Collections.Generic;
using UnityEngine;
using PiXYZ.Config;
using PiXYZ.Utils;

namespace PiXYZ.Tools.Builtin {

    public class GetChildren : ActionInOut<IList<GameObject>, IList<GameObject>> {

        [UserParameter]
        public bool recursive = true;

        [UserParameter]
        public bool keepParentsInSelection = true;

        public override int id => 925546315;
        public override string menuPathRuleEngine => "Get/Children";
        public override string menuPathToolbox => null;
        public override string tooltip => "Get children of the given GameObjects.\nUser [Resursive] to get children at all levels.\nUse [Keep Parents In Selection] to keep input GameObjects.";

        public override IList<GameObject> run(IList<GameObject> input) {
            if (!Configuration.CheckLicense()) throw new NoValidLicenseException();
            return input.GetChildren(recursive, keepParentsInSelection);
        }
    }
}