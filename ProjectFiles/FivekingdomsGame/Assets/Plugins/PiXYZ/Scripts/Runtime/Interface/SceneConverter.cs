using PiXYZ.Import;
using PiXYZ.Plugin4Unity;
using PiXYZ.Utils;
using System;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace PiXYZ.Interface {

    public sealed class SceneExtractToUnity {

        private const string LOD_NUMBER_ATTR = "PXZ_LOD_No";

        public GameObject gameObject { get; private set; }

        private int _polyCount;
        public int polyCount => _polyCount;

        private int _objectCount;
        public int objectCount => _objectCount;

        private ImportSettings _settings;
        private Dictionary<uint, Material> _uniqueMaterials = new Dictionary<uint, Material>();
        private Dictionary<Color, Material> _uniqueLineColor = new Dictionary<Color, Material>();
        private List<Texture2D> _textures = new List<Texture2D>();
        private LookupTable<int, MeshRenderer> _lods = new LookupTable<int, MeshRenderer>();
        private MeshDefinitionToMesh[] meshDefConverters;

        private VoidHandler _conversionCallback;
        private NativeInterface.SceneExtract _scene;
        private bool _isCompleted = false;
        private bool _isReadyForCompletion = false;
        private bool _isAsynchronous;

        private string _file;
        private int _meshDefConverterProcessedCount = 0;

        public SceneExtractToUnity(NativeInterface.SceneExtract scene, string file, ImportSettings settings, VoidHandler conversionCallback = null, bool isAsynchronous = true) {

            if (scene.matrixMode != MatrixExtractMode.LOCAL)
                throw new Exception("Only LOCAL MatrixExtractMode is supported");
            if (scene.materialsMode != MaterialExtractMode.PART_ONLY)
                throw new Exception("Only PART_ONLY MaterialExtractMode is supported");
            if (scene.visibilityMode != VisibilityExtractMode.VISIBLE_ONLY)
                throw new Exception("Only VISIBLE_ONLY VisibilityExtractMode is supported");

            _settings = settings;
            _scene = scene;
            _conversionCallback = conversionCallback;
            _isAsynchronous = isAsynchronous;
            _file = file;
        }

        public void convert() {
            createTextures(_scene.images);
            createMaterials(_scene.materials);
            createMeshesAsync(_scene.meshes.list);
            createTree(_scene);

            _isReadyForCompletion = true;
            checkCompletion();
        }

        private void meshDefConverterProcessed(MeshDefinitionToMesh meshDefinitionConverter) {
            _meshDefConverterProcessedCount++;
            checkCompletion();
        }

        private void checkCompletion() {
            //Debug.Log("current : " + meshDefConverterProcessedCount + " / total : " + meshDefConverters.Length);
            if (_isReadyForCompletion && !_isCompleted && _meshDefConverterProcessedCount >= meshDefConverters.Length) {
                if (_conversionCallback != null) {
                    _isCompleted = true;
                    _conversionCallback?.Invoke();
                    clear();
                }
            }
            //for (int i = 0; i < meshDefConverters.Length; i++) {
            //    if (meshDefConverters[i]!= null && !meshDefConverters[i].isCompleted) {
            //        Debug.Log($"Not completed submesh:{meshDefConverters[i].subMeshCount} dressed:{meshDefConverters[i].meshDefinition.dressedPolys.Length()} tris:{meshDefConverters[i].meshDefinition.triangles.Length()}");
            //    }
            //}
        }

        private int getLODNumber(NativeInterface.SceneExtract scene, int occurrence) {
            for (int i = 0; i < scene.properties[occurrence].names.length; ++i) {
                if (scene.properties[occurrence].names[i] == LOD_NUMBER_ATTR) {
                    int num = -1;
                    int.TryParse(scene.properties[occurrence].values[i], out num);
                    return num;
                }
            }
            return -1;
        }

        private List<LODGroup> lodGroups = new List<LODGroup>();

        private void createTree(NativeInterface.SceneExtract scene) {
            Transform current = null;
            for (int i = 0; i < scene.tree.length; i++) {

                int treeIndex = scene.tree[i];

                if (treeIndex < 0) { // Leave assembly
                    
                    // Goes levels back in the tree
                    for (int p = 0; p < -treeIndex; ++p) {
                        current = current.parent;
                    }
                } else {
                    int partRef = scene.partsRef[treeIndex];

                    // Creates an object
                    GameObject newGameObject = extractObject(scene, treeIndex);

                    // Set 
                    newGameObject.transform.SetParent(current, scene.matrixMode == MatrixExtractMode.GLOBAL);
                    if (!gameObject) {
                        gameObject = newGameObject; // Set the root gameObject
                    }
                    current = newGameObject.transform;

                    // Check if GameObject name is of type "XXXXXXXXX_LODN"
                    // If that's the case, we register this LOD to a LOD group, on it's parent or on the root object (depending on settings)
                    string[] split = newGameObject.name.Split(new[] { "_LOD" }, StringSplitOptions.None);
                    int lodn;
                    if (split.Length > 1 && int.TryParse(split[split.Length - 1], out lodn)) {
                        Renderer renderer = newGameObject.GetComponent<MeshRenderer>();
                        GameObject lodGroupHolder = (_settings.lodsMode == LodGroupPlacement.ROOT) ? gameObject : current.parent?.gameObject;
                        // If GameObject has a renderer to register as a LOD and if there is a GameObject to register the LOD on, we do it.
                        if (renderer && lodGroupHolder) {
                            LODGroup lodGroup; 
                            lodGroup = lodGroupHolder.GetComponent<LODGroup>();
                            if (!lodGroup) {
                                lodGroup = lodGroupHolder.AddComponent<LODGroup>();
                                lodGroups.Add(lodGroup);
                                lodGroup.SetLODs(new LOD[1]);
                            }
                            var lods = lodGroup.GetLODs();
                            if (lodn > lods.Length - 1) {
                                Array.Resize(ref lods, lodn + 1);
                            }
                            lods[lodn].screenRelativeTransitionHeight = (float)_settings.qualities.lods[lodn].threshold;
                            if (lods[lodn].renderers == null)
                                lods[lodn].renderers = new Renderer[0];
                            CollectionExtensions.Append(ref lods[lodn].renderers, renderer);
                            lodGroup.SetLODs(lods);                           
                        }
                    }
                }
            }

            string filename = Path.GetFileName(_file);
            string extension = Path.GetExtension(filename).ToLower();

            if (extension == ".pxz")
                gameObject.name = filename;
        }

        private GameObject extractObject(NativeInterface.SceneExtract scene, int occurrence) {

            GameObject gameObject = new GameObject(scene.names[occurrence]);

            int partRef = scene.partsRef[occurrence];
            bool isPart = partRef >= 0;

            // Transformation             
            int matrixIndex = scene.matricesRef[occurrence];
            if (matrixIndex != -1) {
                Matrix4x4 matrix = scene.matrices[matrixIndex].ToUnityObject();
                InterfaceExtensions.SetTransformFromMatrix(gameObject.transform, matrix, _settings.scaleFactor, _settings.isZUp, !_settings.isLeftHanded);
            }

            // Geometry
            if (isPart) {
                int meshRef = scene.meshesRef[partRef];
                if (meshDefConverters[meshRef] != null) {
                    MeshDefinitionToMesh meshConverter = meshDefConverters[meshRef];
                    if (meshConverter.mesh != null) {
                        MeshFilter meshFilter = gameObject.AddComponent<MeshFilter>();
                        MeshRenderer meshRenderer = gameObject.AddComponent<MeshRenderer>();
                        meshFilter.sharedMesh = meshConverter.mesh;
                        _polyCount += meshConverter.polyCount;
                        _objectCount++;

                        // Assign materials
                        int matRef = scene.materialsRef[partRef];
                        Material[] materials = new Material[meshConverter.subMeshCount];
                        for (int i = 0; i < materials.Length; ++i) {
                            if (meshConverter.getSubmeshTopology(i) == MeshTopology.Lines) {
                                materials[i] = getLineMaterial(meshConverter.getNativeLineColor(i));
                            } else if (meshConverter.getSubmeshTopology(i) == MeshTopology.Points) {
                                materials[i] = getPointMaterial();
                            } else {
                                materials[i] = getMaterial((matRef < 0) ? meshConverter.getNativeMaterial(i) : scene.materials[matRef].id);
                            }
                        }
                        meshRenderer.sharedMaterials = materials;
                    }
                }
            }

            // Metadata
            if (_settings.loadMetadata) {
                if (scene.metadata[occurrence].names.length > 0) {
                    Metadata metadata = gameObject.AddComponent<Metadata>();
                    metadata.type = "Metadata";
                    metadata.setProperties(scene.metadata[occurrence]);
                }

                if (scene.properties[occurrence].names.length > 0) {
                    Metadata properties = gameObject.AddComponent<Metadata>();
                    properties.type = "Custom Properties";
                    properties.setProperties(scene.properties[occurrence]);
                }
            }
            return gameObject;
        }

        #region Materials

        /// <summary>
        /// Creates all Unity Materials from the Material Extract List
        /// </summary>
        /// <param name="images"></param>
        private void createTextures(NativeInterface.ImageDefinitionList images) {
            foreach (var imageDefinition in images.list) {
                Texture2D texture = imageDefinition.ToUnityObject();
                _textures.Add(texture);
            }
        }

        private Dictionary<string, Material> _materialsInResources;
        private Dictionary<string, Material> materialsInResources {
            get {
                if (_materialsInResources == null) {
                    _materialsInResources = new Dictionary<string, Material>();
                    foreach (var material in Resources.LoadAll<Material>("")) {
                        if (_materialsInResources.ContainsKey(material.name)) {
                            Debug.LogWarning($"There are multiple materials with the name '{material.name}' in your resources.");
                        } else {
                            _materialsInResources.Add(material.name, material);
                        }
                    }
                }
                return _materialsInResources;
            }
        }

        /// <summary>
        /// Creates all Unity Materials from the Material Extract List
        /// </summary>
        /// <param name="materialExtractList"></param>
        private void createMaterials(NativeInterface.MaterialDefinitionList materialExtractList) {

            foreach (var materialExtract in materialExtractList.list) {

                if (!_uniqueMaterials.ContainsKey(materialExtract.id)) {

                    Material material = null;

                    if (_settings.useMaterialsInResources) {
                        materialsInResources.TryGetValue(materialExtract.name, out material);
                    }

                    if (material == null) {
                        material = materialExtract.ToUnityObject(_settings.shader, _textures);
                    }

                    _uniqueMaterials.Add(materialExtract.id, material);
                }
            }
        }

        /// <summary>
        /// Returns a created Unity Material for the given ID
        /// </summary>
        /// <param name="materialId"></param>
        /// <returns></returns>
        private Material getMaterial(uint materialId) {
            Material material;
            if (_uniqueMaterials.TryGetValue(materialId, out material)) {
                return material;
            } else {
                return getDefaultMaterial();
            }
        }

        /// <summary>
        /// Returns a created Unity Material for the given ID
        /// </summary>
        /// <param name="hexaColor"></param>
        /// <returns></returns>
        private Material getLineMaterial(Color color) {
            if (_uniqueLineColor.ContainsKey(color)) {
                return _uniqueLineColor[color];
            } else {
                var shader = Shader.Find("PiXYZ/Simple Lines");
                if (shader == null)
                    throw new Exception("Shader 'PiXYZ/Simple Lines' not found. Make sure it is in your project and included in your build if you are running from a build.");
                Material material = new Material(shader);
                material.name = "Line #" + ColorUtility.ToHtmlStringRGB(color);
                material.color = color;
                _uniqueLineColor.Add(color, material);
                return material;
            }
        }

        private Material _defaultMaterial;
        private Material getDefaultMaterial() {
            if (_defaultMaterial == null) {
                _defaultMaterial = new Material(_settings.shader ?? SceneExtensions.GetDefaultShader());
                _defaultMaterial.name = "DefaultMaterial";
                _defaultMaterial.color = new Color(0.5f, 0.5f, 0.5f, 1f);
                _uniqueMaterials.Add(0, _defaultMaterial);
            }
            return _defaultMaterial;
        }

        private Material _pointMaterial;
        private Material getPointMaterial() {
            if (_pointMaterial == null) {
                var shader = Shader.Find("PiXYZ/Vertex Colors");
                if (shader == null)
                    throw new Exception("Shader 'PiXYZ/Vertex Colors' not found. Make sure it is in your project and included in your build if you are running from a build.");
                _pointMaterial = new Material(shader);
                _pointMaterial.name = "Point Unlit";
            }
            return _pointMaterial;
        }

        #endregion

        #region Meshes

        /// <summary>
        /// Creates all MeshConverters that processes Meshs (threaded) and gather corresponding Materials
        /// </summary>
        /// <param name="tesselationDefinitions"></param>
        /// <param name="withMaterials"></param>
        private void createMeshesAsync(NativeInterface.MeshDefinition[] meshDefinitions) {
            meshDefConverters = new MeshDefinitionToMesh[meshDefinitions.Length];
            for (int i = 0; i < meshDefConverters.Length; i++) {
                // Creates Job (and start processing)
                meshDefConverters[i] = new MeshDefinitionToMesh();
                Dispatcher.StartCoroutine(meshDefConverters[i].Convert(meshDefinitions[i], !_settings.isLeftHanded, _settings.isZUp, _settings.scaleFactor, meshDefConverterProcessed, _isAsynchronous));
                if (meshDefConverters[i].mesh == null)
                    continue;

                meshDefConverters[i].mesh.name = "Mesh_" + (uint)meshDefConverters[i].mesh.GetInstanceID();//i;
            }
        }
        /// <summary>
        /// Creates all MeshDefinitionConverters that processes MeshDefinitions (threaded) and gather corresponding MaterialExtracts
        /// </summary>
        /// <param name="Meshes"></param>
        #endregion

        /// <summary>
        /// Clears all the data for this Scene Extraction
        /// </summary>
        private void clear() {
            foreach (LODGroup lodGroup in lodGroups) {
                lodGroup.RecalculateBounds();
            }
            try {
                NativeInterface.ClearScene();
            } catch (Exception ex) {
                Debug.LogException(ex);
            }
        }
    }
}