// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/Advanced Dynamic Shaders/Simple Lit/Grass (Legacy)"
{
	Properties
	{
		[BBanner(ADS Simple Lit, Grass)]_ADSSimpleLitGrass("< ADS Simple Lit Grass >", Float) = 1
		[HideInInspector]_Internal_ADS("_Internal_ADS", Float) = 1
		[BMessage(Error, The ADS Grass shaders will be deprecated soon Please switch to ADS Foliage shaders instead, 0, 0)]_Internal_Deprecated("!!! Internal_Deprecated !!!", Float) = 1
		[BCategory(Rendering)]_RENDERINGG("[ RENDERINGG ]", Float) = 0
		[Enum(Off,0,Front,1,Back,2)]_CullMode("Cull Mode", Float) = 0
		[BInteractive(_Mode, 1)]_Modee("# _Modee", Float) = 0
		_Cutoff("Cutout", Range( 0 , 1)) = 0.5
		[BCategory(Main)]_MAINN("[ MAINN ]", Float) = 0
		_Color("Main Color", Color) = (1,1,1,1)
		[HideInInspector][NoScaleOffset]_AlbedoTex("AlbedoTex", 2D) = "white" {}
		[HideInInspector]_Internal_UnityToBoxophobic("_Internal_UnityToBoxophobic", Float) = 0
		[NoScaleOffset]_MainTex("Main Texture", 2D) = "white" {}
		[HideInInspector]_NormalScale("NormalScale", Float) = 1
		[Toggle]_NormalInvertOnBackface("Normal Backface", Float) = 1
		_BumpScale("Normal Scale", Float) = 1
		[NoScaleOffset]_BumpMap("Normal Texture", 2D) = "bump" {}
		[HideInInspector][NoScaleOffset]_NormalTex("NormalTex", 2D) = "bump" {}
		[HideInInspector][Space(10)]_UVOne("UVOne", Vector) = (1,1,0,0)
		[Space(10)]_MainUVs("Main UVs", Vector) = (1,1,0,0)
		[BCategory(Globals)]_GLOBALSS("[ GLOBALSS ]", Float) = 0
		[HideInInspector]_MotionNoise("Motion Noise", Float) = 1
		_GlobalTurbulence("Global Turbulence", Range( 0 , 1)) = 1
		[Toggle]_GrassTint("Grass Tint", Float) = 1
		[Toggle]_GrassSize("Grass Size", Float) = 1
		[HideInInspector]_FoliageTint("FoliageTint", Float) = 0
		[HideInInspector]_FoliageSize("FoliageSize", Float) = 0
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
		LOD 200
		Cull [_CullMode]
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma shader_feature _MOTIONSPACE_WORLD _MOTIONSPACE_LOCAL
		#pragma exclude_renderers d3d9 gles 
		#pragma surface surf Lambert keepalpha addshadow fullforwardshadows nolightmap  nodynlightmap nodirlightmap nometa vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			half ASEVFace : VFACE;
			float4 vertexToFrag1088;
		};

		uniform half _MaskTypeeEnd;
		uniform half _QuickMaskk;
		uniform half _MaskTypee;
		uniform float _MotionNoise;
		uniform half _MotionSpaceeEnd;
		uniform half _MotionSpaceeeEnd;
		uniform half _MotionSpaceee;
		uniform half _MotionSpacee;
		uniform half _Modee;
		uniform sampler2D _NormalTex;
		uniform half _RENDERINGG;
		uniform half _ADVANCEDD;
		uniform half _NormalScale;
		uniform half _Internal_Deprecated;
		uniform half _Internal_ADS;
		uniform float _FoliageSize;
		uniform sampler2D _AlbedoTex;
		uniform float _FoliageTint;
		uniform half _MOTIONN;
		uniform half _Cutoff;
		uniform half _GLOBALSS;
		uniform half4 _UVOne;
		uniform half _CullMode;
		uniform half _Internal_UnityToBoxophobic;
		uniform half _MAINN;
		uniform half _ADSSimpleLitGrass;
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

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 ase_vertex3Pos = v.vertex.xyz;
			#if defined(_MOTIONSPACE_WORLD)
				float3 staticSwitch216_g1013 = ase_worldPos;
			#elif defined(_MOTIONSPACE_LOCAL)
				float3 staticSwitch216_g1013 = ase_vertex3Pos;
			#else
				float3 staticSwitch216_g1013 = ase_worldPos;
			#endif
			half MotionScale60_g1013 = ( ADS_GlobalScale * _MotionScale );
			half MotionSpeed62_g1013 = ( ADS_GlobalSpeed * _MotionSpeed );
			float mulTime90_g1013 = _Time.y * MotionSpeed62_g1013;
			float2 appendResult115_g1004 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 panner73_g1004 = ( _Time.y * ( ADS_TurbulenceSpeed * (-ADS_GlobalDirection).xz ) + ( appendResult115_g1004 * ADS_TurbulenceScale ));
			float lerpResult136_g1004 = lerp( 1.0 , saturate( pow( abs( tex2Dlod( ADS_TurbulenceTex, float4( panner73_g1004, 0, 0.0) ).r ) , ADS_TurbulenceContrast ) ) , _GlobalTurbulence);
			float ifLocalVar94_g1004 = 0;
			UNITY_BRANCH 
			if( ( ADS_TurbulenceTex_ON * _GlobalTurbulence ) > 0.0001 )
				ifLocalVar94_g1004 = lerpResult136_g1004;
			else if( ( ADS_TurbulenceTex_ON * _GlobalTurbulence ) < 0.0001 )
				ifLocalVar94_g1004 = 1.0;
			half MotionlAmplitude58_g1013 = ( ADS_GlobalAmplitude * _MotionAmplitude * ifLocalVar94_g1004 );
			#if defined(_MOTIONSPACE_WORLD)
				float3 staticSwitch214_g1013 = mul( unity_WorldToObject, float4( ( ADS_GlobalDirection + _MotionOffset + 0.0001 ) , 0.0 ) ).xyz;
			#elif defined(_MOTIONSPACE_LOCAL)
				float3 staticSwitch214_g1013 = _LocalDirection;
			#else
				float3 staticSwitch214_g1013 = mul( unity_WorldToObject, float4( ( ADS_GlobalDirection + _MotionOffset + 0.0001 ) , 0.0 ) ).xyz;
			#endif
			half3 MotionDirection59_g1013 = staticSwitch214_g1013;
			float temp_output_25_0_g1002 = _MaskAxis;
			float lerpResult24_g1002 = lerp( v.texcoord3.x , v.texcoord3.y , saturate( temp_output_25_0_g1002 ));
			float lerpResult21_g1002 = lerp( lerpResult24_g1002 , v.texcoord3.z , step( 2.0 , temp_output_25_0_g1002 ));
			half THREE27_g1002 = lerpResult21_g1002;
			float lerpResult42_g1001 = lerp( v.color.r , THREE27_g1002 , _MaskType);
			float temp_output_7_0_g1003 = _MaskMin;
			float lerpResult31_g1001 = lerp( 0.0 , 1.0 , saturate( ( ( lerpResult42_g1001 - temp_output_7_0_g1003 ) / ( _MaskMax - temp_output_7_0_g1003 ) ) ));
			half MotionMask137_g1013 = lerpResult31_g1001;
			float lerpResult116_g1014 = lerp( ADS_GrassSizeMin , ADS_GrassSizeMax , tex2Dlod( ADS_GrassSizeTex, float4( ( ( (ase_worldPos).xz * (ADS_GrassSizeScaleOffset).xy ) + (ADS_GrassSizeScaleOffset).zw ), 0, 0.0) ).r);
			float3 temp_cast_5 = (0.0).xxx;
			float3 ifLocalVar96_g1014 = 0;
			UNITY_BRANCH 
			if( ( ADS_GrassSizeTex_ON * _GrassSize ) > 0.5 )
				ifLocalVar96_g1014 = ( lerpResult116_g1014 * v.texcoord3.xyz );
			else if( ( ADS_GrassSizeTex_ON * _GrassSize ) < 0.5 )
				ifLocalVar96_g1014 = temp_cast_5;
			v.vertex.xyz += ( ( ( ( ( sin( ( ( ( staticSwitch216_g1013 * MotionScale60_g1013 ) + mulTime90_g1013 ) + ( v.color.g * 1.756 ) ) ) * MotionlAmplitude58_g1013 ) + ( MotionlAmplitude58_g1013 * saturate( MotionScale60_g1013 ) ) ) * MotionDirection59_g1013 ) * MotionMask137_g1013 ) + ifLocalVar96_g1014 );
			float4 temp_cast_6 = (1.0).xxxx;
			float2 appendResult130_g980 = (float2(ase_worldPos.x , ase_worldPos.z));
			float4 tex2DNode75_g980 = tex2Dlod( ADS_GrassTintTex, float4( ( ( appendResult130_g980 * (ADS_GrassTintScaleOffset).xy ) + (ADS_GrassTintScaleOffset).zw ), 0, 0.0) );
			float4 lerpResult115_g980 = lerp( ADS_GrassTintColorOne , ADS_GrassTintColorTwo , tex2DNode75_g980.r);
			float4 lerpResult121_g980 = lerp( tex2DNode75_g980 , lerpResult115_g980 , ADS_GrassTintModeColors);
			float4 lerpResult126_g980 = lerp( temp_cast_6 , ( lerpResult121_g980 * ADS_GrassTintIntensity ) , saturate( ADS_GrassTintIntensity ));
			float4 temp_cast_7 = (1.0).xxxx;
			float4 ifLocalVar96_g980 = 0;
			UNITY_BRANCH 
			if( ( ADS_GrassTintTex_ON * _GrassTint ) > 0.5 )
				ifLocalVar96_g980 = lerpResult126_g980;
			else if( ( ADS_GrassTintTex_ON * _GrassTint ) < 0.5 )
				ifLocalVar96_g980 = temp_cast_7;
			o.vertexToFrag1088 = ifLocalVar96_g980;
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 appendResult564 = (float2(_MainUVs.x , _MainUVs.y));
			float2 appendResult565 = (float2(_MainUVs.z , _MainUVs.w));
			half2 MainUVs587 = ( ( i.uv_texcoord * appendResult564 ) + appendResult565 );
			float3 temp_output_13_0_g1015 = UnpackScaleNormal( tex2D( _BumpMap, MainUVs587 ), _BumpScale );
			float3 break17_g1015 = temp_output_13_0_g1015;
			float switchResult12_g1015 = (((i.ASEVFace>0)?(break17_g1015.z):(-break17_g1015.z)));
			float3 appendResult18_g1015 = (float3(break17_g1015.x , break17_g1015.y , switchResult12_g1015));
			float3 lerpResult20_g1015 = lerp( temp_output_13_0_g1015 , appendResult18_g1015 , _NormalInvertOnBackface);
			half3 NORMAL620 = lerpResult20_g1015;
			o.Normal = NORMAL620;
			float4 tex2DNode18 = tex2D( _MainTex, MainUVs587 );
			half4 MainTex487 = tex2DNode18;
			half4 MainColor486 = _Color;
			o.Albedo = saturate( ( MainTex487 * MainColor486 * i.vertexToFrag1088 ) ).rgb;
			o.Alpha = 1;
			half MainTexAlpha616 = tex2DNode18.a;
			clip( MainTexAlpha616 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Mobile/Bumped Specular"
	CustomEditor "ADSShaderGUI"
}
/*ASEBEGIN
Version=16203
1927;29;1906;1014;-948.6873;2526.372;1;True;False
Node;AmplifyShaderEditor.Vector4Node;563;-1280,-1952;Half;False;Property;_MainUVs;Main UVs;18;0;Create;True;0;0;False;1;Space(10);1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;564;-1024,-1952;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;561;-1280,-2176;Float;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;562;-832,-2176;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;565;-1024,-1872;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;575;-624,-2176;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;587;-448,-2176;Half;False;MainUVs;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;588;-128,-2176;Float;False;587;MainUVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;604;1536,-2176;Float;False;587;MainUVs;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;409;768,-2176;Half;False;Property;_Color;Main Color;8;0;Create;False;0;0;False;0;1,1,1,1;1,1,1,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;18;80,-2176;Float;True;Property;_MainTex;Main Texture;11;1;[NoScaleOffset];Create;False;0;0;False;0;None;c3a99bc198a17f345b882ffd532e8f86;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;655;1536,-2048;Half;False;Property;_BumpScale;Normal Scale;14;0;Create;False;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;384,-2176;Half;False;MainTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1136;1824,-1984;Half;False;Property;_NormalInvertOnBackface;Normal Backface;13;1;[Toggle];Create;False;2;Opaque;0;Transparent;1;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;486;1024,-2176;Half;False;MainColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;607;1806,-2176;Float;True;Property;_BumpMap;Normal Texture;15;1;[NoScaleOffset];Create;False;0;0;False;0;None;0f1e41185a66b4545ac50a990a888c39;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1087;-1280,-3200;Float;False;ADS Grass Tint (Legacy);24;;980;b810a046229fab449ab4dfc3f9df6e7f;0;0;1;COLOR;85
Node;AmplifyShaderEditor.FunctionNode;1054;-1280,-2752;Float;False;ADS Global Turbulence;20;;1004;047eb809542f42d40b4b5066e22cee72;1,126,0;0;1;FLOAT;85
Node;AmplifyShaderEditor.FunctionNode;1135;2128,-2176;Float;False;ADS Back Type;-1;;1015;4f53bc25e6d8da34db70401bcf363a2a;0;2;13;FLOAT3;0,0,0;False;30;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1053;-1280,-2816;Float;False;ADS Mask Generic;44;;1001;2cfc3815568565c4585aebb38bd7a29b;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexToFragmentNode;1088;-992,-3200;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1099;-1280,-3264;Float;False;486;MainColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1077;-1280,-3328;Float;False;487;MainTex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;620;2368,-2176;Half;False;NORMAL;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1090;-704,-3328;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1134;-1024,-2816;Float;False;ADS Motion Generic;33;;1013;a8838de3869103540a427ac470da4da6;0;3;136;FLOAT;0;False;133;FLOAT;0;False;218;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1121;-1024,-2688;Float;False;ADS Grass Size (Legacy);27;;1014;6675a46c54a0e244fb369c824eead1af;0;0;1;FLOAT3;85
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;384,-2048;Half;False;MainTexAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1111;-544,-3328;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;743;-1280,-3584;Half;False;Property;_CullMode;Cull Mode;4;1;[Enum];Create;True;3;Off;0;Front;1;Back;2;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;1126;-1280,-1760;Half;False;Property;_UVOne;UVOne;17;1;[HideInInspector];Create;True;0;0;True;1;Space(10);1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1057;1024,-2080;Half;False;MainColorAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1117;-928,-4256;Half;False;Property;_GLOBALSS;[ GLOBALSS ];19;0;Create;True;0;0;True;1;BCategory(Globals);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1114;-1280,-4352;Half;False;Property;_ADSSimpleLitGrass;< ADS Simple Lit Grass >;0;0;Create;True;0;0;True;1;BBanner(ADS Simple Lit, Grass);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1128;1792,-1872;Float;True;Property;_NormalTex;NormalTex;16;2;[HideInInspector];[NoScaleOffset];Create;True;0;0;True;0;None;0f1e41185a66b4545ac50a990a888c39;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1116;-1088,-4256;Half;False;Property;_MAINN;[ MAINN ];7;0;Create;True;0;0;True;1;BCategory(Main);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;791;-640,-2944;Float;False;616;MainTexAlpha;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1133;-896,-2560;Half;False;Property;_Internal_UnityToBoxophobic;_Internal_UnityToBoxophobic;10;1;[HideInInspector];Create;True;0;0;True;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1095;-640,-2816;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1119;-576,-4256;Half;False;Property;_ADVANCEDD;[ ADVANCEDD ];52;0;Create;True;0;0;True;1;BCategory(Advanced);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1129;1536,-1952;Half;False;Property;_NormalScale;NormalScale;12;1;[HideInInspector];Create;True;0;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1123;-1280,-4064;Half;False;Property;_Internal_Deprecated;!!! Internal_Deprecated !!!;2;0;Create;True;0;0;True;1;BMessage(Error, The ADS Grass shaders will be deprecated soon Please switch to ADS Foliage shaders instead, 0, 0);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1124;-640,-3072;Float;False;620;NORMAL;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1115;-1280,-4160;Half;False;Property;_Modee;# _Modee;5;0;Create;True;0;0;True;1;BInteractive(_Mode, 1);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1113;-1280,-4256;Half;False;Property;_RENDERINGG;[ RENDERINGG ];3;0;Create;True;0;0;True;1;BCategory(Rendering);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1130;-1282,-2560;Float;False;Property;_FoliageTint;FoliageTint;30;1;[HideInInspector];Create;True;0;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;862;-1088,-3584;Half;False;Property;_Cutoff;Cutout;6;0;Create;False;3;Off;0;Front;1;Back;2;0;True;0;0.5;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1118;-752,-4256;Half;False;Property;_MOTIONN;[ MOTIONN ];32;0;Create;True;0;0;True;1;BCategory(Motion);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1125;-992,-4064;Half;False;Property;_Internal_ADS;_Internal_ADS;1;1;[HideInInspector];Create;True;0;0;True;0;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1132;-1122,-2560;Float;False;Property;_FoliageSize;FoliageSize;31;1;[HideInInspector];Create;True;0;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1127;80,-1968;Float;True;Property;_AlbedoTex;AlbedoTex;9;2;[HideInInspector];[NoScaleOffset];Create;True;0;0;True;0;None;c3a99bc198a17f345b882ffd532e8f86;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-256,-3328;Float;False;True;2;Float;ADSShaderGUI;200;0;Lambert;BOXOPHOBIC/Advanced Dynamic Shaders/Simple Lit/Grass (Legacy);False;False;False;False;False;False;True;True;True;False;True;False;False;False;False;False;True;False;False;False;Off;0;True;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.1;True;True;0;False;TransparentCutout;;AlphaTest;All;False;True;True;False;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;True;550;10;True;553;0;1;False;550;10;False;553;0;True;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;200;Mobile/Bumped Specular;-1;-1;-1;-1;0;False;0;0;True;743;-1;0;True;862;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;708;1536,-2304;Float;False;1022.523;100;Normal Texture;0;;0.5019608,0.5019608,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;712;-1280,-2304;Float;False;1022.348;100;Main UVs;0;;0.4980392,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1112;-1280,-4480;Float;False;920.27;100;Drawers;0;;1,0.4980392,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;683;-1280,-3712;Float;False;445.1465;100;Rendering;0;;1,0,0.503,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;760;-128,-2304;Float;False;1352.083;100;Main Texture and Color;0;;0,0.751724,1,1;0;0
WireConnection;564;0;563;1
WireConnection;564;1;563;2
WireConnection;562;0;561;0
WireConnection;562;1;564;0
WireConnection;565;0;563;3
WireConnection;565;1;563;4
WireConnection;575;0;562;0
WireConnection;575;1;565;0
WireConnection;587;0;575;0
WireConnection;18;1;588;0
WireConnection;487;0;18;0
WireConnection;486;0;409;0
WireConnection;607;1;604;0
WireConnection;607;5;655;0
WireConnection;1135;13;607;0
WireConnection;1135;30;1136;0
WireConnection;1088;0;1087;85
WireConnection;620;0;1135;0
WireConnection;1090;0;1077;0
WireConnection;1090;1;1099;0
WireConnection;1090;2;1088;0
WireConnection;1134;136;1053;0
WireConnection;1134;133;1054;85
WireConnection;616;0;18;4
WireConnection;1111;0;1090;0
WireConnection;1057;0;409;4
WireConnection;1095;0;1134;0
WireConnection;1095;1;1121;85
WireConnection;0;0;1111;0
WireConnection;0;1;1124;0
WireConnection;0;10;791;0
WireConnection;0;11;1095;0
ASEEND*/
//CHKSM=FBE85C54913EBC844B35347467638E6BC11593D6