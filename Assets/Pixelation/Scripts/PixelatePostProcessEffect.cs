using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class PixelatePostProcessEffect : MonoBehaviour {

	public Material mat;
	void Start () {
		
	}
	
	private void OnRenderImage (RenderTexture src, RenderTexture dest) {
		//src.c
		Graphics.Blit(src, dest, mat);
	}
}
