using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ABTest : MonoBehaviour {


    //[MenuItem("AssetBundle/Build Windows")]
    //static void BuildAssetBundle()
    //{
    //    string outputPath = Application.streamingAssetsPath;

    //    if (!Directory.Exists(outputPath))
    //    {
    //        Directory.CreateDirectory(outputPath);
    //    }

    //    List<AssetBundleBuild> builds = new List<AssetBundleBuild>();
    //    AssetBundleBuild build = new AssetBundleBuild();
    //    build.assetBundleName = "panel";
    //    build.assetBundleVariant = "unity3d";
    //    build.assetNames = new string[] { "Assets/Resources/UI/MainPanel.prefab" };

    //    builds.Add(build);

    //    BuildPipeline.BuildAssetBundles(outputPath,builds.ToArray(),BuildAssetBundleOptions.None, BuildTarget.StandaloneWindows64);
    //}

    private void Start()
    {
        ////同步加载
        ////先加载AB包
        //AssetBundle ab = AssetBundle.LoadFromFile(Application.streamingAssetsPath + "/" + "panel");

        ////获取依赖包
        ////加载主包
        //AssetBundle abMain = AssetBundle.LoadFromFile(Application.streamingAssetsPath + "/StandaloneWindows");
        //AssetBundleManifest abManifset = abMain.LoadAsset<AssetBundleManifest>("AssetBundleManifest");
        ////得到依赖包的名字
        //string[] strs = abManifset.GetAllDependencies("panel");
        //for (int i = 0; i < strs.Length; i++)
        //{
        //    AssetBundle.LoadFromFile(Application.streamingAssetsPath + "/" + strs[i]);
        //}

        ////加载资源
        //GameObject obj = ab.LoadAsset("BagPanel", typeof(GameObject)) as GameObject;
        //Instantiate(obj,transform,true);

        GameObject obj = ABManager.Instance.LoadRes("panel", "BagPanel",typeof(GameObject)) as GameObject;
        GameObject obj1 = ABManager.Instance.LoadRes<GameObject>("panel", "BagPanel");
        Object obj2 = ABManager.Instance.LoadRes("panel", "BagPanel");
        Instantiate(obj, transform, true);

        ABManager.Instance.LoadResAsync("panel", "MainPanel", typeof(GameObject),(a)=> { Instantiate(a, transform, true); });
        ABManager.Instance.LoadResAsync("panel", "MainPanel", typeof(GameObject),(a)=> { Instantiate(a, transform, true); });
    }

    //异步加载
    IEnumerator LoadABRes(string ABName,string resName)
    {
        //加载AB包
        AssetBundleCreateRequest abcr = AssetBundle.LoadFromFileAsync(Application.streamingAssetsPath + "/" + ABName);
        yield return abcr;

        AssetBundleRequest abq = abcr.assetBundle.LoadAssetAsync(resName, typeof(GameObject));
        yield return abq;
        //abq.asset as GameObject;
    }
}
