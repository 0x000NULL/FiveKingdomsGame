using UnityEngine;
using UnityEditor;
using Boxophobic;
using System.IO;
using System.Collections.Generic;

public class ADSInstall : EditorWindow
{

    Color guiColor;
    string bannerText;
    string helpURL;
    static ADSInstall Window;

    [MenuItem("BOXOPHOBIC/Advanced Dynamic Shaders/The Hub")]
    public static void ShowWindow()
    {

        Window = GetWindow<ADSInstall>(false, "ADS Hub", true);
        Window.minSize = new Vector2(480, 320);
        //Window.maxSize = new Vector2(600f, 300f);

    }

    void OnEnable()
    {

        bannerText = "ADS Hub 2.2.0";
        helpURL = "https://docs.google.com/document/d/1PG_9bb0iiFGoi_yQd8IX0K3sMohuWqyq6_qa4AyVpFw/edit#heading=h.nnme6fkgscpz";

        // Check if Light or Dark Unity Skin
        // Set the Banner and Logo Textures
        if (EditorGUIUtility.isProSkin)
        {
            guiColor = new Color(1f, 0.754f, 0.186f);
        }
        else
        {
            guiColor = BConst.ColorDarkGray;
        }

    }

    void OnGUI()
    {

        BEditorGUI.DrawWindowBanner(guiColor, bannerText, helpURL);

        GUILayout.BeginHorizontal();
        GUILayout.Space(25);

        GUILayout.BeginVertical();

        DrawMessage();

        DrawButton();

        GUILayout.EndVertical();

        GUILayout.Space(20);
        GUILayout.EndHorizontal();


        GUILayout.BeginVertical();
        GUILayout.FlexibleSpace();

        BEditorGUI.DrawLogo();

        GUILayout.FlexibleSpace();
        GUILayout.Space(20);
        GUILayout.EndVertical();
    }

    void DrawMessage()
    {

        EditorGUILayout.HelpBox("Due to many internal changes, all material using ADS need to be updated! Some features will be deprecated in the next update. " +
                                "Click the Question Mark above to open the Update Documentation!", MessageType.None, true);

    }

    void DrawButton()
    {

        GUIStyle stylePopup = new GUIStyle(EditorStyles.popup);
        stylePopup.alignment = TextAnchor.MiddleCenter;

        GUIStyle styleButton = new GUIStyle(EditorStyles.miniButton);

        GUILayout.Space(20);

        GUILayout.BeginHorizontal();

        EditorGUILayout.LabelField(new GUIContent("Advanced Dynamic Shaders", ""));
        if (GUILayout.Button("Update", styleButton, GUILayout.Width(160)))
        {
            Update211To220();
        }


        GUILayout.EndHorizontal();

        //GUILayout.Space(20);
        //GUILayout.BeginHorizontal();
        //GUILayout.Label("");
        //if (GUILayout.Button("Update", styleButton, GUILayout.Width(160)))
        //{
        //    Update211To220();
        //}
        //GUILayout.Label("");
        //GUILayout.EndHorizontal();
        //GUI.enabled = true;

    }

