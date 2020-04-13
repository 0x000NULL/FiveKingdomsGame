﻿using System.Collections.Generic;
using UnityEngine;
using PiXYZ.Config;

namespace PiXYZ.Tools.Builtin
{

    public class SetTag : ActionInOut<IList<GameObject>, IList<GameObject>> {

        [UserParameter]
        public string tagName;

        public override int id => 16465110;
        public override string menuPathRuleEngine => "Set/Tag";
        public override string menuPathToolbox => null;
        public override string tooltip => "Set GameObjects' tag";

        public override IList<GameObject> run(IList<GameObject> input) {
            if (!Configuration.CheckLicense()) throw new NoValidLicenseException();

#if UNITY_EDITOR
            var tags = PiXYZ.Editor.ReferencableEditorUtils.GetTags();
            if (!tags.Contains(tagName))
                PiXYZ.Editor.ReferencableEditorUtils.AddTag(tagName);
#endif

            for (int i = 0; i < input.Count; i++) {
                input[i].tag = tagName;
            }
            return input;
        }
    }
}