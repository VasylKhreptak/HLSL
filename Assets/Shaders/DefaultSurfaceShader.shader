Shader "Custom/DefaultSurfaceShader"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _Color("Color", Color) = (1,1,1,1)
        [HDR] _Emission ("Emission", Color) = (0,0,0,1)
        _Gloss("Gloos", Range(0,1) ) = 0.5
        _Specular("Specular", Range(0,1) ) = 0.5
    }

    SubShader     
    {
        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float2 uv_MainTex;
        };

        half3 _Color;
        half3 _Emission;
        half _Gloss;
        half _Specular;
        sampler2D _MainTex;

        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Color.rgb;
            o.Emission = _Emission.rgb;
            o.Gloss = _Gloss;
            o.Specular = _Specular;
        }
        ENDCG
    }

    Fallback "Diffuse"
}