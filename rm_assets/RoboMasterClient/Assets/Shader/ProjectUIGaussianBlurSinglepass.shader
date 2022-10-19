Shader "Project/UI/GaussianBlurSinglepass" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
		[Toggle(EnableGaussianBlur)] _EnableGaussianBlur ("Enable Gaussian Blur", Float) = 0
	}
	SubShader {
		LOD 100
		Tags { "RenderType" = "Opaque" }
		Pass {
			LOD 100
			Tags { "RenderType" = "Opaque" }
			GpuProgramID 44893
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
						vec4 unused_0_0[3];
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
						vec4 unused_0_0[3];
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
					in  vec2 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					vec2 u_xlat0;
					void main()
					{
					    u_xlat0.xy = vs_TEXCOORD4.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    SV_Target0 = texture(_MainTex, u_xlat0.xy);
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
					float u_xlat3;
					float u_xlat4;
					vec2 u_xlat6;
					bool u_xlatb6;
					vec2 u_xlat7;
					bool u_xlatb7;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.x = (-vs_TEXCOORD1.y) + 1.0;
					    u_xlat0.xy = u_xlat0.xx * vec2(1080.0, 215.995667);
					    u_xlatb6 = u_xlat0.y>=(-u_xlat0.y);
					    u_xlat3 = fract(abs(u_xlat0.y));
					    u_xlat3 = (u_xlatb6) ? u_xlat3 : (-u_xlat3);
					    u_xlat0.x = (-u_xlat3) * 5.00010014 + u_xlat0.x;
					    u_xlat0.y = u_xlat0.x * 0.00092592591;
					    u_xlat6.xy = vs_TEXCOORD1.xx * vec2(1920.0, 383.99231);
					    u_xlatb1 = u_xlat6.y>=(-u_xlat6.y);
					    u_xlat9 = fract(abs(u_xlat6.y));
					    u_xlat9 = (u_xlatb1) ? u_xlat9 : (-u_xlat9);
					    u_xlat6.x = (-u_xlat9) * 5.00010014 + u_xlat6.x;
					    u_xlat0.x = u_xlat6.x * 0.00052083336;
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat1.xy = vs_TEXCOORD1.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat0 = u_xlat0 + u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(0.0591589995, 0.0591589995, 0.0591589995, 0.0591589995);
					    u_xlat1.x = (-vs_TEXCOORD0.y) + 1.0;
					    u_xlat1.xy = u_xlat1.xx * vec2(1080.0, 215.995667);
					    u_xlatb7 = u_xlat1.y>=(-u_xlat1.y);
					    u_xlat4 = fract(abs(u_xlat1.y));
					    u_xlat4 = (u_xlatb7) ? u_xlat4 : (-u_xlat4);
					    u_xlat1.x = (-u_xlat4) * 5.00010014 + u_xlat1.x;
					    u_xlat1.y = u_xlat1.x * 0.00092592591;
					    u_xlat7.xy = vs_TEXCOORD0.xx * vec2(1920.0, 383.99231);
					    u_xlatb2 = u_xlat7.y>=(-u_xlat7.y);
					    u_xlat10 = fract(abs(u_xlat7.y));
					    u_xlat10 = (u_xlatb2) ? u_xlat10 : (-u_xlat10);
					    u_xlat7.x = (-u_xlat10) * 5.00010014 + u_xlat7.x;
					    u_xlat1.x = u_xlat7.x * 0.00052083336;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2.xy = vs_TEXCOORD0.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat1 = u_xlat1 + u_xlat2;
					    u_xlat0 = u_xlat1 * vec4(0.0473707989, 0.0473707989, 0.0473707989, 0.0473707989) + u_xlat0;
					    u_xlat1.x = (-vs_TEXCOORD2.y) + 1.0;
					    u_xlat1.xy = u_xlat1.xx * vec2(1080.0, 215.995667);
					    u_xlatb7 = u_xlat1.y>=(-u_xlat1.y);
					    u_xlat4 = fract(abs(u_xlat1.y));
					    u_xlat4 = (u_xlatb7) ? u_xlat4 : (-u_xlat4);
					    u_xlat1.x = (-u_xlat4) * 5.00010014 + u_xlat1.x;
					    u_xlat1.y = u_xlat1.x * 0.00092592591;
					    u_xlat7.xy = vs_TEXCOORD2.xx * vec2(1920.0, 383.99231);
					    u_xlatb2 = u_xlat7.y>=(-u_xlat7.y);
					    u_xlat10 = fract(abs(u_xlat7.y));
					    u_xlat10 = (u_xlatb2) ? u_xlat10 : (-u_xlat10);
					    u_xlat7.x = (-u_xlat10) * 5.00010014 + u_xlat7.x;
					    u_xlat1.x = u_xlat7.x * 0.00052083336;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2.xy = vs_TEXCOORD2.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat1 = u_xlat1 + u_xlat2;
					    u_xlat0 = u_xlat1 * vec4(0.0473707989, 0.0473707989, 0.0473707989, 0.0473707989) + u_xlat0;
					    u_xlat1.x = (-vs_TEXCOORD3.y) + 1.0;
					    u_xlat1.xy = u_xlat1.xx * vec2(1080.0, 215.995667);
					    u_xlatb7 = u_xlat1.y>=(-u_xlat1.y);
					    u_xlat4 = fract(abs(u_xlat1.y));
					    u_xlat4 = (u_xlatb7) ? u_xlat4 : (-u_xlat4);
					    u_xlat1.x = (-u_xlat4) * 5.00010014 + u_xlat1.x;
					    u_xlat1.y = u_xlat1.x * 0.00092592591;
					    u_xlat7.xy = vs_TEXCOORD3.xx * vec2(1920.0, 383.99231);
					    u_xlatb2 = u_xlat7.y>=(-u_xlat7.y);
					    u_xlat10 = fract(abs(u_xlat7.y));
					    u_xlat10 = (u_xlatb2) ? u_xlat10 : (-u_xlat10);
					    u_xlat7.x = (-u_xlat10) * 5.00010014 + u_xlat7.x;
					    u_xlat1.x = u_xlat7.x * 0.00052083336;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2.xy = vs_TEXCOORD3.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat1 = u_xlat1 + u_xlat2;
					    u_xlat0 = u_xlat1 * vec4(0.0591589995, 0.0591589995, 0.0591589995, 0.0591589995) + u_xlat0;
					    u_xlat1.x = (-vs_TEXCOORD4.y) + 1.0;
					    u_xlat1.xy = u_xlat1.xx * vec2(1080.0, 215.995667);
					    u_xlatb7 = u_xlat1.y>=(-u_xlat1.y);
					    u_xlat4 = fract(abs(u_xlat1.y));
					    u_xlat4 = (u_xlatb7) ? u_xlat4 : (-u_xlat4);
					    u_xlat1.x = (-u_xlat4) * 5.00010014 + u_xlat1.x;
					    u_xlat1.y = u_xlat1.x * 0.00092592591;
					    u_xlat7.xy = vs_TEXCOORD4.xx * vec2(1920.0, 383.99231);
					    u_xlatb2 = u_xlat7.y>=(-u_xlat7.y);
					    u_xlat10 = fract(abs(u_xlat7.y));
					    u_xlat10 = (u_xlatb2) ? u_xlat10 : (-u_xlat10);
					    u_xlat7.x = (-u_xlat10) * 5.00010014 + u_xlat7.x;
					    u_xlat1.x = u_xlat7.x * 0.00052083336;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2.xy = vs_TEXCOORD4.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat1 = u_xlat1 + u_xlat2;
					    u_xlat0 = u_xlat1 * vec4(0.0738805011, 0.0738805011, 0.0738805011, 0.0738805011) + u_xlat0;
					    u_xlat1.x = (-vs_TEXCOORD5.y) + 1.0;
					    u_xlat1.xy = u_xlat1.xx * vec2(1080.0, 215.995667);
					    u_xlatb7 = u_xlat1.y>=(-u_xlat1.y);
					    u_xlat4 = fract(abs(u_xlat1.y));
					    u_xlat4 = (u_xlatb7) ? u_xlat4 : (-u_xlat4);
					    u_xlat1.x = (-u_xlat4) * 5.00010014 + u_xlat1.x;
					    u_xlat1.y = u_xlat1.x * 0.00092592591;
					    u_xlat7.xy = vs_TEXCOORD5.xx * vec2(1920.0, 383.99231);
					    u_xlatb2 = u_xlat7.y>=(-u_xlat7.y);
					    u_xlat10 = fract(abs(u_xlat7.y));
					    u_xlat10 = (u_xlatb2) ? u_xlat10 : (-u_xlat10);
					    u_xlat7.x = (-u_xlat10) * 5.00010014 + u_xlat7.x;
					    u_xlat1.x = u_xlat7.x * 0.00052083336;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2.xy = vs_TEXCOORD5.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat1 = u_xlat1 + u_xlat2;
					    u_xlat0 = u_xlat1 * vec4(0.0591589995, 0.0591589995, 0.0591589995, 0.0591589995) + u_xlat0;
					    u_xlat1.x = (-vs_TEXCOORD6.y) + 1.0;
					    u_xlat1.xy = u_xlat1.xx * vec2(1080.0, 215.995667);
					    u_xlatb7 = u_xlat1.y>=(-u_xlat1.y);
					    u_xlat4 = fract(abs(u_xlat1.y));
					    u_xlat4 = (u_xlatb7) ? u_xlat4 : (-u_xlat4);
					    u_xlat1.x = (-u_xlat4) * 5.00010014 + u_xlat1.x;
					    u_xlat1.y = u_xlat1.x * 0.00092592591;
					    u_xlat7.xy = vs_TEXCOORD6.xx * vec2(1920.0, 383.99231);
					    u_xlatb2 = u_xlat7.y>=(-u_xlat7.y);
					    u_xlat10 = fract(abs(u_xlat7.y));
					    u_xlat10 = (u_xlatb2) ? u_xlat10 : (-u_xlat10);
					    u_xlat7.x = (-u_xlat10) * 5.00010014 + u_xlat7.x;
					    u_xlat1.x = u_xlat7.x * 0.00052083336;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2.xy = vs_TEXCOORD6.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat1 = u_xlat1 + u_xlat2;
					    u_xlat0 = u_xlat1 * vec4(0.0473707989, 0.0473707989, 0.0473707989, 0.0473707989) + u_xlat0;
					    u_xlat1.x = (-vs_TEXCOORD7.y) + 1.0;
					    u_xlat1.xy = u_xlat1.xx * vec2(1080.0, 215.995667);
					    u_xlatb7 = u_xlat1.y>=(-u_xlat1.y);
					    u_xlat4 = fract(abs(u_xlat1.y));
					    u_xlat4 = (u_xlatb7) ? u_xlat4 : (-u_xlat4);
					    u_xlat1.x = (-u_xlat4) * 5.00010014 + u_xlat1.x;
					    u_xlat1.y = u_xlat1.x * 0.00092592591;
					    u_xlat7.xy = vs_TEXCOORD7.xx * vec2(1920.0, 383.99231);
					    u_xlatb2 = u_xlat7.y>=(-u_xlat7.y);
					    u_xlat10 = fract(abs(u_xlat7.y));
					    u_xlat10 = (u_xlatb2) ? u_xlat10 : (-u_xlat10);
					    u_xlat7.x = (-u_xlat10) * 5.00010014 + u_xlat7.x;
					    u_xlat1.x = u_xlat7.x * 0.00052083336;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2.xy = vs_TEXCOORD7.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat1 = u_xlat1 + u_xlat2;
					    u_xlat0 = u_xlat1 * vec4(0.0591589995, 0.0591589995, 0.0591589995, 0.0591589995) + u_xlat0;
					    u_xlat1.x = (-vs_TEXCOORD8.y) + 1.0;
					    u_xlat1.xy = u_xlat1.xx * vec2(1080.0, 215.995667);
					    u_xlatb7 = u_xlat1.y>=(-u_xlat1.y);
					    u_xlat4 = fract(abs(u_xlat1.y));
					    u_xlat4 = (u_xlatb7) ? u_xlat4 : (-u_xlat4);
					    u_xlat1.x = (-u_xlat4) * 5.00010014 + u_xlat1.x;
					    u_xlat1.y = u_xlat1.x * 0.00092592591;
					    u_xlat7.xy = vs_TEXCOORD8.xx * vec2(1920.0, 383.99231);
					    u_xlatb2 = u_xlat7.y>=(-u_xlat7.y);
					    u_xlat10 = fract(abs(u_xlat7.y));
					    u_xlat10 = (u_xlatb2) ? u_xlat10 : (-u_xlat10);
					    u_xlat7.x = (-u_xlat10) * 5.00010014 + u_xlat7.x;
					    u_xlat1.x = u_xlat7.x * 0.00052083336;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat2.xy = vs_TEXCOORD8.xy * vec2(1.0, -1.0) + vec2(0.0, 1.0);
					    u_xlat2 = texture(_MainTex, u_xlat2.xy);
					    u_xlat1 = u_xlat1 + u_xlat2;
					    SV_Target0 = u_xlat1 * vec4(0.0473707989, 0.0473707989, 0.0473707989, 0.0473707989) + u_xlat0;
					    return;
					}"
				}
			}
		}
	}
}