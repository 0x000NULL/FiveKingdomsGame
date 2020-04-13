// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/Advanced Dynamic Shaders/Standard Lit/Plant"
{
	Properties
	{
		[HideInInspector]_Internal_Version("Internal_Version", Float) = 220
		[BBanner(ADS Standard Lit, Plant)]_ADSStandardLitPlant("< ADS Standard Lit Plant >", Float) = 1
		[BCategory(Rendering)]_RENDERINGG("[ RENDERINGG ]", Float) = 0
		[Enum(Two Sided,0,Back,1,Front,2)]_RenderFaces("Render Faces", Float) = 0
		_Cutoff("Cutout", Range( 0 , 1)) = 0.5
		[BCategory(Main)]_MAINN("[ MAINN ]", Float) = 0
		_Color("Plant Color", Color) = (1,1,1,1)
		[NoScaleOffset]_AlbedoTex("Plant Albedo", 2D) = "white" {}
		[Toggle]_NormalInvertOnBackface("Plant Normal Backface", Float) = 1
		_NormalScale("Plant Normal Scale", Float) = 1
		[NoScaleOffset]_NormalTex("Plant Normal", 2D) = "bump" {}
		_Smoothness("Plant Smoothness", Range( 0 , 1)) = 1
		[BCategory(Settings)]_SETTINGS("[ SETTINGS ]", Float) = 0
		[HideInInspector]_MotionNoise("Motion Noise", Float) = 1
		_GlobalTurbulence("Global Turbulence", Range( 0 , 1)) = 1
		_GlobalTint("Global Tint", Range( 0 , 1)) = 1
		_GlobalSize("Global Size", Range( 0 , 1)) = 1
		[BCategory(Plant Motion)]_MOTIONPLANTT("[ MOTION PLANTT ]", Float) = 0
		[BMessage(Info, The Plant Motion Parameters will be overridden by the ADS Materials Helper Component, _Internal_SetByScript, 1, 0, 10)]_PlantMotionParameters("!!! Plant Motion Parameters !!!", Float) = 0
		_MotionAmplitude("Plant Motion Amplitude", Float) = 0
		_MotionSpeed("Plant Motion Speed", Float) = 0
		_MotionScale("Plant Motion Scale", Float) = 0
		_MotionVariation("Plant Motion Variation", Float) = 0
		_MotionVertical("Plant Motion Vertical", Range( 0 , 1)) = 0
		[BCategory(Leaf Motion)]_MOTIONLEAFF("[ MOTION LEAFF ]", Float) = 0
		[BMessage(Info, The Leaf Motion Parameters will be overridden by the ADS Materials Helper Component, _Internal_SetByScript, 1, 0, 10)]_LeafMotionParameters("!!! Leaf Motion Parameters !!!", Float) = 0
		_MotionAmplitude3("Leaf Motion Amplitude", Float) = 0
		_MotionSpeed3("Leaf Motion Speed", Float) = 0
		_MotionScale3("Leaf Motion Scale", Float) = 0
		[BCategory(Advanced)]_ADVANCEDD("[ ADVANCEDD ]", Float) = 0
		[BMessage(Info, Batching is not currently supported Please use GPU Instancing instead for better performance, 0, 0)]_BatchingInfo("!!! BatchingInfo", Float) = 0
		[BInteractive(_MotionSpace, 0)]_MotionSpaceee("# MotionSpaceee", Float) = 0
		[BInteractive(ON)]_MotionSpaceeeEnd("# MotionSpaceee End", Float) = 0
		[BInteractive(_MotionSpace, 1)]_MotionSpacee("# MotionSpacee", Float) = 0
		[BInteractive(ON)]_MotionSpaceeEnd("# MotionSpacee End", Float) = 0
		[HideInInspector]_Internal_ADS("Internal_ADS", Float) = 1
		[HideInInspector]_MetallicGlossMap("_MetallicGlossMap", 2D) = "white" {}
		[HideInInspector]_MainUVs("_MainUVs", Vector) = (1,1,0,0)
		[HideInInspector]_BumpMap("_BumpMap", 2D) = "white" {}
		[HideInInspector]_MainTex("_MainTex", 2D) = "white" {}
		[HideInInspector]_CullMode("_CullMode", Float) = 0
		[HideInInspector]_Glossiness("_Glossiness", Float) = 0
		[HideInInspector]_Mode("_Mode", Float) = 0
		[HideInInspector]_BumpScale("_BumpScale", Float) = 0
		[HideInInspector]_Internal_UnityToBoxophobic("_Internal_UnityToBoxophobic", Float) = 0
		[HideInInspector]_Internal_LitStandard("Internal_LitStandard", Float) = 1
		[HideInInspector]_Internal_TypePlant("Internal_TypePlant", Float) = 1
		[HideInInspector]_Internal_DebugMask("Internal_DebugMask", Float) = 1
		[HideInInspector]_Internal_DebugMask2("Internal_DebugMask2", Float) = 1
		[HideInInspector]_Internal_SetByScript("Internal_SetByScript", Float) = 0
		[HideInInspector]_Internal_DebugVariation("Internal_DebugVariation", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "DisableBatching" = "True" }
		LOD 300
		Cull [_RenderFaces]
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		#include "../../../Utils/CGIncludes/VS_indirect.cginc"
		#pragma instancing_options procedural:setup
		#pragma multi_compile GPU_FRUSTUM_ON __
		#pragma exclude_renderers gles 
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows nolightmap  nodynlightmap nodirlightmap nometa vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			half ASEVFace : VFACE;
			float4 vertexToFrag1207;
		};

		uniform half _MotionSpaceee;
		uniform half _MotionSpacee;
		uniform half _MotionSpaceeeEnd;
		uniform half _MotionSpaceeEnd;
		uniform half _Internal_SetByScript;
		uniform half _Internal_TypePlant;
		uniform half _RENDERINGG;
		uniform half _PlantMotionParameters;
		uniform half _LeafMotionParameters;
		uniform half _Internal_DebugVariation;
		uniform half _RenderFaces;
		uniform half _MOTIONPLANTT;
		uniform half _Internal_Version;
		uniform half _SETTINGS;
		uniform half _BatchingInfo;
		uniform half _MOTIONLEAFF;
		uniform half _Internal_DebugMask2;
		uniform half _Internal_LitStandard;
		uniform half _ADVANCEDD;
		uniform half _Internal_DebugMask;
		uniform half _MAINN;
		uniform half _ADSStandardLitPlant;
		uniform half _Internal_ADS;
		uniform half _Cutoff;
		uniform half4 _MainUVs;
		uniform float _Mode;
		uniform float _Glossiness;
		uniform half _CullMode;
		uniform float _BumpScale;
		uniform sampler2D _MetallicGlossMap;
		uniform half _Internal_UnityToBoxophobic;
		uniform sampler2D _MainTex;
		uniform sampler2D _BumpMap;
		uniform float _MotionNoise;
		uniform half ADS_GlobalScale;
		uniform float _MotionScale;
		uniform half ADS_GlobalSpeed;
		uniform float _MotionSpeed;
		uniform float _MotionVariation;
		uniform half ADS_GlobalAmplitude;
		uniform float _MotionAmplitude;
		uniform half ADS_TurbulenceTex_ON;
		uniform float _GlobalTurbulence;
		uniform sampler2D ADS_TurbulenceTex;
		uniform half ADS_TurbulenceSpeed;
		uniform half3 ADS_GlobalDirection;
		uniform half ADS_TurbulenceScale;
		uniform half ADS_TurbulenceContrast;
		uniform float _MotionVertical;
		uniform float _MotionScale3;
		uniform float _MotionSpeed3;
		uniform float _MotionAmplitude3;
		uniform half ADS_GlobalSizeMin;
		uniform half ADS_GlobalSizeMax;
		uniform sampler2D ADS_GlobalTex;
		uniform half4 ADS_GlobalUVs;
		uniform half _GlobalSize;
		uniform half _NormalScale;
		uniform sampler2D _NormalTex;
		uniform half _NormalInvertOnBackface;
		uniform sampler2D _AlbedoTex;
		uniform half4 _Color;
		uniform half4 ADS_GlobalTintColorOne;
		uniform half4 ADS_GlobalTintColorTwo;
		uniform half ADS_GlobalTintIntensity;
		uniform half _GlobalTint;
		uniform half _Smoothness;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			half MotionScale60_g1782 = ( ADS_GlobalScale * _MotionScale );
			half MotionSpeed62_g1782 = ( ADS_GlobalSpeed * _MotionSpeed );
			float mulTime90_g1782 = _Time.y * MotionSpeed62_g1782;
			float3 temp_output_95_0_g1782 = ( ( ase_worldPos * MotionScale60_g1782 ) + mulTime90_g1782 );
			half Packed_Variation1129 = v.color.a;
			half MotionVariation269_g1782 = ( _MotionVariation * Packed_Variation1129 );
			half MotionlAmplitude58_g1782 = ( ADS_GlobalAmplitude * _MotionAmplitude );
			float3 temp_output_92_0_g1782 = ( sin( ( temp_output_95_0_g1782 + MotionVariation269_g1782 ) ) * MotionlAmplitude58_g1782 );
			float3 temp_output_160_0_g1782 = ( temp_output_92_0_g1782 + MotionlAmplitude58_g1782 + MotionlAmplitude58_g1782 );
			half localunity_ObjectToWorld0w1_g1798 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g1798 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g1798 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g1798 = (float3(localunity_ObjectToWorld0w1_g1798 , localunity_ObjectToWorld1w2_g1798 , localunity_ObjectToWorld2w3_g1798));
			float2 panner73_g1796 = ( _Time.y * ( ADS_TurbulenceSpeed * (-ADS_GlobalDirection).xz ) + ( (appendResult6_g1798).xz * ADS_TurbulenceScale ));
			float lerpResult136_g1796 = lerp( 1.0 , saturate( pow( abs( tex2Dlod( ADS_TurbulenceTex, float4( panner73_g1796, 0, 0.0) ).r ) , ADS_TurbulenceContrast ) ) , _GlobalTurbulence);
			float ifLocalVar94_g1796 = 0;
			UNITY_BRANCH 
			if( ( ADS_TurbulenceTex_ON * _GlobalTurbulence ) > 0.0001 )
				ifLocalVar94_g1796 = lerpResult136_g1796;
			else if( ( ADS_TurbulenceTex_ON * _GlobalTurbulence ) < 0.0001 )
				ifLocalVar94_g1796 = 1.0;
			half Motion_Turbulence1226 = ifLocalVar94_g1796;
			float3 lerpResult293_g1782 = lerp( temp_output_92_0_g1782 , temp_output_160_0_g1782 , Motion_Turbulence1226);
			float3 lerpResult280_g1782 = lerp( ADS_GlobalDirection , float3(0,1,0) , _MotionVertical);
			float3 temp_output_256_0_g1782 = mul( unity_WorldToObject, float4( lerpResult280_g1782 , 0.0 ) ).xyz;
			half3 MotionDirection59_g1782 = temp_output_256_0_g1782;
			half Packed_Plant1134 = v.color.r;
			half MotionMask137_g1782 = Packed_Plant1134;
			float3 temp_output_94_0_g1782 = ( ( lerpResult293_g1782 * MotionDirection59_g1782 ) * MotionMask137_g1782 );
			half3 Motion_Plant1158 = temp_output_94_0_g1782;
			float3 ase_vertex3Pos = v.vertex.xyz;
			half MotionFlutterScale60_g1783 = ( ADS_GlobalScale * _MotionScale3 );
			half MotionFlutterSpeed62_g1783 = ( ADS_GlobalSpeed * _MotionSpeed3 );
			float mulTime90_g1783 = _Time.y * MotionFlutterSpeed62_g1783;
			half MotionlFlutterAmplitude58_g1783 = ( ADS_GlobalAmplitude * _MotionAmplitude3 );
			half Packed_Leaf1169 = v.color.b;
			half MotionMask137_g1783 = Packed_Leaf1169;
			float3 ase_vertexNormal = v.normal.xyz;
			half3 Motion_Leaf1160 = ( ( ( sin( ( ( ase_vertex3Pos * MotionFlutterScale60_g1783 ) + mulTime90_g1783 ) ) * MotionlFlutterAmplitude58_g1783 ) * MotionMask137_g1783 ) * ase_vertexNormal );
			half3 Motion_Output1167 = ( ( Motion_Plant1158 + Motion_Leaf1160 ) * Motion_Turbulence1226 );
			half localunity_ObjectToWorld0w1_g1786 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g1786 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g1786 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g1786 = (float3(localunity_ObjectToWorld0w1_g1786 , localunity_ObjectToWorld1w2_g1786 , localunity_ObjectToWorld2w3_g1786));
			float4 tex2DNode140_g1784 = tex2Dlod( ADS_GlobalTex, float4( ( ( (appendResult6_g1786).xz * (ADS_GlobalUVs).xy ) + (ADS_GlobalUVs).zw ), 0, 0.0) );
			half ADS_GlobalTex_B198_g1784 = tex2DNode140_g1784.b;
			float lerpResult156_g1784 = lerp( ADS_GlobalSizeMin , ADS_GlobalSizeMax , ADS_GlobalTex_B198_g1784);
			half3 Global_Size1211 = ( ( lerpResult156_g1784 * _GlobalSize ) * ase_vertex3Pos );
			v.vertex.xyz += ( Motion_Output1167 + Global_Size1211 );
			float4 temp_cast_2 = (1.0).xxxx;
			half4 ADS_GlobalTintColorOne176_g1784 = ADS_GlobalTintColorOne;
			half4 ADS_GlobalTintColorTwo177_g1784 = ADS_GlobalTintColorTwo;
			half ADS_GlobalTex_R180_g1784 = tex2DNode140_g1784.r;
			float4 lerpResult147_g1784 = lerp( ADS_GlobalTintColorOne176_g1784 , ADS_GlobalTintColorTwo177_g1784 , ADS_GlobalTex_R180_g1784);
			half ADS_GlobalTintIntensity181_g1784 = ADS_GlobalTintIntensity;
			half GlobalTint186_g1784 = _GlobalTint;
			float4 lerpResult150_g1784 = lerp( temp_cast_2 , ( lerpResult147_g1784 * ADS_GlobalTintIntensity181_g1784 ) , GlobalTint186_g1784);
			o.vertexToFrag1207 = lerpResult150_g1784;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalTex607 = i.uv_texcoord;
			float3 temp_output_13_0_g1794 = UnpackScaleNormal( tex2D( _NormalTex, uv_NormalTex607 ), _NormalScale );
			float3 break17_g1794 = temp_output_13_0_g1794;
			float switchResult12_g1794 = (((i.ASEVFace>0)?(break17_g1794.z):(-break17_g1794.z)));
			float3 appendResult18_g1794 = (float3(break17_g1794.x , break17_g1794.y , switchResult12_g1794));
			float3 lerpResult20_g1794 = lerp( temp_output_13_0_g1794 , appendResult18_g1794 , _NormalInvertOnBackface);
			half3 Main_NormalTex620 = lerpResult20_g1794;
			o.Normal = Main_NormalTex620;
			float2 uv_AlbedoTex18 = i.uv_texcoord;
			float4 tex2DNode18 = tex2D( _AlbedoTex, uv_AlbedoTex18 );
			half4 Main_AlbedoTex487 = tex2DNode18;
			half4 Main_Color486 = _Color;
			half4 Gloabl_Tint1210 = i.vertexToFrag1207;
			o.Albedo = saturate( ( Main_AlbedoTex487 * Main_Color486 * Gloabl_Tint1210 ) ).rgb;
			half OUT_SMOOTHNESS660 = _Smoothness;
			o.Smoothness = OUT_SMOOTHNESS660;
			o.Alpha = 1;
			half Main_AlbedoTex_A616 = tex2DNode18.a;
			clip( Main_AlbedoTex_A616 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Utils/ADS Fallback"
	CustomEditor "ADSShaderGUI"
}
/*ASEBEGIN
Version=16209
1927;29;1906;1014;2189.416;1089.443;2.448041;True;False
Node;AmplifyShaderEditor.VertexColorNode;1124;-1280,-256;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1225;-1280,0;Float;False;ADS Global Turbulence;14;;1796;047eb809542f42d40b4b5066e22cee72;0;0;1;FLOAT;85
Node;AmplifyShaderEditor.RegisterLocalVarNode;1129;-1024,-128;Half;False;Packed_Variation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1134;-1024,-256;Half;False;Packed_Plant;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1226;-1024,0;Half;False;Motion_Turbulence;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1169;-1024,-192;Half;False;Packed_Leaf;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1174;-512,-16;Float;False;Property;_MotionVariation;Plant Motion Variation;28;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1172;-512,64;Float;False;1129;Packed_Variation;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1153;768,-176;Float;False;Property;_MotionSpeed3;Leaf Motion Speed;33;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1227;-512,160;Float;False;1226;Motion_Turbulence;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1152;-512,256;Float;False;1134;Packed_Plant;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1204;-512,352;Float;False;Property;_MotionVertical;Plant Motion Vertical;29;0;Create;False;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1150;768,-96;Float;False;Property;_MotionScale3;Leaf Motion Scale;34;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1147;-512,-176;Float;False;Property;_MotionSpeed;Plant Motion Speed;26;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1143;-512,-256;Float;False;Property;_MotionAmplitude;Plant Motion Amplitude;25;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1142;-512,-96;Float;False;Property;_MotionScale;Plant Motion Scale;27;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1144;768,0;Float;False;1169;Packed_Leaf;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1173;-256,-16;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1139;768,-256;Float;False;Property;_MotionAmplitude3;Leaf Motion Amplitude;32;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1155;64,-256;Float;False;ADS Motion Custom;37;;1782;157ee7880d81d9e4ab5582c2b22b9a68;8,225,0,278,1,228,1,292,2,254,0,262,0,252,3,260,0;9;220;FLOAT;0;False;221;FLOAT;0;False;222;FLOAT;0;False;218;FLOAT;0;False;287;FLOAT;0;False;136;FLOAT;0;False;248;FLOAT3;0,0,0;False;279;FLOAT;0;False;247;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1224;1088,-256;Float;False;ADS Motion Flutter;-1;;1783;87d8028e5f83178498a65cfa9f0e9ace;0;4;220;FLOAT;0;False;221;FLOAT;0;False;222;FLOAT;0;False;136;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1160;1408,-256;Half;False;Motion_Leaf;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1158;384,-256;Half;False;Motion_Plant;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1161;1792,-160;Float;False;1160;Motion_Leaf;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1163;1792,-256;Float;False;1158;Motion_Plant;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1206;-1280,768;Float;False;ADS Global Settings;18;;1784;0fe83146627632b4981f5a0aa1b63801;0;1;171;FLOAT;0;False;3;COLOR;85;COLOR;165;FLOAT;157
Node;AmplifyShaderEditor.GetLocalVarNode;1228;1792,-64;Float;False;1226;Motion_Turbulence;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;1221;-1280,896;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;409;-592,-896;Half;False;Property;_Color;Plant Color;6;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;-1280,-896;Float;True;Property;_AlbedoTex;Plant Albedo;7;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;655;0,-896;Half;False;Property;_NormalScale;Plant Normal Scale;9;0;Create;False;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexToFragmentNode;1207;-768,768;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1164;2048,-256;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1217;288,-704;Half;False;Property;_NormalInvertOnBackface;Plant Normal Backface;8;1;[Toggle];Create;False;2;Opaque;0;Transparent;1;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;607;256,-896;Float;True;Property;_NormalTex;Plant Normal;10;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;-336,-896;Half;False;Main_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-976,-896;Half;False;Main_AlbedoTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1210;-384,768;Half;False;Gloabl_Tint;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1166;2240,-256;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1209;-768,896;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1211;-384,896;Half;False;Global_Size;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1083;-1280,-2112;Float;False;486;Main_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1215;592,-896;Float;False;ADS Normal Backface;-1;;1794;4f53bc25e6d8da34db70401bcf363a2a;0;2;13;FLOAT3;0,0,0;False;30;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;-1280,-2176;Float;False;487;Main_AlbedoTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1213;-1280,-2032;Float;False;1210;Gloabl_Tint;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;294;1920,-816;Half;False;Property;_Smoothness;Plant Smoothness;12;0;Create;False;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1167;2400,-256;Half;False;Motion_Output;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1214;-1280,-1456;Float;False;1211;Global_Size;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1175;-1280,-1536;Float;False;1167;Motion_Output;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;660;2400,-896;Half;False;OUT_SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1074;-768,-2176;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;-976,-768;Half;False;Main_AlbedoTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;832,-896;Half;False;Main_NormalTex;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1191;512,-2688;Half;False;Property;_Internal_DebugMask;Internal_DebugMask;59;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1179;-1024,-1536;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;744;1536,-768;Half;False;Main_SurfaceTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;791;-1280,-1664;Float;False;616;Main_AlbedoTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1118;-272,-3360;Half;False;Property;_ADVANCEDD;[ ADVANCEDD ];35;0;Create;True;0;0;True;1;BCategory(Advanced);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;624;-1280,-1920;Float;False;620;Main_NormalTex;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;862;-1120,-2688;Half;False;Property;_Cutoff;Cutout;4;0;Create;False;3;Off;0;Front;1;Back;2;0;True;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1199;-640,-2688;Float;False;Internal Unity Props;47;;1795;b286e6ef621b64a4fb35da1e13fa143f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1193;1280,-2688;Half;False;Property;_Internal_SetByScript;Internal_SetByScript;61;1;[HideInInspector];Create;True;0;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1115;-1088,-3360;Half;False;Property;_MAINN;[ MAINN ];5;0;Create;True;0;0;True;1;BCategory(Main);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1119;-1280,-3456;Half;False;Property;_ADSStandardLitPlant;< ADS Standard Lit Plant >;1;0;Create;True;0;0;True;1;BBanner(ADS Standard Lit, Plant);1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1201;-160,-2688;Half;False;Property;_Internal_ADS;Internal_ADS;46;1;[HideInInspector];Create;True;0;0;True;0;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;2240,-896;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1195;32,-2688;Half;False;Property;_Internal_TypePlant;Internal_TypePlant;58;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;654;-1280,-1760;Float;False;660;OUT_SMOOTHNESS;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;749;1920,-896;Float;False;744;Main_SurfaceTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1113;-1280,-3360;Half;False;Property;_RENDERINGG;[ RENDERINGG ];2;0;Create;True;0;0;True;1;BCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1202;1008,-2688;Half;False;Property;_Internal_DebugVariation;Internal_DebugVariation;62;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;743;-1280,-2688;Half;False;Property;_RenderFaces;Render Faces;3;1;[Enum];Create;True;3;Two Sided;0;Back;1;Front;2;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1222;-1280,-3264;Half;False;Property;_PlantMotionParameters;!!! Plant Motion Parameters !!!;24;0;Create;True;0;0;True;1;BMessage(Info, The Plant Motion Parameters will be overridden by the ADS Materials Helper Component, _Internal_SetByScript, 1, 0, 10);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1223;-976,-3264;Half;False;Property;_LeafMotionParameters;!!! Leaf Motion Parameters !!!;31;0;Create;True;0;0;True;1;BMessage(Info, The Leaf Motion Parameters will be overridden by the ADS Materials Helper Component, _Internal_SetByScript, 1, 0, 10);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1171;-528,-3360;Half;False;Property;_MOTIONLEAFF;[ MOTION LEAFF ];30;0;Create;True;0;0;True;1;BCategory(Leaf Motion);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1220;-672,-3264;Half;False;Property;_BatchingInfo;!!! BatchingInfo;36;0;Create;True;0;0;True;1;BMessage(Info, Batching is not currently supported Please use GPU Instancing instead for better performance, 0, 0);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1192;752,-2688;Half;False;Property;_Internal_DebugMask2;Internal_DebugMask2;60;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1109;-576,-2176;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1196;272,-2688;Half;False;Property;_Internal_LitStandard;Internal_LitStandard;57;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1117;-752,-3360;Half;False;Property;_MOTIONPLANTT;[ MOTION PLANTT ];23;0;Create;True;0;0;True;1;BCategory(Plant Motion);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1218;-384,-2688;Half;False;Property;_Internal_Version;Internal_Version;0;1;[HideInInspector];Create;True;0;0;True;0;220;1;220;220;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;645;1152,-896;Float;True;Property;_SurfaceTex;Plant Surface;11;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1116;-928,-3360;Half;False;Property;_SETTINGS;[ SETTINGS ];13;0;Create;True;0;0;True;1;BCategory(Settings);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-128,-2048;Float;False;True;2;Float;ADSShaderGUI;300;0;Standard;BOXOPHOBIC/Advanced Dynamic Shaders/Standard Lit/Plant;False;False;False;False;False;False;True;True;True;False;True;False;False;True;False;False;True;False;False;False;Off;0;False;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;False;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;550;10;False;553;0;1;False;550;10;False;553;0;True;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;300;Utils/ADS Fallback;-1;-1;-1;-1;0;False;0;0;True;743;-1;0;True;862;3;Include;../../../Utils/CGIncludes/VS_indirect.cginc;False;;Pragma;instancing_options procedural:setup;False;;Pragma;multi_compile GPU_FRUSTUM_ON __;False;;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;683;-1280,-2816;Float;False;417.3682;100;Rendering And Settings;0;;1,0,0.503,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1112;-1280,-3584;Float;False;1185.27;100;Drawers;0;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;708;0,-1024;Float;False;1024.6;100;Normal Texture;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1212;-1280,640;Float;False;1090.415;100;Globals;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;715;1152,-1024;Float;False;1473.26;100;Surface Input;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;760;-1280,-1024;Float;False;1152.612;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1198;-640,-2816;Float;False;2140.52;100;Internal Only;0;;1,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1170;-1280,-384;Float;False;3876.78;100;Motion;0;;0.03448272,1,0,1;0;0
WireConnection;1129;0;1124;4
WireConnection;1134;0;1124;1
WireConnection;1226;0;1225;85
WireConnection;1169;0;1124;3
WireConnection;1173;0;1174;0
WireConnection;1173;1;1172;0
WireConnection;1155;220;1143;0
WireConnection;1155;221;1147;0
WireConnection;1155;222;1142;0
WireConnection;1155;218;1173;0
WireConnection;1155;287;1227;0
WireConnection;1155;136;1152;0
WireConnection;1155;279;1204;0
WireConnection;1224;220;1139;0
WireConnection;1224;221;1153;0
WireConnection;1224;222;1150;0
WireConnection;1224;136;1144;0
WireConnection;1160;0;1224;0
WireConnection;1158;0;1155;0
WireConnection;1207;0;1206;85
WireConnection;1164;0;1163;0
WireConnection;1164;1;1161;0
WireConnection;607;5;655;0
WireConnection;486;0;409;0
WireConnection;487;0;18;0
WireConnection;1210;0;1207;0
WireConnection;1166;0;1164;0
WireConnection;1166;1;1228;0
WireConnection;1209;0;1206;157
WireConnection;1209;1;1221;0
WireConnection;1211;0;1209;0
WireConnection;1215;13;607;0
WireConnection;1215;30;1217;0
WireConnection;1167;0;1166;0
WireConnection;660;0;294;0
WireConnection;1074;0;36;0
WireConnection;1074;1;1083;0
WireConnection;1074;2;1213;0
WireConnection;616;0;18;4
WireConnection;620;0;1215;0
WireConnection;1179;0;1175;0
WireConnection;1179;1;1214;0
WireConnection;744;0;645;4
WireConnection;745;0;749;0
WireConnection;745;1;294;0
WireConnection;1109;0;1074;0
WireConnection;0;0;1109;0
WireConnection;0;1;624;0
WireConnection;0;4;654;0
WireConnection;0;10;791;0
WireConnection;0;11;1179;0
ASEEND*/
//CHKSM=E01A2A239DD0D0405726B2E5D440555CA1B845E8