Shader "Custom/RefelctionShade"
{
    Properties
    {
        _CubeMap("CubeMap", Cube) = "white" {}
        _Metallic("Metallic", Range(0, 1)) = 0
        _Glossiness("Smoothness", Range(0, 1)) = 0.5
    }
    SubShader
    {
        Tags
        {
            "RenderType" = "Opaque"
        }
        
        CGPROGRAM   
        #pragma surface surf Standard fullforwardshadows

        struct Input
        {
            float2 uv_MainTex;
            float3 worldRefl;
        };
        
        samplerCUBE _CubeMap;
        fixed _Metallic;
        fixed _Glossiness;
        
        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = texCUBE(_CubeMap, IN.worldRefl);
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Albedo = c.rgb;
        }
        
        ENDCG
    }
    FallBack "Diffuse"
}