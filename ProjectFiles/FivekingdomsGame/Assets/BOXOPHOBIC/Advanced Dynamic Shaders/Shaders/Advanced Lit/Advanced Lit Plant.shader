// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/Advanced Dynamic Shaders/Advanced Lit/Plant"
{
	Properties
	{
		[HideInInspector]_Internal_Version("Internal_Version", Float) = 220
		[BBanner(ADS Advanced Lit, Plant)]_ADSAdvancedLitPlant("< ADS Advanced Lit Plant >", Float) = 1
		[BCategory(Rendering)]_RENDERINGG("[ RENDERINGG ]", Float) = 0
		[Enum(Two Sided,0,Back,1,Front,2)]_RenderFaces("Render Faces", Float) = 0
		_Cutoff("Cutout", Range( 0 , 1)) = 0.5
		[BCategory(Main)]_MAINN("[ MAINN ]", Float) = 0
		_Color("Plant Color", Color) = (1,1,1,1)
		[NoScaleOffset]_AlbedoTex("Plant Albedo", 2D) = "white" {}
		_NormalScale("Plant Normal Scale", Float) = 1
		[NoScaleOffset]_NormalTex("Plant Normal", 2D) = "bump" {}
		[NoScaleOffset]_SurfaceTex("Plant Surface", 2D) = "white" {}
		_Smoothness("Plant Smoothness (A)", Range( 0 , 1)) = 1
		_SubsurfaceColor("Plant Subsurface (B)", Color) = (1,1,1,1)
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
		[HideInInspector]_Internal_LitAdvanced("Internal_LitAdvanced", Float) = 1
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
		#include "UnityPBSLighting.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		#include "../../../Utils/CGIncludes/VS_indirect.cginc"
		#pragma instancing_options procedural:setup
		#pragma multi_compile GPU_FRUSTUM_ON __
		#pragma exclude_renderers gles 
		#pragma surface surf StandardCustom keepalpha addshadow fullforwardshadows exclude_path:deferred nolightmap  nodynlightmap nodirlightmap nometa vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			half ASEVFace : VFACE;
			float4 vertexToFrag1230;
		};

		struct SurfaceOutputStandardCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			half3 Transmission;
		};

		uniform float _MotionNoise;
		uniform half _Internal_TypePlant;
		uniform half _Internal_DebugVariation;
		uniform half _RENDERINGG;
		uniform half _RenderFaces;
		uniform half _Internal_SetByScript;
		uniform half _Internal_DebugMask;
		uniform half _Internal_Version;
		uniform half _Internal_ADS;
		uniform half _SETTINGS;
		uniform half _BatchingInfo;
		uniform half _MAINN;
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
		uniform half _ADVANCEDD;
		uniform half _Internal_LitAdvanced;
		uniform half _PlantMotionParameters;
		uniform half _Internal_DebugMask2;
		uniform half _MOTIONLEAFF;
		uniform half _LeafMotionParameters;
		uniform half _ADSAdvancedLitPlant;
		uniform half _MOTIONPLANTT;
		uniform half _MotionSpaceee;
		uniform half _MotionSpacee;
		uniform half _MotionSpaceeeEnd;
		uniform half _MotionSpaceeEnd;
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
		uniform sampler2D _AlbedoTex;
		uniform half4 _Color;
		uniform half4 ADS_GlobalTintColorOne;
		uniform half4 ADS_GlobalTintColorTwo;
		uniform half ADS_GlobalTintIntensity;
		uniform half _GlobalTint;
		uniform sampler2D _SurfaceTex;
		uniform half _Smoothness;
		uniform half4 _SubsurfaceColor;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			half MotionScale60_g1593 = ( ADS_GlobalScale * _MotionScale );
			half MotionSpeed62_g1593 = ( ADS_GlobalSpeed * _MotionSpeed );
			float mulTime90_g1593 = _Time.y * MotionSpeed62_g1593;
			float3 temp_output_95_0_g1593 = ( ( ase_worldPos * MotionScale60_g1593 ) + mulTime90_g1593 );
			half Packed_Variation1129 = v.color.a;
			half MotionVariation269_g1593 = ( _MotionVariation * Packed_Variation1129 );
			half MotionlAmplitude58_g1593 = ( ADS_GlobalAmplitude * _MotionAmplitude );
			float3 temp_output_92_0_g1593 = ( sin( ( temp_output_95_0_g1593 + MotionVariation269_g1593 ) ) * MotionlAmplitude58_g1593 );
			float3 temp_output_160_0_g1593 = ( temp_output_92_0_g1593 + MotionlAmplitude58_g1593 + MotionlAmplitude58_g1593 );
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
			half Motion_Turbulence1248 = ifLocalVar94_g1579;
			float3 lerpResult293_g1593 = lerp( temp_output_92_0_g1593 , temp_output_160_0_g1593 , Motion_Turbulence1248);
			float3 lerpResult280_g1593 = lerp( ADS_GlobalDirection , float3(0,1,0) , _MotionVertical);
			float3 temp_output_256_0_g1593 = mul( unity_WorldToObject, float4( lerpResult280_g1593 , 0.0 ) ).xyz;
			half3 MotionDirection59_g1593 = temp_output_256_0_g1593;
			half Packed_Plant1134 = v.color.r;
			half MotionMask137_g1593 = Packed_Plant1134;
			float3 temp_output_94_0_g1593 = ( ( lerpResult293_g1593 * MotionDirection59_g1593 ) * MotionMask137_g1593 );
			half3 Motion_Plant1158 = temp_output_94_0_g1593;
			float3 ase_vertex3Pos = v.vertex.xyz;
			half MotionFlutterScale60_g1585 = ( ADS_GlobalScale * _MotionScale3 );
			half MotionFlutterSpeed62_g1585 = ( ADS_GlobalSpeed * _MotionSpeed3 );
			float mulTime90_g1585 = _Time.y * MotionFlutterSpeed62_g1585;
			half MotionlFlutterAmplitude58_g1585 = ( ADS_GlobalAmplitude * _MotionAmplitude3 );
			half Packed_Leaf1169 = v.color.b;
			half MotionMask137_g1585 = Packed_Leaf1169;
			float3 ase_vertexNormal = v.normal.xyz;
			half3 Motion_Leaf1160 = ( ( ( sin( ( ( ase_vertex3Pos * MotionFlutterScale60_g1585 ) + mulTime90_g1585 ) ) * MotionlFlutterAmplitude58_g1585 ) * MotionMask137_g1585 ) * ase_vertexNormal );
			half3 Motion_Output1167 = ( ( Motion_Plant1158 + Motion_Leaf1160 ) * Motion_Turbulence1248 );
			half localunity_ObjectToWorld0w1_g1588 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g1588 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g1588 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g1588 = (float3(localunity_ObjectToWorld0w1_g1588 , localunity_ObjectToWorld1w2_g1588 , localunity_ObjectToWorld2w3_g1588));
			float4 tex2DNode140_g1586 = tex2Dlod( ADS_GlobalTex, float4( ( ( (appendResult6_g1588).xz * (ADS_GlobalUVs).xy ) + (ADS_GlobalUVs).zw ), 0, 0.0) );
			half ADS_GlobalTex_B198_g1586 = tex2DNode140_g1586.b;
			float lerpResult156_g1586 = lerp( ADS_GlobalSizeMin , ADS_GlobalSizeMax , ADS_GlobalTex_B198_g1586);
			half3 Global_Size1234 = ( ( lerpResult156_g1586 * _GlobalSize ) * ase_vertex3Pos );
			v.vertex.xyz += ( Motion_Output1167 + Global_Size1234 );
			float4 temp_cast_2 = (1.0).xxxx;
			half4 ADS_GlobalTintColorOne176_g1586 = ADS_GlobalTintColorOne;
			half4 ADS_GlobalTintColorTwo177_g1586 = ADS_GlobalTintColorTwo;
			half ADS_GlobalTex_R180_g1586 = tex2DNode140_g1586.r;
			float4 lerpResult147_g1586 = lerp( ADS_GlobalTintColorOne176_g1586 , ADS_GlobalTintColorTwo177_g1586 , ADS_GlobalTex_R180_g1586);
			half ADS_GlobalTintIntensity181_g1586 = ADS_GlobalTintIntensity;
			half GlobalTint186_g1586 = _GlobalTint;
			float4 lerpResult150_g1586 = lerp( temp_cast_2 , ( lerpResult147_g1586 * ADS_GlobalTintIntensity181_g1586 ) , GlobalTint186_g1586);
			o.vertexToFrag1230 = lerpResult150_g1586;
		}

		inline half4 LightingStandardCustom(SurfaceOutputStandardCustom s, half3 viewDir, UnityGI gi )
		{
			half3 transmission = max(0 , -dot(s.Normal, gi.light.dir)) * gi.light.color * s.Transmission;
			half4 d = half4(s.Albedo * transmission , 0);

			SurfaceOutputStandard r;
			r.Albedo = s.Albedo;
			r.Normal = s.Normal;
			r.Emission = s.Emission;
			r.Metallic = s.Metallic;
			r.Smoothness = s.Smoothness;
			r.Occlusion = s.Occlusion;
			r.Alpha = s.Alpha;
			return LightingStandard (r, viewDir, gi) + d;
		}

		inline void LightingStandardCustom_GI(SurfaceOutputStandardCustom s, UnityGIInput data, inout UnityGI gi )
		{
			#if defined(UNITY_PASS_DEFERRED) && UNITY_ENABLE_REFLECTION_BUFFERS
				gi = UnityGlobalIllumination(data, s.Occlusion, s.Normal);
			#else
				UNITY_GLOSSY_ENV_FROM_SURFACE( g, s, data );
				gi = UnityGlobalIllumination( data, s.Occlusion, s.Normal, g );
			#endif
		}

		void surf( Input i , inout SurfaceOutputStandardCustom o )
		{
			float2 uv_NormalTex607 = i.uv_texcoord;
			float3 break17_g1591 = UnpackScaleNormal( tex2D( _NormalTex, uv_NormalTex607 ), _NormalScale );
			float switchResult12_g1591 = (((i.ASEVFace>0)?(break17_g1591.z):(-break17_g1591.z)));
			float3 appendResult18_g1591 = (float3(break17_g1591.x , break17_g1591.y , switchResult12_g1591));
			half3 Main_NormalTex620 = appendResult18_g1591;
			o.Normal = Main_NormalTex620;
			float2 uv_AlbedoTex18 = i.uv_texcoord;
			float4 tex2DNode18 = tex2D( _AlbedoTex, uv_AlbedoTex18 );
			half4 Main_AlbedoTex487 = tex2DNode18;
			half4 Main_Color486 = _Color;
			half4 Gloabl_Tint1232 = i.vertexToFrag1230;
			o.Albedo = saturate( ( Main_AlbedoTex487 * Main_Color486 * Gloabl_Tint1232 ) ).rgb;
			float2 uv_SurfaceTex645 = i.uv_texcoord;
			float4 tex2DNode645 = tex2D( _SurfaceTex, uv_SurfaceTex645 );
			half Main_SurfaceTex_A744 = tex2DNode645.a;
			half OUT_SMOOTHNESS660 = ( Main_SurfaceTex_A744 * _Smoothness );
			o.Smoothness = OUT_SMOOTHNESS660;
			half Main_SurfaceTex_B1203 = tex2DNode645.b;
			half4 OUT_TRANSMISSION1208 = ( Main_SurfaceTex_B1203 * _SubsurfaceColor );
			o.Transmission = OUT_TRANSMISSION1208.rgb;
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
1927;29;1906;1014;2376.106;1386.935;2.491367;True;False
Node;AmplifyShaderEditor.VertexColorNode;1124;-1280,-256;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1129;-1024,-128;Half;False;Packed_Variation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1221;-1280,0;Float;False;ADS Global Turbulence;14;;1579;047eb809542f42d40b4b5066e22cee72;0;0;1;FLOAT;85
Node;AmplifyShaderEditor.GetLocalVarNode;1172;-512,64;Float;False;1129;Packed_Variation;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1169;-1024,-192;Half;False;Packed_Leaf;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1174;-512,-16;Float;False;Property;_MotionVariation;Plant Motion Variation;28;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1134;-1024,-256;Half;False;Packed_Plant;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1248;-1024,0;Half;False;Motion_Turbulence;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1139;768,-256;Float;False;Property;_MotionAmplitude3;Leaf Flutter Amplitude;32;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1212;-512,352;Float;False;Property;_MotionVertical;Plant Motion Vertical;29;0;Create;False;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1153;768,-176;Float;False;Property;_MotionSpeed3;Leaf Flutter Speed;33;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1144;768,0;Float;False;1169;Packed_Leaf;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1150;768,-96;Float;False;Property;_MotionScale3;Leaf Flutter Scale;34;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1143;-512,-256;Float;False;Property;_MotionAmplitude;Plant Motion Amplitude;25;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1147;-512,-176;Float;False;Property;_MotionSpeed;Plant Motion Speed;26;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1173;-256,-16;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1250;-512,160;Float;False;1248;Motion_Turbulence;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1142;-512,-96;Float;False;Property;_MotionScale;Plant Motion Scale;27;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1152;-512,256;Float;False;1134;Packed_Plant;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1252;64,-256;Float;False;ADS Motion Custom;37;;1593;157ee7880d81d9e4ab5582c2b22b9a68;8,225,0,278,1,228,1,292,2,254,0,262,0,252,3,260,0;9;220;FLOAT;0;False;221;FLOAT;0;False;222;FLOAT;0;False;218;FLOAT;0;False;287;FLOAT;0;False;136;FLOAT;0;False;248;FLOAT3;0,0,0;False;279;FLOAT;0;False;247;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1247;1152,-256;Float;False;ADS Motion Flutter;-1;;1585;87d8028e5f83178498a65cfa9f0e9ace;0;4;220;FLOAT;0;False;221;FLOAT;0;False;222;FLOAT;0;False;136;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1158;384,-256;Half;False;Motion_Plant;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1160;1408,-256;Half;False;Motion_Leaf;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1161;1792,-160;Float;False;1160;Motion_Leaf;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;645;1152,-896;Float;True;Property;_SurfaceTex;Plant Surface;10;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1163;1792,-256;Float;False;1158;Motion_Plant;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1241;-1280,768;Float;False;ADS Global Settings;18;;1586;0fe83146627632b4981f5a0aa1b63801;0;1;171;FLOAT;0;False;3;COLOR;85;COLOR;165;FLOAT;157
Node;AmplifyShaderEditor.SimpleAddOpNode;1164;2048,-256;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;18;-1280,-896;Float;True;Property;_AlbedoTex;Plant Albedo;7;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;744;1536,-766;Half;False;Main_SurfaceTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;655;0,-896;Half;False;Property;_NormalScale;Plant Normal Scale;8;0;Create;False;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;409;-592,-896;Half;False;Property;_Color;Plant Color;6;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;1245;-1280,896;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1251;1792,-64;Float;False;1248;Motion_Turbulence;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1203;1536,-832;Half;False;Main_SurfaceTex_B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexToFragmentNode;1230;-768,768;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1207;2816,-800;Half;False;Property;_SubsurfaceColor;Plant Subsurface (B);12;0;Create;False;0;0;False;0;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;749;1920,-896;Float;False;744;Main_SurfaceTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-976,-896;Half;False;Main_AlbedoTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1233;-768,896;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;607;256,-896;Float;True;Property;_NormalTex;Plant Normal;9;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1232;-384,768;Half;False;Gloabl_Tint;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;-336,-896;Half;False;Main_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;294;1920,-816;Half;False;Property;_Smoothness;Plant Smoothness (A);11;0;Create;False;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1205;2816,-896;Float;False;1203;Main_SurfaceTex_B;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1166;2240,-256;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;-1280,-2176;Float;False;487;Main_AlbedoTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;2240,-896;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1240;-1280,-2048;Float;False;1232;Gloabl_Tint;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1083;-1280,-2112;Float;False;486;Main_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1234;-384,896;Half;False;Global_Size;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1064;576,-896;Float;False;Normal BackFace;-1;;1591;121446c878db06f4c847f9c5afed7cfe;0;1;13;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1167;2400,-256;Half;False;Motion_Output;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1206;3136,-896;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1238;-1280,-1472;Float;False;1234;Global_Size;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;-976,-768;Half;False;Main_AlbedoTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1175;-1280,-1536;Float;False;1167;Motion_Output;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1074;-768,-2176;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;832,-896;Half;False;Main_NormalTex;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;660;2400,-896;Half;False;OUT_SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1208;3328,-896;Half;False;OUT_TRANSMISSION;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1195;32,-2688;Half;False;Property;_Internal_TypePlant;Internal_TypePlant;58;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;791;-1280,-1664;Float;False;616;Main_AlbedoTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1202;1008,-2688;Half;False;Property;_Internal_DebugVariation;Internal_DebugVariation;62;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1113;-1280,-3360;Half;False;Property;_RENDERINGG;[ RENDERINGG ];2;0;Create;True;0;0;True;1;BCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;743;-1280,-2688;Half;False;Property;_RenderFaces;Render Faces;3;1;[Enum];Create;True;3;Two Sided;0;Back;1;Front;2;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1193;1280,-2688;Half;False;Property;_Internal_SetByScript;Internal_SetByScript;61;1;[HideInInspector];Create;True;0;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1191;512,-2688;Half;False;Property;_Internal_DebugMask;Internal_DebugMask;59;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1242;-384,-2688;Half;False;Property;_Internal_Version;Internal_Version;0;1;[HideInInspector];Create;True;0;0;True;0;220;1;220;220;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1201;-160,-2688;Half;False;Property;_Internal_ADS;Internal_ADS;46;1;[HideInInspector];Create;True;0;0;True;0;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1116;-928,-3360;Half;False;Property;_SETTINGS;[ SETTINGS ];13;0;Create;True;0;0;True;1;BCategory(Settings);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1109;-576,-2176;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1244;-672,-3264;Half;False;Property;_BatchingInfo;!!! BatchingInfo;36;0;Create;True;0;0;True;1;BMessage(Info, Batching is not currently supported Please use GPU Instancing instead for better performance, 0, 0);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;624;-1280,-1920;Float;False;620;Main_NormalTex;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1199;-640,-2688;Float;False;Internal Unity Props;47;;1592;b286e6ef621b64a4fb35da1e13fa143f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1118;-272,-3360;Half;False;Property;_ADVANCEDD;[ ADVANCEDD ];35;0;Create;True;0;0;True;1;BCategory(Advanced);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1192;752,-2688;Half;False;Property;_Internal_DebugMask2;Internal_DebugMask2;60;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;862;-1120,-2688;Half;False;Property;_Cutoff;Cutout;4;0;Create;False;3;Off;0;Front;1;Back;2;0;True;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1196;272,-2688;Half;False;Property;_Internal_LitAdvanced;Internal_LitAdvanced;57;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1239;-1024,-1536;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1189;-1280,-3264;Half;False;Property;_PlantMotionParameters;!!! Plant Motion Parameters !!!;24;0;Create;True;0;0;True;1;BMessage(Info, The Plant Motion Parameters will be overridden by the ADS Materials Helper Component, _Internal_SetByScript, 1, 0, 10);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1187;-976,-3264;Half;False;Property;_LeafMotionParameters;!!! Leaf Motion Parameters !!!;31;0;Create;True;0;0;True;1;BMessage(Info, The Leaf Motion Parameters will be overridden by the ADS Materials Helper Component, _Internal_SetByScript, 1, 0, 10);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1119;-1280,-3456;Half;False;Property;_ADSAdvancedLitPlant;< ADS Advanced Lit Plant >;1;0;Create;True;0;0;True;1;BBanner(ADS Advanced Lit, Plant);1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1115;-1088,-3360;Half;False;Property;_MAINN;[ MAINN ];5;0;Create;True;0;0;True;1;BCategory(Main);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1171;-528,-3360;Half;False;Property;_MOTIONLEAFF;[ MOTION LEAFF ];30;0;Create;True;0;0;True;1;BCategory(Leaf Motion);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;654;-1280,-1840;Float;False;660;OUT_SMOOTHNESS;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1117;-752,-3360;Half;False;Property;_MOTIONPLANTT;[ MOTION PLANTT ];23;0;Create;True;0;0;True;1;BCategory(Plant Motion);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1210;-1280,-1760;Float;False;1208;OUT_TRANSMISSION;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-128,-2048;Float;False;True;2;Float;ADSShaderGUI;300;0;Standard;BOXOPHOBIC/Advanced Dynamic Shaders/Advanced Lit/Plant;False;False;False;False;False;False;True;True;True;False;True;False;False;True;False;False;True;False;False;False;Off;0;False;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0;True;True;0;False;TransparentCutout;;AlphaTest;ForwardOnly;True;True;True;False;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;550;10;False;553;0;1;False;550;10;False;553;0;True;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;300;Utils/ADS Fallback;-1;-1;-1;-1;0;False;0;0;True;743;-1;0;True;862;3;Include;../../../Utils/CGIncludes/VS_indirect.cginc;False;;Pragma;instancing_options procedural:setup;False;;Pragma;multi_compile GPU_FRUSTUM_ON __;False;;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;683;-1280,-2816;Float;False;417.3682;100;Rendering And Settings;0;;1,0,0.503,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;708;0,-1024;Float;False;1024.6;100;Normal Texture;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1235;-1280,640;Float;False;1090.415;100;Globals;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;715;1152,-1024;Float;False;1473.26;100;Surface Input;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1112;-1280,-3584;Float;False;1185.27;100;Drawers;0;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1170;-1280,-384;Float;False;3876.749;100;Motion;0;;0.03448272,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1204;2816,-1024;Float;False;770.26;100;Transmission;0;;0.7843137,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1198;-640,-2816;Float;False;2129.42;100;Internal Only;0;;1,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;760;-1280,-1024;Float;False;1152.612;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
WireConnection;1129;0;1124;4
WireConnection;1169;0;1124;3
WireConnection;1134;0;1124;1
WireConnection;1248;0;1221;85
WireConnection;1173;0;1174;0
WireConnection;1173;1;1172;0
WireConnection;1252;220;1143;0
WireConnection;1252;221;1147;0
WireConnection;1252;222;1142;0
WireConnection;1252;218;1173;0
WireConnection;1252;287;1250;0
WireConnection;1252;136;1152;0
WireConnection;1252;279;1212;0
WireConnection;1247;220;1139;0
WireConnection;1247;221;1153;0
WireConnection;1247;222;1150;0
WireConnection;1247;136;1144;0
WireConnection;1158;0;1252;0
WireConnection;1160;0;1247;0
WireConnection;1164;0;1163;0
WireConnection;1164;1;1161;0
WireConnection;744;0;645;4
WireConnection;1203;0;645;3
WireConnection;1230;0;1241;85
WireConnection;487;0;18;0
WireConnection;1233;0;1241;157
WireConnection;1233;1;1245;0
WireConnection;607;5;655;0
WireConnection;1232;0;1230;0
WireConnection;486;0;409;0
WireConnection;1166;0;1164;0
WireConnection;1166;1;1251;0
WireConnection;745;0;749;0
WireConnection;745;1;294;0
WireConnection;1234;0;1233;0
WireConnection;1064;13;607;0
WireConnection;1167;0;1166;0
WireConnection;1206;0;1205;0
WireConnection;1206;1;1207;0
WireConnection;616;0;18;4
WireConnection;1074;0;36;0
WireConnection;1074;1;1083;0
WireConnection;1074;2;1240;0
WireConnection;620;0;1064;0
WireConnection;660;0;745;0
WireConnection;1208;0;1206;0
WireConnection;1109;0;1074;0
WireConnection;1239;0;1175;0
WireConnection;1239;1;1238;0
WireConnection;0;0;1109;0
WireConnection;0;1;624;0
WireConnection;0;4;654;0
WireConnection;0;6;1210;0
WireConnection;0;10;791;0
WireConnection;0;11;1239;0
ASEEND*/
//CHKSM=34F243821F36103B6F4EEE1EF06607A6A59F67B1