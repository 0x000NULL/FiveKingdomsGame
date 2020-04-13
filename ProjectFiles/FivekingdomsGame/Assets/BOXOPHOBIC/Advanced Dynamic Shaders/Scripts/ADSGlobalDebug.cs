// Advanced Dynamic Shaders
// Cristian Pop - https://boxophobic.com/

#if UNITY_EDITOR
using UnityEngine;
using UnityEditor;
using Boxophobic;

[HelpURL("https://docs.google.com/document/d/1PG_9bb0iiFGoi_yQd8IX0K3sMohuWqyq6_qa4AyVpFw/edit#heading=h.d4azvp42k3l7")]
[DisallowMultipleComponent]
[ExecuteInEditMode]
public class ADSGlobalDebug : MonoBehaviour
{

    public enum DebugEnum
    {
        off = -1,

        vertexColorR = 1,
        vertexColorG = 2,
        vertexColorB = 3,
        vertexColorA = 4,

        motionMask1 = 11,
        motionMask2 = 12,
        motionMask3 = 13,
        motionVariation = 14,
        motionNoise = 15,

        globalTint = 31,
        globalSize = 32,

        materialLighting = 61,
        materialInstancing = 62,
        //shaderType = 63,
        materialIssues = 64,
    };

    //[BCategory("Debug")]
    //public int category_Debug;

    [Space(10)]
    public DebugEnum debug = DebugEnum.off;

    private Shader debugShader;
    private bool debugShader_ON = false;


    void Start()
    {

        debugShader = Shader.Find("Utils/ADS Debug");

        gameObject.name = "ADS Global Debug";

        debug = DebugEnum.off;

    }

    void Update()
    {

        if (Application.isPlaying)
        {
            return;
        }

        if (SceneView.lastActiveSceneView != null)
        {
            if (debug == DebugEnum.off)
            {
                if (debugShader_ON == true)
                {
                    SceneView.lastActiveSceneView.SetSceneViewShaderReplace(null, null);
                    SceneView.lastActiveSceneView.Repaint();

                    debugShader_ON = false;
                }
            }
            else
            {
                SceneView.lastActiveSceneView.SetSceneViewShaderReplace(debugShader, null);
                SceneView.lastActiveSceneView.Repaint();

                debugShader_ON = true;

                Shader.SetGlobalFloat("ADS_DebugMode", (int)debug);
            }
        }

    }
}
#endif

