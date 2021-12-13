using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.Events;

public class ABManager : BaseManager<ABManager>
{

    private AssetBundle mainAB = null;
    //主包包的配置文件
    private AssetBundleManifest mainifset = null;

    //AB包的路径
    private string PathUrl
    {
        get
        {
            return Application.streamingAssetsPath + "/";
        }
    }

    private string MainABName
    {
        get
        {
#if UNITY_IOS
            return "IOS";
#elif UNITY_ANDROID
            return "Android";
#else
            return "StandaloneWindows";
#endif
        }
    }

    //存储已经加载过的AB包
    private Dictionary<string, AssetBundle> abDic = new Dictionary<string, AssetBundle>();

    //加载AB包
    private void LoadAB(string abName)
    {
        AssetBundle ab;
        //加载AB包
        //加载主包，获取配置文件
        if (mainAB == null)
        {
            mainAB = AssetBundle.LoadFromFile(PathUrl + MainABName);
            mainifset = mainAB.LoadAsset<AssetBundleManifest>("AssetBundleManifest");
        }
        //获取依赖包
        string[] strs = mainifset.GetAllDependencies(abName);
        //加载依赖包
        for (int i = 0; i < strs.Length; i++)
        {
            //不能重复加载
            if (!abDic.ContainsKey(strs[i]))
            {
                ab = AssetBundle.LoadFromFile(PathUrl + strs[i]);
                abDic.Add(strs[i], ab);
            }
        }
        //加载目标包
        if (!abDic.ContainsKey(abName))
        {
            ab = AssetBundle.LoadFromFile(PathUrl + abName);
            abDic.Add(abName, ab);
        }
    }

    #region 同步加载
    public Object LoadRes(string abName, string resName)
    {
        LoadAB(abName);

        //加载资源
        return abDic[abName].LoadAsset(resName);
    }

    //Lua用
    public Object LoadRes(string abName, string resName, System.Type type)
    {
        LoadAB(abName);
        return abDic[abName].LoadAsset(resName, type);
    }

    //C#用
    public T LoadRes<T>(string abName, string resName) where T : Object
    {
        LoadAB(abName);

        //加载资源
        return abDic[abName].LoadAsset<T>(resName);
    }
    #endregion

    #region 异步加载

    public void LoadResAsync(string abName, string resName, UnityAction<Object> callBack)
    {
        StartCoroutine(ReallyLoadResAsync(abName, resName, callBack));
    }

    private IEnumerator ReallyLoadResAsync(string abName, string resName, UnityAction<Object> callBack)
    {
        LoadAB(abName);
        AssetBundleRequest abr = abDic[abName].LoadAssetAsync(resName);
        yield return abr;
        //回调
        callBack(abr.asset);
    }

    public void LoadResAsync(string abName, string resName, System.Type type, UnityAction<Object> callBack)
    {
        StartCoroutine(ReallyLoadResAsync(abName, resName,type ,callBack));
    }

    private IEnumerator ReallyLoadResAsync(string abName, string resName, System.Type type, UnityAction<Object> callBack)
    {
        LoadAB(abName);
        AssetBundleRequest abr = abDic[abName].LoadAssetAsync(resName,type);
        yield return abr;
        //回调
        callBack(abr.asset);
    }

    public void LoadResAsync<T>(string abName, string resName, UnityAction<T> callBack) where T:Object
    {
        StartCoroutine(ReallyLoadResAsync<T>(abName, resName, callBack));
    }

    private IEnumerator ReallyLoadResAsync<T>(string abName, string resName, UnityAction<T> callBack) where T:Object
    {
        LoadAB(abName);
        AssetBundleRequest abr = abDic[abName].LoadAssetAsync<T>(resName);
        yield return abr;
        //回调
        callBack(abr.asset as T);
    }

    #endregion

    #region 卸载AB包
    //单个包卸载
    public void UnLoad(string abName)
    {
        if (abDic.ContainsKey(abName))
        {
            abDic[abName].Unload(false);
            abDic.Remove(abName);
        }
    }

    //所有包卸载
    public void ClearAB()
    {
        AssetBundle.UnloadAllAssetBundles(false);
        abDic.Clear();
        mainAB = null;
        mainifset = null;
    }
    #endregion


}
