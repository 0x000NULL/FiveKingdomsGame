using PiXYZ.Editor;
using PiXYZ.Utils;
using System;
using System.Linq;
using UnityEditor;
using UnityEngine;

namespace PiXYZ.Import.Editor {

    [CustomPropertyDrawer(typeof(LodsGenerationSettings))]
    public class LODsSettingsDrawer : PropertyDrawer {

        const int SPLITTER_WIDTH = 12;
        const float MINIMUM_LOD_RANGE = 0.01f;

        public static readonly Color[] LOD_COLORS_FOCUS = new Color[] {
            new Color(0.38039f, 0.49020f, 0.01961f),
            new Color(0.21961f, 0.32157f, 0.45882f),
            new Color(0.16471f, 0.41961f, 0.51765f),
            new Color(0.41961f, 0.12549f, 0.01961f),
            new Color(0.30196f, 0.22745f, 0.41569f),
            new Color(0.63137f, 0.34902f, 0.00000f),
            new Color(0.35294f, 0.32157f, 0.03922f),
            new Color(0.61176f, 0.50196f, 0.01961f),
        };

        public static readonly Color[] LOD_COLORS = new Color[] {
            new Color(0.23529f, 0.27451f, 0.10196f),
            new Color(0.18039f, 0.21569f, 0.26275f),
            new Color(0.15686f, 0.25098f, 0.28627f),
            new Color(0.25098f, 0.14510f, 0.10588f),
            new Color(0.20784f, 0.18039f, 0.24706f),
            new Color(0.32549f, 0.22745f, 0.09804f),
            new Color(0.22745f, 0.21569f, 0.11373f),
            new Color(0.32157f, 0.27843f, 0.10588f),
        };

        public static readonly Color CULLED_COLOR = new Color(0.31373f, 0f, 0f);
        public static readonly Color CULLED_COLOR_FOCUS = new Color(0.62745f, 0f, 0f);
        public static readonly Color FRAME_COLOR_FOCUS = new Color(0.23922f, 0.37647f, 0.56863f);

        private static bool NeedsRepaint = false;

        int selectedLOD = 0;
        int grabbing = int.MinValue;

        public static Color GetLodColor(int lodNbr, bool isCulled, bool isSelected)
        {
            return (isCulled) ? isSelected ? CULLED_COLOR_FOCUS : CULLED_COLOR : isSelected ? LOD_COLORS_FOCUS[lodNbr] : LOD_COLORS[lodNbr];
        }

        public static GUIStyle _LodPercentTextStyle;
        public static GUIStyle LodPercentTextStyle {
            get {
                if (_LodPercentTextStyle == null) {
                    _LodPercentTextStyle = new GUIStyle();
                    _LodPercentTextStyle.alignment = TextAnchor.MiddleRight;
                    _LodPercentTextStyle.normal.textColor = EditorGUIUtility.isProSkin ? new Color(.8f, .8f, .8f) : new Color(.1f, .1f, .1f);
                }
                return _LodPercentTextStyle;
            }
        }

