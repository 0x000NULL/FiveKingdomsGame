// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Utils/ADS Debug"
{
	Properties
	{
		[HideInInspector]_Internal_ADS("_Internal_ADS", Float) = 1
		_GlobalTint("Global Tint", Range( 0 , 1)) = 1
		_DetailTint("Detail Tint", Range( 0 , 1)) = 1
		_GlobalSize("Global Size", Range( 0 , 1)) = 1
		[Toggle]_LeavesTint("Leaves Tint", Float) = 1
		[Enum(Opaque,0,Cutout,1,Fade,2)]_Mode("Blend Mode", Float) = 0
		[HideInInspector]_MotionNoise("Motion Noise", Float) = 1
		_GlobalTurbulence("Global Turbulence", Range( 0 , 1)) = 1
		_Debug_Arrow("Debug_Arrow", Float) = 1
		_Internal_Deprecated("_Internal_Deprecated", Float) = 0
		_MaskType("_MaskType", Float) = 0
		_LeavesTint("Fetch _LeavesTint", Float) = 1
		ADS_GlobalTintIntensity("Fetch ADS_GlobalTintIntensity", Float) = 1
		_GlobalTint("Fetch _GlobalTint", Float) = 1
		_MotionNoise("Fetch _MotionNoise", Float) = 1
		[HideInInspector]_Internal_TypeTreeLeaf("Internal_TypeTreeLeaf", Float) = 1
		[HideInInspector]_Internal_TypeTreeBark("Internal_TypeTreeBark", Float) = 1
		[HideInInspector]_Internal_TypeGrass("Internal_TypeGrass", Float) = 1
		[HideInInspector]_Internal_TypePlant("Internal_TypePlant", Float) = 1
		[HideInInspector]_Internal_DebugMask3("Internal_DebugMask3", Float) = 1
		[HideInInspector]_Internal_DebugMask2("Internal_DebugMask2", Float) = 1
		[HideInInspector]_Internal_DebugMask("Internal_DebugMask", Float) = 1
		[HideInInspector]_Internal_DebugVariation("Internal_DebugVariation", Float) = 1
		[HideInInspector]_Internal_TypeGeneric("Internal_TypeGeneric", Float) = 0
		[HideInInspector]_Internal_TypeCloth("Internal_TypeCloth", Float) = 0
		[HideInInspector]_Internal_LitSimple("Internal_LitSimple", Float) = 1
		[HideInInspector]_Internal_LitStandard("Internal_LitStandard", Float) = 1
		[HideInInspector]_Internal_LitAdvanced("Internal_LitAdvanced", Float) = 1
		[Enum(Off,0,Front,1,Back,2)]_CullMode("Cull Mode", Float) = 0
		[Space(10)]_Cutoff("Cutout/Fade", Range( 0 , 1)) = 1
		[NoScaleOffset]_AlbedoTex("Main Texture", 2D) = "white" {}
		[HideInInspector]_ZWrite("_ZWrite", Float) = 1
		[HideInInspector]_SrcBlend("_SrcBlend", Float) = 1
		[HideInInspector]_DstBlend("_DstBlend", Float) = 10
		[HideInInspector] _tex4coord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" "IsEmissive" = "true"  }
		LOD 300
		Cull [_CullMode]
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma exclude_renderers d3d9 gles 
		#pragma surface surf Lambert keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float4 vertexColor : COLOR;
			float4 uv_tex4coord;
			float3 worldPos;
			float3 worldNormal;
			float2 uv_texcoord;
		};

		uniform float _MotionNoise;
		uniform half _CullMode;
		uniform half _Cutoff;
		uniform half _DstBlend;
		uniform half _Mode;
		uniform half _ZWrite;
		uniform half _SrcBlend;
		uniform half ADS_GlobalSizeMin;
		uniform half ADS_GlobalSizeMax;
		uniform sampler2D ADS_GlobalTex;
		uniform half4 ADS_GlobalUVs;
		uniform half _GlobalSize;
		uniform half _Internal_TypeGrass;
		uniform half _Internal_TypePlant;
		uniform half ADS_DebugMode;
		uniform half _Internal_DebugMask;
		uniform half _Internal_TypeTreeBark;
		uniform half _Internal_TypeCloth;
		uniform half _Internal_TypeGeneric;
		uniform half _Internal_TypeTreeLeaf;
		uniform half _Internal_ADS;
		uniform half _Internal_DebugMask2;
		uniform half _Internal_DebugMask3;
		uniform half _Internal_DebugVariation;
		uniform half ADS_TurbulenceTex_ON;
		uniform float _GlobalTurbulence;
		uniform sampler2D ADS_TurbulenceTex;
		uniform half ADS_TurbulenceSpeed;
		uniform half3 ADS_GlobalDirection;
		uniform half ADS_TurbulenceScale;
		uniform half ADS_TurbulenceContrast;
		uniform half4 ADS_GlobalTintColorOne;
		uniform half4 ADS_GlobalTintColorTwo;
		uniform half ADS_GlobalTintIntensity;
		uniform half _GlobalTint;
		uniform half _DetailTint;
		uniform half ADS_TreeTintTex_ON;
		uniform half _LeavesTint;
		uniform sampler2D ADS_TreeTintTex;
		uniform half4 ADS_TreeTintScaleOffset;
		uniform half4 ADS_TreeTintColorOne;
		uniform half4 ADS_TreeTintColorTwo;
		uniform half ADS_TreeTintModeColors;
		uniform half ADS_TreeTintIntensity;
		uniform half _Internal_LitAdvanced;
		uniform half _Internal_LitStandard;
		uniform half _Internal_LitSimple;
		uniform float _MaskType;
		uniform float _Internal_Deprecated;
		uniform half _Debug_Arrow;
		uniform sampler2D _AlbedoTex;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			half localunity_ObjectToWorld0w1_g1510 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g1510 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g1510 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g1510 = (float3(localunity_ObjectToWorld0w1_g1510 , localunity_ObjectToWorld1w2_g1510 , localunity_ObjectToWorld2w3_g1510));
			float4 tex2DNode140_g1500 = tex2Dlod( ADS_GlobalTex, float4( ( ( (appendResult6_g1510).xz * (ADS_GlobalUVs).xy ) + (ADS_GlobalUVs).zw ), 0, 0.0) );
			half ADS_GlobalTex_B198_g1500 = tex2DNode140_g1500.b;
			float lerpResult156_g1500 = lerp( ADS_GlobalSizeMin , ADS_GlobalSizeMax , ADS_GlobalTex_B198_g1500);
			float temp_output_1618_157 = ( lerpResult156_g1500 * _GlobalSize );
			half GlobalSize1619 = temp_output_1618_157;
			float3 ase_vertex3Pos = v.vertex.xyz;
			half Internal_TypeFoliage1472 = saturate( ( _Internal_TypeGrass + _Internal_TypePlant ) );
			float3 lerpResult1626 = lerp( float3( 0,0,0 ) , ( GlobalSize1619 * ase_vertex3Pos ) , Internal_TypeFoliage1472);
			v.vertex.xyz += lerpResult1626;
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			half DebugMode1487 = ADS_DebugMode;
			float4 color3_g1544 = IsGammaSpace() ? float4(0.1397059,0.1397059,0.1397059,0) : float4(0.01732622,0.01732622,0.01732622,0);
			half Internal_DebugMask1474 = _Internal_DebugMask;
			half Internal_TypeFoliage1472 = saturate( ( _Internal_TypeGrass + _Internal_TypePlant ) );
			half Internal_TypeTreeBark1488 = _Internal_TypeTreeBark;
			half Internal_TypeCloth1469 = _Internal_TypeCloth;
			half Internal_TypeGeneric1475 = _Internal_TypeGeneric;
			half Internal_TypeTreeLeaf1463 = _Internal_TypeTreeLeaf;
			half4 color1285 = IsGammaSpace() ? half4(0.9485294,0.02789795,0.1227231,0) : half4(0.8868831,0.002159284,0.01391808,0);
			float4 lerpResult2_g1544 = lerp( color3_g1544 , ( ( ( i.vertexColor.r * Internal_DebugMask1474 * Internal_TypeFoliage1472 ) + ( ( i.vertexColor.r * i.vertexColor.r ) * Internal_DebugMask1474 * Internal_TypeTreeBark1488 ) + ( i.vertexColor.r * Internal_DebugMask1474 * Internal_TypeCloth1469 ) + ( i.vertexColor.r * Internal_DebugMask1474 * Internal_TypeGeneric1475 ) + ( ( i.vertexColor.r * i.vertexColor.r ) * Internal_DebugMask1474 * Internal_TypeTreeLeaf1463 ) ) * color1285 ) , _Internal_ADS);
			float4 ifLocalVar1321 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 11.0 )
				ifLocalVar1321 = lerpResult2_g1544;
			float4 MOTION_MASK_11309 = ifLocalVar1321;
			float4 color3_g1546 = IsGammaSpace() ? float4(0.1397059,0.1397059,0.1397059,0) : float4(0.01732622,0.01732622,0.01732622,0);
			half Internal_DebugMask21397 = _Internal_DebugMask2;
			half4 color1400 = IsGammaSpace() ? half4(0.9485294,0.02789795,0.1227231,0) : half4(0.8868831,0.002159284,0.01391808,0);
			float4 lerpResult2_g1546 = lerp( color3_g1546 , ( ( ( Internal_TypeFoliage1472 * i.vertexColor.b * Internal_DebugMask21397 ) + ( i.vertexColor.g * Internal_DebugMask21397 * Internal_TypeTreeBark1488 ) + ( i.vertexColor.g * Internal_DebugMask21397 * Internal_TypeTreeLeaf1463 ) ) * color1400 ) , _Internal_ADS);
			float4 ifLocalVar1293 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 12.0 )
				ifLocalVar1293 = lerpResult2_g1546;
			float4 MOTION_MASK_21364 = ifLocalVar1293;
			float4 color3_g1543 = IsGammaSpace() ? float4(0.1397059,0.1397059,0.1397059,0) : float4(0.01732622,0.01732622,0.01732622,0);
			half Internal_DebugMask31462 = _Internal_DebugMask3;
			half4 color1319 = IsGammaSpace() ? half4(0.9485294,0.02789795,0.1227231,0) : half4(0.8868831,0.002159284,0.01391808,0);
			float4 lerpResult2_g1543 = lerp( color3_g1543 , ( ( ( i.vertexColor.b * Internal_DebugMask31462 ) + ( i.vertexColor.b * Internal_DebugMask31462 ) ) * color1319 ) , _Internal_ADS);
			float4 ifLocalVar1324 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 13.0 )
				ifLocalVar1324 = lerpResult2_g1543;
			float4 MOTION_MASK_31449 = ifLocalVar1324;
			float4 color3_g1545 = IsGammaSpace() ? float4(0.1397059,0.1397059,0.1397059,0) : float4(0.01732622,0.01732622,0.01732622,0);
			half Internal_DebugVariation1392 = _Internal_DebugVariation;
			float4 lerpResult2_g1545 = lerp( color3_g1545 , ( ( ( i.vertexColor.a * Internal_DebugVariation1392 * Internal_TypeFoliage1472 ) + ( i.vertexColor.a * Internal_DebugVariation1392 * Internal_TypeTreeBark1488 ) + ( i.vertexColor.a * Internal_DebugVariation1392 * Internal_TypeCloth1469 ) + ( i.vertexColor.a * Internal_DebugVariation1392 * Internal_TypeGeneric1475 ) + ( i.vertexColor.a * Internal_DebugVariation1392 * Internal_TypeTreeLeaf1463 ) ) * half4(0.05147059,0.875,0.4660752,0) ) , _Internal_ADS);
			float4 ifLocalVar1274 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 14.0 )
				ifLocalVar1274 = lerpResult2_g1545;
			float4 MOTION_VARIATION1313 = ifLocalVar1274;
			float4 color1467 = IsGammaSpace() ? float4(0.1397059,0.1397059,0.1397059,0) : float4(0.01732622,0.01732622,0.01732622,0);
			half4 OtherColor1481 = color1467;
			half localunity_ObjectToWorld0w1_g1531 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g1531 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g1531 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g1531 = (float3(localunity_ObjectToWorld0w1_g1531 , localunity_ObjectToWorld1w2_g1531 , localunity_ObjectToWorld2w3_g1531));
			float2 panner73_g1529 = ( _Time.y * ( ADS_TurbulenceSpeed * (-ADS_GlobalDirection).xz ) + ( (appendResult6_g1531).xz * ADS_TurbulenceScale ));
			float lerpResult136_g1529 = lerp( 1.0 , saturate( pow( abs( tex2D( ADS_TurbulenceTex, panner73_g1529 ).r ) , ADS_TurbulenceContrast ) ) , _GlobalTurbulence);
			float ifLocalVar94_g1529 = 0;
			UNITY_BRANCH 
			if( ( ADS_TurbulenceTex_ON * _GlobalTurbulence ) > 0.0001 )
				ifLocalVar94_g1529 = lerpResult136_g1529;
			else if( ( ADS_TurbulenceTex_ON * _GlobalTurbulence ) < 0.0001 )
				ifLocalVar94_g1529 = 1.0;
			float temp_output_1583_85 = ifLocalVar94_g1529;
			float4 lerpResult1427 = lerp( OtherColor1481 , ( half4(0.5055925,0.6176471,0,0) * temp_output_1583_85 ) , _MotionNoise);
			float4 ifLocalVar1482 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 15.0 )
				ifLocalVar1482 = lerpResult1427;
			float4 MOTION_NOISE1426 = ifLocalVar1482;
			float4 ifLocalVar1374 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 1.0 )
				ifLocalVar1374 = ( half4(1,0,0,0) * i.vertexColor.r );
			float4 ifLocalVar1355 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 2.0 )
				ifLocalVar1355 = ( half4(0,1,0,0) * i.vertexColor.g );
			float4 ifLocalVar1407 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 3.0 )
				ifLocalVar1407 = ( half4(0,0,1,0) * i.vertexColor.b );
			float ifLocalVar1363 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 4.0 )
				ifLocalVar1363 = i.vertexColor.a;
			float4 VERTEX_COLOR1368 = ( ifLocalVar1374 + ifLocalVar1355 + ifLocalVar1407 + ifLocalVar1363 );
			half4 color1455 = IsGammaSpace() ? half4(0.1586208,0,1,0) : half4(0.02164405,0,1,0);
			half4 color1335 = IsGammaSpace() ? half4(0.375,0.6637931,1,0) : half4(0.1160161,0.398147,1,0);
			half localunity_ObjectToWorld0w1_g1510 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g1510 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g1510 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g1510 = (float3(localunity_ObjectToWorld0w1_g1510 , localunity_ObjectToWorld1w2_g1510 , localunity_ObjectToWorld2w3_g1510));
			float4 tex2DNode140_g1500 = tex2D( ADS_GlobalTex, ( ( (appendResult6_g1510).xz * (ADS_GlobalUVs).xy ) + (ADS_GlobalUVs).zw ) );
			half ADS_GlobalTex_B198_g1500 = tex2DNode140_g1500.b;
			float lerpResult156_g1500 = lerp( ADS_GlobalSizeMin , ADS_GlobalSizeMax , ADS_GlobalTex_B198_g1500);
			float temp_output_1618_157 = ( lerpResult156_g1500 * _GlobalSize );
			float4 lerpResult1354 = lerp( color1455 , color1335 , saturate( ( temp_output_1618_157 + 1.0 ) ));
			float4 lerpResult1333 = lerp( OtherColor1481 , lerpResult1354 , Internal_TypeFoliage1472);
			float4 ifLocalVar1351 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 32.0 )
				ifLocalVar1351 = lerpResult1333;
			float4 FOLIAGE_SIZE1373 = ifLocalVar1351;
			float4 temp_cast_0 = (1.0).xxxx;
			half4 ADS_GlobalTintColorOne176_g1534 = ADS_GlobalTintColorOne;
			half4 ADS_GlobalTintColorTwo177_g1534 = ADS_GlobalTintColorTwo;
			half localunity_ObjectToWorld0w1_g1536 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld1w2_g1536 = ( unity_ObjectToWorld[1].w );
			half localunity_ObjectToWorld2w3_g1536 = ( unity_ObjectToWorld[2].w );
			float3 appendResult6_g1536 = (float3(localunity_ObjectToWorld0w1_g1536 , localunity_ObjectToWorld1w2_g1536 , localunity_ObjectToWorld2w3_g1536));
			float4 tex2DNode140_g1534 = tex2D( ADS_GlobalTex, ( ( (appendResult6_g1536).xz * (ADS_GlobalUVs).xy ) + (ADS_GlobalUVs).zw ) );
			half ADS_GlobalTex_R180_g1534 = tex2DNode140_g1534.r;
			float4 lerpResult147_g1534 = lerp( ADS_GlobalTintColorOne176_g1534 , ADS_GlobalTintColorTwo177_g1534 , ADS_GlobalTex_R180_g1534);
			half ADS_GlobalTintIntensity181_g1534 = ADS_GlobalTintIntensity;
			half GlobalTint186_g1534 = _GlobalTint;
			float4 lerpResult150_g1534 = lerp( temp_cast_0 , ( lerpResult147_g1534 * ADS_GlobalTintIntensity181_g1534 ) , GlobalTint186_g1534);
			float4 temp_cast_1 = (1.0).xxxx;
			half localunity_ObjectToWorld0w1_g1538 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld2w3_g1538 = ( unity_ObjectToWorld[2].w );
			float lerpResult194_g1534 = lerp( frac( ( localunity_ObjectToWorld0w1_g1538 + localunity_ObjectToWorld2w3_g1538 ) ) , i.uv_tex4coord.w , _DetailTint);
			float4 lerpResult166_g1534 = lerp( ADS_GlobalTintColorOne176_g1534 , ADS_GlobalTintColorTwo177_g1534 , lerpResult194_g1534);
			float4 lerpResult168_g1534 = lerp( temp_cast_1 , ( lerpResult166_g1534 * ADS_GlobalTintIntensity181_g1534 ) , GlobalTint186_g1534);
			float4 lerpResult1617 = lerp( lerpResult150_g1534 , lerpResult168_g1534 , Internal_TypeTreeLeaf1463);
			float4 lerpResult1494 = lerp( OtherColor1481 , ( lerpResult1617 / ADS_GlobalTintIntensity ) , _GlobalTint);
			float4 ifLocalVar1490 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 31.0 )
				ifLocalVar1490 = lerpResult1494;
			float4 FOLAIGE_TINT1306 = ifLocalVar1490;
			float4 temp_cast_2 = (1.0).xxxx;
			half localunity_ObjectToWorld0w1_g1540 = ( unity_ObjectToWorld[0].w );
			half localunity_ObjectToWorld2w3_g1540 = ( unity_ObjectToWorld[2].w );
			float2 appendResult131_g1539 = (float2(localunity_ObjectToWorld0w1_g1540 , localunity_ObjectToWorld2w3_g1540));
			float4 tex2DNode75_g1539 = tex2D( ADS_TreeTintTex, ( ( appendResult131_g1539 * (ADS_TreeTintScaleOffset).xy ) + (ADS_TreeTintScaleOffset).zw ) );
			float4 lerpResult115_g1539 = lerp( ADS_TreeTintColorOne , ADS_TreeTintColorTwo , tex2DNode75_g1539.r);
			float4 lerpResult121_g1539 = lerp( tex2DNode75_g1539 , lerpResult115_g1539 , ADS_TreeTintModeColors);
			float4 lerpResult126_g1539 = lerp( temp_cast_2 , ( lerpResult121_g1539 * ADS_TreeTintIntensity ) , saturate( ADS_TreeTintIntensity ));
			float4 temp_cast_3 = (1.0).xxxx;
			float4 ifLocalVar96_g1539 = 0;
			UNITY_BRANCH 
			if( ( ADS_TreeTintTex_ON * _LeavesTint ) > 0.5 )
				ifLocalVar96_g1539 = lerpResult126_g1539;
			else if( ( ADS_TreeTintTex_ON * _LeavesTint ) < 0.5 )
				ifLocalVar96_g1539 = temp_cast_3;
			float4 lerpResult1345 = lerp( OtherColor1481 , saturate( ifLocalVar96_g1539 ) , _LeavesTint);
			float4 ifLocalVar1341 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 41.0 )
				ifLocalVar1341 = lerpResult1345;
			float4 TREE_TINT1328 = ifLocalVar1341;
			float4 color3_g1542 = IsGammaSpace() ? float4(0.1397059,0.1397059,0.1397059,0) : float4(0.01732622,0.01732622,0.01732622,0);
			half4 color1394 = IsGammaSpace() ? half4(0.415213,0.6764706,0,0) : half4(0.1437809,0.4152089,0,0);
			half Internal_LitAdvanced1473 = _Internal_LitAdvanced;
			half4 color1320 = IsGammaSpace() ? half4(0.9191176,0.6580883,0,0) : half4(0.8257746,0.3906053,0,0);
			half Internal_LitStandard1466 = _Internal_LitStandard;
			half4 color1357 = IsGammaSpace() ? half4(0,0.5085192,0.6764706,0) : half4(0,0.2220113,0.4152089,0);
			half Internal_LitSimple1493 = _Internal_LitSimple;
			float4 lerpResult2_g1542 = lerp( color3_g1542 , ( ( color1394 * Internal_LitAdvanced1473 ) + ( color1320 * Internal_LitStandard1466 ) + ( color1357 * Internal_LitSimple1493 ) ) , _Internal_ADS);
			float4 ifLocalVar1411 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 61.0 )
				ifLocalVar1411 = lerpResult2_g1542;
			float4 SHADER_COMPLEXITY1284 = ifLocalVar1411;
			half4 color1514 = IsGammaSpace() ? half4(0.5,0.5,0.5,0) : half4(0.2140411,0.2140411,0.2140411,0);
			half4 color1515 = IsGammaSpace() ? half4(0.5459431,0.1102941,1,0) : half4(0.2590563,0.01169531,1,0);
			#ifdef INSTANCING_ON
				float4 staticSwitch1523 = color1515;
			#else
				float4 staticSwitch1523 = color1514;
			#endif
			float4 ifLocalVar1519 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 62.0 )
				ifLocalVar1519 = staticSwitch1523;
			float4 SHADER_INSTANCING1520 = ifLocalVar1519;
			float4 color3_g1541 = IsGammaSpace() ? float4(0.1397059,0.1397059,0.1397059,0) : float4(0.01732622,0.01732622,0.01732622,0);
			half4 color1556 = IsGammaSpace() ? half4(1,0.709,0,0) : half4(1,0.4609121,0,0);
			half4 color1603 = IsGammaSpace() ? half4(1,0,0,0) : half4(1,0,0,0);
			float mulTime1599 = _Time.y * 3.0;
			float4 lerpResult2_g1541 = lerp( color3_g1541 , ( saturate( ( ( _MaskType * color1556 ) + ( _Internal_Deprecated * color1603 ) ) ) * (0.25 + (sin( mulTime1599 ) - -1.0) * (1.0 - 0.25) / (1.0 - -1.0)) ) , _Internal_ADS);
			float4 ifLocalVar1563 = 0;
			UNITY_BRANCH 
			if( DebugMode1487 == 64.0 )
				ifLocalVar1563 = lerpResult2_g1541;
			float4 SHADER_ISSUES1564 = saturate( ifLocalVar1563 );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV1442 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode1442 = ( 0.0 + 1.5 * pow( 1.0 - fresnelNdotV1442, 2.0 ) );
			float4 lerpResult1437 = lerp( half4(1,0.5019608,0,0) , half4(1,0.809,0,0) , saturate( fresnelNode1442 ));
			half4 ArrowColor1438 = lerpResult1437;
			half ArrowDebug1450 = _Debug_Arrow;
			float4 lerpResult1278 = lerp( ( ( MOTION_MASK_11309 + MOTION_MASK_21364 + MOTION_MASK_31449 + MOTION_VARIATION1313 + MOTION_NOISE1426 ) + ( VERTEX_COLOR1368 + FOLIAGE_SIZE1373 + FOLAIGE_TINT1306 + TREE_TINT1328 ) + ( SHADER_COMPLEXITY1284 + SHADER_INSTANCING1520 + SHADER_ISSUES1564 ) ) , ArrowColor1438 , ArrowDebug1450);
			o.Albedo = saturate( ( lerpResult1278 * 0.2 ) ).rgb;
			o.Emission = saturate( ( lerpResult1278 * ( 1.0 - 0.2 ) ) ).rgb;
			o.Alpha = 1;
			float2 uv_AlbedoTex18 = i.uv_texcoord;
			float4 tex2DNode18 = tex2D( _AlbedoTex, uv_AlbedoTex18 );
			half MainTexAlpha616 = tex2DNode18.a;
			float lerpResult1508 = lerp( MainTexAlpha616 , 1.0 , Internal_TypeTreeBark1488);
			clip( lerpResult1508 - _Cutoff );
		}

		ENDCG
	}
	CustomEditor "ADSShaderGUI"
}
/*ASEBEGIN
Version=16209
1927;29;1906;1014;10515.58;-368.3488;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;1590;-10112,-4352;Half;False;Property;_Internal_TypeGrass;Internal_TypeGrass;29;1;[HideInInspector];Create;True;0;0;True;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1468;-10112,-4272;Half;False;Property;_Internal_TypePlant;Internal_TypePlant;30;1;[HideInInspector];Create;True;0;0;True;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1591;-9888,-4352;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1393;-8384,-4496;Half;False;Property;_Internal_DebugVariation;Internal_DebugVariation;34;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1387;-9536,-4496;Half;False;Property;_Internal_DebugMask2;Internal_DebugMask2;32;1;[HideInInspector];Create;True;0;0;True;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1592;-9760,-4352;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1465;-8960,-4608;Half;False;Property;_Internal_TypeGeneric;Internal_TypeGeneric;35;1;[HideInInspector];Create;True;0;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1478;-10112,-4496;Half;False;Property;_Internal_DebugMask;Internal_DebugMask;33;1;[HideInInspector];Create;True;0;0;True;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1567;-3456,-1792;Float;False;Property;_Internal_Deprecated;_Internal_Deprecated;21;0;Create;True;0;0;False;0;0;63;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1603;-3456,-1712;Half;False;Constant;_Color23;Color 23;3;0;Create;True;0;0;False;0;1,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;1556;-3456,-2096;Half;False;Constant;_Color24;Color 24;3;0;Create;True;0;0;False;0;1,0.709,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1395;-8960,-4496;Half;False;Property;_Internal_DebugMask3;Internal_DebugMask3;31;1;[HideInInspector];Create;True;0;0;True;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1433;-9536,-4608;Half;False;Property;_Internal_TypeTreeLeaf;Internal_TypeTreeLeaf;27;1;[HideInInspector];Create;True;0;0;True;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1396;-10112,-4608;Half;False;Property;_Internal_TypeTreeBark;Internal_TypeTreeBark;28;1;[HideInInspector];Create;True;0;0;True;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1565;-3456,-2176;Float;False;Property;_MaskType;_MaskType;22;0;Create;True;0;0;False;0;0;63;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1486;-8384,-4608;Half;False;Property;_Internal_TypeCloth;Internal_TypeCloth;36;1;[HideInInspector];Create;True;0;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1604;-3200,-1792;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1392;-8096,-4496;Half;False;Internal_DebugVariation;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1484;-7808,-4608;Half;False;Property;_Internal_LitAdvanced;Internal_LitAdvanced;39;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;1476;-10112,-2688;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1483;-6656,-4608;Half;False;Property;_Internal_LitSimple;Internal_LitSimple;37;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1469;-8144,-4608;Half;False;Internal_TypeCloth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;1599;-3456,-1536;Float;False;1;0;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1472;-9600,-4352;Half;False;Internal_TypeFoliage;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;1371;-10112,-1664;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1470;-7232,-4608;Half;False;Property;_Internal_LitStandard;Internal_LitStandard;38;1;[HideInInspector];Create;True;0;0;True;0;1;0;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1558;-3200,-2176;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1474;-9856,-4496;Half;False;Internal_DebugMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1463;-9280,-4608;Half;False;Internal_TypeTreeLeaf;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1488;-9856,-4608;Half;False;Internal_TypeTreeBark;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1397;-9280,-4496;Half;False;Internal_DebugMask2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1462;-8704,-4496;Half;False;Internal_DebugMask3;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1475;-8704,-4608;Half;False;Internal_TypeGeneric;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1422;-10112,-1984;Float;False;1488;Internal_TypeTreeBark;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1466;-6992,-4608;Half;False;Internal_LitStandard;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1383;-10112,-2512;Float;False;1474;Internal_DebugMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1446;-9856,-1648;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1408;-10112,-2352;Float;False;1462;Internal_DebugMask3;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1435;-10112,-288;Float;False;1469;Internal_TypeCloth;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1425;-10112,-3008;Float;False;1472;Internal_TypeFoliage;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;1382;-10112,0;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;1605;-3072,-2176;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1404;-10112,-960;Float;False;1463;Internal_TypeTreeLeaf;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;1369;-10112,-640;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1616;-6528,-1328;Float;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1417;-10112,-1408;Float;False;1397;Internal_DebugMask2;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1399;-10112,-1040;Float;False;1392;Internal_DebugVariation;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1493;-6416,-4608;Half;False;Internal_LitSimple;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1372;-10112,-384;Float;False;1392;Internal_DebugVariation;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;1415;-10112,-3712;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1441;-10112,256;Float;False;1392;Internal_DebugVariation;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1429;-9856,-2672;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1428;-10112,352;Float;False;1475;Internal_TypeGeneric;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1461;-10112,-1488;Float;False;1474;Internal_DebugMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1358;-10112,-464;Float;False;1474;Internal_DebugMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1485;-10112,-2064;Float;False;1392;Internal_DebugVariation;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1323;-10112,-3536;Float;False;1474;Internal_DebugMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1416;-10112,-1328;Float;False;1462;Internal_DebugMask3;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1401;-10112,176;Float;False;1474;Internal_DebugMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1632;-6272,-304;Float;False;const;-1;;1513;5b64729fb717c5f49a1bc2dab81d5e1c;1,3,1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;1597;-3280,-1536;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1296;-10112,-3120;Float;False;1392;Internal_DebugVariation;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1375;-10112,-3200;Float;False;1397;Internal_DebugMask2;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1473;-7552,-4608;Half;False;Internal_LitAdvanced;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1409;-10112,-2432;Float;False;1397;Internal_DebugMask2;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1618;-6272,-448;Float;False;ADS Global Settings;2;;1500;0fe83146627632b4981f5a0aa1b63801;0;1;171;FLOAT;0;False;3;COLOR;85;COLOR;165;FLOAT;157
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1471;-9088,-3328;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1361;-9088,-2672;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1430;-9088,0;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1477;-9088,-1392;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1394;-6272,-3712;Half;False;Constant;_Color14;Color 14;3;0;Create;True;0;0;False;0;0.415213,0.6764706,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1406;-9088,-1104;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1288;-6272,-3024;Float;False;1493;Internal_LitSimple;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1606;-2944,-2176;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1613;-6272,-1328;Float;False;ADS Global Settings;2;;1534;0fe83146627632b4981f5a0aa1b63801;0;1;171;FLOAT;0;False;3;COLOR;85;COLOR;165;FLOAT;157
Node;AmplifyShaderEditor.GetLocalVarNode;1614;-6272,-1216;Float;False;1463;Internal_TypeTreeLeaf;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1297;-6272,-3552;Float;False;1473;Internal_LitAdvanced;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1378;-9088,-1520;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1418;-9088,-3712;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1480;-8960,-5776;Half;False;Global;ADS_DebugMode;ADS_DebugMode;3;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1320;-6272,-3456;Half;False;Constant;_Color15;Color 15;3;0;Create;True;0;0;False;0;0.9191176,0.6580883,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;1467;-8960,-5680;Float;False;Constant;_Color12;Color 12;21;0;Create;True;0;0;False;0;0.1397059,0.1397059,0.1397059,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;1602;-3088,-1632;Float;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0.25;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1413;-9088,-2128;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1631;-6032,-320;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1356;-9088,128;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1379;-9088,-512;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1424;-9088,-2416;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1457;-9088,-2544;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1431;-9088,-3200;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1357;-6272,-3200;Half;False;Constant;_Color16;Color 16;3;0;Create;True;0;0;False;0;0,0.5085192,0.6764706,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1340;-6272,-3296;Float;False;1466;Internal_LitStandard;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1403;-9088,-1648;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1330;-9088,-640;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1349;-5952,-3456;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1285;-8000,-3584;Half;False;Constant;_Color9;Color 9;3;0;Create;True;0;0;False;0;0.9485294,0.02789795,0.1227231,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;1455;-6272,-768;Half;False;Constant;_Color17;Color 17;3;0;Create;True;0;0;False;0;0.1586208,0,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;1443;-8000,-2304;Half;False;Constant;_Color13;Color 13;3;0;Create;True;0;0;False;0;0.05147059,0.875,0.4660752,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;1377;-6272,-2432;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1315;-5952,-3200;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1322;-8320,-2432;Float;False;5;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1314;-6080,-2688;Half;False;Constant;_Color3;Color 3;3;0;Create;True;0;0;False;0;1,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;1292;-6272,-2176;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;1400;-8000,-3072;Half;False;Constant;_Color10;Color 10;3;0;Create;True;0;0;False;0;0.9485294,0.02789795,0.1227231,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;1319;-8000,-2688;Half;False;Constant;_Color11;Color 11;3;0;Create;True;0;0;False;0;0.9485294,0.02789795,0.1227231,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;1419;-10112,736;Half;False;Constant;_Color1;Color 1;3;0;Create;True;0;0;False;0;0.5055925,0.6176471,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1385;-5952,-3712;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1335;-6272,-608;Half;False;Constant;_Color0;Color 0;3;0;Create;True;0;0;False;0;0.375,0.6637931,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;1617;-6000,-1328;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1481;-8736,-5680;Half;False;OtherColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;1633;-5936,-512;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1607;-2800,-2176;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1366;-6080,-2176;Half;False;Constant;_Color5;Color 5;3;0;Create;True;0;0;False;0;0,0,1,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;1583;-10112,1168;Float;False;ADS Global Turbulence;13;;1529;047eb809542f42d40b4b5066e22cee72;0;0;1;FLOAT;85
Node;AmplifyShaderEditor.SimpleAddOpNode;1298;-8320,-3712;Float;False;5;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1389;-6080,-2432;Half;False;Constant;_Color4;Color 4;3;0;Create;True;0;0;False;0;0,1,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;1304;-8320,-3200;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1448;-8320,-2816;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1487;-8736,-5776;Half;False;DebugMode;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1634;-6272,-1072;Half;False;Property;ADS_GlobalTintIntensity;Fetch ADS_GlobalTintIntensity;24;0;Fetch;False;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1291;-6272,208;Float;False;ADS Tree Tint;7;;1539;9a0490fafd9b98e45aaa3c8fb9910e26;0;0;1;COLOR;85
Node;AmplifyShaderEditor.VertexColorNode;1384;-6272,-2688;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;1560;-2608,-2176;Float;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1464;-7680,-3712;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1454;-7680,-2432;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1307;-5568,-1920;Float;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1317;-7680,-3200;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1436;-10112,912;Half;False;Property;_MotionNoise;Fetch _MotionNoise;26;0;Fetch;False;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1561;-2608,-2096;Float;False;Constant;_Float3;Float 3;21;0;Create;True;0;0;False;0;64;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1359;-5568,-2048;Float;False;Constant;_Float21;Float 21;31;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1515;-6272,800;Half;False;Constant;_Color8;Color 8;3;0;Create;True;0;0;False;0;0.5459431,0.1102941,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1370;-5568,-1776;Float;False;Constant;_Float22;Float 22;31;0;Create;True;0;0;False;0;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1334;-7680,-2816;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1337;-6272,320;Half;False;Property;_LeavesTint;Fetch _LeavesTint;23;0;Fetch;False;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1380;-9472,640;Float;False;1481;OtherColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1635;-5808,-1328;Float;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1628;-5641.369,-550.752;Float;False;1472;Internal_TypeFoliage;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1562;-2608,-1984;Float;False;ADS Debug Other;0;;1541;d6ad6eace599767429eafd03127b39e4;0;1;4;COLOR;0,0,0,0;False;1;COLOR;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1367;-5824,-2368;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1514;-6272,640;Half;False;Constant;_Color2;Color 2;3;0;Create;True;0;0;False;0;0.5,0.5,0.5,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;1388;-6272,-1920;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1479;-5888,-1088;Half;False;Property;_GlobalTint;Fetch _GlobalTint;25;0;Fetch;False;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1354;-5824,-736;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;1346;-6080,208;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1386;-5568,-2432;Float;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1376;-5632,-3712;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1318;-5824,-2112;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1283;-5568,-2688;Float;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1343;-5632,-768;Float;False;1481;OtherColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1305;-6272,-1408;Float;False;1481;OtherColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1447;-9472,736;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1329;-5568,-2304;Float;False;Constant;_Float9;Float 9;31;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1302;-6272,128;Float;False;1481;OtherColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1339;-5568,-2176;Float;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1286;-5824,-2624;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1410;-5568,-2560;Float;False;Constant;_Float24;Float 24;31;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;1563;-2352,-2176;Float;False;True;5;0;FLOAT;0;False;1;FLOAT;14;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;4;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1453;-7488,-3712;Float;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;1374;-5360,-2688;Float;False;True;5;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ConditionalIfNode;1407;-5360,-2176;Float;False;True;5;0;FLOAT;0;False;1;FLOAT;3;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1518;-5376,640;Float;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1402;-7488,-3632;Float;False;Constant;_Float23;Float 23;21;0;Create;True;0;0;False;0;11;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1523;-5888,640;Float;False;Property;INSTANCING;INSTANCING_ON;39;0;Fetch;False;0;0;False;0;0;0;0;False;INSTANCING_ON;Toggle;2;Key0;Key1;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1390;-7488,-3520;Float;False;ADS Debug Other;0;;1544;d6ad6eace599767429eafd03127b39e4;0;1;4;COLOR;0,0,0,0;False;1;COLOR;5
Node;AmplifyShaderEditor.ConditionalIfNode;1355;-5360,-2432;Float;False;True;5;0;FLOAT;0;False;1;FLOAT;2;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1420;-9152,640;Float;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1333;-5376,-768;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1280;-7488,-2816;Float;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1342;-5184,-640;Float;False;Constant;_Float17;Float 17;33;0;Create;True;0;0;False;0;32;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1365;-7488,-3008;Float;False;ADS Debug Other;0;;1546;d6ad6eace599767429eafd03127b39e4;0;1;4;COLOR;0,0,0,0;False;1;COLOR;5
Node;AmplifyShaderEditor.GetLocalVarNode;1327;-5184,-768;Float;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1325;-7488,-2240;Float;False;ADS Debug Other;0;;1545;d6ad6eace599767429eafd03127b39e4;0;1;4;COLOR;0,0,0,0;False;1;COLOR;5
Node;AmplifyShaderEditor.LerpOp;1494;-5632,-1408;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1423;-9152,720;Float;False;Constant;_Float26;Float 26;21;0;Create;True;0;0;False;0;15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1427;-9312,768;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1412;-5344,-3632;Float;False;Constant;_Float25;Float 25;21;0;Create;True;0;0;False;0;61;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1345;-5760,128;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1344;-5376,256;Float;False;Constant;_Float18;Float 18;33;0;Create;True;0;0;False;0;41;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1492;-5376,-1280;Float;False;Constant;_Float29;Float 29;33;0;Create;True;0;0;False;0;31;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1277;-5344,-3520;Float;False;ADS Debug Other;0;;1542;d6ad6eace599767429eafd03127b39e4;0;1;4;COLOR;0,0,0,0;False;1;COLOR;5
Node;AmplifyShaderEditor.ConditionalIfNode;1363;-5360,-1920;Float;False;True;5;0;FLOAT;0;False;1;FLOAT;4;False;2;FLOAT;0;False;3;FLOAT;0;False;4;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1287;-7488,-3200;Float;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1338;-7488,-3120;Float;False;Constant;_Float16;Float 16;21;0;Create;True;0;0;False;0;12;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1517;-5376,768;Float;False;Constant;_Float12;Float 12;33;0;Create;True;0;0;False;0;62;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1451;-7488,-2352;Float;False;Constant;_Float27;Float 27;21;0;Create;True;0;0;False;0;14;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1275;-5344,-3712;Float;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1316;-7488,-2736;Float;False;Constant;_Float11;Float 11;21;0;Create;True;0;0;False;0;13;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1282;-7488,-2432;Float;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1303;-7488,-2624;Float;False;ADS Debug Other;0;;1543;d6ad6eace599767429eafd03127b39e4;0;1;4;COLOR;0,0,0,0;False;1;COLOR;5
Node;AmplifyShaderEditor.GetLocalVarNode;1347;-5376,128;Float;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1491;-5376,-1408;Float;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1311;-4992,-2304;Float;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ConditionalIfNode;1324;-7232,-2816;Float;False;True;5;0;FLOAT;0;False;1;FLOAT;13;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ConditionalIfNode;1411;-5088,-3712;Float;False;True;5;0;FLOAT;0;False;1;FLOAT;14;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ConditionalIfNode;1490;-5168,-1408;Float;False;True;5;0;FLOAT;0;False;1;FLOAT;31;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ConditionalIfNode;1482;-8960,640;Float;False;True;5;0;FLOAT;0;False;1;FLOAT;14;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ConditionalIfNode;1519;-5168,640;Float;False;True;5;0;FLOAT;0;False;1;FLOAT;31;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ConditionalIfNode;1293;-7232,-3200;Float;False;True;5;0;FLOAT;0;False;1;FLOAT;12;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ConditionalIfNode;1341;-5168,128;Float;False;True;5;0;FLOAT;0;False;1;FLOAT;31;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ConditionalIfNode;1274;-7232,-2432;Float;False;True;5;0;FLOAT;0;False;1;FLOAT;14;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ConditionalIfNode;1351;-4976,-768;Float;False;True;5;0;FLOAT;0;False;1;FLOAT;32;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;1568;-2160,-2176;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FresnelNode;1442;-10112,-5392;Float;False;Standard;TangentNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1.5;False;3;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;1321;-7232,-3712;Float;False;True;5;0;FLOAT;0;False;1;FLOAT;11;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1309;-7056,-3712;Float;False;MOTION_MASK_1;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1564;-2000,-2176;Float;False;SHADER_ISSUES;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1284;-4848,-3712;Float;False;SHADER_COMPLEXITY;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1306;-4800,-1408;Float;False;FOLAIGE_TINT;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1368;-4800,-2304;Float;False;VERTEX_COLOR;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1449;-7056,-2816;Float;False;MOTION_MASK_3;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1373;-4800,-768;Float;False;FOLIAGE_SIZE;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;1440;-9856,-5520;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1520;-4848,640;Float;False;SHADER_INSTANCING;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1364;-7056,-3200;Float;False;MOTION_MASK_2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1459;-10112,-5776;Half;False;Constant;_Color7;Color 7;0;0;Create;True;0;0;False;0;1,0.5019608,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1313;-7072,-2432;Float;False;MOTION_VARIATION;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1439;-10112,-5600;Half;False;Constant;_Color6;Color 6;0;0;Create;True;0;0;False;0;1,0.809,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1328;-4800,128;Float;False;TREE_TINT;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1426;-8784,640;Float;False;MOTION_NOISE;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1434;-9600,-5584;Half;False;Property;_Debug_Arrow;Debug_Arrow;19;0;Create;True;0;0;True;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1381;-7296,-5712;Float;False;1328;TREE_TINT;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1524;-7296,-5520;Float;False;1520;SHADER_INSTANCING;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1460;-7296,-6080;Float;False;1426;MOTION_NOISE;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1362;-7296,-6400;Float;False;1309;MOTION_MASK_1;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1301;-7296,-5792;Float;False;1306;FOLAIGE_TINT;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1566;-7296,-5440;Float;False;1564;SHADER_ISSUES;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1289;-7296,-6160;Float;False;1313;MOTION_VARIATION;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1300;-7296,-6320;Float;False;1364;MOTION_MASK_2;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1326;-7296,-5600;Float;False;1284;SHADER_COMPLEXITY;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1299;-7296,-5952;Float;False;1368;VERTEX_COLOR;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1276;-7296,-6240;Float;False;1449;MOTION_MASK_3;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1432;-7296,-5872;Float;False;1373;FOLIAGE_SIZE;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1437;-9664,-5776;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1526;-6976,-5600;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1438;-9408,-5776;Half;False;ArrowColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1312;-6976,-6288;Float;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1450;-9408,-5584;Half;False;ArrowDebug;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1525;-6976,-5952;Float;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1619;-5855.272,-406.9746;Half;False;GlobalSize;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1273;-6720,-6016;Float;False;1438;ArrowColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1281;-6720,-5952;Float;False;1450;ArrowDebug;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;-9216,-6400;Float;True;Property;_AlbedoTex;Main Texture;42;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;1290;-6720,-6288;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1151;-6272,-6080;Half;False;Constant;_Float0;Float 0;20;0;Create;True;0;0;False;0;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;1572;-6032,-6032;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;1636;-6272,-5472;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;616;-8912,-6272;Half;False;MainTexAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1278;-6272,-6272;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1620;-6272,-5568;Float;False;1619;GlobalSize;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1573;-5824,-6096;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;791;-6272,-5888;Float;False;616;MainTexAlpha;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1513;-6016,-5344;Float;False;1472;Internal_TypeFoliage;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1509;-6272,-5728;Float;False;1488;Internal_TypeTreeBark;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1627;-5920,-5568;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1510;-6272,-5808;Float;False;Constant;_Float1;Float 1;38;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1150;-6016,-6144;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1547;-3136,-2656;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1533;-3456,-3200;Half;False;Constant;_Color20;Color 20;3;0;Create;True;0;0;False;0;0,0.3685599,0.6764706,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1535;-3136,-3456;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;1551;-2560,-3520;Float;False;ADS Debug Other;0;;1547;d6ad6eace599767429eafd03127b39e4;0;1;4;COLOR;0,0,0,0;False;1;COLOR;5
Node;AmplifyShaderEditor.ConditionalIfNode;1541;-2272,-3712;Float;False;True;5;0;FLOAT;0;False;1;FLOAT;14;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1529;-3456,-3456;Half;False;Constant;_Color18;Color 18;3;0;Create;True;0;0;False;0;0.8088235,0.4852941,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;549;-9728,-6912;Half;False;Property;_Mode;Blend Mode;10;1;[Enum];Create;False;3;Opaque;0;Cutout;1;Fade;2;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;553;-9952,-6912;Half;False;Property;_DstBlend;_DstBlend;46;1;[HideInInspector];Create;True;0;0;True;0;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;561;-10112,-6400;Float;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;563;-10112,-6272;Half;False;Property;_UVZero;Main UVs;43;0;Create;False;0;0;False;1;Space(10);1,1,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;1546;-3456,-2928;Half;False;Constant;_Color21;Color 21;3;0;Create;True;0;0;False;0;0.5661765,0.4053961,0.2331315,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1308;-10112,-7040;Half;False;Property;_MaskMin;Mask Min;11;0;Create;True;0;0;False;1;Space(10);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-8912,-6400;Half;False;MainTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1542;-1984,-3712;Float;False;SHADER_TYPE;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;564;-9856,-6272;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1414;-9728,-7040;Half;False;Property;_MaskMax;Mask Max;12;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1584;-10112,1232;Float;False;ADS Global Turbulence;13;;1524;047eb809542f42d40b4b5066e22cee72;0;0;1;FLOAT;85
Node;AmplifyShaderEditor.GetLocalVarNode;1579;-10112,1088;Float;False;1463;Internal_TypeTreeLeaf;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1508;-6016,-5888;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;565;-9856,-6192;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;1574;-5664,-6112;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1458;-9280,-7040;Half;False;Property;_Show_ADSMask;Show_ADSMask;17;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1537;-2816,-3712;Float;False;5;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;550;-10112,-6912;Half;False;Property;_SrcBlend;_SrcBlend;45;1;[HideInInspector];Create;True;0;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;925;-9280,-6912;Half;False;Property;_ZWrite;_ZWrite;44;1;[HideInInspector];Create;True;2;Off;0;On;1;0;True;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1528;-3456,-3024;Float;False;1475;Internal_TypeGeneric;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1540;-2528,-3712;Float;False;1487;DebugMode;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1544;-3136,-2928;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1534;-3136,-3200;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1530;-3456,-3712;Half;False;Constant;_Color19;Color 19;3;0;Create;True;0;0;False;0;0.4072486,0.6544118,0.01443557,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;862;-9088,-6912;Half;False;Property;_Cutoff;Cutout/Fade;41;0;Create;False;3;Off;0;Front;1;Back;2;0;True;1;Space(10);1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1295;-9568,-7040;Half;False;_MaskMax;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1549;-3456,-2656;Half;False;Constant;_Color22;Color 22;3;0;Create;True;0;0;False;0;0.07006919,0.5955882,0.07369344,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1271;-9952,-7040;Half;False;_MaskMin;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;1580;-9728,1024;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1577;-9840,1024;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1578;-10112,1024;Float;False;1488;Internal_TypeTreeBark;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1444;-8448,-7040;Half;False;_Show_MaskSpeedTree;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;743;-9472,-6912;Half;False;Property;_CullMode;Cull Mode;40;1;[Enum];Create;True;3;Off;0;Front;1;Back;2;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1581;-9536,1024;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1536;-3136,-3712;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;1222;-5760,-6272;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;575;-9456,-6400;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1532;-3456,-3296;Float;False;1469;Internal_TypeCloth;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1531;-3456,-3552;Float;False;1472;Internal_TypeFoliage;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1279;-9024,-7040;Half;False;_Show_ADSMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1548;-3456,-2480;Float;False;1463;Internal_TypeTreeLeaf;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1626;-5696,-5568;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1545;-3456,-2752;Float;False;1488;Internal_TypeTreeBark;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1360;-8704,-7040;Half;False;Property;_Show_MaskSpeedTree;Show_MaskSpeedTree;18;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1353;-5674,-630;Half;False;Property;_GlobalSize;Fetch _GlobalSize;20;0;Fetch;False;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1539;-2528,-3632;Float;False;Constant;_Float2;Float 2;21;0;Create;True;0;0;False;0;63;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;562;-9664,-6400;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-5504,-6272;Float;False;True;2;Float;ADSShaderGUI;300;0;Lambert;Utils/ADS Debug;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;True;True;False;False;False;Off;0;False;925;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0;True;False;0;False;TransparentCutout;;AlphaTest;All;False;True;True;False;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;1;True;550;1;True;553;0;0;False;550;0;False;553;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;300;;-1;-1;-1;-1;0;False;0;0;True;743;-1;0;True;862;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;1500;-8320,-3840;Float;False;1528.8;100;Motion Debug;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1543;-3456,-3840;Float;False;1661.688;100;Shader Type;0;;0.6137931,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1497;-10112,-1792;Float;False;1156.727;100;Packed Tree Leaf // VertexR = Trunk Mask / VertexG= Branch Mask / VertexB= Leaf / VertexA = AO / UV0.T = Motion Variation;0;;0.6137931,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1552;-3456,-2304;Float;False;1662.707;100;Shader Issues;0;;1,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1505;-10112,-3840;Float;False;1149.95;100;Packed Foliage // Vertex A = Plant Mask / UV0.W = Leaf Mask / UV0.T = Variation;0;;0.1172413,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1498;-10112,-2816;Float;False;1156.727;100;Packed Tree Bark // VertexR = Trunk Mask / VertexG= Branch Mask / VertexB= Leaf / VertexA = AO / UV0.T = Motion Variation;0;;1,0.6677485,0.07352942,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1504;-6272,-1536;Float;False;1663.898;100;Global Tint;0;;1,0.6,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1503;-10112,-768;Float;False;1151.458;100;Cloth // Vertex R = Mask / Vertex R = Variation;0;;1,0.8896552,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1506;-6272,-896;Float;False;1664.89;100;Global Size;0;;0.3602941,0.4705882,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1516;-6272,512;Float;False;1663.898;100;Instancing;0;;1,0,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1496;-6272,-3840;Float;False;1661.688;100;Shader Complexity;0;;0.6137931,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1502;-6272,-2816;Float;False;1664.767;100;Vertex Color;0;;1,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1495;-6272,0;Float;False;1663.898;100;Foliage Tint;0;;1,0.6,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1501;-10112,512;Float;False;1818.832;100;Motion Noise;0;;0.8206897,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1499;-10112,-128;Float;False;1153.288;100;Generic // Vertex R = Mask / Vertex R = Variation;0;;0.2876297,0.5780365,0.9779412,1;0;0
WireConnection;1591;0;1590;0
WireConnection;1591;1;1468;0
WireConnection;1592;0;1591;0
WireConnection;1604;0;1567;0
WireConnection;1604;1;1603;0
WireConnection;1392;0;1393;0
WireConnection;1469;0;1486;0
WireConnection;1472;0;1592;0
WireConnection;1558;0;1565;0
WireConnection;1558;1;1556;0
WireConnection;1474;0;1478;0
WireConnection;1463;0;1433;0
WireConnection;1488;0;1396;0
WireConnection;1397;0;1387;0
WireConnection;1462;0;1395;0
WireConnection;1475;0;1465;0
WireConnection;1466;0;1470;0
WireConnection;1446;0;1371;1
WireConnection;1446;1;1371;1
WireConnection;1605;0;1558;0
WireConnection;1605;1;1604;0
WireConnection;1493;0;1483;0
WireConnection;1429;0;1476;1
WireConnection;1429;1;1476;1
WireConnection;1597;0;1599;0
WireConnection;1473;0;1484;0
WireConnection;1471;0;1425;0
WireConnection;1471;1;1415;3
WireConnection;1471;2;1375;0
WireConnection;1361;0;1429;0
WireConnection;1361;1;1383;0
WireConnection;1361;2;1422;0
WireConnection;1430;0;1382;1
WireConnection;1430;1;1401;0
WireConnection;1430;2;1428;0
WireConnection;1477;0;1371;3
WireConnection;1477;1;1416;0
WireConnection;1406;0;1371;4
WireConnection;1406;1;1399;0
WireConnection;1406;2;1404;0
WireConnection;1606;0;1605;0
WireConnection;1613;171;1616;4
WireConnection;1378;0;1371;2
WireConnection;1378;1;1417;0
WireConnection;1378;2;1404;0
WireConnection;1418;0;1415;1
WireConnection;1418;1;1323;0
WireConnection;1418;2;1425;0
WireConnection;1602;0;1597;0
WireConnection;1413;0;1476;4
WireConnection;1413;1;1485;0
WireConnection;1413;2;1422;0
WireConnection;1631;0;1618;157
WireConnection;1631;1;1632;0
WireConnection;1356;0;1382;4
WireConnection;1356;1;1441;0
WireConnection;1356;2;1428;0
WireConnection;1379;0;1369;4
WireConnection;1379;1;1372;0
WireConnection;1379;2;1435;0
WireConnection;1424;0;1476;3
WireConnection;1424;1;1408;0
WireConnection;1457;0;1476;2
WireConnection;1457;1;1409;0
WireConnection;1457;2;1422;0
WireConnection;1431;0;1415;4
WireConnection;1431;1;1296;0
WireConnection;1431;2;1425;0
WireConnection;1403;0;1446;0
WireConnection;1403;1;1461;0
WireConnection;1403;2;1404;0
WireConnection;1330;0;1369;1
WireConnection;1330;1;1358;0
WireConnection;1330;2;1435;0
WireConnection;1349;0;1320;0
WireConnection;1349;1;1340;0
WireConnection;1315;0;1357;0
WireConnection;1315;1;1288;0
WireConnection;1322;0;1431;0
WireConnection;1322;1;1413;0
WireConnection;1322;2;1379;0
WireConnection;1322;3;1356;0
WireConnection;1322;4;1406;0
WireConnection;1385;0;1394;0
WireConnection;1385;1;1297;0
WireConnection;1617;0;1613;85
WireConnection;1617;1;1613;165
WireConnection;1617;2;1614;0
WireConnection;1481;0;1467;0
WireConnection;1633;0;1631;0
WireConnection;1607;0;1606;0
WireConnection;1607;1;1602;0
WireConnection;1298;0;1418;0
WireConnection;1298;1;1361;0
WireConnection;1298;2;1330;0
WireConnection;1298;3;1430;0
WireConnection;1298;4;1403;0
WireConnection;1304;0;1471;0
WireConnection;1304;1;1457;0
WireConnection;1304;2;1378;0
WireConnection;1448;0;1424;0
WireConnection;1448;1;1477;0
WireConnection;1487;0;1480;0
WireConnection;1464;0;1298;0
WireConnection;1464;1;1285;0
WireConnection;1454;0;1322;0
WireConnection;1454;1;1443;0
WireConnection;1317;0;1304;0
WireConnection;1317;1;1400;0
WireConnection;1334;0;1448;0
WireConnection;1334;1;1319;0
WireConnection;1635;0;1617;0
WireConnection;1635;1;1634;0
WireConnection;1562;4;1607;0
WireConnection;1367;0;1389;0
WireConnection;1367;1;1377;2
WireConnection;1354;0;1455;0
WireConnection;1354;1;1335;0
WireConnection;1354;2;1633;0
WireConnection;1346;0;1291;85
WireConnection;1376;0;1385;0
WireConnection;1376;1;1349;0
WireConnection;1376;2;1315;0
WireConnection;1318;0;1366;0
WireConnection;1318;1;1292;3
WireConnection;1447;0;1419;0
WireConnection;1447;1;1583;85
WireConnection;1286;0;1314;0
WireConnection;1286;1;1384;1
WireConnection;1563;0;1560;0
WireConnection;1563;1;1561;0
WireConnection;1563;3;1562;5
WireConnection;1374;0;1283;0
WireConnection;1374;1;1410;0
WireConnection;1374;3;1286;0
WireConnection;1407;0;1339;0
WireConnection;1407;1;1359;0
WireConnection;1407;3;1318;0
WireConnection;1523;1;1514;0
WireConnection;1523;0;1515;0
WireConnection;1390;4;1464;0
WireConnection;1355;0;1386;0
WireConnection;1355;1;1329;0
WireConnection;1355;3;1367;0
WireConnection;1333;0;1343;0
WireConnection;1333;1;1354;0
WireConnection;1333;2;1628;0
WireConnection;1365;4;1317;0
WireConnection;1325;4;1454;0
WireConnection;1494;0;1305;0
WireConnection;1494;1;1635;0
WireConnection;1494;2;1479;0
WireConnection;1427;0;1380;0
WireConnection;1427;1;1447;0
WireConnection;1427;2;1436;0
WireConnection;1345;0;1302;0
WireConnection;1345;1;1346;0
WireConnection;1345;2;1337;0
WireConnection;1277;4;1376;0
WireConnection;1363;0;1307;0
WireConnection;1363;1;1370;0
WireConnection;1363;3;1388;4
WireConnection;1303;4;1334;0
WireConnection;1311;0;1374;0
WireConnection;1311;1;1355;0
WireConnection;1311;2;1407;0
WireConnection;1311;3;1363;0
WireConnection;1324;0;1280;0
WireConnection;1324;1;1316;0
WireConnection;1324;3;1303;5
WireConnection;1411;0;1275;0
WireConnection;1411;1;1412;0
WireConnection;1411;3;1277;5
WireConnection;1490;0;1491;0
WireConnection;1490;1;1492;0
WireConnection;1490;3;1494;0
WireConnection;1482;0;1420;0
WireConnection;1482;1;1423;0
WireConnection;1482;3;1427;0
WireConnection;1519;0;1518;0
WireConnection;1519;1;1517;0
WireConnection;1519;3;1523;0
WireConnection;1293;0;1287;0
WireConnection;1293;1;1338;0
WireConnection;1293;3;1365;5
WireConnection;1341;0;1347;0
WireConnection;1341;1;1344;0
WireConnection;1341;3;1345;0
WireConnection;1274;0;1282;0
WireConnection;1274;1;1451;0
WireConnection;1274;3;1325;5
WireConnection;1351;0;1327;0
WireConnection;1351;1;1342;0
WireConnection;1351;3;1333;0
WireConnection;1568;0;1563;0
WireConnection;1321;0;1453;0
WireConnection;1321;1;1402;0
WireConnection;1321;3;1390;5
WireConnection;1309;0;1321;0
WireConnection;1564;0;1568;0
WireConnection;1284;0;1411;0
WireConnection;1306;0;1490;0
WireConnection;1368;0;1311;0
WireConnection;1449;0;1324;0
WireConnection;1373;0;1351;0
WireConnection;1440;0;1442;0
WireConnection;1520;0;1519;0
WireConnection;1364;0;1293;0
WireConnection;1313;0;1274;0
WireConnection;1328;0;1341;0
WireConnection;1426;0;1482;0
WireConnection;1437;0;1459;0
WireConnection;1437;1;1439;0
WireConnection;1437;2;1440;0
WireConnection;1526;0;1326;0
WireConnection;1526;1;1524;0
WireConnection;1526;2;1566;0
WireConnection;1438;0;1437;0
WireConnection;1312;0;1362;0
WireConnection;1312;1;1300;0
WireConnection;1312;2;1276;0
WireConnection;1312;3;1289;0
WireConnection;1312;4;1460;0
WireConnection;1450;0;1434;0
WireConnection;1525;0;1299;0
WireConnection;1525;1;1432;0
WireConnection;1525;2;1301;0
WireConnection;1525;3;1381;0
WireConnection;1619;0;1618;157
WireConnection;1290;0;1312;0
WireConnection;1290;1;1525;0
WireConnection;1290;2;1526;0
WireConnection;1572;0;1151;0
WireConnection;616;0;18;4
WireConnection;1278;0;1290;0
WireConnection;1278;1;1273;0
WireConnection;1278;2;1281;0
WireConnection;1573;0;1278;0
WireConnection;1573;1;1572;0
WireConnection;1627;0;1620;0
WireConnection;1627;1;1636;0
WireConnection;1150;0;1278;0
WireConnection;1150;1;1151;0
WireConnection;1547;0;1549;0
WireConnection;1547;1;1548;0
WireConnection;1535;0;1529;0
WireConnection;1535;1;1532;0
WireConnection;1551;4;1537;0
WireConnection;1541;0;1540;0
WireConnection;1541;1;1539;0
WireConnection;1541;3;1551;5
WireConnection;487;0;18;0
WireConnection;1542;0;1541;0
WireConnection;564;0;563;1
WireConnection;564;1;563;2
WireConnection;1508;0;791;0
WireConnection;1508;1;1510;0
WireConnection;1508;2;1509;0
WireConnection;565;0;563;3
WireConnection;565;1;563;4
WireConnection;1574;0;1573;0
WireConnection;1537;0;1536;0
WireConnection;1537;1;1535;0
WireConnection;1537;2;1534;0
WireConnection;1537;3;1544;0
WireConnection;1537;4;1547;0
WireConnection;1544;0;1546;0
WireConnection;1544;1;1545;0
WireConnection;1534;0;1533;0
WireConnection;1534;1;1528;0
WireConnection;1295;0;1414;0
WireConnection;1271;0;1308;0
WireConnection;1580;0;1577;0
WireConnection;1577;0;1578;0
WireConnection;1577;1;1579;0
WireConnection;1444;0;1360;0
WireConnection;1581;0;1583;85
WireConnection;1581;1;1584;85
WireConnection;1581;2;1580;0
WireConnection;1536;0;1530;0
WireConnection;1536;1;1531;0
WireConnection;1222;0;1150;0
WireConnection;575;0;562;0
WireConnection;575;1;565;0
WireConnection;1279;0;1458;0
WireConnection;1626;1;1627;0
WireConnection;1626;2;1513;0
WireConnection;562;0;561;0
WireConnection;562;1;564;0
WireConnection;0;0;1222;0
WireConnection;0;2;1574;0
WireConnection;0;10;1508;0
WireConnection;0;11;1626;0
ASEEND*/
//CHKSM=8227B778A62525A76D00FC5C6C2F7BA175EAA150