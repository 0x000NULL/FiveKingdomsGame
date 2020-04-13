using PiXYZ.Import;
using PiXYZ.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using PiXYZ.Plugin4Unity;

namespace PiXYZ.Interface {

    public sealed class UnityToSceneExtract
    {
        public NativeInterface.SceneExtract sceneExtract { get; private set; }
        public ImportSettings settings { get; private set; }

        public Dictionary<int, MeshToMeshDefinition> meshes = new Dictionary<int, MeshToMeshDefinition>();
        private Dictionary<int, NativeInterface.MaterialDefinition> _materials = new Dictionary<int, NativeInterface.MaterialDefinition>();
        private List<int> materialRefs = new List<int>();
        private Dictionary<int, NativeInterface.ImageDefinition> images = new Dictionary<int, NativeInterface.ImageDefinition>();
        public LookupTable<int, GameObject> partsRef = new LookupTable<int, GameObject>();
        private List<int> _meshesRefs = new List<int>();
        private bool browseWholeTree;
        private bool manageTextures;

        public UnityToSceneExtract(GameObject root, ImportSettings settings, bool browseWholeTree, bool manageMaterials) {
            this.browseWholeTree = browseWholeTree;
            this.settings = settings;
            this.manageTextures = manageMaterials;
            BuildTree(root);
        }

        public UnityToSceneExtract(GameObject[] gameObjects, ImportSettings settings, bool manageTextures) {
            this.settings = settings;
            this.manageTextures = manageTextures;
            BuildScene(gameObjects);
        }

        private void BuildScene(GameObject[] gameObjects) {

            sceneExtract = new NativeInterface.SceneExtract();

            var tree = new List<int>();
            var partsRefs = new List<int>();
            var names = new List<string>();
            var matrices = new List<NativeInterface.Matrix4>();
            var visibilites = new List<int>();
            var properties = new List<NativeInterface.Properties>();
            var metadata = new List<NativeInterface.Properties>();
            var matricesRef = new List<int>();

            tree.Add(names.Count());
            partsRefs.Add(-1);
            visibilites.Add(1);
            names.Add("Group");
            matricesRef.Add(-1);

            foreach (GameObject gameObject in gameObjects) {

                // Mesh
                MeshFilter mf = gameObject.GetComponent<MeshFilter>();
                partsRefs.Add((mf) ? _meshesRefs.Count : -1);
                ConvertMesh(gameObject, settings);
                tree.Add(names.Count());
                tree.Add(-1);

                // Metadatas
                Metadata[] metadatas = new Metadata[0];
                NativeInterface.Properties data = new NativeInterface.Properties();
                data.names = new NativeInterface.StringList(0);
                data.values = new NativeInterface.StringList(0);
                metadata.Add(data);

                // Visibilities
                visibilites.Add(1);

                // Names
                names.Add(gameObject.GetInstanceID().ToString());

                // Matrices
                matricesRef.Add(matrices.Count);
                matrices.Add(gameObject.transform.ToInterfaceObject(false, !settings.isLeftHanded, settings.isZUp, settings.scaleFactor));
            }

            tree.RemoveAt(tree.Count - 1);

            // Building scene extract
            sceneExtract.tree = new NativeInterface.IntList(tree.ToArray());
            sceneExtract.names = new NativeInterface.StringList(names.ToArray());
            sceneExtract.materialsMode = MaterialExtractMode.PART_ONLY;
            sceneExtract.matrixMode = MatrixExtractMode.GLOBAL;
            sceneExtract.partsRef = new NativeInterface.IntList(partsRefs.ToArray());
            sceneExtract.visibilityMode = VisibilityExtractMode.VISIBLE_ONLY;
            sceneExtract.meshes = new NativeInterface.MeshDefinitionList(meshes.Count());
            sceneExtract.matrices = new NativeInterface.Matrix4List(matrices.ToArray());
            sceneExtract.matricesRef = new NativeInterface.IntList(matricesRef.ToArray());
            sceneExtract.materials = new NativeInterface.MaterialDefinitionList(_materials.Count());
            sceneExtract.visibilities = new NativeInterface.IntList(visibilites.ToArray());
            sceneExtract.metadata = new NativeInterface.PropertiesList(metadata.ToArray());
            sceneExtract.properties = new NativeInterface.PropertiesList(properties.ToArray());
            var matPairs = _materials.ToArray();
            for (int i = 0; i < matPairs.Count(); ++i) {
                sceneExtract.materials[i] = matPairs[i].Value;
                materialRefs = materialRefs.Select(x => x == matPairs[i].Key ? i : x).ToList<int>();
            }
            sceneExtract.materialsRef = new NativeInterface.IntList(materialRefs.ToArray());
            var meshPairs = meshes.ToArray();
            for (int i = 0; i < meshPairs.Count(); ++i) {
                sceneExtract.meshes[i] = meshPairs[i].Value.meshDefinition;
                _meshesRefs = _meshesRefs.Select(x => x == meshPairs[i].Key ? i : x).ToList<int>();
            }
            sceneExtract.meshesRef = new NativeInterface.IntList(_meshesRefs.ToArray());
            sceneExtract.images = new NativeInterface.ImageDefinitionList(images.Values.ToArray());
            Array.Sort(sceneExtract.images.list, delegate (NativeInterface.ImageDefinition img1, NativeInterface.ImageDefinition img2) { return img1.id.CompareTo(img2.id); });
        }

