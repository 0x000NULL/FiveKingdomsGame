// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/Advanced Dynamic Shaders/Standard Lit/Cloth"
{
	Properties
	{
		[HideInInspector]_Internal_Version("Internal_Version", Float) = 220
		[BBanner(ADS Standard Lit, Cloth)]_ADSStandardLitCloth("< ADS Standard Lit Cloth >", Float) = 1
		[BCategory(Rendering)]_RENDERINGG("[ RENDERINGG ]", Float) = 0
		[Enum(Opaque,0,Cutout,1,Fade,2,Transparent,3)]_RenderType("Render Type", Float) = 0
		[Enum(Two Sided,0,Back,1,Front,2)]_RenderFaces("Render Faces", Float) = 0
		[BInteractive(_RenderType, 1)]_RenderTypee("# RenderTypee", Float) = 0
		_Cutoff("Cutout", Range( 0 , 1)) = 0.5
		[BCategory(Alpha)]_ALPHAA("[ ALPHAA ]", Float) = 0
		[KeywordEnum(Main,Alpha)] _AlphaFrom("Alpha From", Float) = 0
		[BInteractive(_AlphaFrom, 1)]_AlphaFromm("# AlphaFromm", Float) = 0
		[NoScaleOffset]_AlphaTexture("Alpha Texture", 2D) = "white" {}
		_AlphaUVs("Alpha UVs", Vector) = (1,1,0,0)
		[BCategory(Cloth)]_CLOTHH("[ CLOTHH ]", Float) = 0
		_Color("Cloth Color", Color) = (1,1,1,1)
		[NoScaleOffset]_AlbedoTex("Cloth Albedo", 2D) = "white" {}
		[Toggle]_NormalInvertOnBackface("Cloth Normal Backface", Float) = 1
		_NormalScale("Cloth Normal Scale", Float) = 1
		[NoScaleOffset]_NormalTex("Cloth Normal", 2D) = "bump" {}
		_Smoothness("Cloth Smoothness", Range( 0 , 1)) = 0.5
		[NoScaleOffset]_SurfaceTex("Cloth Surface", 2D) = "white" {}
		[Space(10)]_UVZero("Cloth UVs", Vector) = (1,1,0,0)
		[BCategory(Symbol)]_SYMBOLL("[ SYMBOLL ]", Float) = 0
		[Enum(Multiplied,0,Sticker,1)]_SymbolMode("Symbol Mode", Float) = 0
		_SymbolColor("Symbol Color", Color) = (1,1,1,1)
		[NoScaleOffset]_SymbolTexture("Symbol Texture", 2D) = "gray" {}
		_SymbolRotation("Symbol Rotation", Range( 0 , 360)) = 0
		_SymbolUVs("Symbol UVs", Vector) = (1,1,1,0)
		[BCategory(Settings)]_SETTINGS("[ SETTINGS ]", Float) = 0
		[HideInInspector]_MotionNoise("Motion Noise", Float) = 1
		_GlobalTurbulence("Global Turbulence", Range( 0 , 1)) = 1
		[BCategory(Cloth Motion)]_CLOTHMOTIONN("[ CLOTH MOTIONN ]", Float) = 0
		_MotionAmplitude("Cloth Motion Amplitude", Float) = 0
		_MotionSpeed("Cloth Motion Speed", Float) = 0
		_MotionScale("Cloth Motion Scale", Float) = 0
		_MotionVariation("Cloth Motion Variation", Float) = 0
		[Enum(ADS Packed,0,ADS QuickMask,1)][Space(10)]_MaskType("Mask Type", Float) = 0
		[BInteractive(_MaskType, 1)]_MaskTypee("# MaskTypee", Float) = 0
		[Enum(X Axis,0,Y Axis,1,Z Axis,2)]_MaskAxis("Mask Axis", Float) = 1
		[BInteractive(ON)]_MaskTypeeEnd("# MaskTypee End", Float) = 0
		[BMessage(Warning, The ADS Quick Mask option is slow when using high poly meshes and it will be deprecated soon, _MaskType, 1, 10, 0)]_QuickMaskk("!!! QuickMaskk !!!", Float) = 0
		[Space(10)]_MaskMin("Mask Min", Float) = 0
		_MaskMax("Mask Max", Float) = 1
		[BInteractive(_MotionSpace, 0)]_MotionSpaceee("# MotionSpaceee", Float) = 0
		[BInteractive(ON)]_MotionSpaceeeEnd("# MotionSpaceee End", Float) = 0
		[BInteractive(_MotionSpace, 1)]_MotionSpacee("# MotionSpacee", Float) = 0
		[BInteractive(ON)]_MotionSpaceeEnd("# MotionSpacee End", Float) = 0
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
		[HideInInspector]_Internal_DebugVariation("Internal_DebugVariation", Float) = 1
		[HideInInspector]_Internal_LitStandard("Internal_LitStandard", Float) = 1
		[HideInInspector]_Internal_TypeCloth("Internal_TypeCloth", Float) = 1
		[HideInInspector]_Internal_DebugMask("Internal_DebugMask", Float) = 1
		[HideInInspector]_SrcBlend("_SrcBlend", Float) = 1
		[HideInInspector]_DstBlend("_DstBlend", Float) = 10
		[HideInInspector]_ZWrite("_ZWrite", Float) = 1
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
		#pragma multi_compile_instancing
		#pragma shader_feature _RENDERTYPEKEY_OPAQUE _RENDERTYPEKEY_CUT _RENDERTYPEKEY_FADE _RENDERTYPEKEY_TRANSPARENT
		#pragma shader_feature _ALPHAFROM_MAIN _ALPHAFROM_ALPHA
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
		uniform half _SrcBlend;
		uniform half _Internal_LitStandard;
		uniform half _Cutoff;
		uniform half _AlphaFromm;
		uniform half _ADSStandardLitCloth;
		uniform half _Internal_Version;
		uniform half _BatchingInfo;
		uniform half _DstBlend;
		uniform half _RENDERINGG;
		uniform half _Internal_DebugVariation;
		uniform half _ALPHAA;
		uniform half _Internal_DebugMask;
		uniform half _ADVANCEDD;
		uniform half _SYMBOLL;
		uniform half _RenderTypee;
		uniform half _RenderType;
		uniform half _Internal_TypeCloth;
		uniform half _CLOTHH;
		uniform half _SETTINGS;
		uniform half _ZWrite;
		uniform half _CLOTHMOTIONN;
		uniform half _Internal_ADS;
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
		uniform half _MaskAxis;
		uniform half _MaskMin;
		uniform half _MaskMax;
		uniform half _MaskType;
		uniform half _NormalScale;
		uniform sampler2D _NormalTex;
		uniform half4 _UVZero;
		uniform half _NormalInvertOnBackface;
		uniform half4 _Color;
		uniform sampler2D _AlbedoTex;
		uniform half4 _SymbolColor;
		uniform sampler2D _SymbolTexture;
		uniform half4 _SymbolUVs;
		uniform half _SymbolRotation;
		uniform half _SymbolMode;
		uniform sampler2D _AlphaTexture;
		uniform half4 _AlphaUVs;
		uniform sampler2D _SurfaceTex;
		uniform half _Smoothness;


		inline half2 RotateUV453( half2 UV , half Angle )
		{
			return mul( UV - half2( 0.5,0.5 ) , half2x2( cos(Angle) , sin(Angle), -sin(Angle) , cos(Angle) )) + half2( 0.5,0.5 );;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			half MotionScale60_g1822 = ( ADS_GlobalScale * _MotionScale );
			half MotionSpeed62_g1822 = ( ADS_GlobalSpeed * _MotionSpeed );
			float mulTime90_g1822 = _Time.y * MotionSpeed62_g1822;
			float3 temp_output_95_0_g1822 = ( ( ase_worldPos * MotionScale60_g1822 ) + mulTime90_g1822 );
			half Packed_Variation1228 = v.color.a;
			half MotionVariation269_g1822 = ( _MotionVariation * Packed_Variation1228 );
			half MotionlAmplitude58_g1822 = ( ADS_GlobalAmplitude * _MotionAmplitude );
			float3 temp_output_92_0_g1822 = ( sin( ( temp_output_95_0_g1822 + MotionVariation269_g1822 ) ) * MotionlAmplitude58_g1822 );
			float3 temp_output_160_0_g1822 = ( temp_output_92_0_g1822 + MotionlAmplitude58_g1822 + MotionlAmplitude58_g1822 );
			half localunity_ObjectToWorld0w1_g1833 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g1833 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g1833 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g1833 = (float3(localunity_ObjectToWorld0w1_g1833 , localunity_ObjectToWorld1w2_g1833 , localunity_ObjectToWorld2w3_g1833));
			float2 panner73_g1831 = ( _Time.y * ( ADS_TurbulenceSpeed * (-ADS_GlobalDirection).xz ) + ( (appendResult6_g1833).xz * ADS_TurbulenceScale ));
			float lerpResult136_g1831 = lerp( 1.0 , saturate( pow( abs( tex2Dlod( ADS_TurbulenceTex, float4( panner73_g1831, 0, 0.0) ).r ) , ADS_TurbulenceContrast ) ) , _GlobalTurbulence);
			float ifLocalVar94_g1831 = 0;
			UNITY_BRANCH 
			if( ( ADS_TurbulenceTex_ON * _GlobalTurbulence ) > 0.0001 )
				ifLocalVar94_g1831 = lerpResult136_g1831;
			else if( ( ADS_TurbulenceTex_ON * _GlobalTurbulence ) < 0.0001 )
				ifLocalVar94_g1831 = 1.0;
			half Motion_Turbulence1283 = ifLocalVar94_g1831;
			float3 lerpResult293_g1822 = lerp( temp_output_92_0_g1822 , temp_output_160_0_g1822 , Motion_Turbulence1283);
			float3 temp_output_256_0_g1822 = mul( unity_WorldToObject, float4( ADS_GlobalDirection , 0.0 ) ).xyz;
			half3 MotionDirection59_g1822 = temp_output_256_0_g1822;
			float temp_output_25_0_g1806 = _MaskAxis;
			float lerpResult24_g1806 = lerp( v.texcoord3.x , v.texcoord3.y , saturate( temp_output_25_0_g1806 ));
			float lerpResult21_g1806 = lerp( lerpResult24_g1806 , v.texcoord3.z , step( 2.0 , temp_output_25_0_g1806 ));
			half THREE27_g1806 = lerpResult21_g1806;
			float temp_output_7_0_g1805 = _MaskMin;
			float lerpResult42_g1804 = lerp( v.color.r , saturate( ( ( THREE27_g1806 - temp_output_7_0_g1805 ) / ( _MaskMax - temp_output_7_0_g1805 ) ) ) , _MaskType);
			half Packed_Cloth1234 = lerpResult42_g1804;
			half MotionMask137_g1822 = Packed_Cloth1234;
			float3 temp_output_94_0_g1822 = ( ( lerpResult293_g1822 * MotionDirection59_g1822 ) * MotionMask137_g1822 );
			half3 Motion_Cloth1250 = temp_output_94_0_g1822;
			half3 Motion_Output1256 = ( Motion_Cloth1250 * Motion_Turbulence1283 );
			v.vertex.xyz += Motion_Output1256;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 appendResult564 = (float2(_UVZero.x , _UVZero.y));
			float2 appendResult565 = (float2(_UVZero.z , _UVZero.w));
			half2 Main_UVs587 = ( ( i.uv_texcoord * appendResult564 ) + appendResult565 );
			float3 temp_output_13_0_g1828 = UnpackScaleNormal( tex2D( _NormalTex, Main_UVs587 ), _NormalScale );
			float3 break17_g1828 = temp_output_13_0_g1828;
			float switchResult12_g1828 = (((i.ASEVFace>0)?(break17_g1828.z):(-break17_g1828.z)));
			float3 appendResult18_g1828 = (float3(break17_g1828.x , break17_g1828.y , switchResult12_g1828));
			float3 lerpResult20_g1828 = lerp( temp_output_13_0_g1828 , appendResult18_g1828 , _NormalInvertOnBackface);
			half3 Main_NormalTex620 = lerpResult20_g1828;
			o.Normal = Main_NormalTex620;
			half4 Main_Color486 = _Color;
			float4 tex2DNode18 = tex2D( _AlbedoTex, Main_UVs587 );
			half4 Main_AlbedoTex487 = tex2DNode18;
			float4 temp_output_518_0 = ( Main_Color486 * Main_AlbedoTex487 );
			half4 SymbolColor492 = _SymbolColor;
			float2 temp_cast_0 = (0.5).xx;
			float2 appendResult870 = (float2(_SymbolUVs.x , _SymbolUVs.y));
			float2 appendResult579 = (float2(_SymbolUVs.z , _SymbolUVs.w));
			half2 UV453 = ( ( ( ( i.uv_texcoord - temp_cast_0 ) * appendResult870 ) + 0.5 ) + appendResult579 );
			half Angle453 = radians( _SymbolRotation );
			half2 localRotateUV453 = RotateUV453( UV453 , Angle453 );
			half2 SymbolUVs488 = localRotateUV453;
			float4 tex2DNode401 = tex2D( _SymbolTexture, SymbolUVs488 );
			half4 SymbolTex490 = tex2DNode401;
			half SymbolTexAlpha963 = tex2DNode401.a;
			float4 lerpResult967 = lerp( temp_output_518_0 , ( SymbolColor492 * SymbolTex490 * saturate( ( Main_AlbedoTex487 + _SymbolMode ) ) ) , SymbolTexAlpha963);
			float4 switchResult478 = (((i.ASEVFace>0)?(lerpResult967):(temp_output_518_0)));
			#if defined(_RENDERTYPEKEY_OPAQUE)
				float4 staticSwitch1175 = switchResult478;
			#elif defined(_RENDERTYPEKEY_CUT)
				float4 staticSwitch1175 = switchResult478;
			#elif defined(_RENDERTYPEKEY_FADE)
				float4 staticSwitch1175 = lerpResult967;
			#elif defined(_RENDERTYPEKEY_TRANSPARENT)
				float4 staticSwitch1175 = lerpResult967;
			#else
				float4 staticSwitch1175 = switchResult478;
			#endif
			float4 OUT_ALBEDO416 = staticSwitch1175;
			half Main_AlbedoTex_A616 = tex2DNode18.a;
			float2 appendResult598 = (float2(_AlphaUVs.x , _AlphaUVs.y));
			float2 appendResult601 = (float2(_AlphaUVs.z , _AlphaUVs.w));
			half2 AlphaUVs603 = ( ( i.uv_texcoord * appendResult598 ) + appendResult601 );
			half AlphaTextureRed595 = tex2D( _AlphaTexture, AlphaUVs603 ).r;
			#if defined(_ALPHAFROM_MAIN)
				float staticSwitch615 = Main_AlbedoTex_A616;
			#elif defined(_ALPHAFROM_ALPHA)
				float staticSwitch615 = AlphaTextureRed595;
			#else
				float staticSwitch615 = Main_AlbedoTex_A616;
			#endif
			half OUT_OPACITY407 = staticSwitch615;
			half Main_Color_A1057 = _Color.a;
			#if defined(_RENDERTYPEKEY_OPAQUE)
				float4 staticSwitch1174 = OUT_ALBEDO416;
			#elif defined(_RENDERTYPEKEY_CUT)
				float4 staticSwitch1174 = OUT_ALBEDO416;
			#elif defined(_RENDERTYPEKEY_FADE)
				float4 staticSwitch1174 = OUT_ALBEDO416;
			#elif defined(_RENDERTYPEKEY_TRANSPARENT)
				float4 staticSwitch1174 = ( OUT_ALBEDO416 * OUT_OPACITY407 * Main_Color_A1057 );
			#else
				float4 staticSwitch1174 = OUT_ALBEDO416;
			#endif
			o.Albedo = staticSwitch1174.rgb;
			float4 tex2DNode645 = tex2D( _SurfaceTex, Main_UVs587 );
			half Main_SurfaceTex_A744 = tex2DNode645.a;
			half OUT_SMOOTHNESS660 = ( Main_SurfaceTex_A744 * _Smoothness );
			o.Smoothness = OUT_SMOOTHNESS660;
			float temp_output_1203_0 = 1.0;
			float temp_output_1058_0 = ( Main_Color_A1057 * OUT_OPACITY407 );
			#if defined(_RENDERTYPEKEY_OPAQUE)
				float staticSwitch1177 = temp_output_1203_0;
			#elif defined(_RENDERTYPEKEY_CUT)
				float staticSwitch1177 = temp_output_1203_0;
			#elif defined(_RENDERTYPEKEY_FADE)
				float staticSwitch1177 = temp_output_1058_0;
			#elif defined(_RENDERTYPEKEY_TRANSPARENT)
				float staticSwitch1177 = temp_output_1058_0;
			#else
				float staticSwitch1177 = temp_output_1203_0;
			#endif
			o.Alpha = staticSwitch1177;
			#if defined(_RENDERTYPEKEY_OPAQUE)
				float staticSwitch1172 = temp_output_1203_0;
			#elif defined(_RENDERTYPEKEY_CUT)
				float staticSwitch1172 = OUT_OPACITY407;
			#elif defined(_RENDERTYPEKEY_FADE)
				float staticSwitch1172 = temp_output_1203_0;
			#elif defined(_RENDERTYPEKEY_TRANSPARENT)
				float staticSwitch1172 = temp_output_1203_0;
			#else
				float staticSwitch1172 = temp_output_1203_0;
			#endif
			clip( staticSwitch1172 - _Cutoff );
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
1927;29;1906;1014;28.41467;-984.7617;1;True;False
Node;AmplifyShaderEditor.Vector4Node;586;-1280,864;Half;False;Property;_SymbolUVs;Symbol UVs;26;0;Create;True;0;0;False;0;1,1,1,0;-1,-1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1201;-1280,768;Float;False;const;-1;;1474;5b64729fb717c5f49a1bc2dab81d5e1c;1,3,3;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;578;-1280,640;Float;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;563;-1280,96;Half;False;Property;_UVZero;Cloth UVs;20;0;Create;False;0;0;False;1;Space(10);1,1,0,0;2,2,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;561;-1280,-128;Float;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;564;-1024,96;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;870;-1024,864;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;580;-1024,640;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;1202;-832,768;Float;False;const;-1;;1475;5b64729fb717c5f49a1bc2dab81d5e1c;1,3,3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;562;-832,-128;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;565;-1024,176;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;581;-832,640;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;873;-832,960;Half;False;Property;_SymbolRotation;Symbol Rotation;25;0;Create;True;0;0;False;0;0;0;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;583;-640,640;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;575;-624,-128;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;579;-1024,944;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;872;-448,640;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;587;-448,-128;Half;False;Main_UVs;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RadiansOpNode;457;-512,960;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;588;-128,-128;Float;False;587;Main_UVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CustomExpressionNode;453;-336,944;Half;False;mul( UV - half2( 0.5,0.5 ) , half2x2( cos(Angle) , sin(Angle), -sin(Angle) , cos(Angle) )) + half2( 0.5,0.5 )@;2;False;2;True;UV;FLOAT2;0,0;In;;Float;True;Angle;FLOAT;0;In;;Float;Rotate UV;True;False;0;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;597;-1280,-672;Half;False;Property;_AlphaUVs;Alpha UVs;11;0;Create;True;0;0;False;0;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;80,-128;Float;True;Property;_AlbedoTex;Cloth Albedo;14;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;598;-1024,-672;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;599;-1280,-896;Float;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;488;-192,640;Half;False;SymbolUVs;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;601;-1024,-592;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;600;-896,-896;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;384,-128;Half;False;Main_AlbedoTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;520;128,640;Float;False;488;SymbolUVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;411;1024,640;Half;False;Property;_SymbolColor;Symbol Color;23;0;Create;True;0;0;False;0;1,1,1,1;1,0.8068966,0,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;401;320,640;Float;True;Property;_SymbolTexture;Symbol Texture;24;1;[NoScaleOffset];Create;True;0;0;False;0;None;2ca55ae3bc3f3174b8cc78a75891f90b;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;602;-704,-896;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;970;1664,848;Half;False;Property;_SymbolMode;Symbol Mode;22;1;[Enum];Create;True;2;Multiplied;0;Sticker;1;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;515;1664,768;Float;False;487;Main_AlbedoTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;409;768,-128;Half;False;Property;_Color;Cloth Color;13;0;Create;False;0;0;False;0;1,1,1,1;0,0,0,0.503;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;490;640,640;Half;False;SymbolTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;975;1888,800;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;1280;-1280,1488;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;603;-448,-896;Half;False;AlphaUVs;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;492;1280,640;Half;False;SymbolColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;1024,-128;Half;False;Main_Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;964;1664,704;Float;False;490;SymbolTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;516;1664,1024;Float;False;487;Main_AlbedoTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1260;-1280,1408;Float;False;ADS Mask Generic;37;;1804;2cfc3815568565c4585aebb38bd7a29b;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1228;-1024,1488;Half;False;Packed_Variation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;593;-128,-896;Float;False;603;AlphaUVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;517;1664,960;Float;False;486;Main_Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;965;1664,640;Float;False;492;SymbolColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;976;2016,800;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;963;640,768;Half;False;SymbolTexAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1282;-1280,1664;Float;False;ADS Global Turbulence;28;;1831;047eb809542f42d40b4b5066e22cee72;0;0;1;FLOAT;85
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;966;2176,640;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1234;-1024,1408;Half;False;Packed_Cloth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1229;-512,1648;Float;False;Property;_MotionVariation;Cloth Motion Variation;36;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1231;-512,1728;Float;False;1228;Packed_Variation;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;594;80,-896;Float;True;Property;_AlphaTexture;Alpha Texture;10;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;968;2176,960;Float;False;963;SymbolTexAlpha;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;518;1920,960;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1283;-1024,1664;Half;False;Motion_Turbulence;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;595;432,-896;Half;False;AlphaTextureRed;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;644;2560,-128;Float;False;587;Main_UVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;967;2400,640;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1237;-512,1408;Float;False;Property;_MotionAmplitude;Cloth Motion Amplitude;33;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1246;-512,1568;Float;False;Property;_MotionScale;Cloth Motion Scale;35;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1243;-256,1648;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;384,0;Half;False;Main_AlbedoTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1239;-512,1920;Float;False;1234;Packed_Cloth;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1240;-512,1488;Float;False;Property;_MotionSpeed;Cloth Motion Speed;34;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1284;-512,1825;Float;False;1283;Motion_Turbulence;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;618;768,-896;Float;False;616;Main_AlbedoTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;619;768,-768;Float;False;595;AlphaTextureRed;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;645;2816,-128;Float;True;Property;_SurfaceTex;Cloth Surface;19;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1279;128,1408;Float;False;ADS Motion Custom;45;;1822;157ee7880d81d9e4ab5582c2b22b9a68;8,225,0,278,1,228,1,292,2,254,0,262,0,252,0,260,0;9;220;FLOAT;0;False;221;FLOAT;0;False;222;FLOAT;0;False;218;FLOAT;0;False;287;FLOAT;0;False;136;FLOAT;0;False;248;FLOAT3;0,0,0;False;279;FLOAT;0;False;247;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwitchByFaceNode;478;2608,864;Float;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;655;1408,0;Half;False;Property;_NormalScale;Cloth Normal Scale;16;0;Create;False;0;0;False;0;1;1.76;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;744;3216,0;Half;False;Main_SurfaceTex_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;615;1088,-896;Float;False;Property;_AlphaFrom;Alpha From;8;0;Create;True;0;0;False;0;0;0;0;True;;KeywordEnum;2;Main;Alpha;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;604;1408,-128;Float;False;587;Main_UVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;1175;2880,640;Float;False;Property;_RenderTypeKey;RenderTypeKey;5;0;Create;True;0;0;False;0;0;0;0;False;_ALPHABLEND_ON;KeywordEnum;4;Opaque;Cut;Fade;Transparent;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1250;384,1408;Half;False;Motion_Cloth;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1251;768,1408;Float;False;1250;Motion_Cloth;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1205;1712,64;Half;False;Property;_NormalInvertOnBackface;Cloth Normal Backface;15;1;[Toggle];Create;False;2;Opaque;0;Transparent;1;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1285;768,1504;Float;False;1283;Motion_Turbulence;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;607;1680,-128;Float;True;Property;_NormalTex;Cloth Normal;17;1;[NoScaleOffset];Create;False;0;0;False;0;None;56bc6b56dc794b94986afe37a535caff;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;294;3584,-48;Half;False;Property;_Smoothness;Cloth Smoothness;18;0;Create;False;0;0;False;0;0.5;0.8;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;407;1472,-896;Half;False;OUT_OPACITY;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;749;3584,-128;Float;False;744;Main_SurfaceTex_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1057;1024,-32;Half;False;Main_Color_A;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;416;3200,640;Float;False;OUT_ALBEDO;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1204;2000,-128;Float;False;ADS Normal Backface;-1;;1828;4f53bc25e6d8da34db70401bcf363a2a;0;2;13;FLOAT3;0,0,0;False;30;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1059;-1280,-1744;Float;False;1057;Main_Color_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;-1280,-2304;Float;False;416;OUT_ALBEDO;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1255;1024,1408;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;3904,-128;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;791;-1280,-1664;Float;False;407;OUT_OPACITY;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1179;-1280,-2160;Float;False;1057;Main_Color_A;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1180;-1280,-2240;Float;False;407;OUT_OPACITY;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1203;-768,-1792;Float;False;const;-1;;1829;5b64729fb717c5f49a1bc2dab81d5e1c;1,3,1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1178;-1024,-2208;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1256;1216,1408;Half;False;Motion_Output;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1058;-1024,-1728;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;2240,-128;Half;False;Main_NormalTex;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;660;4096,-128;Half;False;OUT_SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;550;-1280,-2816;Half;False;Property;_SrcBlend;_SrcBlend;71;1;[HideInInspector];Create;True;0;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1188;912,-2816;Half;False;Property;_Internal_LitStandard;Internal_LitStandard;68;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1200;1392,-2816;Half;False;Property;_Internal_DebugVariation;Internal_DebugVariation;67;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1147;-1088,-3392;Half;False;Property;_AlphaFromm;# AlphaFromm;9;0;Create;True;0;0;True;1;BInteractive(_AlphaFrom, 1);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1206;256,-2816;Half;False;Property;_Internal_Version;Internal_Version;0;1;[HideInInspector];Create;True;0;0;True;0;220;1;220;220;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;624;-1280,-2048;Float;False;620;Main_NormalTex;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;862;-448,-2816;Half;False;Property;_Cutoff;Cutout;6;0;Create;False;3;Off;0;Front;1;Back;2;0;True;0;0.5;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1144;-1280,-3488;Half;False;Property;_RENDERINGG;[ RENDERINGG ];2;0;Create;True;0;0;True;1;BCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1185;-512,-1472;Float;False;1256;Motion_Output;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;553;-1120,-2816;Half;False;Property;_DstBlend;_DstBlend;72;1;[HideInInspector];Create;True;0;0;True;0;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1177;-512,-1792;Float;False;Property;_RenderTypeKey;RenderTypeKey;5;0;Create;True;0;0;False;0;0;0;0;False;_ALPHABLEND_ON;KeywordEnum;4;Opaque;Cut;Fade;Transparent;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1281;-880,-3392;Half;False;Property;_BatchingInfo;!!! BatchingInfo;55;0;Create;True;0;0;True;1;BMessage(Info, Batching is not currently supported Please use GPU Instancing instead for better performance, 0, 0);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1146;-1088,-3488;Half;False;Property;_ALPHAA;[ ALPHAA ];7;0;Create;True;0;0;True;1;BCategory(Alpha);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1149;-192,-3488;Half;False;Property;_ADVANCEDD;[ ADVANCEDD ];54;0;Create;True;0;0;True;1;BCategory(Advanced);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1191;1152,-2816;Half;False;Property;_Internal_DebugMask;Internal_DebugMask;70;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;654;-1280,-1888;Float;False;660;OUT_SMOOTHNESS;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;549;-816,-2816;Half;False;Property;_RenderType;Render Type;3;1;[Enum];Create;True;4;Opaque;0;Cutout;1;Fade;2;Transparent;3;0;True;0;0;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1143;-1280,-3392;Half;False;Property;_RenderTypee;# RenderTypee;5;0;Create;True;0;0;True;1;BInteractive(_RenderType, 1);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1199;480,-2816;Half;False;Property;_Internal_ADS;Internal_ADS;56;1;[HideInInspector];Create;True;0;0;True;0;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1151;-592,-3488;Half;False;Property;_SETTINGS;[ SETTINGS ];27;0;Create;True;0;0;True;1;BCategory(Settings);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1145;-928,-3488;Half;False;Property;_CLOTHH;[ CLOTHH ];12;0;Create;True;0;0;True;1;BCategory(Cloth);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1186;672,-2816;Half;False;Property;_Internal_TypeCloth;Internal_TypeCloth;69;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1174;-512,-2304;Float;False;Property;_RenderTypeKey;RenderTypeKey;5;0;Create;True;0;0;False;0;0;0;0;False;_ALPHABLEND_ON;KeywordEnum;4;Opaque;Cut;Fade;Transparent;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;489;640,704;Half;False;SymbolTexRed;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1148;-768,-3488;Half;False;Property;_SYMBOLL;[ SYMBOLL ];21;0;Create;True;0;0;True;1;BCategory(Symbol);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1150;-416,-3488;Half;False;Property;_CLOTHMOTIONN;[ CLOTH MOTIONN ];32;0;Create;True;0;0;True;1;BCategory(Cloth Motion);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1152;-1280,-3584;Half;False;Property;_ADSStandardLitCloth;< ADS Standard Lit Cloth >;1;0;Create;True;0;0;True;1;BBanner(ADS Standard Lit, Cloth);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;646;3216,-128;Half;False;Main_SurfaceTex_R;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;743;-640,-2816;Half;False;Property;_RenderFaces;Render Faces;4;1;[Enum];Create;True;3;Two Sided;0;Back;1;Front;2;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1187;0,-2816;Float;False;Internal Unity Props;57;;1830;b286e6ef621b64a4fb35da1e13fa143f;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1172;-512,-1648;Float;False;Property;_RenderTypeKey;RenderTypeKey;5;0;Create;True;0;0;False;0;0;0;0;False;_ALPHABLEND_ON;KeywordEnum;4;Opaque;Cut;Fade;Transparent;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;925;-960,-2816;Half;False;Property;_ZWrite;_ZWrite;73;1;[HideInInspector];Create;True;2;Off;0;On;1;0;True;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,-2048;Float;False;True;2;Float;ADSShaderGUI;300;0;Standard;BOXOPHOBIC/Advanced Dynamic Shaders/Standard Lit/Cloth;False;False;False;False;False;False;True;True;True;False;True;False;False;True;False;False;True;False;False;False;Off;0;True;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.1;True;True;0;True;Opaque;;Geometry;All;True;True;True;False;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;1;5;True;550;10;True;553;0;1;False;550;10;False;553;0;True;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;300;Utils/ADS Fallback;-1;-1;-1;-1;0;False;0;0;True;743;-1;0;True;862;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;1192;0,-2944;Float;False;1632.072;100;Internal Only;0;;1,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;715;2560,-256;Float;False;871;100;Smoothness Texture;0;;1,0.7686275,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;710;-1280,-1024;Float;False;1037.449;100;Alpha UVs;0;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1257;-1280,1280;Float;False;2698.834;100;Motion;0;;0.03448272,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;751;3584,-256;Float;False;737;100;Metallic / Smoothness;0;;1,0.7450981,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;962;-1280,512;Float;False;1302.111;100;Symbol UVs;0;;1,0,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;683;-1280,-2944;Float;False;1083.2;100;Rendering;0;;1,0,0.503,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;712;-1280,-256;Float;False;1024.327;100;Main UVs;0;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;711;-128,-1024;Float;False;768.2292;100;Alpha Texture;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;675;128,512;Float;False;1347.373;100;Symbol Texture and Color;0;;1,0,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;728;1664,512;Float;False;1725.412;100;Symbol Layer combined with Main Layer;0;;1,0,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1142;-1280,-3712;Float;False;1275.27;100;Drawers;0;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;723;768,-1024;Float;False;894.8472;100;Alpha Mode;0;;0.5,0.5,0.5,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;760;-128,-256;Float;False;1353.028;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;708;1408,-256;Float;False;1035;100;Normal Texture;0;;0.5019608,0.5019608,1,1;0;0
WireConnection;564;0;563;1
WireConnection;564;1;563;2
WireConnection;870;0;586;1
WireConnection;870;1;586;2
WireConnection;580;0;578;0
WireConnection;580;1;1201;0
WireConnection;562;0;561;0
WireConnection;562;1;564;0
WireConnection;565;0;563;3
WireConnection;565;1;563;4
WireConnection;581;0;580;0
WireConnection;581;1;870;0
WireConnection;583;0;581;0
WireConnection;583;1;1202;0
WireConnection;575;0;562;0
WireConnection;575;1;565;0
WireConnection;579;0;586;3
WireConnection;579;1;586;4
WireConnection;872;0;583;0
WireConnection;872;1;579;0
WireConnection;587;0;575;0
WireConnection;457;0;873;0
WireConnection;453;0;872;0
WireConnection;453;1;457;0
WireConnection;18;1;588;0
WireConnection;598;0;597;1
WireConnection;598;1;597;2
WireConnection;488;0;453;0
WireConnection;601;0;597;3
WireConnection;601;1;597;4
WireConnection;600;0;599;0
WireConnection;600;1;598;0
WireConnection;487;0;18;0
WireConnection;401;1;520;0
WireConnection;602;0;600;0
WireConnection;602;1;601;0
WireConnection;490;0;401;0
WireConnection;975;0;515;0
WireConnection;975;1;970;0
WireConnection;603;0;602;0
WireConnection;492;0;411;0
WireConnection;486;0;409;0
WireConnection;1228;0;1280;4
WireConnection;976;0;975;0
WireConnection;963;0;401;4
WireConnection;966;0;965;0
WireConnection;966;1;964;0
WireConnection;966;2;976;0
WireConnection;1234;0;1260;0
WireConnection;594;1;593;0
WireConnection;518;0;517;0
WireConnection;518;1;516;0
WireConnection;1283;0;1282;85
WireConnection;595;0;594;1
WireConnection;967;0;518;0
WireConnection;967;1;966;0
WireConnection;967;2;968;0
WireConnection;1243;0;1229;0
WireConnection;1243;1;1231;0
WireConnection;616;0;18;4
WireConnection;645;1;644;0
WireConnection;1279;220;1237;0
WireConnection;1279;221;1240;0
WireConnection;1279;222;1246;0
WireConnection;1279;218;1243;0
WireConnection;1279;287;1284;0
WireConnection;1279;136;1239;0
WireConnection;478;0;967;0
WireConnection;478;1;518;0
WireConnection;744;0;645;4
WireConnection;615;1;618;0
WireConnection;615;0;619;0
WireConnection;1175;1;478;0
WireConnection;1175;0;478;0
WireConnection;1175;2;967;0
WireConnection;1175;3;967;0
WireConnection;1250;0;1279;0
WireConnection;607;1;604;0
WireConnection;607;5;655;0
WireConnection;407;0;615;0
WireConnection;1057;0;409;4
WireConnection;416;0;1175;0
WireConnection;1204;13;607;0
WireConnection;1204;30;1205;0
WireConnection;1255;0;1251;0
WireConnection;1255;1;1285;0
WireConnection;745;0;749;0
WireConnection;745;1;294;0
WireConnection;1178;0;36;0
WireConnection;1178;1;1180;0
WireConnection;1178;2;1179;0
WireConnection;1256;0;1255;0
WireConnection;1058;0;1059;0
WireConnection;1058;1;791;0
WireConnection;620;0;1204;0
WireConnection;660;0;745;0
WireConnection;1177;1;1203;0
WireConnection;1177;0;1203;0
WireConnection;1177;2;1058;0
WireConnection;1177;3;1058;0
WireConnection;1174;1;36;0
WireConnection;1174;0;36;0
WireConnection;1174;2;36;0
WireConnection;1174;3;1178;0
WireConnection;489;0;401;1
WireConnection;646;0;645;1
WireConnection;1172;1;1203;0
WireConnection;1172;0;791;0
WireConnection;1172;2;1203;0
WireConnection;1172;3;1203;0
WireConnection;0;0;1174;0
WireConnection;0;1;624;0
WireConnection;0;4;654;0
WireConnection;0;9;1177;0
WireConnection;0;10;1172;0
WireConnection;0;11;1185;0
ASEEND*/
//CHKSM=715D664A5AAAE9F923AFA9335F810009C5B99F30