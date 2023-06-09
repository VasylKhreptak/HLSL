Shader "Custom/WorldPositionShader"
{
    Properties {}
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        #pragma target 3.0

        struct Input
        {
            float3 worldPos; 
        };

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            o.Albedo = IN.worldPos;
        }
        ENDCG
    }
    FallBack "Diffuse"
}