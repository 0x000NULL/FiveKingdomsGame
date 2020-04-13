// Advanced Dynamic Shaders
// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using Boxophobic;

[CanEditMultipleObjects]
[CustomEditor(typeof(ADSQuickMask))]
public class ADSObjectInspector : Editor 
{
	private ADSQuickMask targetScript;

    //private static readonly string excludeScript = "m_Script";

    private Color bannerColor;
    private string bannerText;
    private string helpURL;

	void OnEnable()
    {
		
		targetScript = (ADSQuickMask)target;

        bannerText = "ADS Quick Mask";
        helpURL = "https://docs.google.com/document/d/1PG_9bb0iiFGoi_yQd8IX0K3sMohuWqyq6_qa4AyVpFw/edit#heading=h.nnme6fkgscpz";

        // Check if Light or Dark Unity Skin
        // Set the Banner and Logo Textures
        if (EditorGUIUtility.isProSkin) 
		{
            bannerColor = BConst.ColorLightGray;
        } 
		else 
		{
            bannerColor = BConst.ColorDarkGray;
        }

	}

	public override void OnInspectorGUI()
    {

        BEditorGUI.DrawBanner(bannerColor, bannerText, helpURL);

        EditorGUILayout.HelpBox("The ADS Quick Mask component is slow when using high poly meshes and it will be deprecated soon. Please use the ADS Mesh Packer instead!", MessageType.Warning, true);
        GUILayout.Space(10);

        DrawWarnings ();

	}

//	void DrawInspector(){
//
//		serializedObject.Update ();
//
//		DrawPropertiesExcluding (serializedObject, excludeScript);
//
//		serializedObject.ApplyModifiedProperties ();
//
//		GUILayout.Space(20);
//
//	} 

	void DrawWarnings()
    {

		if (targetScript.warningMissingADSMesh == true) 
		{
			EditorGUILayout.HelpBox ("The gameobject should have valid MeshFilter component with a Mesh attached!", MessageType.Warning, true);
			GUILayout.Space (10);
		}

	}
}
