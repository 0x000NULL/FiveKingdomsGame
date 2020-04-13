using PiXYZ.Import;
using System;
using System.Collections.Generic;
using UnityEngine;
using PiXYZ.Config;
using PiXYZ.Utils;

namespace PiXYZ.Tools.Builtin
{

    /// <summary>
    /// Get the latest GameObject imported with PiXYZ.\nIt will fail if there isn't at least one model imported with PiXYZ in the current scene.\nUse [Include Whole Hierarchy] to also include all of its children as well (at any level).
    /// </summary>
    public class GetLatestImportedModel : ActionOut<IList<GameObject>> {

        [UserParameter]
        public bool includeWholeHierarchy = true;

        public override int id => 246456413;
        public override string menuPathRuleEngine => "Get/Latest Imported Model";
        public override string menuPathToolbox => null;
        public override string tooltip => "Get the latest GameObject imported with PiXYZ.\nIt will fail if there isn't at least one model imported with PiXYZ in the current scene.\nUse [Include Whole Hierarchy] to also include all of its children as well (at any level).";

        public override IList<GameObject> run() {
            if (!Configuration.CheckLicense())
                throw new NoValidLicenseException();

            if (Importer.LatestModelImportedObject == null) throw new NoValidLicenseException();

            if (includeWholeHierarchy) {
                return Importer.LatestModelImportedObject.gameObject.GetChildren(true, true);
            } else {
                return new GameObject[] { Importer.LatestModelImportedObject.gameObject };
            }
        }
    }
}