        public override void OnGUI(Rect position, SerializedProperty property, GUIContent label) {

            EditorGUI.BeginProperty(position, label, property);
            
            var lodsArray = property.FindPropertyRelative("_lods");
            int count = lodsArray.arraySize;
            bool locked = property.FindPropertyRelative("_locked").boolValue;
            var fancyNames = Enum.GetValues(typeof(LodQuality)).Cast<object>().Select(o => o.ToString().FancifyCamelCase()).ToArray();

            if (count > 0) {

                Rect sliderRect = EditorGUILayout.GetControlRect();
                sliderRect.y -= 2;
                sliderRect.height = 30;
                GUILayout.Space(20);

                float previousThreshold = 1f;
                float[] widths = new float[count];

                for (int i = 0; i < count; i++) {

                    bool isLast = i == count - 1;
                    float currentThreshold = (float)lodsArray.GetArrayElementAtIndex(i).FindPropertyRelative("threshold").doubleValue;
                    int quality = lodsArray.GetArrayElementAtIndex(i).FindPropertyRelative("quality").enumValueIndex;

                    widths[i] = previousThreshold - currentThreshold;

                    // Draw Block
                    Rect labelRect = new Rect(
                        new Vector2(sliderRect.position.x + (1 - previousThreshold) * sliderRect.width, sliderRect.position.y),
                        new Vector2(sliderRect.width * widths[i], sliderRect.height)
                    );
                    EditorGUIExtensions.GUIDrawRect(labelRect, GetLodColor(i, quality == (int)LodQuality.CULLED, selectedLOD == i), FRAME_COLOR_FOCUS, selectedLOD == i ? 3 : 0, " LOD " + i + "\n " + fancyNames[quality], TextAnchor.MiddleLeft);

                    // Check if click on LOD
                    EditorGUIUtility.AddCursorRect(labelRect, MouseCursor.Link);
                    if (labelRect.Contains(Event.current.mousePosition))
                    {
                        if (Event.current.type == EventType.MouseDown)
                        {
                            if (Event.current.button == 0)
                            {
                                selectedLOD = i;
                                // Triggers change (for Repaint in Editors)
                                GUI.changed = true;
                            }
                            else if (Event.current.button == 1 && !locked)
                            {
                                selectedLOD = i;
                                GenericMenu genericMenu = new GenericMenu();
                                if (count <= (int)LodQuality.CULLED) {
                                    float newThreshold = 1 - (Event.current.mousePosition.x - sliderRect.x) / sliderRect.width;
                                    genericMenu.AddItem(new GUIContent("Insert Before"), false, () => {
                                        insertLOD(lodsArray, selectedLOD, newThreshold);
                                        selectedLOD++;
                                        NeedsRepaint = true;
                                    });
                                } else {
                                    genericMenu.AddDisabledItem(new GUIContent("Insert Before"));
                                }

                                if (count <= (int)LodQuality.CULLED) {
                                    float newThreshold = 1 - (Event.current.mousePosition.x - sliderRect.x) / sliderRect.width;
                                    genericMenu.AddItem(new GUIContent("Insert After"), false, () => {
                                        lodsArray.GetArrayElementAtIndex(selectedLOD).FindPropertyRelative("threshold").doubleValue = newThreshold;
                                        insertLOD(lodsArray, selectedLOD + 1, currentThreshold);
                                        NeedsRepaint = true;
                                    });
                                } else {
                                    genericMenu.AddDisabledItem(new GUIContent("Insert After"));
                                }

                                if (count > 1) {
                                    genericMenu.AddItem(new GUIContent("Remove"), false, () => {
                                        deleteLOD(lodsArray, selectedLOD);
                                        NeedsRepaint = true;
                                    });
                                } else {
                                    genericMenu.AddDisabledItem(new GUIContent("Remove"));
                                }

                                genericMenu.ShowAsContext();
                            }
                        }
                    }

                    // Draw Splitter if not last
                    if (!isLast) {
                        Rect splitter = new Rect(labelRect.x + labelRect.width, labelRect.y, SPLITTER_WIDTH, labelRect.height);
                        EditorGUI.LabelField(new Rect(splitter.x - 20, splitter.y - 20, 40, 20), (Math.Round(currentThreshold * 100)) + "%", LodPercentTextStyle);
                        EditorGUIUtility.AddCursorRect(splitter, MouseCursor.ResizeHorizontal);
                        if (splitter.Contains(Event.current.mousePosition) && (Event.current.type == EventType.MouseDown && Event.current.button == 0)) {
                            if (i < (int)LodQuality.CULLED)
                                grabbing = i;
                        }
                    }

                    previousThreshold = currentThreshold;
                }

                if (Event.current.type == EventType.MouseUp)
                    grabbing = int.MinValue;

                double mouseDeltaX = 0;
                if (grabbing != int.MinValue && Event.current.type == EventType.MouseDrag) {
                    mouseDeltaX = Event.current.delta.x;
                }

                if (mouseDeltaX != 0)
                {
                    double threshold = lodsArray.GetArrayElementAtIndex(grabbing).FindPropertyRelative("threshold").doubleValue;
                    double delta = - mouseDeltaX / (sliderRect.width);

                    // Moves dragging LOD
                    float max = (grabbing > 0) ? (float)lodsArray.GetArrayElementAtIndex(grabbing - 1).FindPropertyRelative("threshold").doubleValue - MINIMUM_LOD_RANGE : 1 - MINIMUM_LOD_RANGE;
                    float min = (grabbing < count)? (float)lodsArray.GetArrayElementAtIndex(grabbing + 1).FindPropertyRelative("threshold").doubleValue + MINIMUM_LOD_RANGE : MINIMUM_LOD_RANGE;
                    float newThreshold = Mathf.Clamp((float)(threshold + delta), min, max);
                    lodsArray.GetArrayElementAtIndex(grabbing).FindPropertyRelative("threshold").doubleValue = newThreshold;

                    // Triggers change (for Repaint in Editors)
                    GUI.changed = true;
                }

                // Selected LOD Quality dropdown selector
                if (!locked && selectedLOD != -1)
                {
                    int selectedLodQuality = lodsArray.GetArrayElementAtIndex(selectedLOD).FindPropertyRelative("quality").enumValueIndex;

                    // Prevent from selecting higher quality than previous LOD
                    int previousLodQuality = selectedLOD > 0 ? lodsArray.GetArrayElementAtIndex(selectedLOD - 1).FindPropertyRelative("quality").enumValueIndex : -1;
                    previousLodQuality++;
                    string[] options = new string[fancyNames.Length - previousLodQuality];
                    for (int i = previousLodQuality; i < fancyNames.Length; ++i)
                        options[i - previousLodQuality] = fancyNames[i];
                    selectedLodQuality -= previousLodQuality;

                    // Select value
                    int newSelected = EditorGUILayout.Popup(new GUIContent("Selected LOD Quality", ImportSettings.TOOLTIP_QUALITY_PRESET), selectedLodQuality, options);

                    // Update next LODs
                    if (selectedLodQuality != newSelected)
                    {
                        newSelected += previousLodQuality;
                        lodsArray.GetArrayElementAtIndex(selectedLOD).FindPropertyRelative("quality").enumValueIndex = newSelected;
                    }
                }
            }

            // Ensures LOD chain is coherent
            int currentLOD = 0;
            while (currentLOD < count - 1) {
                var leftLOD = lodsArray.GetArrayElementAtIndex(currentLOD);
                var rightLOD = lodsArray.GetArrayElementAtIndex(currentLOD + 1);
                int leftLODQuality = leftLOD.FindPropertyRelative("quality").enumValueIndex;
                int rightLODQuality = rightLOD.FindPropertyRelative("quality").enumValueIndex;
                if (leftLODQuality < rightLODQuality)
                    return;
                if (leftLODQuality + 1 > (int)LodQuality.CULLED) {
                    for (int i = currentLOD + 1; i < count; ++i)
                        lodsArray.DeleteArrayElementAtIndex(currentLOD + 1);
                    leftLOD.FindPropertyRelative("threshold").doubleValue = 0;
                    return;
                } else
                    rightLOD.FindPropertyRelative("quality").enumValueIndex = leftLODQuality + 1;
                currentLOD++;
            }

            EditorGUI.EndProperty();

            if (NeedsRepaint) {
                NeedsRepaint = false;
                GUI.changed = true;
            }
        }

