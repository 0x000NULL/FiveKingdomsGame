// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/Advanced Dynamic Shaders/Simple Lit/Tree Leaf"
{
	Properties
	{
		[HideInInspector]_Internal_Version("Internal_Version", Float) = 220
		[BBanner(ADS Simple Lit, Tree Leaf)]_ADSSimpleLitTreeLeaf("< ADS Simple Lit Tree Leaf >", Float) = 1
		[BCategory(Rendering)]_RENDERINGG("[ RENDERINGG ]", Float) = 0
		[Enum(Two Sided,0,Back,1,Front,2)]_RenderFaces("Render Faces", Float) = 0
		_Cutoff("Cutout", Range( 0 , 1)) = 0.5
		[BCategory(Leaf)]_LEAFF("[ LEAFF ]", Float) = 0
		_Color("Leaf Color", Color) = (1,1,1,1)
		[NoScaleOffset]_AlbedoTex("Leaf Albedo", 2D) = "white" {}
		[Toggle]_NormalInvertOnBackface("Leaf Normal Backface", Float) = 1
		_NormalScale("Leaf Normal Scale", Float) = 1
		[NoScaleOffset]_NormalTex("Leaf Normal", 2D) = "bump" {}
		[HideInInspector]_MotionNoise("Motion Noise", Float) = 1
		_GlobalTurbulence("Global Turbulence", Range( 0 , 1)) = 1
		[BCategory(Settings)]_SETTINGSS("[ SETTINGSS ]", Float) = 0
		_VertexOcclusion("Vertex Occlusion", Range( 0 , 1)) = 0
		_GlobalTint("Global Tint", Range( 0 , 1)) = 1
		_DetailTint("Detail Tint", Range( 0 , 1)) = 1
		[BCategory(Trunk Motion)]_TRUNKMOTIONN("[ TRUNK MOTIONN ]", Float) = 0
		[BInteractive(_MotionSpace, 0)]_MotionSpaceee("# MotionSpaceee", Float) = 0
		[BInteractive(ON)]_MotionSpaceeeEnd("# MotionSpaceee End", Float) = 0
		[BInteractive(_MotionSpace, 1)]_MotionSpacee("# MotionSpacee", Float) = 0
		[BInteractive(ON)]_MotionSpaceeEnd("# MotionSpacee End", Float) = 0
		[BMessage(Info, The Trunk Motion Parameters will be overridden by the ADS Materials Helper Component, _Internal_SetByScript, 1, 0, 10)]_TrunkMotionParameters("!!! Trunk Motion Parameters !!!", Float) = 0
		_MotionAmplitude("Trunk Motion Amplitude", Float) = 0
		_MotionSpeed("Trunk Motion Speed", Float) = 0
		_MotionScale("Trunk Motion Scale", Float) = 0
		[BCategory(Branch Motion)]_BRANCHMOTIONN("[ BRANCH MOTIONN ]", Float) = 0
		[BMessage(Info, The Branch Motion Parameters will be overridden by the ADS Materials Helper Component, _Internal_SetByScript, 1, 0, 10)]_BranchMotionParameters("!!! Branch Motion Parameters !!!", Float) = 0
		_MotionAmplitude2("Branch Motion Amplitude", Float) = 0
		_MotionSpeed2("Branch Motion Speed", Float) = 0
		_MotionScale2("Branch Motion Scale", Float) = 0
		_MotionVariation2("Branch Motion Variation", Float) = 0
		_MotionVertical2("Branch Motion Vertical", Range( 0 , 1)) = 0
		[BCategory(Leaf Motion)]_LEAFMOTIONN("[ LEAF MOTIONN ]", Float) = 0
		[BMessage(Info, The Leaf Motion Parameters will be overridden by the ADS Materials Helper Component, _Internal_SetByScript, 1, 0, 10)]_LeafMtionParameters("!!! Leaf Mtion Parameters !!!", Float) = 0
		_MotionAmplitude3("Leaf Flutter Amplitude", Float) = 0
		_MotionSpeed3("Leaf Flutter Speed", Float) = 0
		_MotionScale3("Leaf Flutter Scale", Float) = 0
		[BCategory(Advanced)]_ADVANCEDD("[ ADVANCEDD ]", Float) = 0
		[BMessage(Info, Batching is not currently supported Please use GPU Instancing instead for better performance, 0, 0)]_BatchingInfo("!!! BatchingInfo", Float) = 0
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
		[HideInInspector]_Internal_TypeTreeLeaf("Internal_TypeTreeLeaf", Float) = 1
		[HideInInspector]_Internal_DebugMask("Internal_DebugMask", Float) = 1
		[HideInInspector]_Internal_DebugMask2("Internal_DebugMask2", Float) = 1
		[HideInInspector]_Internal_DebugMask3("Internal_DebugMask3", Float) = 1
		[HideInInspector]_Internal_DebugVariation("Internal_DebugVariation", Float) = 1
		[HideInInspector]_Internal_SetByScript("Internal_SetByScript", Float) = 0
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "DisableBatching" = "True" }
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
		#pragma surface surf Lambert keepalpha addshadow fullforwardshadows novertexlights nolightmap  nodynlightmap nodirlightmap nometa vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			half ASEVFace : VFACE;
			float4 vertexToFrag1907;
			float4 uv_tex4coord;
			float4 vertexColor : COLOR;
		};

		uniform float _MotionNoise;
		uniform half _MotionSpaceee;
		uniform half _MotionSpacee;
		uniform half _MotionSpaceeeEnd;
		uniform half _MotionSpaceeEnd;
		uniform half _LEAFMOTIONN;
		uniform half _ADVANCEDD;
		uniform half _Internal_TypeTreeLeaf;
		uniform half _Internal_DebugVariation;
		uniform half _RENDERINGG;
		uniform half4 _MainUVs;
		uniform float _Mode;
		uniform float _Glossiness;
		uniform half _CullMode;
		uniform float _BumpScale;
		uniform sampler2D _MetallicGlossMap;
		uniform half _Internal_UnityToBoxophobic;
		uniform sampler2D _MainTex;
		uniform sampler2D _BumpMap;
		uniform half _TRUNKMOTIONN;
		uniform half _Internal_LitSimple;
		uniform half _Internal_ADS;
		uniform half _Internal_Version;
		uniform half _Internal_SetByScript;
		uniform half _Internal_DebugMask3;
		uniform half _BRANCHMOTIONN;
		uniform half _LeafMtionParameters;
		uniform half _BranchMotionParameters;
		uniform half _TrunkMotionParameters;
		uniform half _BatchingInfo;
		uniform half _SETTINGSS;
		uniform half _Internal_DebugMask;
		uniform half _Internal_DebugMask2;
		uniform half _Cutoff;
		uniform half _RenderFaces;
		uniform half _ADSSimpleLitTreeLeaf;
		uniform half _LEAFF;
		uniform half ADS_GlobalScale;
		uniform float _MotionScale;
		uniform half ADS_GlobalSpeed;
		uniform float _MotionSpeed;
		uniform half ADS_GlobalAmplitude;
		uniform float _MotionAmplitude;
		uniform half3 ADS_GlobalDirection;
		uniform half ADS_GlobalLeavesAmount;
		uniform half ADS_GlobalLeavesVar;
		uniform float _MotionScale2;
		uniform float _MotionSpeed2;
		uniform float _MotionVariation2;
		uniform float _MotionAmplitude2;
		uniform float _MotionVertical2;
		uniform float _MotionScale3;
		uniform float _MotionSpeed3;
		uniform float _MotionAmplitude3;
		uniform half ADS_TurbulenceTex_ON;
		uniform float _GlobalTurbulence;
		uniform sampler2D ADS_TurbulenceTex;
		uniform half ADS_TurbulenceSpeed;
		uniform half ADS_TurbulenceScale;
		uniform half ADS_TurbulenceContrast;
		uniform half _NormalScale;
		uniform sampler2D _NormalTex;
		uniform half _NormalInvertOnBackface;
		uniform sampler2D _AlbedoTex;
		uniform half4 _Color;
		uniform half4 ADS_GlobalTintColorOne;
		uniform half4 ADS_GlobalTintColorTwo;
		uniform half _DetailTint;
		uniform half ADS_GlobalTintIntensity;
		uniform half _GlobalTint;
		uniform half _VertexOcclusion;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			half MotionScale60_g1839 = ( ADS_GlobalScale * _MotionScale );
			half MotionSpeed62_g1839 = ( ADS_GlobalSpeed * _MotionSpeed );
			float mulTime90_g1839 = _Time.y * MotionSpeed62_g1839;
			float3 temp_output_95_0_g1839 = ( ( ase_worldPos * MotionScale60_g1839 ) + mulTime90_g1839 );
			half MotionlAmplitude58_g1839 = ( ADS_GlobalAmplitude * _MotionAmplitude );
			float3 temp_output_92_0_g1839 = ( sin( temp_output_95_0_g1839 ) * MotionlAmplitude58_g1839 );
			float3 temp_output_256_0_g1839 = mul( unity_WorldToObject, float4( ADS_GlobalDirection , 0.0 ) ).xyz;
			half3 MotionDirection59_g1839 = temp_output_256_0_g1839;
			half Packed_Trunk21809 = ( v.color.r * v.color.r );
			half ADS_TreeLeavesAffectMotion168_g1833 = 0.1;
			half ADS_TreeLeavesAmount157_g1833 = ADS_GlobalLeavesAmount;
			half localunity_ObjectToWorld0w1_g1834 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld2w3_g1834 = ( unity_ObjectToWorld[2].w );
			float temp_output_142_0_g1833 = saturate( ( ADS_TreeLeavesAmount157_g1833 - ( frac( ( localunity_ObjectToWorld0w1_g1834 + localunity_ObjectToWorld2w3_g1834 ) ) * ADS_GlobalLeavesVar ) ) );
			half LeavesAmountSimple172_g1833 = temp_output_142_0_g1833;
			float lerpResult156_g1833 = lerp( ADS_TreeLeavesAffectMotion168_g1833 , 1.0 , LeavesAmountSimple172_g1833);
			half MotionMask137_g1839 = ( Packed_Trunk21809 * lerpResult156_g1833 );
			float3 temp_output_94_0_g1839 = ( ( temp_output_92_0_g1839 * MotionDirection59_g1839 ) * MotionMask137_g1839 );
			float3 break231_g1839 = temp_output_94_0_g1839;
			float3 appendResult232_g1839 = (float3(break231_g1839.x , 0.0 , break231_g1839.z));
			half3 Motion_Trunk1749 = appendResult232_g1839;
			half MotionScale60_g1838 = ( ADS_GlobalScale * _MotionScale2 );
			half MotionSpeed62_g1838 = ( ADS_GlobalSpeed * _MotionSpeed2 );
			float mulTime90_g1838 = _Time.y * MotionSpeed62_g1838;
			float3 temp_output_95_0_g1838 = ( ( ase_worldPos * MotionScale60_g1838 ) + mulTime90_g1838 );
			half Packed_Variation1815 = v.color.a;
			half MotionVariation269_g1838 = ( _MotionVariation2 * Packed_Variation1815 );
			half MotionlAmplitude58_g1838 = ( ADS_GlobalAmplitude * _MotionAmplitude2 );
			float3 temp_output_92_0_g1838 = ( sin( ( temp_output_95_0_g1838 + MotionVariation269_g1838 ) ) * MotionlAmplitude58_g1838 );
			float3 lerpResult280_g1838 = lerp( ADS_GlobalDirection , float3(0,1,0) , _MotionVertical2);
			float3 temp_output_256_0_g1838 = mul( unity_WorldToObject, float4( lerpResult280_g1838 , 0.0 ) ).xyz;
			half3 MotionDirection59_g1838 = temp_output_256_0_g1838;
			half Packed_Branch1830 = v.color.g;
			half ADS_TreeLeavesAffectMotion168_g1835 = 0.1;
			float temp_output_152_0_g1835 = Packed_Variation1815;
			half ADS_TreeLeavesAmount157_g1835 = ADS_GlobalLeavesAmount;
			half localunity_ObjectToWorld0w1_g1836 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld2w3_g1836 = ( unity_ObjectToWorld[2].w );
			float temp_output_142_0_g1835 = saturate( ( ADS_TreeLeavesAmount157_g1835 - ( frac( ( localunity_ObjectToWorld0w1_g1836 + localunity_ObjectToWorld2w3_g1836 ) ) * ADS_GlobalLeavesVar ) ) );
			float lerpResult175_g1835 = lerp( 0.0 , ceil( ( temp_output_152_0_g1835 - temp_output_142_0_g1835 ) ) , step( temp_output_152_0_g1835 , 3.0 ));
			half LeavesAmountWithVariation161_g1835 = ( 1.0 - lerpResult175_g1835 );
			float lerpResult166_g1835 = lerp( ADS_TreeLeavesAffectMotion168_g1835 , 1.0 , LeavesAmountWithVariation161_g1835);
			half MotionMask137_g1838 = ( Packed_Branch1830 * lerpResult166_g1835 );
			float3 temp_output_94_0_g1838 = ( ( temp_output_92_0_g1838 * MotionDirection59_g1838 ) * MotionMask137_g1838 );
			half3 Motion_Branch1750 = temp_output_94_0_g1838;
			float3 ase_vertex3Pos = v.vertex.xyz;
			half MotionFlutterScale60_g1837 = ( ADS_GlobalScale * _MotionScale3 );
			half MotionFlutterSpeed62_g1837 = ( ADS_GlobalSpeed * _MotionSpeed3 );
			float mulTime90_g1837 = _Time.y * MotionFlutterSpeed62_g1837;
			half MotionlFlutterAmplitude58_g1837 = ( ADS_GlobalAmplitude * _MotionAmplitude3 );
			half Packed_Leaf1819 = v.color.b;
			half MotionMask137_g1837 = Packed_Leaf1819;
			float3 ase_vertexNormal = v.normal.xyz;
			half3 Motion_Leaf1751 = ( ( ( sin( ( ( ase_vertex3Pos * MotionFlutterScale60_g1837 ) + mulTime90_g1837 ) ) * MotionlFlutterAmplitude58_g1837 ) * MotionMask137_g1837 ) * ase_vertexNormal );
			half localunity_ObjectToWorld0w1_g1830 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g1830 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g1830 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g1830 = (float3(localunity_ObjectToWorld0w1_g1830 , localunity_ObjectToWorld1w2_g1830 , localunity_ObjectToWorld2w3_g1830));
			float2 panner73_g1828 = ( _Time.y * ( ADS_TurbulenceSpeed * (-ADS_GlobalDirection).xz ) + ( (appendResult6_g1830).xz * ADS_TurbulenceScale ));
			float lerpResult136_g1828 = lerp( 1.0 , saturate( pow( abs( tex2Dlod( ADS_TurbulenceTex, float4( panner73_g1828, 0, 0.0) ).r ) , ADS_TurbulenceContrast ) ) , _GlobalTurbulence);
			float ifLocalVar94_g1828 = 0;
			UNITY_BRANCH 
			if( ( ADS_TurbulenceTex_ON * _GlobalTurbulence ) > 0.0001 )
				ifLocalVar94_g1828 = lerpResult136_g1828;
			else if( ( ADS_TurbulenceTex_ON * _GlobalTurbulence ) < 0.0001 )
				ifLocalVar94_g1828 = 1.0;
			half Motion_Turbulence1921 = ifLocalVar94_g1828;
			half3 Motion_Output1220 = ( ( Motion_Trunk1749 + Motion_Branch1750 + Motion_Leaf1751 ) * Motion_Turbulence1921 );
			v.vertex.xyz += Motion_Output1220;
			float4 temp_cast_4 = (1.0).xxxx;
			half4 ADS_GlobalTintColorOne176_g1840 = ADS_GlobalTintColorOne;
			half4 ADS_GlobalTintColorTwo177_g1840 = ADS_GlobalTintColorTwo;
			half localunity_ObjectToWorld0w1_g1844 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld2w3_g1844 = ( unity_ObjectToWorld[2].w );
			float lerpResult194_g1840 = lerp( frac( ( localunity_ObjectToWorld0w1_g1844 + localunity_ObjectToWorld2w3_g1844 ) ) , Packed_Variation1815 , _DetailTint);
			float4 lerpResult166_g1840 = lerp( ADS_GlobalTintColorOne176_g1840 , ADS_GlobalTintColorTwo177_g1840 , lerpResult194_g1840);
			half ADS_GlobalTintIntensity181_g1840 = ADS_GlobalTintIntensity;
			half GlobalTint186_g1840 = _GlobalTint;
			float4 lerpResult168_g1840 = lerp( temp_cast_4 , ( lerpResult166_g1840 * ADS_GlobalTintIntensity181_g1840 ) , GlobalTint186_g1840);
			o.vertexToFrag1907 = lerpResult168_g1840;
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_NormalTex607 = i.uv_texcoord;
			float3 temp_output_13_0_g1848 = UnpackScaleNormal( tex2D( _NormalTex, uv_NormalTex607 ), _NormalScale );
			float3 break17_g1848 = temp_output_13_0_g1848;
			float switchResult12_g1848 = (((i.ASEVFace>0)?(break17_g1848.z):(-break17_g1848.z)));
			float3 appendResult18_g1848 = (float3(break17_g1848.x , break17_g1848.y , switchResult12_g1848));
			float3 lerpResult20_g1848 = lerp( temp_output_13_0_g1848 , appendResult18_g1848 , _NormalInvertOnBackface);
			half3 Main_NormalTex620 = lerpResult20_g1848;
			o.Normal = Main_NormalTex620;
			float2 uv_AlbedoTex18 = i.uv_texcoord;
			float4 tex2DNode18 = tex2D( _AlbedoTex, uv_AlbedoTex18 );
			half4 Main_AlbedoTex487 = tex2DNode18;
			half4 Main_Color486 = _Color;
			half4 Gloabl_Tint1908 = i.vertexToFrag1907;
			float lerpResult1308 = lerp( 1.0 , i.uv_tex4coord.z , _VertexOcclusion);
			half Vertex_Occlusion1312 = lerpResult1308;
			o.Albedo = saturate( ( Main_AlbedoTex487 * Main_Color486 * Gloabl_Tint1908 * Vertex_Occlusion1312 ) ).rgb;
			o.Alpha = 1;
			half Main_AlbedoTex_A616 = tex2DNode18.a;
			half Packed_Variation1815 = i.vertexColor.a;
			float temp_output_152_0_g1846 = Packed_Variation1815;
			half ADS_TreeLeavesAmount157_g1846 = ADS_GlobalLeavesAmount;
			half localunity_ObjectToWorld0w1_g1847 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld2w3_g1847 = ( unity_ObjectToWorld[2].w );
			float temp_output_142_0_g1846 = saturate( ( ADS_TreeLeavesAmount157_g1846 - ( frac( ( localunity_ObjectToWorld0w1_g1847 + localunity_ObjectToWorld2w3_g1847 ) ) * ADS_GlobalLeavesVar ) ) );
			float lerpResult175_g1846 = lerp( 0.0 , ceil( ( temp_output_152_0_g1846 - temp_output_142_0_g1846 ) ) , step( temp_output_152_0_g1846 , 3.0 ));
			half Opacity1306 = saturate( ( Main_AlbedoTex_A616 - lerpResult175_g1846 ) );
			clip( Opacity1306 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Utils/ADS Fallback"
	CustomEditor "ADSShaderGUI"
}
/*ASEBEGIN
Version=16209
1927;29;1906;1014;893.7826;-489.0563;1;True;False
Node;AmplifyShaderEditor.VertexColorNode;1804;-1280,768;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1808;-1024,1072;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1815;-1024,1216;Half;False;Packed_Variation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1894;640,1280;Float;False;1815;Packed_Variation;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1809;-832,1088;Half;False;Packed_Trunk2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1830;-1024,848;Half;False;Packed_Branch;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1893;896,1280;Float;False;ADS Leaves Amount;-1;;1835;ee8761bdf5e2c1e4b8e0ff49e8488b33;0;1;152;FLOAT;0;False;3;FLOAT;154;FLOAT;148;FLOAT;167
Node;AmplifyShaderEditor.GetLocalVarNode;1712;896,1088;Float;False;1815;Packed_Variation;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1732;896,1008;Float;False;Property;_MotionVariation2;Branch Motion Variation;47;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1820;896,1184;Float;False;1830;Packed_Branch;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1819;-1024,928;Half;False;Packed_Leaf;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1637;-384,1152;Float;False;1809;Packed_Trunk2;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1891;-384,1280;Float;False;ADS Leaves Amount;-1;;1833;ee8761bdf5e2c1e4b8e0ff49e8488b33;0;1;152;FLOAT;0;False;3;FLOAT;154;FLOAT;148;FLOAT;167
Node;AmplifyShaderEditor.RangedFloatNode;1556;-384,848;Float;False;Property;_MotionSpeed;Trunk Motion Speed;40;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1903;1280,1408;Float;False;Property;_MotionVertical2;Branch Motion Vertical;48;0;Create;False;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1563;896,768;Float;False;Property;_MotionAmplitude2;Branch Motion Amplitude;44;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1895;1344,1184;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1555;-384,768;Float;False;Property;_MotionAmplitude;Trunk Motion Amplitude;39;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1722;2240,1024;Float;False;1819;Packed_Leaf;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1562;896,848;Float;False;Property;_MotionSpeed2;Branch Motion Speed;45;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1557;-384,928;Float;False;Property;_MotionScale;Trunk Motion Scale;41;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1733;1152,1008;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1716;2240,768;Float;False;Property;_MotionAmplitude3;Leaf Flutter Amplitude;51;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1714;2240,928;Float;False;Property;_MotionScale3;Leaf Flutter Scale;53;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1715;2240,848;Float;False;Property;_MotionSpeed3;Leaf Flutter Speed;52;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1561;896,928;Float;False;Property;_MotionScale2;Branch Motion Scale;46;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1892;0,1152;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;-1280,-896;Float;True;Property;_AlbedoTex;Leaf Albedo;8;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1905;-1280,1920;Float;False;1815;Packed_Variation;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1857;1536,768;Float;False;ADS Motion Custom;29;;1838;157ee7880d81d9e4ab5582c2b22b9a68;8,225,0,278,1,228,1,292,1,254,0,262,0,252,3,260,0;9;220;FLOAT;0;False;221;FLOAT;0;False;222;FLOAT;0;False;218;FLOAT;0;False;287;FLOAT;0;False;136;FLOAT;0;False;248;FLOAT3;0,0,0;False;279;FLOAT;0;False;247;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1919;2560,768;Float;False;ADS Motion Flutter;-1;;1837;87d8028e5f83178498a65cfa9f0e9ace;0;4;220;FLOAT;0;False;221;FLOAT;0;False;222;FLOAT;0;False;136;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1859;256,768;Float;False;ADS Motion Custom;29;;1839;157ee7880d81d9e4ab5582c2b22b9a68;8,225,1,278,0,228,0,292,1,254,0,262,0,252,0,260,0;9;220;FLOAT;0;False;221;FLOAT;0;False;222;FLOAT;0;False;218;FLOAT;0;False;287;FLOAT;0;False;136;FLOAT;0;False;248;FLOAT3;0,0,0;False;279;FLOAT;0;False;247;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1751;2816,768;Half;False;Motion_Leaf;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1814;0,0;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1749;512,768;Half;False;Motion_Trunk;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1309;0,192;Half;False;Property;_VertexOcclusion;Vertex Occlusion;22;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1885;-1280,-64;Float;False;1815;Packed_Variation;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1750;1856,768;Half;False;Motion_Branch;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1906;-1024,1920;Float;False;ADS Global Settings;23;;1840;0fe83146627632b4981f5a0aa1b63801;0;1;171;FLOAT;0;False;3;COLOR;85;COLOR;165;FLOAT;157
Node;AmplifyShaderEditor.FunctionNode;1920;-1280,1344;Float;False;ADS Global Turbulence;15;;1828;047eb809542f42d40b4b5066e22cee72;0;0;1;FLOAT;85
Node;AmplifyShaderEditor.FunctionNode;1901;0,-128;Float;False;const;-1;;1845;5b64729fb717c5f49a1bc2dab81d5e1c;1,3,1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;-976,-768;Half;False;Main_AlbedoTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1308;384,-128;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1796;3200,864;Float;False;1750;Motion_Branch;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1797;3200,960;Float;False;1751;Motion_Leaf;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;409;-384,-896;Half;False;Property;_Color;Leaf Color;7;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1752;3200,768;Float;False;1749;Motion_Trunk;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1888;-1280,-128;Float;False;616;Main_AlbedoTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1921;-1024,1344;Half;False;Motion_Turbulence;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1884;-1008,0;Float;False;ADS Leaves Amount;-1;;1846;ee8761bdf5e2c1e4b8e0ff49e8488b33;0;1;152;FLOAT;0;False;3;FLOAT;154;FLOAT;148;FLOAT;167
Node;AmplifyShaderEditor.VertexToFragmentNode;1907;-768,1920;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;655;384,-896;Half;False;Property;_NormalScale;Leaf Normal Scale;10;0;Create;False;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1889;-608,-128;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-976,-896;Half;False;Main_AlbedoTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1312;576,-128;Half;False;Vertex_Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1916;688,-704;Half;False;Property;_NormalInvertOnBackface;Leaf Normal Backface;9;1;[Toggle];Create;False;2;Opaque;0;Transparent;1;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1908;-448,1920;Half;False;Gloabl_Tint;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;-128,-896;Half;False;Main_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1923;3200,1056;Float;False;1921;Motion_Turbulence;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1801;3584,768;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;607;656,-896;Float;True;Property;_NormalTex;Leaf Normal;11;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1076;-1280,-1984;Float;False;486;Main_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1629;3776,768;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;-1280,-2048;Float;False;487;Main_AlbedoTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1914;-1280,-1920;Float;False;1908;Gloabl_Tint;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1313;-1280,-1856;Float;False;1312;Vertex_Occlusion;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1890;-464,-128;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1915;976,-896;Float;False;ADS Normal Backface;-1;;1848;4f53bc25e6d8da34db70401bcf363a2a;0;2;13;FLOAT3;0,0,0;False;30;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1306;-320,-128;Half;False;Opacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1075;-768,-2048;Float;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;1200,-896;Half;False;Main_NormalTex;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1220;3936,768;Half;False;Motion_Output;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1838;1376,-2560;Half;False;Property;_Internal_DebugMask2;Internal_DebugMask2;70;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1837;1136,-2560;Half;False;Property;_Internal_DebugMask;Internal_DebugMask;69;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1469;-736,-3232;Half;False;Property;_SETTINGSS;[ SETTINGSS ];21;0;Create;True;0;0;True;1;BCategory(Settings);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;925;-960,-2560;Half;False;Property;_ZWrite;_ZWrite;76;1;[HideInInspector];Create;True;2;Off;0;On;1;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1865;-1024,768;Half;False;Packed_Trunk;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1343;-576,-2048;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1708;-976,-3040;Half;False;Property;_BranchMotionParameters;!!! Branch Motion Parameters !!!;43;0;Create;True;0;0;True;1;BMessage(Info, The Branch Motion Parameters will be overridden by the ADS Materials Helper Component, _Internal_SetByScript, 1, 0, 10);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;294;2304,-816;Half;False;Property;_Smoothness;Leaf Smoothness;13;0;Create;False;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1057;-128,-800;Half;False;Main_Color_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1918;-352,-3040;Half;False;Property;_BatchingInfo;!!! BatchingInfo;55;0;Create;True;0;0;True;1;BMessage(Info, Batching is not currently supported Please use GPU Instancing instead for better performance, 0, 0);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1902;895.382,-127.3066;Float;False;const;-1;;1850;5b64729fb717c5f49a1bc2dab81d5e1c;1,3,1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1723;-1280,-3040;Half;False;Property;_TrunkMotionParameters;!!! Trunk Motion Parameters !!!;38;0;Create;True;0;0;True;1;BMessage(Info, The Trunk Motion Parameters will be overridden by the ADS Materials Helper Component, _Internal_SetByScript, 1, 0, 10);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1792;896,192;Half;False;Property;_Occlusion;Leaf Occlusion;14;0;Create;False;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1793;1280,-128;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;743;-624,-2560;Half;False;Property;_RenderFaces;Render Faces;4;1;[Enum];Create;True;3;Two Sided;0;Back;1;Front;2;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1788;1920,-832;Half;False;Main_SurfaceTex_G;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1922;-384,1024;Float;False;1921;Motion_Turbulence;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1468;-1088,-3232;Half;False;Property;_LEAFF;[ LEAFF ];6;0;Create;True;0;0;True;1;BCategory(Leaf);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1472;-1280,-3328;Half;False;Property;_ADSSimpleLitTreeLeaf;< ADS Simple Lit Tree Leaf >;1;0;Create;True;0;0;True;1;BBanner(ADS Simple Lit, Tree Leaf);1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1799;-1280,-3136;Half;False;Property;_EnableBlendingg;# EnableBlendingg;20;0;Create;True;0;0;False;1;BInteractive(_ENABLEBLENDING_ON);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;624;-1280,-1760;Float;False;620;Main_NormalTex;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1783;-1280,-1664;Float;False;1306;Opacity;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;646;1920,-896;Half;False;Main_SurfaceTex_R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;744;1921,-704;Half;False;Main_SurfaceTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;862;-448,-2560;Half;False;Property;_Cutoff;Cutout;5;0;Create;False;3;Off;0;Front;1;Back;2;0;True;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1724;-672,-3040;Half;False;Property;_LeafMtionParameters;!!! Leaf Mtion Parameters !!!;50;0;Create;True;0;0;True;1;BMessage(Info, The Leaf Motion Parameters will be overridden by the ADS Materials Helper Component, _Internal_SetByScript, 1, 0, 10);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;749;2304,-896;Float;False;744;Main_SurfaceTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;553;-1120,-2560;Half;False;Property;_DstBlend;_DstBlend;75;1;[HideInInspector];Create;True;0;0;False;0;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1846;0,-2560;Float;False;Internal Unity Props;57;;1849;b286e6ef621b64a4fb35da1e13fa143f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1795;896,0;Float;False;1788;Main_SurfaceTex_G;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1470;-544,-3232;Half;False;Property;_TRUNKMOTIONN;[ TRUNK MOTIONN ];28;0;Create;True;0;0;True;1;BCategory(Trunk Motion);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1513;-928,-3232;Half;False;Property;_BLENDINGG;[ BLENDINGG ];19;0;Create;True;0;0;False;1;BCategory(Trunk Blending);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;660;2816,-896;Half;False;SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1471;160,-3232;Half;False;Property;_ADVANCEDD;[ ADVANCEDD ];54;0;Create;True;0;0;True;1;BCategory(Advanced);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1473;-80,-3232;Half;False;Property;_LEAFMOTIONN;[ LEAF MOTIONN ];49;0;Create;True;0;0;True;1;BCategory(Leaf Motion);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1466;-1280,-3232;Half;False;Property;_RENDERINGG;[ RENDERINGG ];2;0;Create;True;0;0;True;1;BCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1897;1856,-2560;Half;False;Property;_Internal_DebugVariation;Internal_DebugVariation;72;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1841;656,-2560;Half;False;Property;_Internal_TypeTreeLeaf;Internal_TypeTreeLeaf;68;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;645;1536,-896;Float;True;Property;_SurfaceTex;Leaf Surface;12;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1845;1616,-2560;Half;False;Property;_Internal_DebugMask3;Internal_DebugMask3;71;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1839;2112,-2560;Half;False;Property;_Internal_SetByScript;Internal_SetByScript;73;1;[HideInInspector];Create;True;0;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1221;-1280,-1536;Float;False;1220;Motion_Output;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;2624,-896;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1688;-320,-3232;Half;False;Property;_BRANCHMOTIONN;[ BRANCH MOTIONN ];42;0;Create;True;0;0;True;1;BCategory(Branch Motion);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;549;-800,-2560;Half;False;Property;_RenderType;Render Type;3;1;[Enum];Create;True;2;Opaque;0;Cutout;1;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1842;912,-2560;Half;False;Property;_Internal_LitSimple;Internal_LitSimple;67;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;550;-1280,-2560;Half;False;Property;_SrcBlend;_SrcBlend;74;1;[HideInInspector];Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1836;1920,-768;Half;False;Main_SurfaceTex_B;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1794;1472,-128;Half;False;Main_Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1917;256,-2560;Half;False;Property;_Internal_Version;Internal_Version;0;1;[HideInInspector];Create;True;0;0;True;0;220;1;220;220;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1896;464,-2560;Half;False;Property;_Internal_ADS;Internal_ADS;56;1;[HideInInspector];Create;True;0;0;True;0;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-128,-2048;Float;False;True;2;Float;ADSShaderGUI;300;0;Lambert;BOXOPHOBIC/Advanced Dynamic Shaders/Simple Lit/Tree Leaf;False;False;False;False;False;True;True;True;True;False;True;False;False;True;True;False;True;False;False;False;Off;0;False;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;False;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;True;550;10;True;553;0;1;False;550;10;False;553;0;True;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;300;Utils/ADS Fallback;-1;-1;-1;-1;0;False;0;0;True;743;-1;0;True;862;3;Include;../../../Utils/CGIncludes/VS_indirect.cginc;False;;Pragma;instancing_options procedural:setup;False;;Pragma;multi_compile GPU_FRUSTUM_ON __;False;;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;760;-1280,-1024;Float;False;1364.434;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1465;-1280,-3456;Float;False;1614.13;100;Drawers;0;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1542;-1280,640;Float;False;5414.462;100;Tree Motion;0;;0.03448272,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;751;2304,-1024;Float;False;709.9668;100;Metallic / Smoothness;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;708;384,-1024;Float;False;1027.031;100;Normal Texture;0;;0.5019608,0.5019608,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1543;-1280,-256;Float;False;1155.176;100;Leaf Amount;0;;0.5,0.5,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;715;1536,-1024;Float;False;638;100;Surface Texture (Metallic, AO, SubSurface, Smoothness);0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1544;0,-256;Float;False;1668.041;100;Ambient Occlusion;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1844;0,-2688;Float;False;2325.872;100;Internal Only;0;;1,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1913;-1280,1792;Float;False;1029.015;100;Globals;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;683;-1280,-2688;Float;False;1104;100;Rendering (Unused);0;;1,0,0.503,1;0;0
WireConnection;1808;0;1804;1
WireConnection;1808;1;1804;1
WireConnection;1815;0;1804;4
WireConnection;1809;0;1808;0
WireConnection;1830;0;1804;2
WireConnection;1893;152;1894;0
WireConnection;1819;0;1804;3
WireConnection;1895;0;1820;0
WireConnection;1895;1;1893;167
WireConnection;1733;0;1732;0
WireConnection;1733;1;1712;0
WireConnection;1892;0;1637;0
WireConnection;1892;1;1891;148
WireConnection;1857;220;1563;0
WireConnection;1857;221;1562;0
WireConnection;1857;222;1561;0
WireConnection;1857;218;1733;0
WireConnection;1857;136;1895;0
WireConnection;1857;279;1903;0
WireConnection;1919;220;1716;0
WireConnection;1919;221;1715;0
WireConnection;1919;222;1714;0
WireConnection;1919;136;1722;0
WireConnection;1859;220;1555;0
WireConnection;1859;221;1556;0
WireConnection;1859;222;1557;0
WireConnection;1859;136;1892;0
WireConnection;1751;0;1919;0
WireConnection;1749;0;1859;0
WireConnection;1750;0;1857;0
WireConnection;1906;171;1905;0
WireConnection;616;0;18;4
WireConnection;1308;0;1901;0
WireConnection;1308;1;1814;3
WireConnection;1308;2;1309;0
WireConnection;1921;0;1920;85
WireConnection;1884;152;1885;0
WireConnection;1907;0;1906;165
WireConnection;1889;0;1888;0
WireConnection;1889;1;1884;154
WireConnection;487;0;18;0
WireConnection;1312;0;1308;0
WireConnection;1908;0;1907;0
WireConnection;486;0;409;0
WireConnection;1801;0;1752;0
WireConnection;1801;1;1796;0
WireConnection;1801;2;1797;0
WireConnection;607;5;655;0
WireConnection;1629;0;1801;0
WireConnection;1629;1;1923;0
WireConnection;1890;0;1889;0
WireConnection;1915;13;607;0
WireConnection;1915;30;1916;0
WireConnection;1306;0;1890;0
WireConnection;1075;0;36;0
WireConnection;1075;1;1076;0
WireConnection;1075;2;1914;0
WireConnection;1075;3;1313;0
WireConnection;620;0;1915;0
WireConnection;1220;0;1629;0
WireConnection;1865;0;1804;1
WireConnection;1343;0;1075;0
WireConnection;1057;0;409;4
WireConnection;1793;0;1902;0
WireConnection;1793;1;1795;0
WireConnection;1793;2;1792;0
WireConnection;1788;0;645;2
WireConnection;646;0;645;1
WireConnection;744;0;645;4
WireConnection;660;0;745;0
WireConnection;745;0;749;0
WireConnection;745;1;294;0
WireConnection;1836;0;645;3
WireConnection;1794;0;1793;0
WireConnection;0;0;1343;0
WireConnection;0;1;624;0
WireConnection;0;10;1783;0
WireConnection;0;11;1221;0
ASEEND*/
//CHKSM=27B3B4689E3762BE9EF1A252D73A55A5037BDE9D