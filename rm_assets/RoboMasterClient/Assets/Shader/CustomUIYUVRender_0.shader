Shader "Custom/UI/YUVRender" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
		_UVTex ("Texture", 2D) = "white" {}
		[Toggle(EnableGaussianBlur)] _EnableGaussianBlur ("Enable Gaussian Blur", Float) = 0
	}
	SubShader {
		Pass {
			ZTest Always
			ZWrite Off
			Cull Off
			GpuProgramID 41037
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_TexelSize;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD3;
					out vec2 vs_TEXCOORD4;
					out vec2 vs_TEXCOORD5;
					out vec2 vs_TEXCOORD6;
					out vec2 vs_TEXCOORD7;
					out vec2 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = _MainTex_TexelSize.xy * vec2(-3.0, 3.0) + in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = _MainTex_TexelSize.xy * vec2(0.0, 3.0) + in_TEXCOORD0.xy;
					    vs_TEXCOORD2.xy = _MainTex_TexelSize.xy * vec2(3.0, 3.0) + in_TEXCOORD0.xy;
					    vs_TEXCOORD3.xy = _MainTex_TexelSize.xy * vec2(-3.0, 0.0) + in_TEXCOORD0.xy;
					    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD5.xy = _MainTex_TexelSize.xy * vec2(3.0, 0.0) + in_TEXCOORD0.xy;
					    vs_TEXCOORD6.xy = _MainTex_TexelSize.xy * vec2(-3.0, -3.0) + in_TEXCOORD0.xy;
					    vs_TEXCOORD7.xy = _MainTex_TexelSize.xy * vec2(0.0, -3.0) + in_TEXCOORD0.xy;
					    vs_TEXCOORD8.xy = _MainTex_TexelSize.xy * vec2(3.0, -3.0) + in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "EnableGaussianBlur" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_TexelSize;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD3;
					out vec2 vs_TEXCOORD4;
					out vec2 vs_TEXCOORD5;
					out vec2 vs_TEXCOORD6;
					out vec2 vs_TEXCOORD7;
					out vec2 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    vs_TEXCOORD0.xy = _MainTex_TexelSize.xy * vec2(-3.0, 3.0) + in_TEXCOORD0.xy;
					    vs_TEXCOORD1.xy = _MainTex_TexelSize.xy * vec2(0.0, 3.0) + in_TEXCOORD0.xy;
					    vs_TEXCOORD2.xy = _MainTex_TexelSize.xy * vec2(3.0, 3.0) + in_TEXCOORD0.xy;
					    vs_TEXCOORD3.xy = _MainTex_TexelSize.xy * vec2(-3.0, 0.0) + in_TEXCOORD0.xy;
					    vs_TEXCOORD4.xy = in_TEXCOORD0.xy;
					    vs_TEXCOORD5.xy = _MainTex_TexelSize.xy * vec2(3.0, 0.0) + in_TEXCOORD0.xy;
					    vs_TEXCOORD6.xy = _MainTex_TexelSize.xy * vec2(-3.0, -3.0) + in_TEXCOORD0.xy;
					    vs_TEXCOORD7.xy = _MainTex_TexelSize.xy * vec2(0.0, -3.0) + in_TEXCOORD0.xy;
					    vs_TEXCOORD8.xy = _MainTex_TexelSize.xy * vec2(3.0, -3.0) + in_TEXCOORD0.xy;
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform  sampler2D _MainTex;
					uniform  sampler2D _UVTex;
					in  vec2 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					bvec2 u_xlatb2;
					bvec2 u_xlatb4;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD4.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_UVTex, u_xlat0.xy);
					    u_xlat0 = u_xlat0.yxyx + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat1.x = u_xlat1.w + -0.140000001;
					    u_xlat2 = (-u_xlat0.y) * 0.345499992 + u_xlat1.x;
					    u_xlat0.xw = u_xlat0.xw * vec2(1.40750003, 1.77900004) + u_xlat1.xx;
					    u_xlat2 = (-u_xlat0.z) * 0.716899991 + u_xlat2;
					    u_xlatb4.x = 1.0<u_xlat2;
					    u_xlat2 = (u_xlatb4.x) ? 1.0 : u_xlat2;
					    u_xlatb4.x = u_xlat2<0.0;
					    SV_Target0.y = (u_xlatb4.x) ? 0.0 : u_xlat2;
					    u_xlatb2.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat0.xwxx).xy;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb2.x) ? float(1.0) : u_xlat0.x;
					        hlslcc_movcTemp.y = (u_xlatb2.y) ? float(1.0) : u_xlat0.w;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlatb4.xy = lessThan(u_xlat0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    SV_Target0.x = (u_xlatb4.x) ? float(0.0) : u_xlat0.x;
					    SV_Target0.z = (u_xlatb4.y) ? float(0.0) : u_xlat0.y;
					    SV_Target0.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "EnableGaussianBlur" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					uniform  sampler2D _MainTex;
					uniform  sampler2D _UVTex;
					in  vec2 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec2 vs_TEXCOORD3;
					in  vec2 vs_TEXCOORD4;
					in  vec2 vs_TEXCOORD5;
					in  vec2 vs_TEXCOORD6;
					in  vec2 vs_TEXCOORD7;
					in  vec2 vs_TEXCOORD8;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					bool u_xlatb1;
					vec4 u_xlat2;
					bool u_xlatb2;
					vec4 u_xlat3;
					float u_xlat4;
					bvec2 u_xlatb4;
					float u_xlat5;
					bvec2 u_xlatb5;
					vec2 u_xlat8;
					bvec2 u_xlatb8;
					vec2 u_xlat9;
					bvec2 u_xlatb9;
					float u_xlat12;
					float u_xlat13;
					float u_xlat14;
					void main()
					{
					    u_xlat0.x = (-vs_TEXCOORD0.y) + 1.0;
					    u_xlat0.xy = u_xlat0.xx * vec2(1080.0, 215.995667);
					    u_xlatb8.x = u_xlat0.y>=(-u_xlat0.y);
					    u_xlat4 = fract(abs(u_xlat0.y));
					    u_xlat4 = (u_xlatb8.x) ? u_xlat4 : (-u_xlat4);
					    u_xlat0.x = (-u_xlat4) * 5.00010014 + u_xlat0.x;
					    u_xlat0.y = u_xlat0.x * 0.00092592591;
					    u_xlat8.xy = vs_TEXCOORD0.xx * vec2(1920.0, 383.99231);
					    u_xlatb1 = u_xlat8.y>=(-u_xlat8.y);
					    u_xlat12 = fract(abs(u_xlat8.y));
					    u_xlat12 = (u_xlatb1) ? u_xlat12 : (-u_xlat12);
					    u_xlat8.x = (-u_xlat12) * 5.00010014 + u_xlat8.x;
					    u_xlat0.x = u_xlat8.x * 0.00052083336;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_UVTex, u_xlat0.xy);
					    u_xlat0 = u_xlat0.yxyx + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat1.x = u_xlat1.w + -0.140000001;
					    u_xlat4 = (-u_xlat0.y) * 0.345499992 + u_xlat1.x;
					    u_xlat0.xw = u_xlat0.xw * vec2(1.40750003, 1.77900004) + u_xlat1.xx;
					    u_xlat4 = (-u_xlat0.z) * 0.716899991 + u_xlat4;
					    u_xlatb8.x = 1.0<u_xlat4;
					    u_xlat4 = (u_xlatb8.x) ? 1.0 : u_xlat4;
					    u_xlatb8.x = u_xlat4<0.0;
					    u_xlat1.y = (u_xlatb8.x) ? 0.0 : u_xlat4;
					    u_xlatb4.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat0.xwxx).xy;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb4.x) ? float(1.0) : u_xlat0.x;
					        hlslcc_movcTemp.y = (u_xlatb4.y) ? float(1.0) : u_xlat0.w;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlatb8.xy = lessThan(u_xlat0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat1.x = (u_xlatb8.x) ? float(0.0) : u_xlat0.x;
					    u_xlat1.z = (u_xlatb8.y) ? float(0.0) : u_xlat0.y;
					    u_xlat0.xy = vs_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    u_xlat2 = texture(_MainTex, u_xlat0.xy);
					    u_xlat0 = texture(_UVTex, u_xlat0.xy);
					    u_xlat0 = u_xlat0.yxyx + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat13 = u_xlat2.w + -0.140000001;
					    u_xlat4 = (-u_xlat0.y) * 0.345499992 + u_xlat13;
					    u_xlat0.xw = u_xlat0.xw * vec2(1.40750003, 1.77900004) + vec2(u_xlat13);
					    u_xlat4 = (-u_xlat0.z) * 0.716899991 + u_xlat4;
					    u_xlatb8.x = 1.0<u_xlat4;
					    u_xlat4 = (u_xlatb8.x) ? 1.0 : u_xlat4;
					    u_xlatb8.x = u_xlat4<0.0;
					    u_xlat2.y = (u_xlatb8.x) ? 0.0 : u_xlat4;
					    u_xlatb4.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat0.xwxx).xy;
					    {
					        vec4 hlslcc_movcTemp = u_xlat0;
					        hlslcc_movcTemp.x = (u_xlatb4.x) ? float(1.0) : u_xlat0.x;
					        hlslcc_movcTemp.y = (u_xlatb4.y) ? float(1.0) : u_xlat0.w;
					        u_xlat0 = hlslcc_movcTemp;
					    }
					    u_xlatb8.xy = lessThan(u_xlat0.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat2.x = (u_xlatb8.x) ? float(0.0) : u_xlat0.x;
					    u_xlat2.z = (u_xlatb8.y) ? float(0.0) : u_xlat0.y;
					    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.0473707989, 0.0473707989, 0.0473707989);
					    u_xlat1.x = (-vs_TEXCOORD1.y) + 1.0;
					    u_xlat1.xy = u_xlat1.xx * vec2(1080.0, 215.995667);
					    u_xlatb9.x = u_xlat1.y>=(-u_xlat1.y);
					    u_xlat5 = fract(abs(u_xlat1.y));
					    u_xlat5 = (u_xlatb9.x) ? u_xlat5 : (-u_xlat5);
					    u_xlat1.x = (-u_xlat5) * 5.00010014 + u_xlat1.x;
					    u_xlat1.y = u_xlat1.x * 0.00092592591;
					    u_xlat9.xy = vs_TEXCOORD1.xx * vec2(1920.0, 383.99231);
					    u_xlatb2 = u_xlat9.y>=(-u_xlat9.y);
					    u_xlat13 = fract(abs(u_xlat9.y));
					    u_xlat13 = (u_xlatb2) ? u_xlat13 : (-u_xlat13);
					    u_xlat9.x = (-u_xlat13) * 5.00010014 + u_xlat9.x;
					    u_xlat1.x = u_xlat9.x * 0.00052083336;
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_UVTex, u_xlat1.xy);
					    u_xlat1 = u_xlat1.yxyx + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat2.x = u_xlat2.w + -0.140000001;
					    u_xlat5 = (-u_xlat1.y) * 0.345499992 + u_xlat2.x;
					    u_xlat1.xw = u_xlat1.xw * vec2(1.40750003, 1.77900004) + u_xlat2.xx;
					    u_xlat5 = (-u_xlat1.z) * 0.716899991 + u_xlat5;
					    u_xlatb9.x = 1.0<u_xlat5;
					    u_xlat5 = (u_xlatb9.x) ? 1.0 : u_xlat5;
					    u_xlatb9.x = u_xlat5<0.0;
					    u_xlat2.y = (u_xlatb9.x) ? 0.0 : u_xlat5;
					    u_xlatb5.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat1.xwxx).xy;
					    {
					        vec4 hlslcc_movcTemp = u_xlat1;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? float(1.0) : u_xlat1.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? float(1.0) : u_xlat1.w;
					        u_xlat1 = hlslcc_movcTemp;
					    }
					    u_xlatb9.xy = lessThan(u_xlat1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat2.x = (u_xlatb9.x) ? float(0.0) : u_xlat1.x;
					    u_xlat2.z = (u_xlatb9.y) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = vs_TEXCOORD1.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    u_xlat3 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_UVTex, u_xlat1.xy);
					    u_xlat1 = u_xlat1.yxyx + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat14 = u_xlat3.w + -0.140000001;
					    u_xlat5 = (-u_xlat1.y) * 0.345499992 + u_xlat14;
					    u_xlat1.xw = u_xlat1.xw * vec2(1.40750003, 1.77900004) + vec2(u_xlat14);
					    u_xlat5 = (-u_xlat1.z) * 0.716899991 + u_xlat5;
					    u_xlatb9.x = 1.0<u_xlat5;
					    u_xlat5 = (u_xlatb9.x) ? 1.0 : u_xlat5;
					    u_xlatb9.x = u_xlat5<0.0;
					    u_xlat3.y = (u_xlatb9.x) ? 0.0 : u_xlat5;
					    u_xlatb5.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat1.xwxx).xy;
					    {
					        vec4 hlslcc_movcTemp = u_xlat1;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? float(1.0) : u_xlat1.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? float(1.0) : u_xlat1.w;
					        u_xlat1 = hlslcc_movcTemp;
					    }
					    u_xlatb9.xy = lessThan(u_xlat1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat3.x = (u_xlatb9.x) ? float(0.0) : u_xlat1.x;
					    u_xlat3.z = (u_xlatb9.y) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.0591589995, 0.0591589995, 0.0591589995);
					    u_xlat0.w = 0.0947415978;
					    u_xlat1.w = 0.118317999;
					    u_xlat0 = u_xlat0 + u_xlat1;
					    u_xlat1.x = (-vs_TEXCOORD2.y) + 1.0;
					    u_xlat1.xy = u_xlat1.xx * vec2(1080.0, 215.995667);
					    u_xlatb9.x = u_xlat1.y>=(-u_xlat1.y);
					    u_xlat5 = fract(abs(u_xlat1.y));
					    u_xlat5 = (u_xlatb9.x) ? u_xlat5 : (-u_xlat5);
					    u_xlat1.x = (-u_xlat5) * 5.00010014 + u_xlat1.x;
					    u_xlat1.y = u_xlat1.x * 0.00092592591;
					    u_xlat9.xy = vs_TEXCOORD2.xx * vec2(1920.0, 383.99231);
					    u_xlatb2 = u_xlat9.y>=(-u_xlat9.y);
					    u_xlat13 = fract(abs(u_xlat9.y));
					    u_xlat13 = (u_xlatb2) ? u_xlat13 : (-u_xlat13);
					    u_xlat9.x = (-u_xlat13) * 5.00010014 + u_xlat9.x;
					    u_xlat1.x = u_xlat9.x * 0.00052083336;
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_UVTex, u_xlat1.xy);
					    u_xlat1 = u_xlat1.yxyx + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat2.x = u_xlat2.w + -0.140000001;
					    u_xlat5 = (-u_xlat1.y) * 0.345499992 + u_xlat2.x;
					    u_xlat1.xw = u_xlat1.xw * vec2(1.40750003, 1.77900004) + u_xlat2.xx;
					    u_xlat5 = (-u_xlat1.z) * 0.716899991 + u_xlat5;
					    u_xlatb9.x = 1.0<u_xlat5;
					    u_xlat5 = (u_xlatb9.x) ? 1.0 : u_xlat5;
					    u_xlatb9.x = u_xlat5<0.0;
					    u_xlat2.y = (u_xlatb9.x) ? 0.0 : u_xlat5;
					    u_xlatb5.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat1.xwxx).xy;
					    {
					        vec4 hlslcc_movcTemp = u_xlat1;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? float(1.0) : u_xlat1.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? float(1.0) : u_xlat1.w;
					        u_xlat1 = hlslcc_movcTemp;
					    }
					    u_xlatb9.xy = lessThan(u_xlat1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat2.x = (u_xlatb9.x) ? float(0.0) : u_xlat1.x;
					    u_xlat2.z = (u_xlatb9.y) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = vs_TEXCOORD2.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    u_xlat3 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_UVTex, u_xlat1.xy);
					    u_xlat1 = u_xlat1.yxyx + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat14 = u_xlat3.w + -0.140000001;
					    u_xlat5 = (-u_xlat1.y) * 0.345499992 + u_xlat14;
					    u_xlat1.xw = u_xlat1.xw * vec2(1.40750003, 1.77900004) + vec2(u_xlat14);
					    u_xlat5 = (-u_xlat1.z) * 0.716899991 + u_xlat5;
					    u_xlatb9.x = 1.0<u_xlat5;
					    u_xlat5 = (u_xlatb9.x) ? 1.0 : u_xlat5;
					    u_xlatb9.x = u_xlat5<0.0;
					    u_xlat3.y = (u_xlatb9.x) ? 0.0 : u_xlat5;
					    u_xlatb5.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat1.xwxx).xy;
					    {
					        vec4 hlslcc_movcTemp = u_xlat1;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? float(1.0) : u_xlat1.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? float(1.0) : u_xlat1.w;
					        u_xlat1 = hlslcc_movcTemp;
					    }
					    u_xlatb9.xy = lessThan(u_xlat1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat3.x = (u_xlatb9.x) ? float(0.0) : u_xlat1.x;
					    u_xlat3.z = (u_xlatb9.y) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.0473707989, 0.0473707989, 0.0473707989);
					    u_xlat1.w = 0.0947415978;
					    u_xlat0 = u_xlat0 + u_xlat1;
					    u_xlat1.x = (-vs_TEXCOORD3.y) + 1.0;
					    u_xlat1.xy = u_xlat1.xx * vec2(1080.0, 215.995667);
					    u_xlatb9.x = u_xlat1.y>=(-u_xlat1.y);
					    u_xlat5 = fract(abs(u_xlat1.y));
					    u_xlat5 = (u_xlatb9.x) ? u_xlat5 : (-u_xlat5);
					    u_xlat1.x = (-u_xlat5) * 5.00010014 + u_xlat1.x;
					    u_xlat1.y = u_xlat1.x * 0.00092592591;
					    u_xlat9.xy = vs_TEXCOORD3.xx * vec2(1920.0, 383.99231);
					    u_xlatb2 = u_xlat9.y>=(-u_xlat9.y);
					    u_xlat13 = fract(abs(u_xlat9.y));
					    u_xlat13 = (u_xlatb2) ? u_xlat13 : (-u_xlat13);
					    u_xlat9.x = (-u_xlat13) * 5.00010014 + u_xlat9.x;
					    u_xlat1.x = u_xlat9.x * 0.00052083336;
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_UVTex, u_xlat1.xy);
					    u_xlat1 = u_xlat1.yxyx + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat2.x = u_xlat2.w + -0.140000001;
					    u_xlat5 = (-u_xlat1.y) * 0.345499992 + u_xlat2.x;
					    u_xlat1.xw = u_xlat1.xw * vec2(1.40750003, 1.77900004) + u_xlat2.xx;
					    u_xlat5 = (-u_xlat1.z) * 0.716899991 + u_xlat5;
					    u_xlatb9.x = 1.0<u_xlat5;
					    u_xlat5 = (u_xlatb9.x) ? 1.0 : u_xlat5;
					    u_xlatb9.x = u_xlat5<0.0;
					    u_xlat2.y = (u_xlatb9.x) ? 0.0 : u_xlat5;
					    u_xlatb5.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat1.xwxx).xy;
					    {
					        vec4 hlslcc_movcTemp = u_xlat1;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? float(1.0) : u_xlat1.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? float(1.0) : u_xlat1.w;
					        u_xlat1 = hlslcc_movcTemp;
					    }
					    u_xlatb9.xy = lessThan(u_xlat1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat2.x = (u_xlatb9.x) ? float(0.0) : u_xlat1.x;
					    u_xlat2.z = (u_xlatb9.y) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = vs_TEXCOORD3.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    u_xlat3 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_UVTex, u_xlat1.xy);
					    u_xlat1 = u_xlat1.yxyx + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat14 = u_xlat3.w + -0.140000001;
					    u_xlat5 = (-u_xlat1.y) * 0.345499992 + u_xlat14;
					    u_xlat1.xw = u_xlat1.xw * vec2(1.40750003, 1.77900004) + vec2(u_xlat14);
					    u_xlat5 = (-u_xlat1.z) * 0.716899991 + u_xlat5;
					    u_xlatb9.x = 1.0<u_xlat5;
					    u_xlat5 = (u_xlatb9.x) ? 1.0 : u_xlat5;
					    u_xlatb9.x = u_xlat5<0.0;
					    u_xlat3.y = (u_xlatb9.x) ? 0.0 : u_xlat5;
					    u_xlatb5.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat1.xwxx).xy;
					    {
					        vec4 hlslcc_movcTemp = u_xlat1;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? float(1.0) : u_xlat1.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? float(1.0) : u_xlat1.w;
					        u_xlat1 = hlslcc_movcTemp;
					    }
					    u_xlatb9.xy = lessThan(u_xlat1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat3.x = (u_xlatb9.x) ? float(0.0) : u_xlat1.x;
					    u_xlat3.z = (u_xlatb9.y) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.0591589995, 0.0591589995, 0.0591589995);
					    u_xlat1.w = 0.118317999;
					    u_xlat0 = u_xlat0 + u_xlat1;
					    u_xlat1.x = (-vs_TEXCOORD4.y) + 1.0;
					    u_xlat1.xy = u_xlat1.xx * vec2(1080.0, 215.995667);
					    u_xlatb9.x = u_xlat1.y>=(-u_xlat1.y);
					    u_xlat5 = fract(abs(u_xlat1.y));
					    u_xlat5 = (u_xlatb9.x) ? u_xlat5 : (-u_xlat5);
					    u_xlat1.x = (-u_xlat5) * 5.00010014 + u_xlat1.x;
					    u_xlat1.y = u_xlat1.x * 0.00092592591;
					    u_xlat9.xy = vs_TEXCOORD4.xx * vec2(1920.0, 383.99231);
					    u_xlatb2 = u_xlat9.y>=(-u_xlat9.y);
					    u_xlat13 = fract(abs(u_xlat9.y));
					    u_xlat13 = (u_xlatb2) ? u_xlat13 : (-u_xlat13);
					    u_xlat9.x = (-u_xlat13) * 5.00010014 + u_xlat9.x;
					    u_xlat1.x = u_xlat9.x * 0.00052083336;
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_UVTex, u_xlat1.xy);
					    u_xlat1 = u_xlat1.yxyx + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat2.x = u_xlat2.w + -0.140000001;
					    u_xlat5 = (-u_xlat1.y) * 0.345499992 + u_xlat2.x;
					    u_xlat1.xw = u_xlat1.xw * vec2(1.40750003, 1.77900004) + u_xlat2.xx;
					    u_xlat5 = (-u_xlat1.z) * 0.716899991 + u_xlat5;
					    u_xlatb9.x = 1.0<u_xlat5;
					    u_xlat5 = (u_xlatb9.x) ? 1.0 : u_xlat5;
					    u_xlatb9.x = u_xlat5<0.0;
					    u_xlat2.y = (u_xlatb9.x) ? 0.0 : u_xlat5;
					    u_xlatb5.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat1.xwxx).xy;
					    {
					        vec4 hlslcc_movcTemp = u_xlat1;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? float(1.0) : u_xlat1.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? float(1.0) : u_xlat1.w;
					        u_xlat1 = hlslcc_movcTemp;
					    }
					    u_xlatb9.xy = lessThan(u_xlat1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat2.x = (u_xlatb9.x) ? float(0.0) : u_xlat1.x;
					    u_xlat2.z = (u_xlatb9.y) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = vs_TEXCOORD4.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    u_xlat3 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_UVTex, u_xlat1.xy);
					    u_xlat1 = u_xlat1.yxyx + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat14 = u_xlat3.w + -0.140000001;
					    u_xlat5 = (-u_xlat1.y) * 0.345499992 + u_xlat14;
					    u_xlat1.xw = u_xlat1.xw * vec2(1.40750003, 1.77900004) + vec2(u_xlat14);
					    u_xlat5 = (-u_xlat1.z) * 0.716899991 + u_xlat5;
					    u_xlatb9.x = 1.0<u_xlat5;
					    u_xlat5 = (u_xlatb9.x) ? 1.0 : u_xlat5;
					    u_xlatb9.x = u_xlat5<0.0;
					    u_xlat3.y = (u_xlatb9.x) ? 0.0 : u_xlat5;
					    u_xlatb5.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat1.xwxx).xy;
					    {
					        vec4 hlslcc_movcTemp = u_xlat1;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? float(1.0) : u_xlat1.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? float(1.0) : u_xlat1.w;
					        u_xlat1 = hlslcc_movcTemp;
					    }
					    u_xlatb9.xy = lessThan(u_xlat1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat3.x = (u_xlatb9.x) ? float(0.0) : u_xlat1.x;
					    u_xlat3.z = (u_xlatb9.y) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.0738805011, 0.0738805011, 0.0738805011);
					    u_xlat1.w = 0.147761002;
					    u_xlat0 = u_xlat0 + u_xlat1;
					    u_xlat1.x = (-vs_TEXCOORD5.y) + 1.0;
					    u_xlat1.xy = u_xlat1.xx * vec2(1080.0, 215.995667);
					    u_xlatb9.x = u_xlat1.y>=(-u_xlat1.y);
					    u_xlat5 = fract(abs(u_xlat1.y));
					    u_xlat5 = (u_xlatb9.x) ? u_xlat5 : (-u_xlat5);
					    u_xlat1.x = (-u_xlat5) * 5.00010014 + u_xlat1.x;
					    u_xlat1.y = u_xlat1.x * 0.00092592591;
					    u_xlat9.xy = vs_TEXCOORD5.xx * vec2(1920.0, 383.99231);
					    u_xlatb2 = u_xlat9.y>=(-u_xlat9.y);
					    u_xlat13 = fract(abs(u_xlat9.y));
					    u_xlat13 = (u_xlatb2) ? u_xlat13 : (-u_xlat13);
					    u_xlat9.x = (-u_xlat13) * 5.00010014 + u_xlat9.x;
					    u_xlat1.x = u_xlat9.x * 0.00052083336;
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_UVTex, u_xlat1.xy);
					    u_xlat1 = u_xlat1.yxyx + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat2.x = u_xlat2.w + -0.140000001;
					    u_xlat5 = (-u_xlat1.y) * 0.345499992 + u_xlat2.x;
					    u_xlat1.xw = u_xlat1.xw * vec2(1.40750003, 1.77900004) + u_xlat2.xx;
					    u_xlat5 = (-u_xlat1.z) * 0.716899991 + u_xlat5;
					    u_xlatb9.x = 1.0<u_xlat5;
					    u_xlat5 = (u_xlatb9.x) ? 1.0 : u_xlat5;
					    u_xlatb9.x = u_xlat5<0.0;
					    u_xlat2.y = (u_xlatb9.x) ? 0.0 : u_xlat5;
					    u_xlatb5.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat1.xwxx).xy;
					    {
					        vec4 hlslcc_movcTemp = u_xlat1;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? float(1.0) : u_xlat1.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? float(1.0) : u_xlat1.w;
					        u_xlat1 = hlslcc_movcTemp;
					    }
					    u_xlatb9.xy = lessThan(u_xlat1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat2.x = (u_xlatb9.x) ? float(0.0) : u_xlat1.x;
					    u_xlat2.z = (u_xlatb9.y) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = vs_TEXCOORD5.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    u_xlat3 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_UVTex, u_xlat1.xy);
					    u_xlat1 = u_xlat1.yxyx + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat14 = u_xlat3.w + -0.140000001;
					    u_xlat5 = (-u_xlat1.y) * 0.345499992 + u_xlat14;
					    u_xlat1.xw = u_xlat1.xw * vec2(1.40750003, 1.77900004) + vec2(u_xlat14);
					    u_xlat5 = (-u_xlat1.z) * 0.716899991 + u_xlat5;
					    u_xlatb9.x = 1.0<u_xlat5;
					    u_xlat5 = (u_xlatb9.x) ? 1.0 : u_xlat5;
					    u_xlatb9.x = u_xlat5<0.0;
					    u_xlat3.y = (u_xlatb9.x) ? 0.0 : u_xlat5;
					    u_xlatb5.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat1.xwxx).xy;
					    {
					        vec4 hlslcc_movcTemp = u_xlat1;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? float(1.0) : u_xlat1.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? float(1.0) : u_xlat1.w;
					        u_xlat1 = hlslcc_movcTemp;
					    }
					    u_xlatb9.xy = lessThan(u_xlat1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat3.x = (u_xlatb9.x) ? float(0.0) : u_xlat1.x;
					    u_xlat3.z = (u_xlatb9.y) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.0591589995, 0.0591589995, 0.0591589995);
					    u_xlat1.w = 0.118317999;
					    u_xlat0 = u_xlat0 + u_xlat1;
					    u_xlat1.x = (-vs_TEXCOORD6.y) + 1.0;
					    u_xlat1.xy = u_xlat1.xx * vec2(1080.0, 215.995667);
					    u_xlatb9.x = u_xlat1.y>=(-u_xlat1.y);
					    u_xlat5 = fract(abs(u_xlat1.y));
					    u_xlat5 = (u_xlatb9.x) ? u_xlat5 : (-u_xlat5);
					    u_xlat1.x = (-u_xlat5) * 5.00010014 + u_xlat1.x;
					    u_xlat1.y = u_xlat1.x * 0.00092592591;
					    u_xlat9.xy = vs_TEXCOORD6.xx * vec2(1920.0, 383.99231);
					    u_xlatb2 = u_xlat9.y>=(-u_xlat9.y);
					    u_xlat13 = fract(abs(u_xlat9.y));
					    u_xlat13 = (u_xlatb2) ? u_xlat13 : (-u_xlat13);
					    u_xlat9.x = (-u_xlat13) * 5.00010014 + u_xlat9.x;
					    u_xlat1.x = u_xlat9.x * 0.00052083336;
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_UVTex, u_xlat1.xy);
					    u_xlat1 = u_xlat1.yxyx + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat2.x = u_xlat2.w + -0.140000001;
					    u_xlat5 = (-u_xlat1.y) * 0.345499992 + u_xlat2.x;
					    u_xlat1.xw = u_xlat1.xw * vec2(1.40750003, 1.77900004) + u_xlat2.xx;
					    u_xlat5 = (-u_xlat1.z) * 0.716899991 + u_xlat5;
					    u_xlatb9.x = 1.0<u_xlat5;
					    u_xlat5 = (u_xlatb9.x) ? 1.0 : u_xlat5;
					    u_xlatb9.x = u_xlat5<0.0;
					    u_xlat2.y = (u_xlatb9.x) ? 0.0 : u_xlat5;
					    u_xlatb5.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat1.xwxx).xy;
					    {
					        vec4 hlslcc_movcTemp = u_xlat1;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? float(1.0) : u_xlat1.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? float(1.0) : u_xlat1.w;
					        u_xlat1 = hlslcc_movcTemp;
					    }
					    u_xlatb9.xy = lessThan(u_xlat1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat2.x = (u_xlatb9.x) ? float(0.0) : u_xlat1.x;
					    u_xlat2.z = (u_xlatb9.y) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = vs_TEXCOORD6.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    u_xlat3 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_UVTex, u_xlat1.xy);
					    u_xlat1 = u_xlat1.yxyx + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat14 = u_xlat3.w + -0.140000001;
					    u_xlat5 = (-u_xlat1.y) * 0.345499992 + u_xlat14;
					    u_xlat1.xw = u_xlat1.xw * vec2(1.40750003, 1.77900004) + vec2(u_xlat14);
					    u_xlat5 = (-u_xlat1.z) * 0.716899991 + u_xlat5;
					    u_xlatb9.x = 1.0<u_xlat5;
					    u_xlat5 = (u_xlatb9.x) ? 1.0 : u_xlat5;
					    u_xlatb9.x = u_xlat5<0.0;
					    u_xlat3.y = (u_xlatb9.x) ? 0.0 : u_xlat5;
					    u_xlatb5.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat1.xwxx).xy;
					    {
					        vec4 hlslcc_movcTemp = u_xlat1;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? float(1.0) : u_xlat1.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? float(1.0) : u_xlat1.w;
					        u_xlat1 = hlslcc_movcTemp;
					    }
					    u_xlatb9.xy = lessThan(u_xlat1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat3.x = (u_xlatb9.x) ? float(0.0) : u_xlat1.x;
					    u_xlat3.z = (u_xlatb9.y) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.0473707989, 0.0473707989, 0.0473707989);
					    u_xlat1.w = 0.0947415978;
					    u_xlat0 = u_xlat0 + u_xlat1;
					    u_xlat1.x = (-vs_TEXCOORD7.y) + 1.0;
					    u_xlat1.xy = u_xlat1.xx * vec2(1080.0, 215.995667);
					    u_xlatb9.x = u_xlat1.y>=(-u_xlat1.y);
					    u_xlat5 = fract(abs(u_xlat1.y));
					    u_xlat5 = (u_xlatb9.x) ? u_xlat5 : (-u_xlat5);
					    u_xlat1.x = (-u_xlat5) * 5.00010014 + u_xlat1.x;
					    u_xlat1.y = u_xlat1.x * 0.00092592591;
					    u_xlat9.xy = vs_TEXCOORD7.xx * vec2(1920.0, 383.99231);
					    u_xlatb2 = u_xlat9.y>=(-u_xlat9.y);
					    u_xlat13 = fract(abs(u_xlat9.y));
					    u_xlat13 = (u_xlatb2) ? u_xlat13 : (-u_xlat13);
					    u_xlat9.x = (-u_xlat13) * 5.00010014 + u_xlat9.x;
					    u_xlat1.x = u_xlat9.x * 0.00052083336;
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_UVTex, u_xlat1.xy);
					    u_xlat1 = u_xlat1.yxyx + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat2.x = u_xlat2.w + -0.140000001;
					    u_xlat5 = (-u_xlat1.y) * 0.345499992 + u_xlat2.x;
					    u_xlat1.xw = u_xlat1.xw * vec2(1.40750003, 1.77900004) + u_xlat2.xx;
					    u_xlat5 = (-u_xlat1.z) * 0.716899991 + u_xlat5;
					    u_xlatb9.x = 1.0<u_xlat5;
					    u_xlat5 = (u_xlatb9.x) ? 1.0 : u_xlat5;
					    u_xlatb9.x = u_xlat5<0.0;
					    u_xlat2.y = (u_xlatb9.x) ? 0.0 : u_xlat5;
					    u_xlatb5.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat1.xwxx).xy;
					    {
					        vec4 hlslcc_movcTemp = u_xlat1;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? float(1.0) : u_xlat1.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? float(1.0) : u_xlat1.w;
					        u_xlat1 = hlslcc_movcTemp;
					    }
					    u_xlatb9.xy = lessThan(u_xlat1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat2.x = (u_xlatb9.x) ? float(0.0) : u_xlat1.x;
					    u_xlat2.z = (u_xlatb9.y) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = vs_TEXCOORD7.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    u_xlat3 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_UVTex, u_xlat1.xy);
					    u_xlat1 = u_xlat1.yxyx + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat14 = u_xlat3.w + -0.140000001;
					    u_xlat5 = (-u_xlat1.y) * 0.345499992 + u_xlat14;
					    u_xlat1.xw = u_xlat1.xw * vec2(1.40750003, 1.77900004) + vec2(u_xlat14);
					    u_xlat5 = (-u_xlat1.z) * 0.716899991 + u_xlat5;
					    u_xlatb9.x = 1.0<u_xlat5;
					    u_xlat5 = (u_xlatb9.x) ? 1.0 : u_xlat5;
					    u_xlatb9.x = u_xlat5<0.0;
					    u_xlat3.y = (u_xlatb9.x) ? 0.0 : u_xlat5;
					    u_xlatb5.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat1.xwxx).xy;
					    {
					        vec4 hlslcc_movcTemp = u_xlat1;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? float(1.0) : u_xlat1.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? float(1.0) : u_xlat1.w;
					        u_xlat1 = hlslcc_movcTemp;
					    }
					    u_xlatb9.xy = lessThan(u_xlat1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat3.x = (u_xlatb9.x) ? float(0.0) : u_xlat1.x;
					    u_xlat3.z = (u_xlatb9.y) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.0591589995, 0.0591589995, 0.0591589995);
					    u_xlat1.w = 0.118317999;
					    u_xlat0 = u_xlat0 + u_xlat1;
					    u_xlat1.x = (-vs_TEXCOORD8.y) + 1.0;
					    u_xlat1.xy = u_xlat1.xx * vec2(1080.0, 215.995667);
					    u_xlatb9.x = u_xlat1.y>=(-u_xlat1.y);
					    u_xlat5 = fract(abs(u_xlat1.y));
					    u_xlat5 = (u_xlatb9.x) ? u_xlat5 : (-u_xlat5);
					    u_xlat1.x = (-u_xlat5) * 5.00010014 + u_xlat1.x;
					    u_xlat1.y = u_xlat1.x * 0.00092592591;
					    u_xlat9.xy = vs_TEXCOORD8.xx * vec2(1920.0, 383.99231);
					    u_xlatb2 = u_xlat9.y>=(-u_xlat9.y);
					    u_xlat13 = fract(abs(u_xlat9.y));
					    u_xlat13 = (u_xlatb2) ? u_xlat13 : (-u_xlat13);
					    u_xlat9.x = (-u_xlat13) * 5.00010014 + u_xlat9.x;
					    u_xlat1.x = u_xlat9.x * 0.00052083336;
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_UVTex, u_xlat1.xy);
					    u_xlat1 = u_xlat1.yxyx + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat2.x = u_xlat2.w + -0.140000001;
					    u_xlat5 = (-u_xlat1.y) * 0.345499992 + u_xlat2.x;
					    u_xlat1.xw = u_xlat1.xw * vec2(1.40750003, 1.77900004) + u_xlat2.xx;
					    u_xlat5 = (-u_xlat1.z) * 0.716899991 + u_xlat5;
					    u_xlatb9.x = 1.0<u_xlat5;
					    u_xlat5 = (u_xlatb9.x) ? 1.0 : u_xlat5;
					    u_xlatb9.x = u_xlat5<0.0;
					    u_xlat2.y = (u_xlatb9.x) ? 0.0 : u_xlat5;
					    u_xlatb5.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat1.xwxx).xy;
					    {
					        vec4 hlslcc_movcTemp = u_xlat1;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? float(1.0) : u_xlat1.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? float(1.0) : u_xlat1.w;
					        u_xlat1 = hlslcc_movcTemp;
					    }
					    u_xlatb9.xy = lessThan(u_xlat1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat2.x = (u_xlatb9.x) ? float(0.0) : u_xlat1.x;
					    u_xlat2.z = (u_xlatb9.y) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xy = vs_TEXCOORD8.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    u_xlat3 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_UVTex, u_xlat1.xy);
					    u_xlat1 = u_xlat1.yxyx + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat14 = u_xlat3.w + -0.140000001;
					    u_xlat5 = (-u_xlat1.y) * 0.345499992 + u_xlat14;
					    u_xlat1.xw = u_xlat1.xw * vec2(1.40750003, 1.77900004) + vec2(u_xlat14);
					    u_xlat5 = (-u_xlat1.z) * 0.716899991 + u_xlat5;
					    u_xlatb9.x = 1.0<u_xlat5;
					    u_xlat5 = (u_xlatb9.x) ? 1.0 : u_xlat5;
					    u_xlatb9.x = u_xlat5<0.0;
					    u_xlat3.y = (u_xlatb9.x) ? 0.0 : u_xlat5;
					    u_xlatb5.xy = lessThan(vec4(1.0, 1.0, 0.0, 0.0), u_xlat1.xwxx).xy;
					    {
					        vec4 hlslcc_movcTemp = u_xlat1;
					        hlslcc_movcTemp.x = (u_xlatb5.x) ? float(1.0) : u_xlat1.x;
					        hlslcc_movcTemp.y = (u_xlatb5.y) ? float(1.0) : u_xlat1.w;
					        u_xlat1 = hlslcc_movcTemp;
					    }
					    u_xlatb9.xy = lessThan(u_xlat1.xyxy, vec4(0.0, 0.0, 0.0, 0.0)).xy;
					    u_xlat3.x = (u_xlatb9.x) ? float(0.0) : u_xlat1.x;
					    u_xlat3.z = (u_xlatb9.y) ? float(0.0) : u_xlat1.y;
					    u_xlat1.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.0473707989, 0.0473707989, 0.0473707989);
					    u_xlat1.w = 0.0947415978;
					    SV_Target0 = u_xlat0 + u_xlat1;
					    return;
					}"
				}
			}
		}
	}
}