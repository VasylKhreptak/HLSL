Shader "Custom/TextureShade"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Color", Color ) = (1,1,1,1)
        _MetallicTex("MetallicTex", 2D) = "white" {}
        _Metallic("Metallic", Range(0,1)) = 0.0
        _Glossiness("Smoothness", Range(0,1)) = 0.5
        _OcclusionTex("OcclusionTex", 2D) = "white" {}
        _Occlusion("Occlusion", Range(0,1)) = 1.0
        [Normal] _NormalMap("NormalMap", 2D) = "bump" {}
        _NormalScale("Normal Scale", Range(0,1)) = 1.0
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        struct Input
        {
            float2 uv_MainTex;
        };

        sampler2D _MainTex;
        fixed4 _Color;
        fixed _Glossiness;
        sampler2D _MetallicTex;
        fixed _Metallic;
        sampler2D _OcclusionTex;
        fixed _Occlusion;
        sampler2D _NormalMap;
        fixed _NormalScale;

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Alpha = c.a;
            o.Metallic = tex2D(_MetallicTex, IN.uv_MainTex).r * _Metallic;
            o.Smoothness = _Glossiness;
            o.Occlusion = tex2D(_OcclusionTex, IN.uv_MainTex).r * _Occlusion;
            o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_MainTex)) * _NormalScale;
        }
        ENDCG

    }
}