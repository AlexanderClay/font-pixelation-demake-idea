Shader "Hidden/NewImageEffectShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_FontSprite("Texture", 2D) = "white" {}
		_CellSize("Cell Size", Vector) = (0.02, 0.02, 0, 0)
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			/*
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};
			*/
			uniform sampler2D _MainTex;
			uniform sampler2D _FontSprite;

			float4 _CellSize;

			/*
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			*/
			fixed4 frag (v2f_img i) : COLOR
			{
				//half2 n = tex2D(_DisplacementTex, i.uv);

				//float k = Camera.main.aspect;
				//Vector2 count = new Vector2(BlockCount, BlockCount / k);
				//Vector2 size = new Vector2(1.0f / count.x, 1.0f / count.y);

				//float2 blockPos = floor(i.uv * BlockCount);
				//float2 blockCenter = blockPos * BlockSize + BlockSize * 0.5;

				float2 steppedUV = i.uv;

				float screenRatio = 0.5625; // (9 / 16)
				float2 normalizedCellSize = float4(_CellSize.x * screenRatio, _CellSize.y , 0, 0); // normalize: success!

				steppedUV /= normalizedCellSize.xy;
				steppedUV = round(steppedUV);
				steppedUV *= normalizedCellSize.xy;

				//steppedUV *= _ScreenParams.xy;

				fixed4 base = tex2D(_MainTex, steppedUV);

				return base;
			}
			ENDCG
		}
	}
}