        private void BuildTree(GameObject root) {

            sceneExtract = new NativeInterface.SceneExtract();

            //int id = 0;
            bool endOfBranch = false;
            List<int> tree = new List<int>();
            List<int> childCounts = new List<int>();
            List<int> partsRefs = new List<int>();
            List<string> names = new List<string>();
            List<NativeInterface.Matrix4> matrices = new List<NativeInterface.Matrix4>();
            List<int> visibilites = new List<int>();
            List<NativeInterface.Properties> properties = new List<NativeInterface.Properties>();
            List<NativeInterface.Properties> metadata = new List<NativeInterface.Properties>();
            List<int> matricesRef = new List<int>();

            Stack<GameObject> stack = new Stack<GameObject>(); // LIFO for tree
            stack.Push(root);
            GameObject current = null;
            while (stack.Count != 0)
            {
                if (endOfBranch)
                {
                    tree.Add(-1);

                    if (childCounts.Count() > 0)
                    {
                        childCounts[childCounts.Count() - 1]--;
                        while (childCounts.Last()== 0)
                        {
                            childCounts.RemoveAt(childCounts.Count() - 1);
                            childCounts[childCounts.Count() - 1]--;
                            if (tree.Last() < 0)
                                tree[tree.Count() - 1]--;
                            else
                                tree.Add(-1);
                        }
                    }
                    endOfBranch = false;
                }
                current = stack.Pop();
                MeshFilter mf = current.GetComponent<MeshFilter>();
                partsRefs.Add((mf) ? _meshesRefs.Count : -1);
                ConvertMesh(current, settings);
                tree.Add(names.Count());

                Metadata[] metadatas = current.GetComponents<Metadata>();
                Metadata data = null;
                for (int i = 0; i < metadatas.Length; i++) {
                    data = metadatas[i];
                        metadata.Add(data.getPropertiesNative());
                }
                if (metadatas.Count() < 2)
                {
                    NativeInterface.Properties met = new NativeInterface.Properties();
                    met.names = new NativeInterface.StringList(0);
                    met.values = new NativeInterface.StringList(0);
                    if (metadatas.Count() == 0)
                    {
                        metadata.Add(met);
                    }
                }
                visibilites.Add(1);

                names.Add(current.name);
                if (current.transform.LocalIsIdentity())
                    matricesRef.Add(-1);
                else
                {
                    matricesRef.Add(matrices.Count);
                    matrices.Add(current.transform.ToInterfaceObject(true, !settings.isLeftHanded, settings.isZUp, settings.scaleFactor));
                }
                int childCount = current.transform.childCount;
                if (childCount > 0 && browseWholeTree)
                {
                    childCounts.Add(childCount);
                    for (int childIndex = childCount-1; childIndex >=0 ; --childIndex)
                    {
                        stack.Push(current.transform.GetChild(childIndex).gameObject);
                    }
                }
                else
                {
                    endOfBranch = true;
                }
            }
            sceneExtract.tree = new NativeInterface.IntList(tree.ToArray());
            sceneExtract.names = new NativeInterface.StringList(names.ToArray());
            sceneExtract.materialsMode = MaterialExtractMode.PART_ONLY;
            sceneExtract.matrixMode = MatrixExtractMode.GLOBAL;
            sceneExtract.partsRef = new NativeInterface.IntList(partsRefs.ToArray());
            sceneExtract.visibilityMode = VisibilityExtractMode.VISIBLE_ONLY;
            sceneExtract.meshes = new NativeInterface.MeshDefinitionList(meshes.Count());
            sceneExtract.matrices = new NativeInterface.Matrix4List(matrices.ToArray());
            sceneExtract.matricesRef = new NativeInterface.IntList(matricesRef.ToArray());
            sceneExtract.materials = new NativeInterface.MaterialDefinitionList(_materials.Count());
            sceneExtract.visibilities = new NativeInterface.IntList(visibilites.ToArray());
            sceneExtract.properties = new NativeInterface.PropertiesList(properties.ToArray());
            sceneExtract.metadata = new NativeInterface.PropertiesList(metadata.ToArray());
            var matPairs = _materials.ToArray();
            for (int i = 0; i < matPairs.Count(); ++i)
            {
                sceneExtract.materials[i] = matPairs[i].Value;
                materialRefs = materialRefs.Select(x => x == matPairs[i].Key ? i : x).ToList<int>();
            }
            sceneExtract.materialsRef = new NativeInterface.IntList(materialRefs.ToArray());
            var meshPairs = meshes.ToArray();
            for (int i = 0; i < meshPairs.Count(); ++i)
            {
                sceneExtract.meshes[i] = meshPairs[i].Value.meshDefinition;
                _meshesRefs = _meshesRefs.Select(x => x == meshPairs[i].Key ? i : x).ToList<int>();
            }
            sceneExtract.meshesRef = new NativeInterface.IntList(_meshesRefs.ToArray());
            sceneExtract.images = new NativeInterface.ImageDefinitionList(images.Values.ToArray());
            Array.Sort(sceneExtract.images.list, delegate(NativeInterface.ImageDefinition img1, NativeInterface.ImageDefinition img2) { return img1.id.CompareTo(img2.id); });
        }

