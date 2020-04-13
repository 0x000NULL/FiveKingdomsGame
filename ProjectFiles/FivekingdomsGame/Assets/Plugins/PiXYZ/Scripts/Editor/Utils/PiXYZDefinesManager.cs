using System.IO;
using UnityEditor;
using UnityEditor.Compilation;

namespace PiXYZ
{
    public class PiXYZDefinesManager
    {
        public const string PIXYZ_DEFINES = "PIXYZ;PIXYZ_2019;PIXYZ_2019_2;PIXYZ_2019_2_OR_NEWER";

        [InitializeOnLoadMethod]
        private static void Initialize()
        {
            AddDefines();
#if UNITY_2019_1_OR_NEWER
            CompilationPipeline.compilationStarted += (o) => CompilationStarted();
#else
            CompilationPipeline.assemblyCompilationStarted += (o) => CompilationStarted();
#endif
        }

        private static void CompilationStarted()
        {
            string thisSourceFilePath = new System.Diagnostics.StackTrace(true).GetFrame(0).GetFileName();
            // The code below might execute even if this file got deleted (it is still in the last built binaries).
            // If this file no longer exists, it means that PiXYZ is not longer present (or parts of it are missing) so defines are removed
            if (!File.Exists(thisSourceFilePath)) {
                RemoveDefines();
            }
        }

        public static void AddDefines()
        {
            var currentDefines = PlayerSettings.GetScriptingDefineSymbolsForGroup(EditorUserBuildSettings.selectedBuildTargetGroup);
            if (!currentDefines.Contains(PIXYZ_DEFINES)) {
                PlayerSettings.SetScriptingDefineSymbolsForGroup(EditorUserBuildSettings.selectedBuildTargetGroup, $"{PIXYZ_DEFINES};{currentDefines}");
            }
        }

        public static void RemoveDefines()
        {
            var currentDefines = PlayerSettings.GetScriptingDefineSymbolsForGroup(EditorUserBuildSettings.selectedBuildTargetGroup);
            if (currentDefines.Contains(PIXYZ_DEFINES)) {
                currentDefines = currentDefines.Replace($"{PIXYZ_DEFINES}", "");
                currentDefines = currentDefines.Trim(new[] { ';' });
                PlayerSettings.SetScriptingDefineSymbolsForGroup(EditorUserBuildSettings.selectedBuildTargetGroup, currentDefines);
            }
        }
    }
}