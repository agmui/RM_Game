Shader "Hidden/KlakNDI/Sender" {
	Properties {
		_MainTex ("", 2D) = "" {}
	}
	SubShader {
		Pass {
			GpuProgramID 50094
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_TexelSize;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					vec2 u_xlat4;
					void main()
					{
					    u_xlat0.x = _MainTex_TexelSize.x;
					    u_xlat0.y = 1.0;
					    u_xlat1.y = (-_MainTex_TexelSize.x) * 0.5 + vs_TEXCOORD0.x;
					    u_xlat1.xw = (-vs_TEXCOORD0.yy);
					    u_xlat0.xy = u_xlat0.xy + u_xlat1.yw;
					    u_xlat1.z = u_xlat1.x + 1.0;
					    u_xlat1 = texture(_MainTex, u_xlat1.yz);
					    u_xlat0 = texture(_MainTex, u_xlat0.xy);
					    u_xlat2 = dot(vec3(0.212599993, 0.715200007, 0.0722000003), u_xlat0.xyz);
					    u_xlat0.xz = (-vec2(u_xlat2)) + u_xlat0.zx;
					    u_xlat2 = u_xlat2 * 219.0 + 16.0;
					    SV_Target0.w = u_xlat2 * 0.00392156886;
					    u_xlat0.xy = u_xlat0.xz * vec2(120.715675, 142.24028) + vec2(128.0, 128.0);
					    u_xlat0.xy = u_xlat0.xy * vec2(0.00392156886, 0.00392156886);
					    u_xlat4.x = dot(vec3(0.212599993, 0.715200007, 0.0722000003), u_xlat1.xyz);
					    u_xlat1.xy = (-u_xlat4.xx) + u_xlat1.zx;
					    u_xlat4.x = u_xlat4.x * 219.0 + 16.0;
					    SV_Target0.y = u_xlat4.x * 0.00392156886;
					    u_xlat4.xy = u_xlat1.xy * vec2(120.715675, 142.24028) + vec2(128.0, 128.0);
					    u_xlat0.xy = u_xlat4.xy * vec2(0.00392156886, 0.00392156886) + u_xlat0.xy;
					    SV_Target0.xz = u_xlat0.xy * vec2(0.5, 0.5);
					    return;
					}"
				}
			}
		}
		Pass {
			GpuProgramID 118626
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _MainTex_TexelSize;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat10;
					bool u_xlatb10;
					float u_xlat15;
					void main()
					{
					    u_xlat0.y = vs_TEXCOORD0.y * -1.5 + 1.0;
					    u_xlat0.x = (-_MainTex_TexelSize.x) * 0.5 + vs_TEXCOORD0.x;
					    u_xlat1 = texture(_MainTex, u_xlat0.xy);
					    u_xlat5.x = dot(vec3(0.212599993, 0.715200007, 0.0722000003), u_xlat1.xyz);
					    u_xlat1.xy = (-u_xlat5.xx) + u_xlat1.zx;
					    u_xlat5.x = u_xlat5.x * 219.0 + 16.0;
					    u_xlat2.y = u_xlat5.x * 0.00392156886;
					    u_xlat5.xz = u_xlat1.xy * vec2(120.715675, 142.24028) + vec2(128.0, 128.0);
					    u_xlat0.z = vs_TEXCOORD0.y * -1.5;
					    u_xlat1.xz = _MainTex_TexelSize.xx;
					    u_xlat1.y = float(1.0);
					    u_xlat1.w = float(0.0);
					    u_xlat0.xz = u_xlat0.xz + u_xlat1.xy;
					    u_xlat3 = texture(_MainTex, u_xlat0.xz);
					    u_xlat0.x = dot(vec3(0.212599993, 0.715200007, 0.0722000003), u_xlat3.xyz);
					    u_xlat1.xy = (-u_xlat0.xx) + u_xlat3.zx;
					    u_xlat0.x = u_xlat0.x * 219.0 + 16.0;
					    u_xlat2.w = u_xlat0.x * 0.00392156886;
					    u_xlat0.xz = u_xlat1.xy * vec2(120.715675, 142.24028) + vec2(128.0, 128.0);
					    u_xlat0.xz = u_xlat0.xz * vec2(0.00392156886, 0.00392156886);
					    u_xlat0.xy = u_xlat5.xz * vec2(0.00392156886, 0.00392156886) + u_xlat0.xz;
					    u_xlat2.xz = u_xlat0.xy * vec2(0.5, 0.5);
					    u_xlat0.x = vs_TEXCOORD0.x + vs_TEXCOORD0.x;
					    u_xlat0.x = fract(u_xlat0.x);
					    u_xlat0.x = (-_MainTex_TexelSize.x) * 1.5 + u_xlat0.x;
					    u_xlatb10 = vs_TEXCOORD0.x<0.5;
					    u_xlat10 = (u_xlatb10) ? 0.5 : -0.5;
					    u_xlat15 = (-vs_TEXCOORD0.y) * 3.0 + 3.0;
					    u_xlat0.y = _MainTex_TexelSize.y * u_xlat10 + u_xlat15;
					    u_xlat3 = texture(_MainTex, u_xlat0.xy).wxyz;
					    u_xlatb10 = u_xlat0.y<1.0;
					    u_xlat1.xy = u_xlat1.zw + u_xlat0.xy;
					    u_xlat4 = texture(_MainTex, u_xlat1.xy);
					    u_xlat3.y = u_xlat4.w;
					    u_xlat1.xy = u_xlat1.zw * vec2(2.0, 2.0) + u_xlat0.xy;
					    u_xlat0.xy = u_xlat1.zw * vec2(3.0, 3.0) + u_xlat0.xy;
					    u_xlat4 = texture(_MainTex, u_xlat0.xy);
					    u_xlat3.w = u_xlat4.w;
					    u_xlat1 = texture(_MainTex, u_xlat1.xy);
					    u_xlat3.z = u_xlat1.w;
					    SV_Target0 = (bool(u_xlatb10)) ? u_xlat3 : u_xlat2;
					    return;
					}"
				}
			}
		}
	}
}