using SLua;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

public class LuaManager : BaseManager<LuaManager> {

    private static LuaSvr luaSvr;
    private LuaFunction luaFunction;

    public LuaSvr Init()
    {
        if(luaSvr != null)
        {
            return luaSvr;
        }
        luaSvr = new LuaSvr();
        LuaSvr.mainState.loaderDelegate = MyCustomLoader;

        luaSvr.init(null, () =>
        {
            Debug.Log("初始化");
        });
        return luaSvr;
    }

    private byte[] MyCustomLoader(string fn, ref string absoluteFn)
    {
        Debug.Log("当前文件" + fn);
        string path = Application.dataPath + "/Lua/" + fn + ".lua";
        if (File.Exists(path))
        {
            return File.ReadAllBytes(path);
        }
        else
        {
            Debug.Log("MyCustomeLoader重定向失败");
        }
        return null;
    }
}
