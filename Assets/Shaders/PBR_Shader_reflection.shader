Shader "Custom/PBR_Shader_reflection"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _BaseColor ("Base Color", Color) = (1,1,1,1)
        _MetallicMap ("Metallic Map", 2D) = "white" {}
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _SmoothnessMap ("Smoothness Map", 2D) = "white" {}
        _Smoothness ("Smoothness", Range(0,1)) = 0.5
        [Normal] _NormalMap ("Normal Map", 2D) = "bump" {}
        _NormalScale ("Normal Scale", float) = 1.0
        _OcclusionMap ("Occlusion Map", 2D) = "white" {}
        _OcclusionStrength ("Occlusion Strength", Range(0,1)) = 1.0
        _reflectionMap ("Reflection Map", 2D) = "white" {}
        _reflectionMapStrength ("Reflection Map Strength", Range(0,1)) = 1.0
        _reflectionStrength ("Reflection Strength", Range(0,1)) = 1.0
        _ReflectionCube ("Reflection Cubemap", Cube) = "_Skybox" {}
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        #pragma target 3.0

        struct Input
        {
            float2 uv_MainTex;
        };

        sampler2D _MainTex;
        sampler2D _MetallicMap;
        sampler2D _SmoothnessMap;
        sampler2D _NormalMap;
        sampler2D _OcclusionMap;
        samplerCUBE _ReflectionCube;
        sampler2D _reflectionMap;

        fixed4 _BaseColor;
        fixed _Metallic;
        fixed _Smoothness;
        fixed _NormalScale;
        fixed _OcclusionStrength;
        fixed _reflectionStrength;
        fixed _reflectionMapStrength;

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _BaseColor;
            o.Metallic = tex2D(_MetallicMap, IN.uv_MainTex).r * _Metallic;
            o.Smoothness = tex2D(_SmoothnessMap, IN.uv_MainTex).r * _Smoothness;
            o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_MainTex)) * _NormalScale;
            o.Occlusion = tex2D(_OcclusionMap, IN.uv_MainTex).r * _OcclusionStrength;
            o.Emission = 0.0;
            o.Alpha = 1.0;

            const fixed3 reflectionMap = tex2D(_reflectionMap, IN.uv_MainTex).r * _reflectionMapStrength;
            const fixed3 reflectionCube = texCUBE(_ReflectionCube, o.Normal).rgb;
            
            const fixed3 reflection = reflectionMap
                * reflectionCube
                * _reflectionStrength;

            o.Albedo += reflection;
        }
        ENDCG
    }
    FallBack "Diffuse"
}