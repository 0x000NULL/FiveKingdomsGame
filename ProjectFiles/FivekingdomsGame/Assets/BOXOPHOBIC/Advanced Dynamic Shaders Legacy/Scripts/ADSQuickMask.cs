// Advanced Dynamic Shaders
// Cristian Pop - https://boxophobic.com/

using System.Collections.Generic;
using UnityEngine;

[HelpURL("https://docs.google.com/document/d/1PG_9bb0iiFGoi_yQd8IX0K3sMohuWqyq6_qa4AyVpFw/edit#heading=h.nnme6fkgscpz")]
[DisallowMultipleComponent]
[ExecuteInEditMode]
public class ADSQuickMask : MonoBehaviour
{

	#if UNITY_EDITOR
	public bool warningMissingADSMesh = false;
	#endif

	private Mesh sharedMesh;

	void Awake ()
    {        

        #if UNITY_EDITOR
        warningMissingADSMesh = false;

        if (gameObject.GetComponent<MeshFilter>() == null || gameObject.GetComponent<MeshFilter>().sharedMesh == null)
        {
            warningMissingADSMesh = true;
            return;
        }
        #endif

        sharedMesh = gameObject.GetComponent<MeshFilter>().sharedMesh;

        if (sharedMesh.name.Contains("ADSPacked") == true)
        {
            return;
        }
        else
        {
            VertexPosToTexCoord4(sharedMesh);
        }

    }

    // Copy vertex position to vertex color
    // Packed this way to keep compatibility with the old script
    void VertexPosToTexCoord4(Mesh inputMesh)
    {

        var localPos = new List<Vector3>();

        for (int i = 0; i < inputMesh.vertices.Length; i++)
        {
            localPos.Add(new Vector3(inputMesh.vertices[i].x, inputMesh.vertices[i].y, inputMesh.vertices[i].z));
        }

        inputMesh.SetUVs(3, localPos);
        inputMesh.name = sharedMesh.name + " (ADSPacked QuickMask)";

        localPos.Clear();

    }
}
