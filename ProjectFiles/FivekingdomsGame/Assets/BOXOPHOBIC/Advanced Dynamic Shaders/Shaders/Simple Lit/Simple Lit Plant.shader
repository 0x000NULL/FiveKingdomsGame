// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/Advanced Dynamic Shaders/Simple Lit/Plant"
{
	Properties
	{
		[HideInInspector]_Internal_Version("Internal_Version", Float) = 220
		[BBanner(ADS Simple Lit, Plant)]_ADSSimpleLitPlant("< ADS Simple Lit Plant >", Float) = 1
		[BCategory(Rendering)]_RENDERINGG("[ RENDERINGG ]", Float) = 0
		[Enum(Two Sided,0,Back,1,Front,2)]_RenderFaces("Render Faces", Float) = 0
		_Cutoff("Cutout", Range( 0 , 1)) = 0.5
		[BCategory(Main)]_MAINN("[ MAINN ]", Float) = 0
		_Color("Plant Color", Color) = (1,1,1,1)
		[NoScaleOffset]_AlbedoTex("Plant Albedo", 2D) = "white" {}
		[Toggle]_NormalInvertOnBackface("Plant Normal Backface", Float) = 1
		_NormalScale("Plant Normal Scale", Float) = 1
		[NoScaleOffset]_NormalTex("Plant Normal", 2D) = "bump" {}
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
		_MotionAmplitude3("Leaf Flutter Amplitude", Float) = 0
		_MotionSpeed3("Leaf Flutter Speed", Float) = 0
		_MotionScale3("Leaf Flutter Scale", Float) = 0
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
		[HideInInspector]_Internal_LitSimple("Internal_LitSimple", Float) = 1
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
		LOD 200
		Cull [_RenderFaces]
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#include "../../../Utils/CGIncludes/VS_indirect.cginc"
		#pragma instancing_options procedural:setup
		#pragma multi_compile GPU_FRUSTUM_ON __
		#pragma exclude_renderers gles 
		#pragma surface surf Lambert keepalpha addshadow fullforwardshadows nolightmap  nodynlightmap nodirlightmap nometa vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			half ASEVFace : VFACE;
			float4 vertexToFrag1248;
		};

		uniform half _MotionSpaceee;
		uniform half _MotionSpacee;
		uniform half _MotionSpaceeeEnd;
		uniform half _MotionSpaceeEnd;
		uniform half _SETTINGS;
		uniform half _LeafMotionParameters;
		uniform half _PlantMotionParameters;
		uniform half _BatchingInfo;
		uniform half _Internal_Version;
		uniform half _Cutoff;
		uniform half _Internal_TypePlant;
		uniform half _Internal_DebugMask2;
		uniform half _Internal_DebugVariation;
		uniform half _RENDERINGG;
		uniform half _ADSSimpleLitPlant;
		uniform half4 _MainUVs;
		uniform float _Mode;
		uniform float _Glossiness;
		uniform half _CullMode;
		uniform float _BumpScale;
		uniform sampler2D _MetallicGlossMap;
		uniform half _Internal_UnityToBoxophobic;
		uniform sampler2D _MainTex;
		uniform sampler2D _BumpMap;
		uniform half _MOTIONLEAFF;
		uniform half _Internal_ADS;
		uniform half _ADVANCEDD;
		uniform half _MAINN;
		uniform half _RenderFaces;
		uniform half _Internal_SetByScript;
		uniform half _Internal_DebugMask;
		uniform half _Internal_LitSimple;
		uniform half _MOTIONPLANTT;
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
		uniform half4 _Color;
		uniform sampler2D _AlbedoTex;
		uniform half4 ADS_GlobalTintColorOne;
		uniform half4 ADS_GlobalTintColorTwo;
		uniform half ADS_GlobalTintIntensity;
		uniform half _GlobalTint;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			half MotionScale60_g1556 = ( ADS_GlobalScale * _MotionScale );
			half MotionSpeed62_g1556 = ( ADS_GlobalSpeed * _MotionSpeed );
			float mulTime90_g1556 = _Time.y * MotionSpeed62_g1556;
			float3 temp_output_95_0_g1556 = ( ( ase_worldPos * MotionScale60_g1556 ) + mulTime90_g1556 );
			half Packed_Variation1129 = v.color.a;
			half MotionVariation269_g1556 = ( _MotionVariation * Packed_Variation1129 );
			half MotionlAmplitude58_g1556 = ( ADS_GlobalAmplitude * _MotionAmplitude );
			float3 temp_output_92_0_g1556 = ( sin( ( temp_output_95_0_g1556 + MotionVariation269_g1556 ) ) * MotionlAmplitude58_g1556 );
			float3 temp_output_160_0_g1556 = ( temp_output_92_0_g1556 + MotionlAmplitude58_g1556 + MotionlAmplitude58_g1556 );
			half localunity_ObjectToWorld0w1_g1581 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g1581 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g1581 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g1581 = (float3(localunity_ObjectToWorld0w1_g1581 , localunity_ObjectToWorld1w2_g1581 , localunity_ObjectToWorld2w3_g1581));
			float2 panner73_g1579 = ( _Time.y * ( ADS_TurbulenceSpeed * (-ADS_GlobalDirection).xz ) + ( (appendResult6_g1581).xz * ADS_TurbulenceScale ));
			float lerpResult136_g1579 = lerp( 1.0 , saturate( pow( abs( tex2Dlod( ADS_TurbulenceTex, float4( panner73_g1579, 0, 0.0) ).r ) , ADS_TurbulenceContrast ) ) , _GlobalTurbulence);
			float ifLocalVar94_g1579 = 0;
			UNITY_BRANCH 
			if( ( ADS_TurbulenceTex_ON * _GlobalTurbulence ) > 0.0001 )
				ifLocalVar94_g1579 = lerpResult136_g1579;
			else if( ( ADS_TurbulenceTex_ON * _GlobalTurbulence ) < 0.0001 )
				ifLocalVar94_g1579 = 1.0;
			half Motion_Turbulence1267 = ifLocalVar94_g1579;
			float3 lerpResult293_g1556 = lerp( temp_output_92_0_g1556 , temp_output_160_0_g1556 , Motion_Turbulence1267);
			float3 lerpResult280_g1556 = lerp( ADS_GlobalDirection , float3(0,1,0) , _MotionVertical);
			float3 temp_output_256_0_g1556 = mul( unity_WorldToObject, float4( lerpResult280_g1556 , 0.0 ) ).xyz;
			half3 MotionDirection59_g1556 = temp_output_256_0_g1556;
			half Packed_Plant1134 = v.color.r;
			half MotionMask137_g1556 = Packed_Plant1134;
			float3 temp_output_94_0_g1556 = ( ( lerpResult293_g1556 * MotionDirection59_g1556 ) * MotionMask137_g1556 );
			half3 Motion_Plant1158 = temp_output_94_0_g1556;
			float3 ase_vertex3Pos = v.vertex.xyz;
			half MotionFlutterScale60_g1557 = ( ADS_GlobalScale * _MotionScale3 );
			half MotionFlutterSpeed62_g1557 = ( ADS_GlobalSpeed * _MotionSpeed3 );
			float mulTime90_g1557 = _Time.y * MotionFlutterSpeed62_g1557;
			half MotionlFlutterAmplitude58_g1557 = ( ADS_GlobalAmplitude * _MotionAmplitude3 );
			half Packed_Leaf1169 = v.color.b;
			half MotionMask137_g1557 = Packed_Leaf1169;
			float3 ase_vertexNormal = v.normal.xyz;
			half3 Motion_Leaf1160 = ( ( ( sin( ( ( ase_vertex3Pos * MotionFlutterScale60_g1557 ) + mulTime90_g1557 ) ) * MotionlFlutterAmplitude58_g1557 ) * MotionMask137_g1557 ) * ase_vertexNormal );
			half3 Motion_Output1167 = ( ( Motion_Plant1158 + Motion_Leaf1160 ) * Motion_Turbulence1267 );
			half localunity_ObjectToWorld0w1_g1560 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g1560 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g1560 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g1560 = (float3(localunity_ObjectToWorld0w1_g1560 , localunity_ObjectToWorld1w2_g1560 , localunity_ObjectToWorld2w3_g1560));
			float4 tex2DNode140_g1558 = tex2Dlod( ADS_GlobalTex, float4( ( ( (appendResult6_g1560).xz * (ADS_GlobalUVs).xy ) + (ADS_GlobalUVs).zw ), 0, 0.0) );
			half ADS_GlobalTex_B198_g1558 = tex2DNode140_g1558.b;
			float lerpResult156_g1558 = lerp( ADS_GlobalSizeMin , ADS_GlobalSizeMax , ADS_GlobalTex_B198_g1558);
			half3 Global_Size1252 = ( ( lerpResult156_g1558 * _GlobalSize ) * ase_vertex3Pos );
			v.vertex.xyz += ( Motion_Output1167 + Global_Size1252 );
			float4 temp_cast_2 = (1.0).xxxx;
			half4 ADS_GlobalTintColorOne176_g1558 = ADS_GlobalTintColorOne;
			half4 ADS_GlobalTintColorTwo177_g1558 = ADS_GlobalTintColorTwo;
			half ADS_GlobalTex_R180_g1558 = tex2DNode140_g1558.r;
			float4 lerpResult147_g1558 = lerp( ADS_GlobalTintColorOne176_g1558 , ADS_GlobalTintColorTwo177_g1558 , ADS_GlobalTex_R180_g1558);
			half ADS_GlobalTintIntensity181_g1558 = ADS_GlobalTintIntensity;
			half GlobalTint186_g1558 = _GlobalTint;
			float4 lerpResult150_g1558 = lerp( temp_cast_2 , ( lerpResult147_g1558 * ADS_GlobalTintIntensity181_g1558 ) , GlobalTint186_g1558);
			o.vertexToFrag1248 = lerpResult150_g1558;
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_NormalTex607 = i.uv_texcoord;
			float3 temp_output_13_0_g1568 = UnpackScaleNormal( tex2D( _NormalTex, uv_NormalTex607 ), _NormalScale );
			float3 break17_g1568 = temp_output_13_0_g1568;
			float switchResult12_g1568 = (((i.ASEVFace>0)?(break17_g1568.z):(-break17_g1568.z)));
			float3 appendResult18_g1568 = (float3(break17_g1568.x , break17_g1568.y , switchResult12_g1568));
			float3 lerpResult20_g1568 = lerp( temp_output_13_0_g1568 , appendResult18_g1568 , _NormalInvertOnBackface);
			half3 Main_NormalTex620 = lerpResult20_g1568;
			o.Normal = Main_NormalTex620;
			half4 Main_Color486 = _Color;
			float2 uv_AlbedoTex18 = i.uv_texcoord;
			float4 tex2DNode18 = tex2D( _AlbedoTex, uv_AlbedoTex18 );
			half4 Main_AlbedoTex487 = tex2DNode18;
			half4 Gloabl_Tint1251 = i.vertexToFrag1248;
			o.Albedo = saturate( ( Main_Color486 * Main_AlbedoTex487 * Gloabl_Tint1251 ) ).rgb;
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
1927;29;1906;1014;-272.535;906.355;1;True;False
Node;AmplifyShaderEditor.VertexColorNode;1124;-1280,-640;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1266;-1280,-384;Float;False;ADS Global Turbulence;14;;1579;047eb809542f42d40b4b5066e22cee72;0;0;1;FLOAT;85
Node;AmplifyShaderEditor.RegisterLocalVarNode;1129;-1024,-512;Half;False;Packed_Variation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1169;-1024,-576;Half;False;Packed_Leaf;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1267;-1024,-384;Half;False;Motion_Turbulence;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1172;-512,-320;Float;False;1129;Packed_Variation;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1134;-1024,-640;Half;False;Packed_Plant;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1174;-512,-400;Float;False;Property;_MotionVariation;Plant Motion Variation;28;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1245;-512,-32;Float;False;Property;_MotionVertical;Plant Motion Vertical;29;0;Create;False;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1152;-512,-128;Float;False;1134;Packed_Plant;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1153;768,-560;Float;False;Property;_MotionSpeed3;Leaf Flutter Speed;33;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1139;768,-640;Float;False;Property;_MotionAmplitude3;Leaf Flutter Amplitude;32;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1268;-512,-224;Float;False;1267;Motion_Turbulence;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1150;768,-480;Float;False;Property;_MotionScale3;Leaf Flutter Scale;34;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1173;-256,-400;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1147;-512,-560;Float;False;Property;_MotionSpeed;Plant Motion Speed;26;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1143;-512,-640;Float;False;Property;_MotionAmplitude;Plant Motion Amplitude;25;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1144;768,-384;Float;False;1169;Packed_Leaf;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1142;-512,-480;Float;False;Property;_MotionScale;Plant Motion Scale;27;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1155;64,-640;Float;False;ADS Motion Custom;37;;1556;157ee7880d81d9e4ab5582c2b22b9a68;8,225,0,278,1,228,1,292,2,254,0,262,0,252,3,260,0;9;220;FLOAT;0;False;221;FLOAT;0;False;222;FLOAT;0;False;218;FLOAT;0;False;287;FLOAT;0;False;136;FLOAT;0;False;248;FLOAT3;0,0,0;False;279;FLOAT;0;False;247;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1265;1088,-640;Float;False;ADS Motion Flutter;-1;;1557;87d8028e5f83178498a65cfa9f0e9ace;0;4;220;FLOAT;0;False;221;FLOAT;0;False;222;FLOAT;0;False;136;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1158;384,-640;Half;False;Motion_Plant;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1160;1408,-640;Half;False;Motion_Leaf;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1247;-1280,384;Float;False;ADS Global Settings;18;;1558;0fe83146627632b4981f5a0aa1b63801;0;1;171;FLOAT;0;False;3;COLOR;85;COLOR;165;FLOAT;157
Node;AmplifyShaderEditor.GetLocalVarNode;1161;1792,-544;Float;False;1160;Motion_Leaf;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1163;1792,-640;Float;False;1158;Motion_Plant;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1269;1792,-448;Float;False;1267;Motion_Turbulence;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1164;2048,-640;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PosVertexDataNode;1262;-1280,512;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexToFragmentNode;1248;-768,384;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;409;-592,-1280;Half;False;Property;_Color;Plant Color;6;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;655;0,-1280;Half;False;Property;_NormalScale;Plant Normal Scale;9;0;Create;False;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;-1280,-1280;Float;True;Property;_AlbedoTex;Plant Albedo;7;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1251;-384,384;Half;False;Gloabl_Tint;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;-336,-1280;Half;False;Main_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1258;288,-1088;Half;False;Property;_NormalInvertOnBackface;Plant Normal Backface;8;1;[Toggle];Create;False;2;Opaque;0;Transparent;1;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1166;2240,-640;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-976,-1280;Half;False;Main_AlbedoTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;607;256,-1280;Float;True;Property;_NormalTex;Plant Normal;10;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1250;-768,512;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1255;-1280,-2304;Float;False;1251;Gloabl_Tint;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1257;592,-1280;Float;False;ADS Normal Backface;-1;;1568;4f53bc25e6d8da34db70401bcf363a2a;0;2;13;FLOAT3;0,0,0;False;30;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1235;-1280,-2432;Float;False;486;Main_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1252;-384,512;Half;False;Global_Size;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1167;2400,-640;Half;False;Motion_Output;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1236;-1280,-2368;Float;False;487;Main_AlbedoTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1237;-944,-2432;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;816,-1280;Half;False;Main_NormalTex;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;-976,-1152;Half;False;Main_AlbedoTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1254;-1280,-1856;Float;False;1252;Global_Size;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1175;-1280,-1920;Float;False;1167;Motion_Output;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1193;1264,-2944;Half;False;Property;_Internal_SetByScript;Internal_SetByScript;61;1;[HideInInspector];Create;True;0;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1191;496,-2944;Half;False;Property;_Internal_DebugMask;Internal_DebugMask;59;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;645;1152,-1280;Float;True;Property;_SurfaceTex;Plant Surface;12;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;743;-1280,-2944;Half;False;Property;_RenderFaces;Render Faces;3;1;[Enum];Create;True;3;Two Sided;0;Back;1;Front;2;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;749;1920,-1280;Float;False;744;Main_SurfaceTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1196;256,-2944;Half;False;Property;_Internal_LitSimple;Internal_LitSimple;57;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1117;-752,-3616;Half;False;Property;_MOTIONPLANTT;[ MOTION PLANTT ];23;0;Create;True;0;0;True;1;BCategory(Plant Motion);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1179;-1024,-1920;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;624;-1280,-2176;Float;False;620;Main_NormalTex;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;2240,-1280;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;791;-1280,-2048;Float;False;616;Main_AlbedoTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1264;-976,-3520;Half;False;Property;_LeafMotionParameters;!!! Leaf Motion Parameters !!!;31;0;Create;True;0;0;True;1;BMessage(Info, The Leaf Motion Parameters will be overridden by the ADS Materials Helper Component, _Internal_SetByScript, 1, 0, 10);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1263;-1280,-3520;Half;False;Property;_PlantMotionParameters;!!! Plant Motion Parameters !!!;24;0;Create;True;0;0;True;1;BMessage(Info, The Plant Motion Parameters will be overridden by the ADS Materials Helper Component, _Internal_SetByScript, 1, 0, 10);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1116;-928,-3616;Half;False;Property;_SETTINGS;[ SETTINGS ];13;0;Create;True;0;0;True;1;BCategory(Settings);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1256;-736,-2432;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;294;1920,-1200;Half;False;Property;_Smoothness;Plant Smoothness;11;0;Create;False;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1192;736,-2944;Half;False;Property;_Internal_DebugMask2;Internal_DebugMask2;60;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1195;16,-2944;Half;False;Property;_Internal_TypePlant;Internal_TypePlant;58;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;862;-1120,-2944;Half;False;Property;_Cutoff;Cutout;4;0;Create;False;3;Off;0;Front;1;Back;2;0;True;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1261;-672,-3520;Half;False;Property;_BatchingInfo;!!! BatchingInfo;36;0;Create;True;0;0;True;1;BMessage(Info, Batching is not currently supported Please use GPU Instancing instead for better performance, 0, 0);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1259;-384,-2944;Half;False;Property;_Internal_Version;Internal_Version;0;1;[HideInInspector];Create;True;0;0;True;0;220;1;220;220;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1241;992,-2944;Half;False;Property;_Internal_DebugVariation;Internal_DebugVariation;62;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1115;-1088,-3616;Half;False;Property;_MAINN;[ MAINN ];5;0;Create;True;0;0;True;1;BCategory(Main);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1118;-272,-3616;Half;False;Property;_ADVANCEDD;[ ADVANCEDD ];35;0;Create;True;0;0;True;1;BCategory(Advanced);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;646;1536,-1280;Half;False;Main_SurfaceTex_R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;660;2432,-1280;Half;False;OUT_SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;744;1536,-1152;Half;False;Main_SurfaceTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1240;-176,-2944;Half;False;Property;_Internal_ADS;Internal_ADS;46;1;[HideInInspector];Create;True;0;0;True;0;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1119;-1280,-3712;Half;False;Property;_ADSSimpleLitPlant;< ADS Simple Lit Plant >;1;0;Create;True;0;0;True;1;BBanner(ADS Simple Lit, Plant);1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1113;-1280,-3616;Half;False;Property;_RENDERINGG;[ RENDERINGG ];2;0;Create;True;0;0;True;1;BCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1171;-528,-3616;Half;False;Property;_MOTIONLEAFF;[ MOTION LEAFF ];30;0;Create;True;0;0;True;1;BCategory(Leaf Motion);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1199;-640,-2944;Float;False;Internal Unity Props;47;;1569;b286e6ef621b64a4fb35da1e13fa143f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-512,-2432;Float;False;True;2;Float;ADSShaderGUI;200;0;Lambert;BOXOPHOBIC/Advanced Dynamic Shaders/Simple Lit/Plant;False;False;False;False;False;False;True;True;True;False;True;False;False;True;False;False;False;False;False;False;Off;0;False;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;False;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;550;10;False;553;0;1;False;550;10;False;553;0;True;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;200;Utils/ADS Fallback;-1;-1;-1;-1;0;False;0;0;True;743;-1;0;True;862;3;Include;../../../Utils/CGIncludes/VS_indirect.cginc;False;;Pragma;instancing_options procedural:setup;False;;Pragma;multi_compile GPU_FRUSTUM_ON __;False;;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;1170;-1280,-768;Float;False;3885.181;100;Motion;0;;0.03448272,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;715;1152,-1408;Float;False;1501.26;100;Surface Input;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;708;0,-1408;Float;False;1024.6;100;Normal Texture;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;683;-1280,-3072;Float;False;417.3682;100;Rendering And Settings;0;;1,0,0.503,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;760;-1280,-1408;Float;False;1152.612;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1198;-640,-3072;Float;False;2117.369;100;Internal Only;0;;1,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1112;-1280,-3840;Float;False;1185.27;100;Drawers;0;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1253;-1280,256;Float;False;1090.415;100;Globals;0;;1,0.7686275,0,1;0;0
WireConnection;1129;0;1124;4
WireConnection;1169;0;1124;3
WireConnection;1267;0;1266;85
WireConnection;1134;0;1124;1
WireConnection;1173;0;1174;0
WireConnection;1173;1;1172;0
WireConnection;1155;220;1143;0
WireConnection;1155;221;1147;0
WireConnection;1155;222;1142;0
WireConnection;1155;218;1173;0
WireConnection;1155;287;1268;0
WireConnection;1155;136;1152;0
WireConnection;1155;279;1245;0
WireConnection;1265;220;1139;0
WireConnection;1265;221;1153;0
WireConnection;1265;222;1150;0
WireConnection;1265;136;1144;0
WireConnection;1158;0;1155;0
WireConnection;1160;0;1265;0
WireConnection;1164;0;1163;0
WireConnection;1164;1;1161;0
WireConnection;1248;0;1247;85
WireConnection;1251;0;1248;0
WireConnection;486;0;409;0
WireConnection;1166;0;1164;0
WireConnection;1166;1;1269;0
WireConnection;487;0;18;0
WireConnection;607;5;655;0
WireConnection;1250;0;1247;157
WireConnection;1250;1;1262;0
WireConnection;1257;13;607;0
WireConnection;1257;30;1258;0
WireConnection;1252;0;1250;0
WireConnection;1167;0;1166;0
WireConnection;1237;0;1235;0
WireConnection;1237;1;1236;0
WireConnection;1237;2;1255;0
WireConnection;620;0;1257;0
WireConnection;616;0;18;4
WireConnection;1179;0;1175;0
WireConnection;1179;1;1254;0
WireConnection;745;0;749;0
WireConnection;745;1;294;0
WireConnection;1256;0;1237;0
WireConnection;646;0;645;1
WireConnection;660;0;294;0
WireConnection;744;0;645;4
WireConnection;0;0;1256;0
WireConnection;0;1;624;0
WireConnection;0;10;791;0
WireConnection;0;11;1179;0
ASEEND*/
//CHKSM=A83D97605B3F96310CB535CCAAECA4DDEBD0943B