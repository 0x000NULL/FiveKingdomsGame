using System.Collections.Generic;
using UnityEngine;
using PiXYZ.Config;

namespace PiXYZ.Tools.Builtin
{

    public class AddCollider : ActionInOut<IList<GameObject>, IList<GameObject>> {

        public enum ColliderType {
            MeshCollider,
            AxisAlignedBoundingBox,
        }

        [UserParameter]
        public ColliderType type = ColliderType.MeshCollider;

        public override int id => 951016102;
        public override string menuPathRuleEngine => "Add/Collider";
        public override string menuPathToolbox => null;
        public override string tooltip => "Adds Colliders to GameObjects (if no collider is present).";

        public override IList<GameObject> run(IList<GameObject> input) {
            if (!Configuration.CheckLicense()) throw new NoValidLicenseException();

            foreach (GameObject gameObject in input) {
                Collider collider = gameObject.GetComponent<Collider>();
                MeshFilter meshFilter = gameObject.GetComponent<MeshFilter>();
                MeshRenderer meshRenderer = gameObject.GetComponent<MeshRenderer>();
                if (collider || !meshFilter || !meshFilter.sharedMesh || !meshRenderer)
                    continue;
                if (type == ColliderType.MeshCollider) {
                    MeshCollider meshCollider = gameObject.AddComponent<MeshCollider>();
                    meshCollider.sharedMesh = meshFilter.sharedMesh;
                } else {
                    BoxCollider boxCollider = gameObject.AddComponent<BoxCollider>();
                    boxCollider.center = meshFilter.sharedMesh.bounds.center;
                    boxCollider.size = meshFilter.sharedMesh.bounds.size;
                }
            }
            return input;
        }
    }
}