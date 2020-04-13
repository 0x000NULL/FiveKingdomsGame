using System.Collections.Generic;
using System.IO;
using System.Text;
using UnityEditor;
using UnityEngine;

namespace PiXYZ.Editor {

    [InitializeOnLoad]
    public static class NonPersistentSerializer {

        static NonPersistentSerializer() {
            PrefabUtility.prefabInstanceUpdated += PrefabInstanceUpdated;
        }

        public static void PrefabInstanceUpdated(GameObject gameObject) {

            string path = PrefabUtility.GetPrefabAssetPathOfNearestInstanceRoot(gameObject);
            if (string.IsNullOrEmpty(path))
                return;

            var nonPersistentDependencies = gameObject.GetVolatileDependencies();
            if (nonPersistentDependencies.Length == 0)
                return;

            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.Append("PiXYZ has detected that following objects are not persistent.\nWould you like to make them persistent by saving them in the generated prefab ?\n\n");
            for (int i = 0; i < Mathf.Clamp(nonPersistentDependencies.Length, 0, 5); i++) {
                stringBuilder.Append("- " + nonPersistentDependencies[i] + "\n");
            }
            if (nonPersistentDependencies.Length > 5) {
                stringBuilder.Append($"and {nonPersistentDependencies.Length - 5} other objects\n");
            }
            if (!EditorUtility.DisplayDialog("Non persistent data", stringBuilder.ToString(), "Yes, save these assets", "No"))
                return;

            GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(path);

            switch (Preferences.PrefabDependenciesDestination) {
                case PrefabDependenciesDestination.InPrefab:
                    foreach (var dependency in nonPersistentDependencies) {
                        AssetDatabase.AddObjectToAsset(dependency, prefab);
                    }
                    PrefabUtility.SaveAsPrefabAssetAndConnect(gameObject, path, InteractionMode.AutomatedAction);
                    AssetDatabase.SaveAssets();
                    break;

                case PrefabDependenciesDestination.InFolder:
                    string dir = Path.Combine(Path.GetDirectoryName(path), Path.GetFileNameWithoutExtension(path));
                    foreach (var dependency in nonPersistentDependencies) {
                        string depPath = dir + "/" + dependency.name;
                        dependency.CreateAsset(depPath);
                    }
                    PrefabUtility.SaveAsPrefabAssetAndConnect(gameObject, path, InteractionMode.AutomatedAction);
                    AssetDatabase.SaveAssets();
                    break;
            }
        }
    }
}