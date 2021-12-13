using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using SLua;

[CustomLuaClass]
public class LoadToLua {
    public ABManager ABManager = ABManager.Instance;
    public Sprite LoadSprite(string path)
    {
        return Resources.Load<Sprite>(path);
    }
}
