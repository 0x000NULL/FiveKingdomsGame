using UnityEditor;

namespace PiXYZ.Editor
{
    public abstract class SingletonEditorWindow : EditorWindow
    {
        public abstract string WindowTitle { get; }
    }
}