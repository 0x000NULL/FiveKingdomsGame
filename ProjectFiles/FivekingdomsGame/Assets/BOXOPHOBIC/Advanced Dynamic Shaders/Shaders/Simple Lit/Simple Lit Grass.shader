// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/Advanced Dynamic Shaders/Simple Lit/Grass"
{
	Properties
	{
		[HideInInspector]_Internal_Version("Internal_Version", Float) = 220
		[BBanner(ADS Simple Lit, Grass)]_ADSSimpleLitGrass("< ADS Simple Lit Grass >", Float) = 1
		[BCategory(Rendering)]_RENDERINGG("[ RENDERINGG ]", Float) = 0
		[Enum(Two Sided,0,Back,1,Front,2)]_RenderFaces("Render Faces", Float) = 0
		_Cutoff("Cutout", Range( 0 , 1)) = 0.5
		[BCategory(Main)]_MAINN("[ MAINN ]", Float) = 0
		_Color("Grass Color", Color) = (1,1,1,1)
		[NoScaleOffset]_AlbedoTex("Grass Albedo", 2D) = "white" {}
		[Toggle]_NormalInvertOnBackface("Grass Normal Backface", Float) = 1
		_NormalScale("Grass Normal Scale", Float) = 1
		[NoScaleOffset]_NormalTex("Grass Normal", 2D) = "bump" {}
		[BCategory(Settings)]_SETTINGS("[ SETTINGS ]", Float) = 0
		[HideInInspector]_MotionNoise("Motion Noise", Float) = 1
		_GlobalTurbulence("Global Turbulence", Range( 0 , 1)) = 1
		_GlobalTint("Global Tint", Range( 0 , 1)) = 1
		_GlobalSize("Global Size", Range( 0 , 1)) = 1
		[BCategory(Grass Motion)]_MOTIONGRASS("[ MOTION GRASS ]", Float) = 0
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
		[HideInInspector]_Internal_LitSimple("Internal_LitSimple", Float) = 1
		[HideInInspector]_Internal_TypeGrass("Internal_TypeGrass", Float) = 1
		[HideInInspector]_Internal_DebugMask("Internal_DebugMask", Float) = 1
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
			float4 vertexToFrag1244;
		};

		uniform half _Internal_TypeGrass;
		uniform half _Internal_LitSimple;
		uniform half _ADSSimpleLitGrass;
		uniform half _Internal_DebugVariation;
		uniform half _BatchingInfo;
		uniform half _Internal_DebugMask;
		uniform half _Internal_Version;
		uniform half _SETTINGS;
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
		uniform half _MAINN;
		uniform half _RENDERINGG;
		uniform half _ADVANCEDD;
		uniform half _MOTIONGRASS;
		uniform half _RenderFaces;
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
			half MotionScale60_g1586 = ( ADS_GlobalScale * _MotionScale );
			half MotionSpeed62_g1586 = ( ADS_GlobalSpeed * _MotionSpeed );
			float mulTime90_g1586 = _Time.y * MotionSpeed62_g1586;
			float3 temp_output_95_0_g1586 = ( ( ase_worldPos * MotionScale60_g1586 ) + mulTime90_g1586 );
			half Packed_Variation1261 = v.color.a;
			half MotionVariation269_g1586 = ( _MotionVariation * Packed_Variation1261 );
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
			half Motion_Turbulence1262 = ifLocalVar94_g1579;
			float3 lerpResult293_g1586 = lerp( temp_output_92_0_g1586 , temp_output_160_0_g1586 , Motion_Turbulence1262);
			float3 temp_output_256_0_g1586 = mul( unity_WorldToObject, float4( ADS_GlobalDirection , 0.0 ) ).xyz;
			half3 MotionDirection59_g1586 = temp_output_256_0_g1586;
			half Packed_Grass1263 = v.color.r;
			half MotionMask137_g1586 = Packed_Grass1263;
			float3 temp_output_94_0_g1586 = ( ( lerpResult293_g1586 * MotionDirection59_g1586 ) * MotionMask137_g1586 );
			float3 break231_g1586 = temp_output_94_0_g1586;
			float3 appendResult232_g1586 = (float3(break231_g1586.x , 0.0 , break231_g1586.z));
			half3 Motion_Grass1279 = appendResult232_g1586;
			float3 ase_vertex3Pos = v.vertex.xyz;
			half MotionFlutterScale60_g1587 = ( ADS_GlobalScale * _MotionScale3 );
			half MotionFlutterSpeed62_g1587 = ( ADS_GlobalSpeed * _MotionSpeed3 );
			float mulTime90_g1587 = _Time.y * MotionFlutterSpeed62_g1587;
			half MotionlFlutterAmplitude58_g1587 = ( ADS_GlobalAmplitude * _MotionAmplitude3 );
			half MotionMask137_g1587 = Packed_Grass1263;
			float3 ase_vertexNormal = v.normal.xyz;
			half3 Motion_Leaf1278 = ( ( ( sin( ( ( ase_vertex3Pos * MotionFlutterScale60_g1587 ) + mulTime90_g1587 ) ) * MotionlFlutterAmplitude58_g1587 ) * MotionMask137_g1587 ) * ase_vertexNormal );
			half3 Motion_Output1285 = ( ( Motion_Grass1279 + Motion_Leaf1278 ) * Motion_Turbulence1262 );
			half localunity_ObjectToWorld0w1_g1543 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g1543 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g1543 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g1543 = (float3(localunity_ObjectToWorld0w1_g1543 , localunity_ObjectToWorld1w2_g1543 , localunity_ObjectToWorld2w3_g1543));
			float4 tex2DNode140_g1541 = tex2Dlod( ADS_GlobalTex, float4( ( ( (appendResult6_g1543).xz * (ADS_GlobalUVs).xy ) + (ADS_GlobalUVs).zw ), 0, 0.0) );
			half ADS_GlobalTex_B198_g1541 = tex2DNode140_g1541.b;
			float lerpResult156_g1541 = lerp( ADS_GlobalSizeMin , ADS_GlobalSizeMax , ADS_GlobalTex_B198_g1541);
			half3 Global_Size1248 = ( ( lerpResult156_g1541 * _GlobalSize ) * ase_vertex3Pos );
			v.vertex.xyz += ( Motion_Output1285 + Global_Size1248 );
			float4 temp_cast_2 = (1.0).xxxx;
			half4 ADS_GlobalTintColorOne176_g1541 = ADS_GlobalTintColorOne;
			half4 ADS_GlobalTintColorTwo177_g1541 = ADS_GlobalTintColorTwo;
			half ADS_GlobalTex_R180_g1541 = tex2DNode140_g1541.r;
			float4 lerpResult147_g1541 = lerp( ADS_GlobalTintColorOne176_g1541 , ADS_GlobalTintColorTwo177_g1541 , ADS_GlobalTex_R180_g1541);
			half ADS_GlobalTintIntensity181_g1541 = ADS_GlobalTintIntensity;
			half GlobalTint186_g1541 = _GlobalTint;
			float4 lerpResult150_g1541 = lerp( temp_cast_2 , ( lerpResult147_g1541 * ADS_GlobalTintIntensity181_g1541 ) , GlobalTint186_g1541);
			o.vertexToFrag1244 = lerpResult150_g1541;
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_NormalTex607 = i.uv_texcoord;
			float3 temp_output_13_0_g1553 = UnpackScaleNormal( tex2D( _NormalTex, uv_NormalTex607 ), _NormalScale );
			float3 break17_g1553 = temp_output_13_0_g1553;
			float switchResult12_g1553 = (((i.ASEVFace>0)?(break17_g1553.z):(-break17_g1553.z)));
			float3 appendResult18_g1553 = (float3(break17_g1553.x , break17_g1553.y , switchResult12_g1553));
			float3 lerpResult20_g1553 = lerp( temp_output_13_0_g1553 , appendResult18_g1553 , _NormalInvertOnBackface);
			half3 Main_NormalTex620 = lerpResult20_g1553;
			o.Normal = Main_NormalTex620;
			half4 Main_Color486 = _Color;
			float2 uv_AlbedoTex18 = i.uv_texcoord;
			float4 tex2DNode18 = tex2D( _AlbedoTex, uv_AlbedoTex18 );
			half4 Main_AlbedoTex487 = tex2DNode18;
			half4 Gloabl_Tint1247 = i.vertexToFrag1244;
			o.Albedo = saturate( ( Main_Color486 * Main_AlbedoTex487 * Gloabl_Tint1247 ) ).rgb;
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
1927;29;1906;1014;1714.503;3927.371;1;True;False
Node;AmplifyShaderEditor.VertexColorNode;1259;-1280,-640;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1261;-1024,-576;Half;False;Packed_Variation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1260;-1280,-448;Float;False;ADS Global Turbulence;14;;1579;047eb809542f42d40b4b5066e22cee72;0;0;1;FLOAT;85
Node;AmplifyShaderEditor.RegisterLocalVarNode;1262;-1024,-448;Half;False;Motion_Turbulence;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1265;-512,-320;Float;False;1261;Packed_Variation;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1264;-512,-400;Float;False;Property;_MotionVariation;Grass Motion Variation;27;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1263;-1024,-640;Half;False;Packed_Grass;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1269;-512,-128;Float;False;1263;Packed_Grass;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1270;-512,-224;Float;False;1262;Motion_Turbulence;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1268;768,-480;Float;False;Property;_MotionScale3;Leaf Flutter Scale;31;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1266;768,-560;Float;False;Property;_MotionSpeed3;Leaf Flutter Speed;30;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1267;768,-640;Float;False;Property;_MotionAmplitude3;Leaf Flutter Amplitude;29;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1275;-512,-640;Float;False;Property;_MotionAmplitude;Grass Motion Amplitude;24;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1274;-512,-480;Float;False;Property;_MotionScale;Grass Motion Scale;26;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1273;-512,-560;Float;False;Property;_MotionSpeed;Grass Motion Speed;25;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1271;768,-384;Float;False;1263;Packed_Grass;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1272;-256,-400;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1276;128,-640;Float;False;ADS Motion Custom;34;;1586;157ee7880d81d9e4ab5582c2b22b9a68;8,225,1,278,1,228,1,292,2,254,0,262,0,252,0,260,0;9;220;FLOAT;0;False;221;FLOAT;0;False;222;FLOAT;0;False;218;FLOAT;0;False;287;FLOAT;0;False;136;FLOAT;0;False;248;FLOAT3;0,0,0;False;279;FLOAT;0;False;247;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1277;1152,-640;Float;False;ADS Motion Flutter;-1;;1587;87d8028e5f83178498a65cfa9f0e9ace;0;4;220;FLOAT;0;False;221;FLOAT;0;False;222;FLOAT;0;False;136;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1279;384,-640;Half;False;Motion_Grass;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1278;1408,-640;Half;False;Motion_Leaf;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1280;1792,-544;Float;False;1278;Motion_Leaf;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1243;-1280,256;Float;False;ADS Global Settings;18;;1541;0fe83146627632b4981f5a0aa1b63801;0;1;171;FLOAT;0;False;3;COLOR;85;COLOR;165;FLOAT;157
Node;AmplifyShaderEditor.GetLocalVarNode;1281;1792,-640;Float;False;1279;Motion_Grass;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;409;-592,-1280;Half;False;Property;_Color;Grass Color;6;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1282;1792,-448;Float;False;1262;Motion_Turbulence;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1283;2048,-640;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PosVertexDataNode;1258;-1280,384;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;-1280,-1280;Float;True;Property;_AlbedoTex;Grass Albedo;7;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;655;0,-1280;Half;False;Property;_NormalScale;Grass Normal Scale;9;0;Create;False;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexToFragmentNode;1244;-768,256;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-976,-1280;Half;False;Main_AlbedoTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1254;288,-1088;Half;False;Property;_NormalInvertOnBackface;Grass Normal Backface;8;1;[Toggle];Create;False;2;Opaque;0;Transparent;1;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1247;-384,256;Half;False;Gloabl_Tint;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;-336,-1280;Half;False;Main_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1246;-768,384;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1284;2240,-640;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;607;256,-1280;Float;True;Property;_NormalTex;Grass Normal;10;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1248;-384,384;Half;False;Global_Size;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1236;-1280,-2368;Float;False;487;Main_AlbedoTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1253;576,-1280;Float;False;ADS Normal Backface;-1;;1553;4f53bc25e6d8da34db70401bcf363a2a;0;2;13;FLOAT3;0,0,0;False;30;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1285;2432,-640;Half;False;Motion_Output;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1235;-1280,-2432;Float;False;486;Main_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1251;-1280,-2304;Float;False;1247;Gloabl_Tint;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1250;-1280,-1856;Float;False;1248;Global_Size;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1237;-896,-2432;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1175;-1280,-1920;Float;False;1285;Motion_Output;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;-976,-1152;Half;False;Main_AlbedoTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;816,-1280;Half;False;Main_NormalTex;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1118;-304,-3616;Half;False;Property;_ADVANCEDD;[ ADVANCEDD ];32;0;Create;True;0;0;True;1;BCategory(Advanced);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1117;-752,-3616;Half;False;Property;_MOTIONGRASS;[ MOTION GRASS ];23;0;Create;True;0;0;True;1;BCategory(Grass Motion);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1257;-1280,-3520;Half;False;Property;_BatchingInfo;!!! BatchingInfo;33;0;Create;True;0;0;True;1;BMessage(Info, Batching is not currently supported Please use GPU Instancing instead for better performance, 0, 0);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1287;-528,-3616;Half;False;Property;_LEAFMOTIONN;[ LEAF MOTIONN ];28;0;Create;True;0;0;True;1;BCategory(Leaf Motion);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1240;-160,-2944;Half;False;Property;_Internal_ADS;Internal_ADS;43;1;[HideInInspector];Create;True;0;0;True;0;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1179;-1024,-1920;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1255;-384,-2944;Half;False;Property;_Internal_Version;Internal_Version;0;1;[HideInInspector];Create;True;0;0;True;0;220;1;220;220;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1116;-928,-3616;Half;False;Property;_SETTINGS;[ SETTINGS ];13;0;Create;True;0;0;True;1;BCategory(Settings);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;791;-1280,-2048;Float;False;616;Main_AlbedoTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1199;-640,-2944;Float;False;Internal Unity Props;44;;1554;b286e6ef621b64a4fb35da1e13fa143f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;862;-1120,-2944;Half;False;Property;_Cutoff;Cutout;4;0;Create;False;3;Off;0;Front;1;Back;2;0;True;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1252;-720,-2432;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1196;272,-2944;Half;False;Property;_Internal_LitSimple;Internal_LitSimple;54;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;744;1536,-1152;Half;False;Main_SurfaceTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1195;32,-2944;Half;False;Property;_Internal_TypeGrass;Internal_TypeGrass;55;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;2240,-1280;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1241;768,-2944;Half;False;Property;_Internal_DebugVariation;Internal_DebugVariation;57;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1191;512,-2944;Half;False;Property;_Internal_DebugMask;Internal_DebugMask;56;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;624;-1280,-2176;Float;False;620;Main_NormalTex;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1119;-1280,-3712;Half;False;Property;_ADSSimpleLitGrass;< ADS Simple Lit Grass >;1;0;Create;True;0;0;True;1;BBanner(ADS Simple Lit, Grass);1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;660;2432,-1280;Half;False;OUT_SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;645;1152,-1280;Float;True;Property;_SurfaceTex;Grass Surface;12;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;294;1920,-1200;Half;False;Property;_Smoothness;Grass Smoothness;11;0;Create;False;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;743;-1280,-2944;Half;False;Property;_RenderFaces;Render Faces;3;1;[Enum];Create;True;3;Two Sided;0;Back;1;Front;2;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1113;-1280,-3616;Half;False;Property;_RENDERINGG;[ RENDERINGG ];2;0;Create;True;0;0;True;1;BCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1115;-1088,-3616;Half;False;Property;_MAINN;[ MAINN ];5;0;Create;True;0;0;True;1;BCategory(Main);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;646;1536,-1280;Half;False;Main_SurfaceTex_R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;749;1920,-1280;Float;False;744;Main_SurfaceTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-512,-2432;Float;False;True;2;Float;ADSShaderGUI;200;0;Lambert;BOXOPHOBIC/Advanced Dynamic Shaders/Simple Lit/Grass;False;False;False;False;False;False;True;True;True;False;True;False;False;True;False;False;False;False;False;False;Off;0;False;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;False;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;550;10;False;553;0;1;False;550;10;False;553;0;True;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;200;Utils/ADS Fallback;-1;-1;-1;-1;0;False;0;0;True;743;-1;0;True;862;3;Include;../../../Utils/CGIncludes/VS_indirect.cginc;False;;Pragma;instancing_options procedural:setup;False;;Pragma;multi_compile GPU_FRUSTUM_ON __;False;;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;708;0,-1408;Float;False;1024.6;100;Normal Texture;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;683;-1280,-3072;Float;False;417.3682;100;Rendering And Settings;0;;1,0,0.503,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1112;-1280,-3840;Float;False;1185.27;100;Drawers;0;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;715;1152,-1408;Float;False;1501.26;100;Surface Input;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1249;-1280,128;Float;False;1090.415;100;Globals;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;760;-1280,-1408;Float;False;1152.612;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1286;-1280,-768;Float;False;3910.489;100;Motion;0;;0.03448272,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1198;-640,-3072;Float;False;1656.62;100;Internal Only;0;;1,0,0,1;0;0
WireConnection;1261;0;1259;4
WireConnection;1262;0;1260;85
WireConnection;1263;0;1259;1
WireConnection;1272;0;1264;0
WireConnection;1272;1;1265;0
WireConnection;1276;220;1275;0
WireConnection;1276;221;1273;0
WireConnection;1276;222;1274;0
WireConnection;1276;218;1272;0
WireConnection;1276;287;1270;0
WireConnection;1276;136;1269;0
WireConnection;1277;220;1267;0
WireConnection;1277;221;1266;0
WireConnection;1277;222;1268;0
WireConnection;1277;136;1271;0
WireConnection;1279;0;1276;0
WireConnection;1278;0;1277;0
WireConnection;1283;0;1281;0
WireConnection;1283;1;1280;0
WireConnection;1244;0;1243;85
WireConnection;487;0;18;0
WireConnection;1247;0;1244;0
WireConnection;486;0;409;0
WireConnection;1246;0;1243;157
WireConnection;1246;1;1258;0
WireConnection;1284;0;1283;0
WireConnection;1284;1;1282;0
WireConnection;607;5;655;0
WireConnection;1248;0;1246;0
WireConnection;1253;13;607;0
WireConnection;1253;30;1254;0
WireConnection;1285;0;1284;0
WireConnection;1237;0;1235;0
WireConnection;1237;1;1236;0
WireConnection;1237;2;1251;0
WireConnection;616;0;18;4
WireConnection;620;0;1253;0
WireConnection;1179;0;1175;0
WireConnection;1179;1;1250;0
WireConnection;1252;0;1237;0
WireConnection;744;0;645;4
WireConnection;745;0;749;0
WireConnection;745;1;294;0
WireConnection;660;0;294;0
WireConnection;646;0;645;1
WireConnection;0;0;1252;0
WireConnection;0;1;624;0
WireConnection;0;10;791;0
WireConnection;0;11;1179;0
ASEEND*/
//CHKSM=CB53F1C95E62FFF04EC8C5A3AE4D11D664D8846B