        private void deleteLOD(SerializedProperty lodsArray, int index) {

            lodsArray.DeleteArrayElementAtIndex(index);
            if (index == lodsArray.arraySize)
            {
                lodsArray.GetArrayElementAtIndex(lodsArray.arraySize - 1).FindPropertyRelative("threshold").doubleValue = 0;
            }
            selectedLOD--;
            selectedLOD = Mathf.Clamp(selectedLOD, 0, lodsArray.arraySize);

            grabbing = int.MinValue;
        }

        private static void insertLOD(SerializedProperty lodsArray, int index, double threshold = 0.05) {

            lodsArray.InsertArrayElementAtIndex(index);
            lodsArray.GetArrayElementAtIndex(index).FindPropertyRelative("threshold").doubleValue = threshold;

            var qualities = new int[] {-1,-1,-1,-1,-1,-1};
            var qualityToChange = new System.Collections.Generic.List<int>();
            for(int i = 0; i < lodsArray.arraySize; ++i) {
                int lodQuality = lodsArray.GetArrayElementAtIndex(i).FindPropertyRelative("quality").enumValueIndex;
                if (qualities[lodQuality] == -1)
                    qualities[lodQuality] = lodQuality;
                else
                    qualityToChange.Add(lodQuality);
            }

            foreach (int i in qualityToChange.ToArray()) {
                bool flag = false;
                for (int j = i; j < qualities.Length; ++j)
                {
                    if (qualities[j] == -1)
                    {
                        qualities[j] = j;
                        qualityToChange.Remove(i);
                        flag = true;
                        break;
                    }
                }
                if (flag)
                    continue;
                for (int j = i; j >= 0; --j) {
                    if (qualities[j] == -1)
                    {
                        qualities[j] = j;
                        qualityToChange.Remove(i);
                        break;
                    }
                }
            }
            int q = 0;
            for(int i = 0; i < lodsArray.arraySize; ++i) {
                while (qualities[q] == -1)
                    q++;
                lodsArray.GetArrayElementAtIndex(i).FindPropertyRelative("quality").enumValueIndex = qualities[q];
                q++;
                if (i + 1 < lodsArray.arraySize) {
                    var leftLOD = lodsArray.GetArrayElementAtIndex(i);
                    var rightLOD = lodsArray.GetArrayElementAtIndex(i + 1);
                    if (leftLOD.FindPropertyRelative("threshold").doubleValue <= rightLOD.FindPropertyRelative("threshold").doubleValue + 0.027)
                        leftLOD.FindPropertyRelative("threshold").doubleValue = rightLOD.FindPropertyRelative("threshold").doubleValue + 0.05;
                }
            }
        }
    }
}