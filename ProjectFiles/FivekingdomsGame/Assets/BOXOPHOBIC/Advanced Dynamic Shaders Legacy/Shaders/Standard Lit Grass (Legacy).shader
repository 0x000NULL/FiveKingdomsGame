// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/Advanced Dynamic Shaders/Standard Lit/Grass (Legacy)"
{
	Properties
	{
		[HideInInspector]_Internal_ADS("_Internal_ADS", Float) = 1
		[BBanner(ADS Standard Lit, Grass)]_ADSStandardLitGrass("< ADS Standard Lit Grass >", Float) = 1
		[BMessage(Error, The ADS Grass shaders will be deprecated soon Please switch to ADS Foliage shaders instead, 0, 0)]_Internal_Deprecated("!!! Internal_Deprecated !!!", Float) = 1
		[BCategory(Rendering)]_RENDERINGG("[ RENDERINGG ]", Float) = 0
		[Enum(Off,0,Front,1,Back,2)]_CullMode("Cull Mode", Float) = 0
		[BInteractive(_Mode, 1)]_Modee("# _Modee", Float) = 0
		_Cutoff("Cutout", Range( 0 , 1)) = 0.5
		[BCategory(Main)]_MAINN("[ MAINN ]", Float) = 0
		_Color("Main Color", Color) = (1,1,1,1)
		[HideInInspector]_Internal_UnityToBoxophobic("_Internal_UnityToBoxophobic", Float) = 0
		[NoScaleOffset]_MainTex("Main Texture", 2D) = "white" {}
		[HideInInspector][NoScaleOffset]_AlbedoTex("AlbedoTex", 2D) = "white" {}
		[Toggle]_NormalInvertOnBackface("Normal Backface", Float) = 1
		[HideInInspector]_NormalScale("NormalScale", Float) = 1
		_BumpScale("Normal Scale", Float) = 1
		[HideInInspector][NoScaleOffset]_NormalTex("NormalTex", 2D) = "bump" {}
		[NoScaleOffset]_BumpMap("Normal Texture", 2D) = "bump" {}
		_Metallic("Surface Metallic", Range( 0 , 1)) = 0
		_Glossiness("Surface Smoothness", Range( 0 , 1)) = 0.5
		[HideInInspector]_Smoothness("Smoothness", Range( 0 , 1)) = 0.5
		[HideInInspector][NoScaleOffset]_SurfaceTex("SurfaceTex", 2D) = "white" {}
		[NoScaleOffset]_MetallicGlossMap("Surface Texture", 2D) = "white" {}
		[HideInInspector][Space(10)]_UVOne("UVOne", Vector) = (1,1,0,0)
		[Space(10)]_MainUVs("Main UVs", Vector) = (1,1,0,0)
		[BCategory(Globals)]_GLOBALSS("[ GLOBALSS ]", Float) = 0
		[HideInInspector]_MotionNoise("Motion Noise", Float) = 1
		_GlobalTurbulence("Global Turbulence", Range( 0 , 1)) = 1
		[Toggle]_GrassTint("Grass Tint", Float) = 1
		[HideInInspector]_FoliageTint("FoliageTint", Float) = 0
		[HideInInspector]_FoliageSize("FoliageSize", Float) = 0
		[Toggle]_GrassSize("Grass Size", Float) = 1
		[BCategory(Motion)]_MOTIONN("[ MOTIONN ]", Float) = 0
		_MotionAmplitude("Motion Amplitude", Float) = 1
		_MotionSpeed("Motion Speed", Float) = 1
		_MotionScale("Motion Scale", Float) = 1
		[BInteractive(_MotionSpace, 0)]_MotionSpaceee("# MotionSpaceee", Float) = 0
		_MotionOffset("Motion Offset", Vector) = (0,0,0,0)
		[BInteractive(ON)]_MotionSpaceeeEnd("# MotionSpaceee End", Float) = 0
		[KeywordEnum(World,Local)] _MotionSpace("Motion Space", Float) = 0
		[BInteractive(_MotionSpace, 1)]_MotionSpacee("# MotionSpacee", Float) = 0
		_LocalDirection("Motion Local Direction", Vector) = (0,0,1,0)
		[BInteractive(ON)]_MotionSpaceeEnd("# MotionSpacee End", Float) = 0
		[Enum(ADS Packed,0,ADS QuickMask,1)][Space(10)]_MaskType("Mask Type", Float) = 0
		[BInteractive(_MaskType, 1)]_MaskTypee("# MaskTypee", Float) = 0
		[Enum(X Axis,0,Y Axis,1,Z Axis,2)]_MaskAxis("Mask Axis", Float) = 1
		[BInteractive(ON)]_MaskTypeeEnd("# MaskTypee End", Float) = 0
		[BMessage(Warning, The ADS Quick Mask option is slow when using high poly meshes and it will be deprecated soon, _MaskType, 1, 10, 0)]_QuickMaskk("!!! QuickMaskk !!!", Float) = 0
		[Space(10)]_MaskMin("Mask Min", Float) = 0
		_MaskMax("Mask Max", Float) = 1
		[BCategory(Advanced)]_ADVANCEDD("[ ADVANCEDD ]", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" }
		LOD 300
		Cull [_CullMode]
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma shader_feature _MOTIONSPACE_WORLD _MOTIONSPACE_LOCAL
		#pragma exclude_renderers d3d9 gles 
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows nolightmap  nodynlightmap nodirlightmap nometa vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			half ASEVFace : VFACE;
			float4 vertexToFrag1077;
		};

		uniform float _MotionNoise;
		uniform half _MaskTypeeEnd;
		uniform half _QuickMaskk;
		uniform half _MaskTypee;
		uniform half _MotionSpaceeEnd;
		uniform half _MotionSpaceeeEnd;
		uniform half _MotionSpaceee;
		uniform half _MotionSpacee;
		uniform float _FoliageSize;
		uniform sampler2D _NormalTex;
		uniform float _FoliageTint;
		uniform half _MOTIONN;
		uniform sampler2D _SurfaceTex;
		uniform half _Internal_UnityToBoxophobic;
		uniform half _Internal_Deprecated;
		uniform half _Internal_ADS;
		uniform half _Smoothness;
		uniform half _MAINN;
		uniform half _Cutoff;
		uniform half _NormalScale;
		uniform half _ADSStandardLitGrass;
		uniform half _Modee;
		uniform half4 _UVOne;
		uniform half _CullMode;
		uniform sampler2D _AlbedoTex;
		uniform half _ADVANCEDD;
		uniform half _RENDERINGG;
		uniform half _GLOBALSS;
		uniform half ADS_GlobalScale;
		uniform half _MotionScale;
		uniform half ADS_GlobalSpeed;
		uniform half _MotionSpeed;
		uniform half ADS_GlobalAmplitude;
		uniform half _MotionAmplitude;
		uniform half ADS_TurbulenceTex_ON;
		uniform float _GlobalTurbulence;
		uniform sampler2D ADS_TurbulenceTex;
		uniform half ADS_TurbulenceSpeed;
		uniform half3 ADS_GlobalDirection;
		uniform half ADS_TurbulenceScale;
		uniform half ADS_TurbulenceContrast;
		uniform half3 _MotionOffset;
		uniform half3 _LocalDirection;
		uniform half _MaskAxis;
		uniform half _MaskType;
		uniform half _MaskMin;
		uniform half _MaskMax;
		uniform half ADS_GrassSizeTex_ON;
		uniform half _GrassSize;
		uniform half ADS_GrassSizeMin;
		uniform half ADS_GrassSizeMax;
		uniform sampler2D ADS_GrassSizeTex;
		uniform half4 ADS_GrassSizeScaleOffset;
		uniform half _BumpScale;
		uniform sampler2D _BumpMap;
		uniform half4 _MainUVs;
		uniform half _NormalInvertOnBackface;
		uniform sampler2D _MainTex;
		uniform half4 _Color;
		uniform half ADS_GrassTintTex_ON;
		uniform half _GrassTint;
		uniform sampler2D ADS_GrassTintTex;
		uniform half4 ADS_GrassTintScaleOffset;
		uniform half4 ADS_GrassTintColorOne;
		uniform half4 ADS_GrassTintColorTwo;
		uniform half ADS_GrassTintModeColors;
		uniform half ADS_GrassTintIntensity;
		uniform sampler2D _MetallicGlossMap;
		uniform half _Metallic;
		uniform half _Glossiness;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 ase_vertex3Pos = v.vertex.xyz;
			#if defined(_MOTIONSPACE_WORLD)
				float3 staticSwitch216_g1064 = ase_worldPos;
			#elif defined(_MOTIONSPACE_LOCAL)
				float3 staticSwitch216_g1064 = ase_vertex3Pos;
			#else
				float3 staticSwitch216_g1064 = ase_worldPos;
			#endif
			half MotionScale60_g1064 = ( ADS_GlobalScale * _MotionScale );
			half MotionSpeed62_g1064 = ( ADS_GlobalSpeed * _MotionSpeed );
			float mulTime90_g1064 = _Time.y * MotionSpeed62_g1064;
			float2 appendResult115_g1055 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 panner73_g1055 = ( _Time.y * ( ADS_TurbulenceSpeed * (-ADS_GlobalDirection).xz ) + ( appendResult115_g1055 * ADS_TurbulenceScale ));
			float lerpResult136_g1055 = lerp( 1.0 , saturate( pow( abs( tex2Dlod( ADS_TurbulenceTex, float4( panner73_g1055, 0, 0.0) ).r ) , ADS_TurbulenceContrast ) ) , _GlobalTurbulence);
			float ifLocalVar94_g1055 = 0;
			UNITY_BRANCH 
			if( ( ADS_TurbulenceTex_ON * _GlobalTurbulence ) > 0.0001 )
				ifLocalVar94_g1055 = lerpResult136_g1055;
			else if( ( ADS_TurbulenceTex_ON * _GlobalTurbulence ) < 0.0001 )
				ifLocalVar94_g1055 = 1.0;
			half MotionlAmplitude58_g1064 = ( ADS_GlobalAmplitude * _MotionAmplitude * ifLocalVar94_g1055 );
			#if defined(_MOTIONSPACE_WORLD)
				float3 staticSwitch214_g1064 = mul( unity_WorldToObject, float4( ( ADS_GlobalDirection + _MotionOffset + 0.0001 ) , 0.0 ) ).xyz;
			#elif defined(_MOTIONSPACE_LOCAL)
				float3 staticSwitch214_g1064 = _LocalDirection;
			#else
				float3 staticSwitch214_g1064 = mul( unity_WorldToObject, float4( ( ADS_GlobalDirection + _MotionOffset + 0.0001 ) , 0.0 ) ).xyz;
			#endif
			half3 MotionDirection59_g1064 = staticSwitch214_g1064;
			float temp_output_25_0_g1061 = _MaskAxis;
			float lerpResult24_g1061 = lerp( v.texcoord3.x , v.texcoord3.y , saturate( temp_output_25_0_g1061 ));
			float lerpResult21_g1061 = lerp( lerpResult24_g1061 , v.texcoord3.z , step( 2.0 , temp_output_25_0_g1061 ));
			half THREE27_g1061 = lerpResult21_g1061;
			float lerpResult42_g1060 = lerp( v.color.r , THREE27_g1061 , _MaskType);
			float temp_output_7_0_g1062 = _MaskMin;
			float lerpResult31_g1060 = lerp( 0.0 , 1.0 , saturate( ( ( lerpResult42_g1060 - temp_output_7_0_g1062 ) / ( _MaskMax - temp_output_7_0_g1062 ) ) ));
			half MotionMask137_g1064 = lerpResult31_g1060;
			float lerpResult116_g1065 = lerp( ADS_GrassSizeMin , ADS_GrassSizeMax , tex2Dlod( ADS_GrassSizeTex, float4( ( ( (ase_worldPos).xz * (ADS_GrassSizeScaleOffset).xy ) + (ADS_GrassSizeScaleOffset).zw ), 0, 0.0) ).r);
			float3 temp_cast_5 = (0.0).xxx;
			float3 ifLocalVar96_g1065 = 0;
			UNITY_BRANCH 
			if( ( ADS_GrassSizeTex_ON * _GrassSize ) > 0.5 )
				ifLocalVar96_g1065 = ( lerpResult116_g1065 * v.texcoord3.xyz );
			else if( ( ADS_GrassSizeTex_ON * _GrassSize ) < 0.5 )
				ifLocalVar96_g1065 = temp_cast_5;
			v.vertex.xyz += ( ( ( ( ( sin( ( ( ( staticSwitch216_g1064 * MotionScale60_g1064 ) + mulTime90_g1064 ) + ( v.color.g * 1.756 ) ) ) * MotionlAmplitude58_g1064 ) + ( MotionlAmplitude58_g1064 * saturate( MotionScale60_g1064 ) ) ) * MotionDirection59_g1064 ) * MotionMask137_g1064 ) + ifLocalVar96_g1065 );
			float4 temp_cast_6 = (1.0).xxxx;
			float2 appendResult130_g978 = (float2(ase_worldPos.x , ase_worldPos.z));
			float4 tex2DNode75_g978 = tex2Dlod( ADS_GrassTintTex, float4( ( ( appendResult130_g978 * (ADS_GrassTintScaleOffset).xy ) + (ADS_GrassTintScaleOffset).zw ), 0, 0.0) );
			float4 lerpResult115_g978 = lerp( ADS_GrassTintColorOne , ADS_GrassTintColorTwo , tex2DNode75_g978.r);
			float4 lerpResult121_g978 = lerp( tex2DNode75_g978 , lerpResult115_g978 , ADS_GrassTintModeColors);
			float4 lerpResult126_g978 = lerp( temp_cast_6 , ( lerpResult121_g978 * ADS_GrassTintIntensity ) , saturate( ADS_GrassTintIntensity ));
			float4 temp_cast_7 = (1.0).xxxx;
			float4 ifLocalVar96_g978 = 0;
			UNITY_BRANCH 
			if( ( ADS_GrassTintTex_ON * _GrassTint ) > 0.5 )
				ifLocalVar96_g978 = lerpResult126_g978;
			else if( ( ADS_GrassTintTex_ON * _GrassTint ) < 0.5 )
				ifLocalVar96_g978 = temp_cast_7;
			o.vertexToFrag1077 = ifLocalVar96_g978;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 appendResult564 = (float2(_MainUVs.x , _MainUVs.y));
			float2 appendResult565 = (float2(_MainUVs.z , _MainUVs.w));
			half2 MainUVs587 = ( ( i.uv_texcoord * appendResult564 ) + appendResult565 );
			float3 temp_output_13_0_g1066 = UnpackScaleNormal( tex2D( _BumpMap, MainUVs587 ), _BumpScale );
			float3 break17_g1066 = temp_output_13_0_g1066;
			float switchResult12_g1066 = (((i.ASEVFace>0)?(break17_g1066.z):(-break17_g1066.z)));
			float3 appendResult18_g1066 = (float3(break17_g1066.x , break17_g1066.y , switchResult12_g1066));
			float3 lerpResult20_g1066 = lerp( temp_output_13_0_g1066 , appendResult18_g1066 , _NormalInvertOnBackface);
			half3 NORMAL620 = lerpResult20_g1066;
			o.Normal = NORMAL620;
			float4 tex2DNode18 = tex2D( _MainTex, MainUVs587 );
			half4 MainTex487 = tex2DNode18;
			half4 MainColor486 = _Color;
			o.Albedo = saturate( ( MainTex487 * MainColor486 * i.vertexToFrag1077 ) ).rgb;
			float4 tex2DNode645 = tex2D( _MetallicGlossMap, MainUVs587 );
			half SurfaceTexRed646 = tex2DNode645.r;
			half METALLIC748 = ( SurfaceTexRed646 * _Metallic );
			o.Metallic = METALLIC748;
			half SurfaceTexAlpha744 = tex2DNode645.a;
			half SMOOTHNESS660 = ( SurfaceTexAlpha744 * _Glossiness );
			o.Smoothness = SMOOTHNESS660;
			o.Alpha = 1;
			half MainTexAlpha616 = tex2DNode18.a;
			clip( MainTexAlpha616 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Standard"
	CustomEditor "ADSShaderGUI"
}
/*ASEBEGIN
Version=16203
1927;29;1906;1014;-1149.554;1228.723;1;True;False
Node;AmplifyShaderEditor.Vector4Node;563;-1280,-672;Half;False;Property;_MainUVs;Main UVs;23;0;Create;True;0;0;False;1;Space(10);1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;564;-1024,-672;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;561;-1280,-896;Float;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;562;-832,-896;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;565;-1024,-592;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;575;-624,-896;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;587;-448,-896;Half;False;MainUVs;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;644;2688,-896;Float;False;587;MainUVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;645;2944,-896;Float;True;Property;_MetallicGlossMap;Surface Texture;21;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;588;-128,-896;Float;False;587;MainUVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;655;1536,-768;Half;False;Property;_BumpScale;Normal Scale;14;0;Create;False;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;80,-896;Float;True;Property;_MainTex;Main Texture;10;1;[NoScaleOffset];Create;False;0;0;False;0;None;c3a99bc198a17f345b882ffd532e8f86;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;604;1536,-896;Float;False;587;MainUVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;744;3344,-768;Half;False;SurfaceTexAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;646;3344,-896;Half;False;SurfaceTexRed;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;409;768,-896;Half;False;Property;_Color;Main Color;8;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;1024,-896;Half;False;MainColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;656;3712,-896;Float;False;646;SurfaceTexRed;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1140;1840,-704;Half;False;Property;_NormalInvertOnBackface;Normal Backface;12;1;[Toggle];Create;False;2;Opaque;0;Transparent;1;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;750;3712,-816;Half;False;Property;_Metallic;Surface Metallic;17;0;Create;False;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;294;3712,-624;Half;False;Property;_Glossiness;Surface Smoothness;18;0;Create;False;0;0;False;0;0.5;0.4;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1110;-1280,-2032;Float;False;ADS Grass Tint (Legacy);29;;978;b810a046229fab449ab4dfc3f9df6e7f;0;0;1;COLOR;85
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;384,-896;Half;False;MainTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;749;3712,-704;Float;False;744;SurfaceTexAlpha;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;607;1808,-896;Float;True;Property;_BumpMap;Normal Texture;16;1;[NoScaleOffset];Create;False;0;0;False;0;None;0f1e41185a66b4545ac50a990a888c39;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1083;-1280,-2112;Float;False;486;MainColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexToFragmentNode;1077;-1008,-2032;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1139;2151.554,-892.7229;Float;False;ADS Back Type;-1;;1066;4f53bc25e6d8da34db70401bcf363a2a;0;2;13;FLOAT3;0,0,0;False;30;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;36;-1280,-2176;Float;False;487;MainTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;657;4032,-896;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;745;4032,-720;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1127;-1280,-1472;Float;False;ADS Mask Generic;49;;1060;2cfc3815568565c4585aebb38bd7a29b;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1092;-1280,-1408;Float;False;ADS Global Turbulence;25;;1055;047eb809542f42d40b4b5066e22cee72;1,126,0;0;1;FLOAT;85
Node;AmplifyShaderEditor.RegisterLocalVarNode;660;4224,-720;Half;False;SMOOTHNESS;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;384,-768;Half;False;MainTexAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;2368,-896;Half;False;NORMAL;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1074;-512,-2176;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;748;4224,-896;Half;False;METALLIC;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1111;-1024,-1344;Float;False;ADS Grass Size (Legacy);34;;1065;6675a46c54a0e244fb369c824eead1af;0;0;1;FLOAT3;85
Node;AmplifyShaderEditor.FunctionNode;1120;-1024,-1472;Float;False;ADS Motion Generic;38;;1064;a8838de3869103540a427ac470da4da6;0;3;136;FLOAT;0;False;133;FLOAT;0;False;218;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;752;-1280,-1824;Float;False;748;METALLIC;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;743;-1280,-2560;Half;False;Property;_CullMode;Cull Mode;4;1;[Enum];Create;True;3;Off;0;Front;1;Back;2;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1130;80,-704;Float;True;Property;_AlbedoTex;AlbedoTex;11;2;[HideInInspector];[NoScaleOffset];Create;True;0;0;True;0;None;c3a99bc198a17f345b882ffd532e8f86;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1119;-1280,-3328;Half;False;Property;_ADSStandardLitGrass;< ADS Standard Lit Grass >;1;0;Create;True;0;0;True;1;BBanner(ADS Standard Lit, Grass);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1114;-1280,-3136;Half;False;Property;_Modee;# _Modee;5;0;Create;True;0;0;True;1;BInteractive(_Mode, 1);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;1129;-1280,-496;Half;False;Property;_UVOne;UVOne;22;1;[HideInInspector];Create;True;0;0;True;1;Space(10);1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1113;-1280,-3232;Half;False;Property;_RENDERINGG;[ RENDERINGG ];3;0;Create;True;0;0;True;1;BCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1116;-928,-3232;Half;False;Property;_GLOBALSS;[ GLOBALSS ];24;0;Create;True;0;0;True;1;BCategory(Globals);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1136;1808,-608;Float;True;Property;_NormalTex;NormalTex;15;2;[HideInInspector];[NoScaleOffset];Create;True;0;0;True;0;None;0f1e41185a66b4545ac50a990a888c39;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1118;-576,-3232;Half;False;Property;_ADVANCEDD;[ ADVANCEDD ];57;0;Create;True;0;0;True;1;BCategory(Advanced);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;791;-1280,-1664;Float;False;616;MainTexAlpha;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;624;-1280,-1920;Float;False;620;NORMAL;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1131;1536,-688;Half;False;Property;_NormalScale;NormalScale;13;1;[HideInInspector];Create;True;0;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1117;-752,-3232;Half;False;Property;_MOTIONN;[ MOTIONN ];37;0;Create;True;0;0;True;1;BCategory(Motion);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1132;2944,-704;Float;True;Property;_SurfaceTex;SurfaceTex;20;2;[HideInInspector];[NoScaleOffset];Create;True;0;0;True;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1138;-928,-1248;Half;False;Property;_Internal_UnityToBoxophobic;_Internal_UnityToBoxophobic;9;1;[HideInInspector];Create;True;0;0;True;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1082;-768,-1472;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1135;-1120,-1248;Float;False;Property;_FoliageSize;FoliageSize;33;1;[HideInInspector];Create;True;0;0;True;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;654;-1280,-1760;Float;False;660;SMOOTHNESS;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1134;-1280,-1248;Float;False;Property;_FoliageTint;FoliageTint;32;1;[HideInInspector];Create;True;0;0;True;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1109;-320,-2176;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;862;-1088,-2560;Half;False;Property;_Cutoff;Cutout;6;0;Create;False;3;Off;0;Front;1;Back;2;0;True;0;0.5;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1115;-1088,-3232;Half;False;Property;_MAINN;[ MAINN ];7;0;Create;True;0;0;True;1;BCategory(Main);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1057;1024,-800;Half;False;MainColorAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1124;-1280,-3040;Half;False;Property;_Internal_Deprecated;!!! Internal_Deprecated !!!;2;0;Create;True;0;0;True;1;BMessage(Error, The ADS Grass shaders will be deprecated soon Please switch to ADS Foliage shaders instead, 0, 0);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1128;-992,-3040;Half;False;Property;_Internal_ADS;_Internal_ADS;0;1;[HideInInspector];Create;True;0;0;True;0;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1133;3712,-544;Half;False;Property;_Smoothness;Smoothness;19;1;[HideInInspector];Create;True;0;0;True;0;0.5;0.412;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-128,-2048;Float;False;True;2;Float;ADSShaderGUI;300;0;Standard;BOXOPHOBIC/Advanced Dynamic Shaders/Standard Lit/Grass (Legacy);False;False;False;False;False;False;True;True;True;False;True;False;False;False;False;False;True;False;False;False;Off;0;True;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.2;True;True;0;False;TransparentCutout;;AlphaTest;All;False;True;True;False;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;True;550;10;True;553;0;1;False;550;10;False;553;0;True;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;300;Standard;-1;-1;-1;-1;0;False;0;0;True;743;-1;0;True;862;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;712;-1280,-1024;Float;False;1026.93;100;Main UVs;0;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;708;1536,-1024;Float;False;1024.6;100;Normal Texture;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1112;-1280,-3456;Float;False;974.27;100;Drawers;0;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;751;3712,-1024;Float;False;716.1997;100;Metallic / Smoothness;0;;1,0.7450981,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;683;-1280,-2688;Float;False;447.304;100;Rendering;0;;1,0,0.503,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;760;-128,-1024;Float;False;1389.328;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;715;2688,-1024;Float;False;872.9998;100;Smoothness Texture;0;;1,0.7686275,0,1;0;0
WireConnection;564;0;563;1
WireConnection;564;1;563;2
WireConnection;562;0;561;0
WireConnection;562;1;564;0
WireConnection;565;0;563;3
WireConnection;565;1;563;4
WireConnection;575;0;562;0
WireConnection;575;1;565;0
WireConnection;587;0;575;0
WireConnection;645;1;644;0
WireConnection;18;1;588;0
WireConnection;744;0;645;4
WireConnection;646;0;645;1
WireConnection;486;0;409;0
WireConnection;487;0;18;0
WireConnection;607;1;604;0
WireConnection;607;5;655;0
WireConnection;1077;0;1110;85
WireConnection;1139;13;607;0
WireConnection;1139;30;1140;0
WireConnection;657;0;656;0
WireConnection;657;1;750;0
WireConnection;745;0;749;0
WireConnection;745;1;294;0
WireConnection;660;0;745;0
WireConnection;616;0;18;4
WireConnection;620;0;1139;0
WireConnection;1074;0;36;0
WireConnection;1074;1;1083;0
WireConnection;1074;2;1077;0
WireConnection;748;0;657;0
WireConnection;1120;136;1127;0
WireConnection;1120;133;1092;85
WireConnection;1082;0;1120;0
WireConnection;1082;1;1111;85
WireConnection;1109;0;1074;0
WireConnection;1057;0;409;4
WireConnection;0;0;1109;0
WireConnection;0;1;624;0
WireConnection;0;3;752;0
WireConnection;0;4;654;0
WireConnection;0;10;791;0
WireConnection;0;11;1082;0
ASEEND*/
//CHKSM=E6CBB7D92170A1AFB05C88AE388CD2829EF7E882