using SLua;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

[CustomLuaClass]
public class AddLua : MonoBehaviour
{
    public string luaName;

    LuaSvr luaSvr;
    

    private void Start()
    {
        luaSvr = LuaManager.Instance.Init();

        luaSvr.start(luaName);

    }
}
