// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/Advanced Dynamic Shaders/Standard Lit/Grass"
{
	Properties
	{
		[HideInInspector]_Internal_Version("Internal_Version", Float) = 220
		[BBanner(ADS Standard Lit, Grass)]_ADSStandardLitGrass("< ADS Standard Lit Grass >", Float) = 1
		[BCategory(Rendering)]_RENDERINGG("[ RENDERINGG ]", Float) = 0
		[Enum(Two Sided,0,Back,1,Front,2)]_RenderFaces("Render Faces", Float) = 0
		_Cutoff("Cutout", Range( 0 , 1)) = 0.5
		[BCategory(Main)]_MAINN("[ MAINN ]", Float) = 0
		_Color("Grass Color", Color) = (1,1,1,1)
		[NoScaleOffset]_AlbedoTex("Grass Albedo", 2D) = "white" {}
		[Toggle]_NormalInvertOnBackface("Grass Normal Backface", Float) = 1
		_NormalScale("Grass Normal Scale", Float) = 1
		[NoScaleOffset]_NormalTex("Grass Normal", 2D) = "bump" {}
		_Smoothness("Grass Smoothness", Range( 0 , 1)) = 1
		[BCategory(Settings)]_SETTINGS("[ SETTINGS ]", Float) = 0
		[HideInInspector]_MotionNoise("Motion Noise", Float) = 1
		_GlobalTurbulence("Global Turbulence", Range( 0 , 1)) = 1
		_GlobalTint("Global Tint", Range( 0 , 1)) = 1
		_GlobalSize("Global Size", Range( 0 , 1)) = 1
		[BCategory(Grass Motion)]_GRASSMOTIONN("[ GRASS MOTIONN ]", Float) = 0
		_MotionAmplitude("Grass Motion Amplitude", Float) = 0
		_MotionSpeed("Grass Motion Speed", Float) = 0
		_MotionScale("Grass Motion Scale", Float) = 0
		_MotionVariation("Grass Motion Variation", Float) = 0
		[BCategory(Leaf Motion)]_LEAFMOTIONN("[ LEAF MOTIONN ]", Float) = 0
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
		[HideInInspector]_Internal_LitStandard("Internal_LitStandard", Float) = 1
		[HideInInspector]_Internal_TypeGrass("Internal_TypeGrass", Float) = 1
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
			float4 vertexToFrag1205;
		};

		uniform half _Internal_LitStandard;
		uniform half _Internal_DebugMask2;
		uniform half _Internal_ADS;
		uniform half _RENDERINGG;
		uniform half _Internal_SetByScript;
		uniform half _Internal_Version;
		uniform half _Internal_DebugMask;
		uniform half _BatchingInfo;
		uniform half _Internal_TypeGrass;
		uniform half _Internal_DebugVariation;
		uniform half _GRASSMOTIONN;
		uniform half _ADVANCEDD;
		uniform half _ADSStandardLitGrass;
		uniform half _SETTINGS;
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
		uniform half _RenderFaces;
		uniform half _MAINN;
		uniform float _MotionNoise;
		uniform half _MotionSpaceee;
		uniform half _MotionSpacee;
		uniform half _MotionSpaceeeEnd;
		uniform half _MotionSpaceeEnd;
		uniform half _LEAFMOTIONN;
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
			half MotionScale60_g1586 = ( ADS_GlobalScale * _MotionScale );
			half MotionSpeed62_g1586 = ( ADS_GlobalSpeed * _MotionSpeed );
			float mulTime90_g1586 = _Time.y * MotionSpeed62_g1586;
			float3 temp_output_95_0_g1586 = ( ( ase_worldPos * MotionScale60_g1586 ) + mulTime90_g1586 );
			half Packed_Variation1239 = v.color.a;
			half MotionVariation269_g1586 = ( _MotionVariation * Packed_Variation1239 );
			half MotionlAmplitude58_g1586 = ( ADS_GlobalAmplitude * _MotionAmplitude );
			float3 temp_output_92_0_g1586 = ( sin( ( temp_output_95_0_g1586 + MotionVariation269_g1586 ) ) * MotionlAmplitude58_g1586 );
			float3 temp_output_160_0_g1586 = ( temp_output_92_0_g1586 + MotionlAmplitude58_g1586 + MotionlAmplitude58_g1586 );
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
			half Motion_Turbulence1240 = ifLocalVar94_g1579;
			float3 lerpResult293_g1586 = lerp( temp_output_92_0_g1586 , temp_output_160_0_g1586 , Motion_Turbulence1240);
			float3 temp_output_256_0_g1586 = mul( unity_WorldToObject, float4( ADS_GlobalDirection , 0.0 ) ).xyz;
			half3 MotionDirection59_g1586 = temp_output_256_0_g1586;
			half Packed_Grass1241 = v.color.r;
			half MotionMask137_g1586 = Packed_Grass1241;
			float3 temp_output_94_0_g1586 = ( ( lerpResult293_g1586 * MotionDirection59_g1586 ) * MotionMask137_g1586 );
			float3 break231_g1586 = temp_output_94_0_g1586;
			float3 appendResult232_g1586 = (float3(break231_g1586.x , 0.0 , break231_g1586.z));
			half3 Motion_Grass1257 = appendResult232_g1586;
			float3 ase_vertex3Pos = v.vertex.xyz;
			half MotionFlutterScale60_g1587 = ( ADS_GlobalScale * _MotionScale3 );
			half MotionFlutterSpeed62_g1587 = ( ADS_GlobalSpeed * _MotionSpeed3 );
			float mulTime90_g1587 = _Time.y * MotionFlutterSpeed62_g1587;
			half MotionlFlutterAmplitude58_g1587 = ( ADS_GlobalAmplitude * _MotionAmplitude3 );
			half MotionMask137_g1587 = Packed_Grass1241;
			float3 ase_vertexNormal = v.normal.xyz;
			half3 Motion_Leaf1256 = ( ( ( sin( ( ( ase_vertex3Pos * MotionFlutterScale60_g1587 ) + mulTime90_g1587 ) ) * MotionlFlutterAmplitude58_g1587 ) * MotionMask137_g1587 ) * ase_vertexNormal );
			half3 Motion_Output1263 = ( ( Motion_Grass1257 + Motion_Leaf1256 ) * Motion_Turbulence1240 );
			half localunity_ObjectToWorld0w1_g1543 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g1543 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g1543 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g1543 = (float3(localunity_ObjectToWorld0w1_g1543 , localunity_ObjectToWorld1w2_g1543 , localunity_ObjectToWorld2w3_g1543));
			float4 tex2DNode140_g1541 = tex2Dlod( ADS_GlobalTex, float4( ( ( (appendResult6_g1543).xz * (ADS_GlobalUVs).xy ) + (ADS_GlobalUVs).zw ), 0, 0.0) );
			half ADS_GlobalTex_B198_g1541 = tex2DNode140_g1541.b;
			float lerpResult156_g1541 = lerp( ADS_GlobalSizeMin , ADS_GlobalSizeMax , ADS_GlobalTex_B198_g1541);
			half3 Global_Size1209 = ( ( lerpResult156_g1541 * _GlobalSize ) * ase_vertex3Pos );
			v.vertex.xyz += ( Motion_Output1263 + Global_Size1209 );
			float4 temp_cast_2 = (1.0).xxxx;
			half4 ADS_GlobalTintColorOne176_g1541 = ADS_GlobalTintColorOne;
			half4 ADS_GlobalTintColorTwo177_g1541 = ADS_GlobalTintColorTwo;
			half ADS_GlobalTex_R180_g1541 = tex2DNode140_g1541.r;
			float4 lerpResult147_g1541 = lerp( ADS_GlobalTintColorOne176_g1541 , ADS_GlobalTintColorTwo177_g1541 , ADS_GlobalTex_R180_g1541);
			half ADS_GlobalTintIntensity181_g1541 = ADS_GlobalTintIntensity;
			half GlobalTint186_g1541 = _GlobalTint;
			float4 lerpResult150_g1541 = lerp( temp_cast_2 , ( lerpResult147_g1541 * ADS_GlobalTintIntensity181_g1541 ) , GlobalTint186_g1541);
			o.vertexToFrag1205 = lerpResult150_g1541;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalTex607 = i.uv_texcoord;
			float3 temp_output_13_0_g1569 = UnpackScaleNormal( tex2D( _NormalTex, uv_NormalTex607 ), _NormalScale );
			float3 break17_g1569 = temp_output_13_0_g1569;
			float switchResult12_g1569 = (((i.ASEVFace>0)?(break17_g1569.z):(-break17_g1569.z)));
			float3 appendResult18_g1569 = (float3(break17_g1569.x , break17_g1569.y , switchResult12_g1569));
			float3 lerpResult20_g1569 = lerp( temp_output_13_0_g1569 , appendResult18_g1569 , _NormalInvertOnBackface);
			half3 Main_NormalTex620 = lerpResult20_g1569;
			o.Normal = Main_NormalTex620;
			float2 uv_AlbedoTex18 = i.uv_texcoord;
			float4 tex2DNode18 = tex2D( _AlbedoTex, uv_AlbedoTex18 );
			half4 Main_AlbedoTex487 = tex2DNode18;
			half4 Main_Color486 = _Color;
			half4 Gloabl_Tint1208 = i.vertexToFrag1205;
			o.Albedo = saturate( ( Main_AlbedoTex487 * Main_Color486 * Gloabl_Tint1208 ) ).rgb;
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
1927;29;1906;1014;2568.523;2690.203;2.641353;True;False
Node;AmplifyShaderEditor.VertexColorNode;1237;-1280,-256;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1239;-1024,-192;Half;False;Packed_Variation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1238;-1280,-64;Float;False;ADS Global Turbulence;14;;1579;047eb809542f42d40b4b5066e22cee72;0;0;1;FLOAT;85
Node;AmplifyShaderEditor.RegisterLocalVarNode;1240;-1024,-64;Half;False;Motion_Turbulence;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1241;-1024,-256;Half;False;Packed_Grass;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1242;-512,-16;Float;False;Property;_MotionVariation;Grass Motion Variation;27;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1243;-512,64;Float;False;1239;Packed_Variation;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1244;768,-176;Float;False;Property;_MotionSpeed3;Leaf Flutter Speed;30;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1245;768,-256;Float;False;Property;_MotionAmplitude3;Leaf Flutter Amplitude;29;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1246;768,-96;Float;False;Property;_MotionScale3;Leaf Flutter Scale;31;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1247;-512,256;Float;False;1241;Packed_Grass;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1248;-512,160;Float;False;1240;Motion_Turbulence;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1249;768,0;Float;False;1241;Packed_Grass;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1250;-256,-16;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1251;-512,-176;Float;False;Property;_MotionSpeed;Grass Motion Speed;25;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1252;-512,-96;Float;False;Property;_MotionScale;Grass Motion Scale;26;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1253;-512,-256;Float;False;Property;_MotionAmplitude;Grass Motion Amplitude;24;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1254;128,-256;Float;False;ADS Motion Custom;34;;1586;157ee7880d81d9e4ab5582c2b22b9a68;8,225,1,278,1,228,1,292,2,254,0,262,0,252,0,260,0;9;220;FLOAT;0;False;221;FLOAT;0;False;222;FLOAT;0;False;218;FLOAT;0;False;287;FLOAT;0;False;136;FLOAT;0;False;248;FLOAT3;0,0,0;False;279;FLOAT;0;False;247;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1255;1152,-256;Float;False;ADS Motion Flutter;-1;;1587;87d8028e5f83178498a65cfa9f0e9ace;0;4;220;FLOAT;0;False;221;FLOAT;0;False;222;FLOAT;0;False;136;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1256;1408,-256;Half;False;Motion_Leaf;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1257;384,-256;Half;False;Motion_Grass;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1258;1792,-160;Float;False;1256;Motion_Leaf;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1259;1792,-256;Float;False;1257;Motion_Grass;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1204;-1280,640;Float;False;ADS Global Settings;18;;1541;0fe83146627632b4981f5a0aa1b63801;0;1;171;FLOAT;0;False;3;COLOR;85;COLOR;165;FLOAT;157
Node;AmplifyShaderEditor.SamplerNode;18;-1280,-896;Float;True;Property;_AlbedoTex;Grass Albedo;7;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexToFragmentNode;1205;-768,640;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;655;0,-896;Half;False;Property;_NormalScale;Grass Normal Scale;9;0;Create;False;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;409;-592,-896;Half;False;Property;_Color;Grass Color;6;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;1261;2048,-256;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1260;1792,-64;Float;False;1240;Motion_Turbulence;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;1234;-1280,768;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1262;2240,-256;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;-336,-896;Half;False;Main_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1207;-768,768;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-976,-896;Half;False;Main_AlbedoTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;607;256,-896;Float;True;Property;_NormalTex;Grass Normal;10;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1208;-384,640;Half;False;Gloabl_Tint;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1229;288,-704;Half;False;Property;_NormalInvertOnBackface;Grass Normal Backface;8;1;[Toggle];Create;False;2;Opaque;0;Transparent;1;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1230;592,-896;Float;False;ADS Normal Backface;-1;;1569;4f53bc25e6d8da34db70401bcf363a2a;0;2;13;FLOAT3;0,0,0;False;30;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;294;1920,-816;Half;False;Property;_Smoothness;Grass Smoothness;12;0;Create;False;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1083;-1280,-2112;Float;False;486;Main_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1263;2432,-256;Half;False;Motion_Output;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;-1280,-2176;Float;False;487;Main_AlbedoTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1209;-384,768;Half;False;Global_Size;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1212;-1280,-2048;Float;False;1208;Gloabl_Tint;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;832,-896;Half;False;Main_NormalTex;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1211;-1280,-1472;Float;False;1209;Global_Size;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;-976,-768;Half;False;Main_AlbedoTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1074;-768,-2176;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;660;2400,-896;Half;False;OUT_SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1175;-1280,-1536;Float;False;1263;Motion_Output;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1193;1280,-2688;Half;False;Property;_Internal_SetByScript;Internal_SetByScript;58;1;[HideInInspector];Create;True;0;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;744;1536,-768;Half;False;Main_SurfaceTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;743;-1280,-2688;Half;False;Property;_RenderFaces;Render Faces;3;1;[Enum];Create;True;3;Two Sided;0;Back;1;Front;2;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1231;-384,-2688;Half;False;Property;_Internal_Version;Internal_Version;0;1;[HideInInspector];Create;True;0;0;True;0;220;1;220;220;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1196;272,-2688;Half;False;Property;_Internal_LitStandard;Internal_LitStandard;54;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1192;752,-2688;Half;False;Property;_Internal_DebugMask2;Internal_DebugMask2;57;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;749;1920,-896;Float;False;744;Main_SurfaceTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1116;-928,-3232;Half;False;Property;_SETTINGS;[ SETTINGS ];13;0;Create;True;0;0;True;1;BCategory(Settings);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1199;-640,-2688;Float;False;Internal Unity Props;44;;1570;b286e6ef621b64a4fb35da1e13fa143f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;862;-1120,-2688;Half;False;Property;_Cutoff;Cutout;4;0;Create;False;3;Off;0;Front;1;Back;2;0;True;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1109;-576,-2176;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;654;-1280,-1760;Float;False;660;OUT_SMOOTHNESS;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1179;-1024,-1536;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1115;-1088,-3232;Half;False;Property;_MAINN;[ MAINN ];5;0;Create;True;0;0;True;1;BCategory(Main);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1202;1008,-2688;Half;False;Property;_Internal_DebugVariation;Internal_DebugVariation;59;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1233;-1280,-3136;Half;False;Property;_BatchingInfo;!!! BatchingInfo;33;0;Create;True;0;0;True;1;BMessage(Info, Batching is not currently supported Please use GPU Instancing instead for better performance, 0, 0);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1195;32,-2688;Half;False;Property;_Internal_TypeGrass;Internal_TypeGrass;55;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;645;1152,-896;Float;True;Property;_SurfaceTex;Grass Surface;11;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1264;-528,-3232;Half;False;Property;_LEAFMOTIONN;[ LEAF MOTIONN ];28;0;Create;True;0;0;True;1;BCategory(Leaf Motion);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1118;-320,-3232;Half;False;Property;_ADVANCEDD;[ ADVANCEDD ];32;0;Create;True;0;0;True;1;BCategory(Advanced);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1117;-752,-3232;Half;False;Property;_GRASSMOTIONN;[ GRASS MOTIONN ];23;0;Create;True;0;0;True;1;BCategory(Grass Motion);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1191;512,-2688;Half;False;Property;_Internal_DebugMask;Internal_DebugMask;56;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1201;-160,-2688;Half;False;Property;_Internal_ADS;Internal_ADS;43;1;[HideInInspector];Create;True;0;0;True;0;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1113;-1280,-3232;Half;False;Property;_RENDERINGG;[ RENDERINGG ];2;0;Create;True;0;0;True;1;BCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;2240,-896;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;624;-1280,-1920;Float;False;620;Main_NormalTex;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1119;-1280,-3328;Half;False;Property;_ADSStandardLitGrass;< ADS Standard Lit Grass >;1;0;Create;True;0;0;True;1;BBanner(ADS Standard Lit, Grass);1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;791;-1280,-1664;Float;False;616;Main_AlbedoTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-128,-2048;Float;False;True;2;Float;ADSShaderGUI;300;0;Standard;BOXOPHOBIC/Advanced Dynamic Shaders/Standard Lit/Grass;False;False;False;False;False;False;True;True;True;False;True;False;False;True;False;False;True;False;False;False;Off;0;False;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;False;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;550;10;False;553;0;1;False;550;10;False;553;0;True;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;300;Utils/ADS Fallback;-1;-1;-1;-1;0;False;0;0;True;743;-1;0;True;862;3;Include;../../../Utils/CGIncludes/VS_indirect.cginc;False;;Pragma;instancing_options procedural:setup;False;;Pragma;multi_compile GPU_FRUSTUM_ON __;False;;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;1198;-640,-2816;Float;False;2134.62;100;Internal Only;0;;1,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;708;0,-1024;Float;False;1024.6;100;Normal Texture;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1112;-1280,-3456;Float;False;1185.27;100;Drawers;0;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1210;-1280,512;Float;False;1090.415;100;Globals;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1236;-1280,-384;Float;False;3910.489;100;Motion;0;;0.03448272,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;760;-1280,-1024;Float;False;1152.612;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;715;1152,-1024;Float;False;1473.26;100;Surface Input;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;683;-1280,-2816;Float;False;417.3682;100;Rendering And Settings;0;;1,0,0.503,1;0;0
WireConnection;1239;0;1237;4
WireConnection;1240;0;1238;85
WireConnection;1241;0;1237;1
WireConnection;1250;0;1242;0
WireConnection;1250;1;1243;0
WireConnection;1254;220;1253;0
WireConnection;1254;221;1251;0
WireConnection;1254;222;1252;0
WireConnection;1254;218;1250;0
WireConnection;1254;287;1248;0
WireConnection;1254;136;1247;0
WireConnection;1255;220;1245;0
WireConnection;1255;221;1244;0
WireConnection;1255;222;1246;0
WireConnection;1255;136;1249;0
WireConnection;1256;0;1255;0
WireConnection;1257;0;1254;0
WireConnection;1205;0;1204;85
WireConnection;1261;0;1259;0
WireConnection;1261;1;1258;0
WireConnection;1262;0;1261;0
WireConnection;1262;1;1260;0
WireConnection;486;0;409;0
WireConnection;1207;0;1204;157
WireConnection;1207;1;1234;0
WireConnection;487;0;18;0
WireConnection;607;5;655;0
WireConnection;1208;0;1205;0
WireConnection;1230;13;607;0
WireConnection;1230;30;1229;0
WireConnection;1263;0;1262;0
WireConnection;1209;0;1207;0
WireConnection;620;0;1230;0
WireConnection;616;0;18;4
WireConnection;1074;0;36;0
WireConnection;1074;1;1083;0
WireConnection;1074;2;1212;0
WireConnection;660;0;294;0
WireConnection;744;0;645;4
WireConnection;1109;0;1074;0
WireConnection;1179;0;1175;0
WireConnection;1179;1;1211;0
WireConnection;745;0;749;0
WireConnection;745;1;294;0
WireConnection;0;0;1109;0
WireConnection;0;1;624;0
WireConnection;0;4;654;0
WireConnection;0;10;791;0
WireConnection;0;11;1179;0
ASEEND*/
//CHKSM=91E4A8E61229773C0B4AF8F23D14FD29DD9AD76F