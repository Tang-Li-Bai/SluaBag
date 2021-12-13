using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.U2D;

public class Altas : MonoBehaviour {
    public SpriteAtlas imgs;

    private void Start()
    {
        Debug.Log(imgs.GetSprite("1"));
        Debug.Log(imgs.spriteCount);
    }
}