        private void ConvertMesh(GameObject gameObject, ImportSettings settings)
        {
            MeshFilter mf = gameObject.GetComponent<MeshFilter>();
            if (!mf)
                return;

            _meshesRefs.Add(mf.sharedMesh.GetInstanceID());
            if (!meshes.ContainsKey(mf.sharedMesh.GetInstanceID()))
            {
                MeshRenderer meshRenderer = gameObject.GetComponent<MeshRenderer>();
                NativeInterface.MaterialDefinition[] matextr = new NativeInterface.MaterialDefinition[meshRenderer.sharedMaterials.Length];
                if (meshRenderer) {
                    // Put materials on submeshes
                    Material[] locmat = meshRenderer.sharedMaterials;
                    materialRefs.Add(-1);
                    for (int m = 0; m < locmat.Length; m++)
                    {
                        if(!_materials.TryGetValue(locmat[m].GetInstanceID(), out matextr[m])) {
                            matextr[m] = manageTextures ? locmat[m].ToNative(ref images) : locmat[m].ToNativeNoTextures();
                            _materials.Add(locmat[m].GetInstanceID(), matextr[m]);
                        }
                    }
                }
                var mc = new MeshToMeshDefinition();
                Dispatcher.StartCoroutine(mc.Convert(mf.sharedMesh, matextr, !settings.isLeftHanded, settings.isZUp, settings.scaleFactor)); // MIRROR, ISZUP, SCALE. HARDCODED? 
                partsRef.Add(mf.sharedMesh.GetInstanceID(), gameObject);   
                meshes.Add(mf.sharedMesh.GetInstanceID(), mc);
            }
            else
            {
                partsRef.Add(mf.sharedMesh.GetInstanceID(), gameObject);
                MeshRenderer mr = gameObject.GetComponent<MeshRenderer>();
                if (mr && mf.sharedMesh.subMeshCount == 1)
                {
                    Material locmat = mr.sharedMaterial;
                    materialRefs.Add(locmat.GetInstanceID());
                    if (!_materials.ContainsKey(locmat.GetInstanceID()))
                    {
                        _materials.Add(locmat.GetInstanceID(), locmat.ToNative(ref images));
                    }
                } else {
                    materialRefs.Add(-1);
                }
            }
        }
    }
}