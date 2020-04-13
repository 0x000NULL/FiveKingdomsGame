using PiXYZ.Tools;
using PiXYZ.Utils;
using UnityEditor;
using PiXYZ.Plugin4Unity;
using PiXYZ.Editor;

namespace PiXYZ.Import.Editor {

    public class PreprocessVRED : SubProcess {

        [InitializeOnLoadMethod]
        private static void Register() {

            // Preprocess
            var preprocess = new PreprocessVRED();

            //preprocess.outputDirectory = "Assets/" + Preferences.PrefabFolder;
            preprocess.initialize();
            Importer.AddOrSetPreprocess(".vpb", preprocess);

            // Settings Template
            var template = ImportSettingsTemplate.Default;
            template.useMaterialsInResources.defaultValue = true;
            template.loadMetadata.defaultValue = true;
            template.isZUp.defaultValue = true;
            template.isLeftHanded.defaultValue = true;
            template.importVariants.defaultValue = true;

            template.importVariants.status = ParameterAvailability.Available;
            template.scaleFactor.status = ParameterAvailability.Available;

            // Don't reorient VRED mesh
            template.repair.defaultValue = false;

            // Hidden parameters
            template.loadMetadata.status = ParameterAvailability.Hidden;
            template.importPatchBorders.status = ParameterAvailability.Hidden;
            template.importLines.status = ParameterAvailability.Hidden;
            template.isZUp.status = ParameterAvailability.Hidden;
            template.importPoints.status = ParameterAvailability.Hidden;
            template.isLeftHanded.status = ParameterAvailability.Hidden;
            template.mergeFinalLevel.status = ParameterAvailability.Hidden;
            template.treeProcess.status = ParameterAvailability.Hidden; 
            template.splitTo16BytesIndex.status = ParameterAvailability.Hidden;
            template.orient.status = ParameterAvailability.Hidden;
            template.hasLODs.status = ParameterAvailability.Hidden;
            template.singularizeSymmetries.status = ParameterAvailability.Hidden;
            template.mapUV.status = ParameterAvailability.Hidden;

            Importer.AddOrSetTemplate(".vpb", template); 
        }

        public bool isIOFieldsVisibleC = true; 
        public bool isIOVisible() => isIOFieldsVisibleC;

        public bool isEnabledC = true; 
        public bool isEnabled() => isEnabledC;

        public bool isVisibleMode(int i) => i < 2;

        [UserParameter(displayName: "Prefer PiXYZ mesh", tooltip: "Override original mesh with PiXYZ tessellation. Will only work if NURBs data is present in the file. Warning: UVs and Vertex Colors will be lost.")]
        public bool preferPiXYZMesh = false;
        [UserParameter(displayName: "Import Variants", tooltip: "Import transform and material variants. Import variant sets.")]
        public bool importVariants = true;
        [UserParameter(displayName: "Import Animations", tooltip: "Import animations. Animation file will be placed in Prefab Save Folder (Edit/Preferences...).")]
        public bool importAnimations = false;
        [UserParameter(displayName: "Smart Merging", tooltip: "Merge model while preserving variant groups and animations.")]
        public bool smartMerging = false;
        [UserParameter(displayName: "Material Mapping Table", tooltip: "Automatically rename materials (including variants) using a .csv material table. Remember to select 'Use Materials in Resources' to automatically assign them from your material library. A third UV size column can be added to automatically map UVs.")]
        [FilterParameter(new string[] { "CSV", "csv" })]
        public FilePath materialMappingTable = default(FilePath);

        public override int id { get { return 582792807;} }
        public override string menuPathRuleEngine { get { return null;} }
        public override string menuPathToolbox { get { return null;} }

        public string pluginName { get { return "PiXYZ_VRED2Unity";} }
        public string functionName { get { return "convertVREDtoUNITY";} }

        public override string name => "Import Settings (.vpb)";

        public override void run(Importer importer) {
            NativeInterface.RunVREDProcess(!preferPiXYZMesh, importVariants, importAnimations, smartMerging, rffs(materialMappingTable));
        }

        private string rffs(string path) {
            return path.Replace("\\", "/");
        }

        bool drawn = false;
        bool tmpImportVariants;
        bool tmpPreferPiXYZMesh;
        public override void onBeforeDraw(ImportSettings importSettings) {
            EditorPrefs.SetString("PiXYZ_VRED_VredPath", Preferences.VREDExecutable);

            if (!drawn) {
                importSettings.useMaterialsInResources = true;
                importSettings.isZUp = false;
                importSettings.isLeftHanded = false;
                drawn = true;

                tmpImportVariants = NativeInterface.GetLoadVariants();
                tmpPreferPiXYZMesh = !NativeInterface.GetPreferLoadMesh();
            }

            if (preferPiXYZMesh != tmpPreferPiXYZMesh) {
                NativeInterface.SetPreferLoadMesh(!preferPiXYZMesh);
                tmpPreferPiXYZMesh = preferPiXYZMesh;
            }

            if (importVariants != tmpImportVariants) {
                NativeInterface.SetLoadVariants(importVariants);
                tmpImportVariants = importVariants;
            }
        }
    }
}