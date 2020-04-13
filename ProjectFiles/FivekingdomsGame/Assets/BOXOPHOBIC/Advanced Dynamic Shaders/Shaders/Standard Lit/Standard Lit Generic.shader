// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/Advanced Dynamic Shaders/Standard Lit/Generic"
{
	Properties
	{
		[HideInInspector]_Internal_Version("Internal_Version", Float) = 220
		[BBanner(ADS Standard Lit, Generic)]_ADSStandardLitGeneric("< ADS Standard Lit Generic >", Float) = 1
		[BCategory(Rendering)]_RENDERINGG("[ RENDERINGG ]", Float) = 0
		[Enum(Opaque,0,Cutout,1,Fade,2,Transparent,3)]_RenderType("Render Type", Float) = 0
		[Enum(Two Sided,0,Back,1,Front,2)]_RenderFaces("Render Faces", Float) = 0
		[BInteractive(_RenderType, 1)]_RenderTypee("# _RenderTypee", Float) = 0
		_Cutoff("Cutout", Range( 0 , 1)) = 0.5
		[BCategory(Main)]_MAINN("[ MAINN ]", Float) = 0
		_Color("Main Color", Color) = (1,1,1,1)
		[NoScaleOffset]_AlbedoTex("Main Albedo", 2D) = "white" {}
		[Toggle]_NormalInvertOnBackface("Main Normal Backface", Float) = 1
		_NormalScale("Main Normal Scale", Float) = 1
		[NoScaleOffset]_NormalTex("Main Normal", 2D) = "bump" {}
		[NoScaleOffset]_SurfaceTex("Main Surface", 2D) = "white" {}
		_Metallic("Main Metallic", Range( 0 , 1)) = 0
		[HideInInspector]_MotionNoise("Motion Noise", Float) = 1
		_GlobalTurbulence("Global Turbulence", Range( 0 , 1)) = 1
		_Smoothness("Main Smoothness", Range( 0 , 1)) = 0.5
		[Space(10)]_UVZero("Main UVs", Vector) = (1,1,0,0)
		[BCategory(Settings)]_SETTINGSS("[ SETTINGSS ]", Float) = 0
		[BCategory(Motion)]_MOTIONN("[ MOTIONN ]", Float) = 0
		[BInteractive(_MotionSpace, 0)]_MotionSpaceee("# MotionSpaceee", Float) = 0
		[BInteractive(ON)]_MotionSpaceeeEnd("# MotionSpaceee End", Float) = 0
		[KeywordEnum(World,Local)] _MotionSpace("Motion Space", Float) = 0
		[BInteractive(_MotionSpace, 1)]_MotionSpacee("# MotionSpacee", Float) = 0
		_LocalDirection("Motion Local Direction", Vector) = (0,0,1,0)
		[BInteractive(ON)]_MotionSpaceeEnd("# MotionSpacee End", Float) = 0
		_MotionAmplitude("Motion Amplitude", Float) = 0
		_MotionSpeed("Motion Speed", Float) = 0
		_MotionScale("Motion Scale", Float) = 0
		_MotionVariation("Motion Variation", Float) = 0
		[Enum(ADS Packed,0,ADS QuickMask,1)][Space(10)]_MaskType("Mask Type", Float) = 0
		[BInteractive(_MaskType, 1)]_MaskTypee("# MaskTypee", Float) = 0
		[Enum(X Axis,0,Y Axis,1,Z Axis,2)]_MaskAxis("Mask Axis", Float) = 1
		[BInteractive(ON)]_MaskTypeeEnd("# MaskTypee End", Float) = 0
		[BMessage(Warning, The ADS Quick Mask option is slow when using high poly meshes and it will be deprecated soon, _MaskType, 1, 10, 0)]_QuickMaskk("!!! QuickMaskk !!!", Float) = 0
		[Space(10)]_MaskMin("Mask Min", Float) = 0
		_MaskMax("Mask Max", Float) = 1
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
		[HideInInspector]_Internal_LitStandard("Internal_LitStandard", Float) = 1
		[HideInInspector]_Internal_TypeGeneric("Internal_TypeGeneric", Float) = 1
		[HideInInspector]_Internal_DebugMask("Internal_DebugMask", Float) = 1
		[HideInInspector]_SrcBlend("_SrcBlend", Float) = 1
		[HideInInspector]_DstBlend("_DstBlend", Float) = 10
		[HideInInspector]_ZWrite("_ZWrite", Float) = 1
		[HideInInspector]_Internal_DebugVariation("Internal_DebugVariation", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "DisableBatching" = "True" }
		LOD 300
		Cull [_RenderFaces]
		ZWrite [_ZWrite]
		Blend [_SrcBlend] [_DstBlend]
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature _MOTIONSPACE_WORLD _MOTIONSPACE_LOCAL
		#pragma shader_feature _RENDERTYPEKEY_OPAQUE _RENDERTYPEKEY_CUT _RENDERTYPEKEY_FADE _RENDERTYPEKEY_TRANSPARENT
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			half ASEVFace : VFACE;
		};

		uniform half _MaskTypee;
		uniform half _QuickMaskk;
		uniform half _MaskTypeeEnd;
		uniform half _MotionSpaceee;
		uniform half _MotionSpacee;
		uniform half _MotionSpaceeeEnd;
		uniform half _MotionSpaceeEnd;
		uniform half _ADSStandardLitGeneric;
		uniform half _Internal_DebugMask;
		uniform half _Internal_ADS;
		uniform half _ZWrite;
		uniform half _SrcBlend;
		uniform half _Internal_Version;
		uniform half _Cutoff;
		uniform half _BatchingInfo;
		uniform half _MOTIONN;
		uniform half _DstBlend;
		uniform half4 _MainUVs;
		uniform float _Mode;
		uniform float _Glossiness;
		uniform half _CullMode;
		uniform float _BumpScale;
		uniform sampler2D _MetallicGlossMap;
		uniform half _Internal_UnityToBoxophobic;
		uniform sampler2D _MainTex;
		uniform sampler2D _BumpMap;
		uniform half _Internal_LitStandard;
		uniform half _RENDERINGG;
		uniform half _ADVANCEDD;
		uniform half _RenderType;
		uniform half _Internal_DebugVariation;
		uniform half _SETTINGSS;
		uniform half _RenderTypee;
		uniform half _Internal_TypeGeneric;
		uniform half _MAINN;
		uniform half _RenderFaces;
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
		uniform half3 _LocalDirection;
		uniform half _MaskAxis;
		uniform half _MaskMin;
		uniform half _MaskMax;
		uniform half _MaskType;
		uniform half _NormalScale;
		uniform sampler2D _NormalTex;
		uniform half4 _UVZero;
		uniform half _NormalInvertOnBackface;
		uniform sampler2D _AlbedoTex;
		uniform half4 _Color;
		uniform sampler2D _SurfaceTex;
		uniform half _Metallic;
		uniform half _Smoothness;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 ase_vertex3Pos = v.vertex.xyz;
			#if defined(_MOTIONSPACE_WORLD)
				float3 staticSwitch261_g1831 = ase_worldPos;
			#elif defined(_MOTIONSPACE_LOCAL)
				float3 staticSwitch261_g1831 = ase_vertex3Pos;
			#else
				float3 staticSwitch261_g1831 = ase_worldPos;
			#endif
			half MotionScale60_g1831 = ( ADS_GlobalScale * _MotionScale );
			half MotionSpeed62_g1831 = ( ADS_GlobalSpeed * _MotionSpeed );
			float mulTime90_g1831 = _Time.y * MotionSpeed62_g1831;
			float3 temp_output_95_0_g1831 = ( ( staticSwitch261_g1831 * MotionScale60_g1831 ) + mulTime90_g1831 );
			half Packed_Variation1138 = v.color.a;
			half MotionVariation269_g1831 = ( _MotionVariation * Packed_Variation1138 );
			half MotionlAmplitude58_g1831 = ( ADS_GlobalAmplitude * _MotionAmplitude );
			float3 temp_output_92_0_g1831 = ( sin( ( temp_output_95_0_g1831 + MotionVariation269_g1831 ) ) * MotionlAmplitude58_g1831 );
			float3 temp_output_160_0_g1831 = ( temp_output_92_0_g1831 + MotionlAmplitude58_g1831 + MotionlAmplitude58_g1831 );
			half localunity_ObjectToWorld0w1_g1842 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g1842 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g1842 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g1842 = (float3(localunity_ObjectToWorld0w1_g1842 , localunity_ObjectToWorld1w2_g1842 , localunity_ObjectToWorld2w3_g1842));
			float2 panner73_g1840 = ( _Time.y * ( ADS_TurbulenceSpeed * (-ADS_GlobalDirection).xz ) + ( (appendResult6_g1842).xz * ADS_TurbulenceScale ));
			float lerpResult136_g1840 = lerp( 1.0 , saturate( pow( abs( tex2Dlod( ADS_TurbulenceTex, float4( panner73_g1840, 0, 0.0) ).r ) , ADS_TurbulenceContrast ) ) , _GlobalTurbulence);
			float ifLocalVar94_g1840 = 0;
			UNITY_BRANCH 
			if( ( ADS_TurbulenceTex_ON * _GlobalTurbulence ) > 0.0001 )
				ifLocalVar94_g1840 = lerpResult136_g1840;
			else if( ( ADS_TurbulenceTex_ON * _GlobalTurbulence ) < 0.0001 )
				ifLocalVar94_g1840 = 1.0;
			half Motion_Turbulence1162 = ifLocalVar94_g1840;
			float3 lerpResult293_g1831 = lerp( temp_output_92_0_g1831 , temp_output_160_0_g1831 , Motion_Turbulence1162);
			float3 temp_output_256_0_g1831 = mul( unity_WorldToObject, float4( ADS_GlobalDirection , 0.0 ) ).xyz;
			#if defined(_MOTIONSPACE_WORLD)
				float3 staticSwitch257_g1831 = temp_output_256_0_g1831;
			#elif defined(_MOTIONSPACE_LOCAL)
				float3 staticSwitch257_g1831 = _LocalDirection;
			#else
				float3 staticSwitch257_g1831 = temp_output_256_0_g1831;
			#endif
			half3 MotionDirection59_g1831 = staticSwitch257_g1831;
			float temp_output_25_0_g1806 = _MaskAxis;
			float lerpResult24_g1806 = lerp( v.texcoord3.x , v.texcoord3.y , saturate( temp_output_25_0_g1806 ));
			float lerpResult21_g1806 = lerp( lerpResult24_g1806 , v.texcoord3.z , step( 2.0 , temp_output_25_0_g1806 ));
			half THREE27_g1806 = lerpResult21_g1806;
			float temp_output_7_0_g1805 = _MaskMin;
			float lerpResult42_g1804 = lerp( v.color.r , saturate( ( ( THREE27_g1806 - temp_output_7_0_g1805 ) / ( _MaskMax - temp_output_7_0_g1805 ) ) ) , _MaskType);
			half Packed_Mask1141 = lerpResult42_g1804;
			half MotionMask137_g1831 = Packed_Mask1141;
			float3 temp_output_94_0_g1831 = ( ( lerpResult293_g1831 * MotionDirection59_g1831 ) * MotionMask137_g1831 );
			half3 Motion_Generic1148 = temp_output_94_0_g1831;
			half3 Motion_Output1152 = ( Motion_Generic1148 * Motion_Turbulence1162 );
			v.vertex.xyz += Motion_Output1152;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 appendResult564 = (float2(_UVZero.x , _UVZero.y));
			float2 appendResult565 = (float2(_UVZero.z , _UVZero.w));
			half2 Main_UVs587 = ( ( i.uv_texcoord * appendResult564 ) + appendResult565 );
			float3 temp_output_13_0_g1837 = UnpackScaleNormal( tex2D( _NormalTex, Main_UVs587 ), _NormalScale );
			float3 break17_g1837 = temp_output_13_0_g1837;
			float switchResult12_g1837 = (((i.ASEVFace>0)?(break17_g1837.z):(-break17_g1837.z)));
			float3 appendResult18_g1837 = (float3(break17_g1837.x , break17_g1837.y , switchResult12_g1837));
			float3 lerpResult20_g1837 = lerp( temp_output_13_0_g1837 , appendResult18_g1837 , _NormalInvertOnBackface);
			half3 Main_NormalTex620 = lerpResult20_g1837;
			o.Normal = Main_NormalTex620;
			float4 tex2DNode18 = tex2D( _AlbedoTex, Main_UVs587 );
			half4 Main_AlbedoTex487 = tex2DNode18;
			half4 Main_Color486 = _Color;
			float4 temp_output_1075_0 = ( Main_AlbedoTex487 * Main_Color486 );
			half Main_Color_A1057 = _Color.a;
			half Main_AlbedoTex_A616 = tex2DNode18.a;
			#if defined(_RENDERTYPEKEY_OPAQUE)
				float4 staticSwitch1114 = temp_output_1075_0;
			#elif defined(_RENDERTYPEKEY_CUT)
				float4 staticSwitch1114 = temp_output_1075_0;
			#elif defined(_RENDERTYPEKEY_FADE)
				float4 staticSwitch1114 = temp_output_1075_0;
			#elif defined(_RENDERTYPEKEY_TRANSPARENT)
				float4 staticSwitch1114 = ( Main_AlbedoTex487 * Main_Color486 * Main_Color_A1057 * Main_AlbedoTex_A616 );
			#else
				float4 staticSwitch1114 = temp_output_1075_0;
			#endif
			o.Albedo = staticSwitch1114.rgb;
			float4 tex2DNode645 = tex2D( _SurfaceTex, Main_UVs587 );
			half MAin_SurfaceTex_R646 = tex2DNode645.r;
			half OUT_METALLIC748 = ( MAin_SurfaceTex_R646 * _Metallic );
			o.Metallic = OUT_METALLIC748;
			half Main_SurfaceTex_A744 = tex2DNode645.a;
			half OUT_SMOOTHNESS660 = ( Main_SurfaceTex_A744 * _Smoothness );
			o.Smoothness = OUT_SMOOTHNESS660;
			float temp_output_1133_0 = 1.0;
			float temp_output_1058_0 = ( Main_Color_A1057 * Main_AlbedoTex_A616 );
			#if defined(_RENDERTYPEKEY_OPAQUE)
				float staticSwitch1112 = temp_output_1133_0;
			#elif defined(_RENDERTYPEKEY_CUT)
				float staticSwitch1112 = temp_output_1133_0;
			#elif defined(_RENDERTYPEKEY_FADE)
				float staticSwitch1112 = temp_output_1058_0;
			#elif defined(_RENDERTYPEKEY_TRANSPARENT)
				float staticSwitch1112 = temp_output_1058_0;
			#else
				float staticSwitch1112 = temp_output_1133_0;
			#endif
			o.Alpha = staticSwitch1112;
			#if defined(_RENDERTYPEKEY_OPAQUE)
				float staticSwitch1113 = temp_output_1133_0;
			#elif defined(_RENDERTYPEKEY_CUT)
				float staticSwitch1113 = Main_AlbedoTex_A616;
			#elif defined(_RENDERTYPEKEY_FADE)
				float staticSwitch1113 = temp_output_1133_0;
			#elif defined(_RENDERTYPEKEY_TRANSPARENT)
				float staticSwitch1113 = temp_output_1133_0;
			#else
				float staticSwitch1113 = temp_output_1133_0;
			#endif
			clip( staticSwitch1113 - _Cutoff );
		}

		ENDCG
		CGPROGRAM
		#pragma exclude_renderers gles 
		#pragma surface surf Standard keepalpha fullforwardshadows nolightmap  nodynlightmap nodirlightmap nometa vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Utils/ADS Fallback"
	CustomEditor "ADSShaderGUI"
}
/*ASEBEGIN
Version=16209
1927;29;1906;1014;52.49939;491.8783;1;True;False
Node;AmplifyShaderEditor.Vector4Node;563;-1280,-672;Half;False;Property;_UVZero;Main UVs;20;0;Create;False;0;0;False;1;Space(10);1,1,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;564;-1024,-672;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;561;-1280,-896;Float;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;565;-1024,-592;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;562;-832,-896;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.VertexColorNode;1154;-1280,-32;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;575;-624,-896;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;1161;-1280,192;Float;False;ADS Global Turbulence;15;;1840;047eb809542f42d40b4b5066e22cee72;0;0;1;FLOAT;85
Node;AmplifyShaderEditor.RegisterLocalVarNode;1138;-1024,-48;Half;False;Packed_Variation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1137;-1280,-128;Float;False;ADS Mask Generic;36;;1804;2cfc3815568565c4585aebb38bd7a29b;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1140;-512,192;Float;False;1138;Packed_Variation;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1162;-1024,192;Half;False;Motion_Turbulence;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1141;-1024,-128;Half;False;Packed_Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1139;-512,112;Float;False;Property;_MotionVariation;Motion Variation;35;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;587;-448,-896;Half;False;Main_UVs;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1142;-512,32;Float;False;Property;_MotionScale;Motion Scale;34;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1163;-512,288;Float;False;1162;Motion_Turbulence;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1144;-512,-128;Float;False;Property;_MotionAmplitude;Motion Amplitude;32;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;644;2688,-896;Float;False;587;Main_UVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1146;-512,384;Float;False;1141;Packed_Mask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1145;-512,-48;Float;False;Property;_MotionSpeed;Motion Speed;33;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1143;-256,112;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1159;128,-128;Float;False;ADS Motion Custom;23;;1831;157ee7880d81d9e4ab5582c2b22b9a68;8,225,0,278,1,228,1,292,2,254,2,262,2,252,0,260,0;9;220;FLOAT;0;False;221;FLOAT;0;False;222;FLOAT;0;False;218;FLOAT;0;False;287;FLOAT;0;False;136;FLOAT;0;False;248;FLOAT3;0,0,0;False;279;FLOAT;0;False;247;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;588;-128,-896;Float;False;587;Main_UVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;645;2944,-896;Float;True;Property;_SurfaceTex;Main Surface;13;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;80,-896;Float;True;Property;_AlbedoTex;Main Albedo;9;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;646;3344,-896;Half;False;MAin_SurfaceTex_R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;744;3344,-768;Half;False;Main_SurfaceTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;604;1536,-896;Float;False;587;Main_UVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;655;1536,-768;Half;False;Property;_NormalScale;Main Normal Scale;11;0;Create;False;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;409;768,-896;Half;False;Property;_Color;Main Color;8;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1148;384,-128;Half;False;Motion_Generic;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;294;3712,-624;Half;False;Property;_Smoothness;Main Smoothness;19;0;Create;False;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;749;3712,-704;Float;False;744;Main_SurfaceTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1164;768,-32;Float;False;1162;Motion_Turbulence;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;384,-896;Half;False;Main_AlbedoTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;1024,-896;Half;False;Main_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;384,-768;Half;False;Main_AlbedoTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1135;1824,-704;Half;False;Property;_NormalInvertOnBackface;Main Normal Backface;10;1;[Toggle];Create;False;2;Opaque;0;Transparent;1;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1150;768,-128;Float;False;1148;Motion_Generic;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;656;3712,-896;Float;False;646;MAin_SurfaceTex_R;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1057;1024,-800;Half;False;Main_Color_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;750;3712,-816;Half;False;Property;_Metallic;Main Metallic;14;0;Create;False;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;607;1808,-896;Float;True;Property;_NormalTex;Main Normal;12;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1059;-1280,-1664;Float;False;1057;Main_Color_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1151;1024,-128;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;657;4032,-896;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1134;2128,-896;Float;False;ADS Normal Backface;-1;;1837;4f53bc25e6d8da34db70401bcf363a2a;0;2;13;FLOAT3;0,0,0;False;30;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;-1280,-2432;Float;False;487;Main_AlbedoTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1116;-1280,-2192;Float;False;616;Main_AlbedoTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;4032,-720;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1076;-1280,-2368;Float;False;486;Main_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1115;-1280,-2272;Float;False;1057;Main_Color_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;791;-1280,-1568;Float;False;616;Main_AlbedoTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1152;1216,-128;Half;False;Motion_Output;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1133;-896,-1792;Float;False;const;-1;;1838;5b64729fb717c5f49a1bc2dab81d5e1c;1,3,1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1117;-1024,-2304;Float;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;660;4224,-720;Half;False;OUT_SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1058;-1024,-1664;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;748;4224,-896;Half;False;OUT_METALLIC;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1075;-1024,-2432;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;2368,-896;Half;False;Main_NormalTex;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;549;-816,-2944;Half;False;Property;_RenderType;Render Type;3;1;[Enum];Create;True;4;Opaque;0;Cutout;1;Fade;2;Transparent;3;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1132;1392,-2944;Half;False;Property;_Internal_DebugVariation;Internal_DebugVariation;63;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1112;-640,-1792;Float;False;Property;_RenderTypeKey;RenderTypeKey;5;0;Create;True;0;0;False;0;0;0;0;False;_ALPHABLEND_ON;KeywordEnum;4;Opaque;Cut;Fade;Transparent;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;654;-1280,-1856;Float;False;660;OUT_SMOOTHNESS;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1114;-640,-2432;Float;False;Property;_RenderTypeKey;RenderTypeKey;5;0;Create;True;0;0;False;0;0;0;0;False;_ALPHABLEND_ON;KeywordEnum;4;Opaque;Cut;Fade;Transparent;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1105;-928,-3616;Half;False;Property;_SETTINGSS;[ SETTINGSS ];21;0;Create;True;0;0;True;1;BCategory(Settings);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;624;-1280,-2016;Float;False;620;Main_NormalTex;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;743;-640,-2944;Half;False;Property;_RenderFaces;Render Faces;4;1;[Enum];Create;True;3;Two Sided;0;Back;1;Front;2;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1104;-1088,-3616;Half;False;Property;_MAINN;[ MAINN ];7;0;Create;True;0;0;True;1;BCategory(Main);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1103;-1280,-3520;Half;False;Property;_RenderTypee;# _RenderTypee;5;0;Create;True;0;0;True;1;BInteractive(_RenderType, 1);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1126;672,-2944;Half;False;Property;_Internal_TypeGeneric;Internal_TypeGeneric;58;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1107;-576,-3616;Half;False;Property;_ADVANCEDD;[ ADVANCEDD ];44;0;Create;True;0;0;True;1;BCategory(Advanced);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;550;-1280,-2944;Half;False;Property;_SrcBlend;_SrcBlend;60;1;[HideInInspector];Create;True;0;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1102;-1280,-3712;Half;False;Property;_ADSStandardLitGeneric;< ADS Standard Lit Generic >;1;0;Create;True;0;0;True;1;BBanner(ADS Standard Lit, Generic);1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1113;-640,-1632;Float;False;Property;_RenderTypeKey;RenderTypeKey;5;0;Create;True;0;0;False;0;0;0;0;False;_ALPHABLEND_ON;KeywordEnum;4;Opaque;Cut;Fade;Transparent;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1136;256,-2944;Half;False;Property;_Internal_Version;Internal_Version;0;1;[HideInInspector];Create;True;0;0;True;0;220;1;220;220;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1131;480,-2944;Half;False;Property;_Internal_ADS;Internal_ADS;46;1;[HideInInspector];Create;True;0;0;True;0;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;925;-960,-2944;Half;False;Property;_ZWrite;_ZWrite;62;1;[HideInInspector];Create;True;2;Off;0;On;1;0;True;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1129;1152,-2944;Half;False;Property;_Internal_DebugMask;Internal_DebugMask;59;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;752;-1280,-1936;Float;False;748;OUT_METALLIC;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1128;912,-2944;Half;False;Property;_Internal_LitStandard;Internal_LitStandard;57;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1127;0,-2944;Float;False;Internal Unity Props;47;;1839;b286e6ef621b64a4fb35da1e13fa143f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1125;-640,-1408;Float;False;1152;Motion_Output;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1101;-1280,-3616;Half;False;Property;_RENDERINGG;[ RENDERINGG ];2;0;Create;True;0;0;True;1;BCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;553;-1120,-2944;Half;False;Property;_DstBlend;_DstBlend;61;1;[HideInInspector];Create;True;0;0;True;0;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1160;-1056,-3520;Half;False;Property;_BatchingInfo;!!! BatchingInfo;45;0;Create;True;0;0;True;1;BMessage(Info, Batching is not currently supported Please use GPU Instancing instead for better performance, 0, 0);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;862;-448,-2944;Half;False;Property;_Cutoff;Cutout;6;0;Create;False;3;Off;0;Front;1;Back;2;0;True;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1106;-752,-3616;Half;False;Property;_MOTIONN;[ MOTIONN ];22;0;Create;True;0;0;True;1;BCategory(Motion);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,-2176;Float;False;True;2;Float;ADSShaderGUI;300;0;Standard;BOXOPHOBIC/Advanced Dynamic Shaders/Standard Lit/Generic;False;False;False;False;False;False;True;True;True;False;True;False;False;True;False;False;False;False;False;False;Off;0;True;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0;True;True;0;True;Opaque;;Geometry;All;True;True;True;False;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;1;5;True;550;10;True;553;0;1;False;550;10;False;553;0;True;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;300;Utils/ADS Fallback;-1;-1;-1;-1;0;False;0;0;True;743;-1;0;True;862;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;1100;-1280,-3840;Float;False;897.0701;100;Drawers;0;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;712;-1280,-1024;Float;False;1039.27;100;Main UVs;0;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1153;-1280,-256;Float;False;2698.834;100;Motion;0;;0.03448272,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1130;0,-3072;Float;False;1638.072;100;Internal Only;0;;1,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;751;3712,-1024;Float;False;713.7266;100;Metallic / Smoothness;0;;1,0.7450981,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;715;2688,-1024;Float;False;890.0676;100;Smoothness Texture;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;760;-128,-1024;Float;False;1361.88;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;683;-1280,-3072;Float;False;1084;100;Rendering;0;;1,0,0.503,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;708;1536,-1024;Float;False;1038.73;100;Normal Texture;0;;0.5019608,0.5019608,1,1;0;0
WireConnection;564;0;563;1
WireConnection;564;1;563;2
WireConnection;565;0;563;3
WireConnection;565;1;563;4
WireConnection;562;0;561;0
WireConnection;562;1;564;0
WireConnection;575;0;562;0
WireConnection;575;1;565;0
WireConnection;1138;0;1154;4
WireConnection;1162;0;1161;85
WireConnection;1141;0;1137;0
WireConnection;587;0;575;0
WireConnection;1143;0;1139;0
WireConnection;1143;1;1140;0
WireConnection;1159;220;1144;0
WireConnection;1159;221;1145;0
WireConnection;1159;222;1142;0
WireConnection;1159;218;1143;0
WireConnection;1159;287;1163;0
WireConnection;1159;136;1146;0
WireConnection;645;1;644;0
WireConnection;18;1;588;0
WireConnection;646;0;645;1
WireConnection;744;0;645;4
WireConnection;1148;0;1159;0
WireConnection;487;0;18;0
WireConnection;486;0;409;0
WireConnection;616;0;18;4
WireConnection;1057;0;409;4
WireConnection;607;1;604;0
WireConnection;607;5;655;0
WireConnection;1151;0;1150;0
WireConnection;1151;1;1164;0
WireConnection;657;0;656;0
WireConnection;657;1;750;0
WireConnection;1134;13;607;0
WireConnection;1134;30;1135;0
WireConnection;745;0;749;0
WireConnection;745;1;294;0
WireConnection;1152;0;1151;0
WireConnection;1117;0;36;0
WireConnection;1117;1;1076;0
WireConnection;1117;2;1115;0
WireConnection;1117;3;1116;0
WireConnection;660;0;745;0
WireConnection;1058;0;1059;0
WireConnection;1058;1;791;0
WireConnection;748;0;657;0
WireConnection;1075;0;36;0
WireConnection;1075;1;1076;0
WireConnection;620;0;1134;0
WireConnection;1112;1;1133;0
WireConnection;1112;0;1133;0
WireConnection;1112;2;1058;0
WireConnection;1112;3;1058;0
WireConnection;1114;1;1075;0
WireConnection;1114;0;1075;0
WireConnection;1114;2;1075;0
WireConnection;1114;3;1117;0
WireConnection;1113;1;1133;0
WireConnection;1113;0;791;0
WireConnection;1113;2;1133;0
WireConnection;1113;3;1133;0
WireConnection;0;0;1114;0
WireConnection;0;1;624;0
WireConnection;0;3;752;0
WireConnection;0;4;654;0
WireConnection;0;9;1112;0
WireConnection;0;10;1113;0
WireConnection;0;11;1125;0
ASEEND*/
//CHKSM=AD26B780A60A8572028EAE889CFE68A161DC7A91