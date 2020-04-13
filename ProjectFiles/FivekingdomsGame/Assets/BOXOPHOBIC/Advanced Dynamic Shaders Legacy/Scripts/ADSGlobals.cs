// Advanced Dynamic Shaders
// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEngine.Serialization;
using Boxophobic;
#if UNITY_EDITOR
using UnityEditor;
#endif

[HelpURL("https://docs.google.com/document/d/1PG_9bb0iiFGoi_yQd8IX0K3sMohuWqyq6_qa4AyVpFw/edit#heading=h.nnme6fkgscpz")]
[DisallowMultipleComponent]
[ExecuteInEditMode]
[RequireComponent(typeof(MeshRenderer))]
public class ADSGlobals : MonoBehaviour
{

    [BMessage("Warning", "The ADS Settings component will be deprecated soon! Please check out the upgrading manual and use the ADS Global Motion and ADS Global Settings components instead!", 0, 0)]
    public bool message_Legacy = true;

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

    [BCategory("Debug")]
    public int category_Debug;

    public DebugEnum debug = DebugEnum.off;

    //[Space(5)]
    [BCategory("Motion")]
    public int category_Motion;

    [FormerlySerializedAs("globalAmplitude")]
    public float motionAmplitude = 0.5f;
    [FormerlySerializedAs("globalSpeed")]
    public float motionSpeed = 4.0f;
    [FormerlySerializedAs("globalScale")]
    public float motionScale = 0.5f;

    [BCategory("Turbulence")]
    public int category_Turbulence;

    [FormerlySerializedAs("noiseTexture")]
    public Texture2D turbulenceTexture = null;
    [FormerlySerializedAs("noiseContrast")]
    public float turbulenceContrast = 1.0f;
    [FormerlySerializedAs("noiseSpeed")]
    public float turbulenceSpeed = 1.0f;
    [FormerlySerializedAs("noiseScale")]
    public float turbulenceScale = 1.0f;

    [BCategory("Grass")]
    public int category_Legacy;

    public enum GrassTintModeEnum
    {
        texture = 0,
        colors = 1,
    };

    public GrassTintModeEnum grassTintMode = GrassTintModeEnum.colors;
    public Texture2D grassTintTexture = null;
    public float grassTintIntensity = 1.0f;

    [BInteractive(1)]
    public int InteractiveGrassTintColors;

    public Color grassTintColorOne = Color.white;
    public Color grassTintColorTwo = Color.white;

    [BInteractive("ON")]
    public int InteractiveOn;

    public Vector4 grassTintScaleOffset = new Vector4(1.0f, 1.0f, 0.0f, 0.0f);

    [Space(10)]
    public Texture2D grassSizeTexture = null;
    public float grassSizeMin = 0.0f;
    public float grassSizeMax = 1.0f;
    public Vector4 grassSizeScaleOffset = new Vector4(1.0f, 1.0f, 0.0f, 0.0f);

    private Shader debugShader;
    private bool debugShader_ON = false;

    void Awake()
    {

        // Set gameobject name to be searchable
        gameObject.name = "ADS Globals";

        // Send global information to shaders
        SetGlobalShaderProperties();

        // Disable Arrow in play mode
        if (Application.isPlaying == true)
        {
            gameObject.GetComponent<MeshRenderer>().enabled = false;
        }
        else
        {
            gameObject.GetComponent<MeshRenderer>().enabled = true;
        }

        #if UNITY_EDITOR
        // Set Debug Shader
        debugShader = Shader.Find("Utils/ADS Debug");
        #endif

    }

    #if UNITY_EDITOR
    void Update ()
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

        if (Selection.Contains(gameObject) == true)
        {
            SetGlobalShaderProperties();
        }

    }
    #endif

    // Send global information to shaders
    void SetGlobalShaderProperties()
    {

        // Send Motion parameters to shaders
        Shader.SetGlobalVector("ADS_GlobalDirection", gameObject.transform.forward);
        Shader.SetGlobalFloat("ADS_GlobalAmplitude", motionAmplitude);
        Shader.SetGlobalFloat("ADS_GlobalSpeed", motionSpeed);
        Shader.SetGlobalFloat("ADS_GlobalScale", motionScale);

        // Send Turbulence parameters to shaders
        if (turbulenceTexture == null || turbulenceContrast <= 0)
        {
            Shader.SetGlobalFloat("ADS_TurbulenceTex_ON", 0.0f);
        }
        else
        {
            Shader.SetGlobalFloat("ADS_TurbulenceTex_ON", 1.0f);
            Shader.SetGlobalTexture("ADS_TurbulenceTex", turbulenceTexture);
            Shader.SetGlobalFloat("ADS_TurbulenceContrast", turbulenceContrast);
            Shader.SetGlobalFloat("ADS_TurbulenceSpeed", turbulenceSpeed * 0.1f);
            Shader.SetGlobalFloat("ADS_TurbulenceScale", turbulenceScale * 0.1f);
        }

        // Legacy, will be removed in the next update
        if (grassTintMode == GrassTintModeEnum.texture)
        {
            InteractiveGrassTintColors = 0;
        }
        else
        {
            InteractiveGrassTintColors = 1;
        }

        if (grassTintTexture == null || grassTintIntensity <= 0 || (grassTintColorOne == Color.white && grassTintColorTwo == Color.white))
        {
            Shader.SetGlobalFloat("ADS_GrassTintTex_ON", 0.0f);
        }
        else
        {
            if (grassTintMode == GrassTintModeEnum.texture)
            {
                Shader.SetGlobalFloat("ADS_GrassTintModeColors", 0.0f);
            }
            else
            {
                Shader.SetGlobalFloat("ADS_GrassTintModeColors", 1.0f);
            }

            Shader.SetGlobalFloat("ADS_GrassTintTex_ON", 1.0f);
            Shader.SetGlobalTexture("ADS_GrassTintTex", grassTintTexture);
            Shader.SetGlobalFloat("ADS_GrassTintIntensity", grassTintIntensity);
            Shader.SetGlobalColor("ADS_GrassTintColorOne", grassTintColorOne);
            Shader.SetGlobalColor("ADS_GrassTintColorTwo", grassTintColorTwo);
            Shader.SetGlobalVector("ADS_GrassTintScaleOffset", grassTintScaleOffset);
        }

        if (grassSizeTexture == null)
        {
            Shader.SetGlobalFloat("ADS_GrassSizeTex_ON", 0.0f);
        }
        else
        {
            Shader.SetGlobalFloat("ADS_GrassSizeTex_ON", 1.0f);
            Shader.SetGlobalTexture("ADS_GrassSizeTex", grassSizeTexture);
            Shader.SetGlobalFloat("ADS_GrassSizeMin", grassSizeMin - 1.0f);
            Shader.SetGlobalFloat("ADS_GrassSizeMax", grassSizeMax - 1.0f);
            Shader.SetGlobalVector("ADS_GrassSizeScaleOffset", grassSizeScaleOffset);
        }

    }
}