    void Update211To220()
    {

        List<Material> allMaterials = new List<Material>();
        string[] allMatFiles = Directory.GetFiles(Application.dataPath, "*.mat", SearchOption.AllDirectories);

        for (int i = 0; i < allMatFiles.Length; i++)
        {
            string assetPath = "Assets" + allMatFiles[i].Replace(Application.dataPath, "").Replace('\\', '/');
            Material assetMat = (Material)AssetDatabase.LoadAssetAtPath(assetPath, typeof(Material));
            allMaterials.Add(assetMat);
        }

        for (int i = 0; i < allMaterials.Count; i++)
        {
            if (allMaterials[i] != null)
            {
                Material material = allMaterials[i];

                if (material.shader == Shader.Find("BOXOPHOBIC/Advanced Dynamic Shaders/Simple Lit/Cloth") ||
                    material.shader == Shader.Find("BOXOPHOBIC/Advanced Dynamic Shaders/Simple Lit/Generic") ||
                    material.shader == Shader.Find("BOXOPHOBIC/Advanced Dynamic Shaders/Standard Lit/Cloth") ||
                    material.shader == Shader.Find("BOXOPHOBIC/Advanced Dynamic Shaders/Standard Lit/Generic") ||
                    material.shader == Shader.Find("BOXOPHOBIC/Advanced Dynamic Shaders/Simple Lit/Grass (Legacy)") ||
                    material.shader == Shader.Find("BOXOPHOBIC/Advanced Dynamic Shaders/Standard Lit/Grass (Legacy)"))
                {

                    if (material.HasProperty("_Mode"))
                    {
                        material.SetFloat("_RenderType", material.GetFloat("_Mode"));
                    }

                    if (material.HasProperty("_CullMode"))
                    {
                        material.SetFloat("_RenderFaces", material.GetFloat("_CullMode"));
                    }

                    //Main set on inputs
                    if (material.HasProperty("_MainUVs"))
                    {
                        material.SetVector("_UVZero", material.GetVector("_MainUVs"));
                    }

                    if (material.HasProperty("_MainTex"))
                    {
                        material.SetTexture("_AlbedoTex", material.GetTexture("_MainTex"));
                    }

                    if (material.HasProperty("_BumpMap"))
                    {
                        material.SetTexture("_NormalTex", material.GetTexture("_BumpMap"));
                    }

                    if (material.HasProperty("_MetallicGlossMap"))
                    {
                        material.SetTexture("_SurfaceTex", material.GetTexture("_MetallicGlossMap"));
                    }

                    if (material.HasProperty("_BumpScale"))
                    {
                        material.SetFloat("_NormalScale", material.GetFloat("_BumpScale"));
                    }

                    if (material.HasProperty("_Glossiness"))
                    {
                        material.SetFloat("_Smoothness", material.GetFloat("_Glossiness"));
                    }

                    if (material.HasProperty("_MotionNoise"))
                    {
                        material.SetFloat("_GlobalTurbulence", material.GetFloat("_MotionNoise"));
                    }

                    // Upgrade RenderMode without selecting the material
                    if (material.HasProperty("_RenderType"))
                    {
                        var renderType = material.GetFloat("_RenderType");

                        if (renderType == 0)
                        {
                            material.SetOverrideTag("RenderType", "");
                            material.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.One);
                            material.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.Zero);
                            material.SetInt("_ZWrite", 1);
                            material.renderQueue = -1;

                            material.EnableKeyword("_RENDERTYPEKEY_OPAQUE");
                            material.DisableKeyword("_RENDERTYPEKEY_CUT");
                            material.DisableKeyword("_RENDERTYPEKEY_FADE");
                            material.DisableKeyword("_RENDERTYPEKEY_TRANSPARENT");
                        }
                        else if (renderType == 1)
                        {
                            material.SetOverrideTag("RenderType", "TransparentCutout");
                            material.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.One);
                            material.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.Zero);
                            material.SetInt("_ZWrite", 1);
                            material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.AlphaTest;

                            material.DisableKeyword("_RENDERTYPEKEY_OPAQUE");
                            material.EnableKeyword("_RENDERTYPEKEY_CUT");
                            material.DisableKeyword("_RENDERTYPEKEY_FADE");
                            material.DisableKeyword("_RENDERTYPEKEY_TRANSPARENT");
                        }
                        else if (renderType == 2)
                        {
                            material.SetOverrideTag("RenderType", "Transparent");
                            material.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.SrcAlpha);
                            material.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
                            material.SetInt("_ZWrite", 0);
                            material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.Transparent;

                            material.DisableKeyword("_RENDERTYPEKEY_OPAQUE");
                            material.DisableKeyword("_RENDERTYPEKEY_CUT");
                            material.EnableKeyword("_RENDERTYPEKEY_FADE");
                            material.DisableKeyword("_RENDERTYPEKEY_TRANSPARENT");
                        }
                        else if (renderType == 3)
                        {
                            material.SetOverrideTag("RenderType", "Transparent");
                            material.SetInt("_SrcBlend", (int)UnityEngine.Rendering.BlendMode.One);
                            material.SetInt("_DstBlend", (int)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
                            material.SetInt("_ZWrite", 0);
                            material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.Transparent;

                            material.DisableKeyword("_RENDERTYPEKEY_OPAQUE");
                            material.DisableKeyword("_RENDERTYPEKEY_CUT");
                            material.DisableKeyword("_RENDERTYPEKEY_FADE");
                            material.EnableKeyword("_RENDERTYPEKEY_TRANSPARENT");
                        }
                    }

                    // Since ADS Legacy properties have the same name as Unity propeties this can be set to 1
                    material.SetFloat("_Internal_UnityToBoxophobic", 1);

                    // Debug chnaged Materials
                    Debug.Log(material.name + " Updated");
                }
            }

        }  
    }
}
