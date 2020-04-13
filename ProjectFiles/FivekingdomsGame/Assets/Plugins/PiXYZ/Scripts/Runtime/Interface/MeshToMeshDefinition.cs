using PiXYZ.Plugin4Unity;
using PiXYZ.Utils;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace PiXYZ.Interface
{
    /// <summary>
    /// Sync conversion from Mesh to MeshDefinition
    /// </summary>
    public sealed class MeshToMeshDefinition
    {
        public NativeInterface.MeshDefinition meshDefinition;
        public Mesh mesh;

        public IEnumerator Convert(Mesh mesh, NativeInterface.MaterialDefinition[] materials, bool mirrorX, bool isZup, float scale)
        {
            this.mesh = mesh;

            NativeInterface.Point3List ivertices;
            NativeInterface.ColorAlphaList icolors;
            NativeInterface.Vector3List inormals;
            NativeInterface.Vector3List itangents;
            List<NativeInterface.StylizedLine> lines;
            List<NativeInterface.Point3> lineVertices;
            List<NativeInterface.DressedPoly> dressedPolys;
            List<int> triangles;

            float mirrorXF = (mirrorX ? -1 : 1);

            meshDefinition = new NativeInterface.MeshDefinition();
            meshDefinition.id = mesh.GetInstanceID().ToUInt32();

            if (mesh.subMeshCount != 1 && mesh.subMeshCount != materials.Length)
            {
                throw new Exception("This mesh submesh count isn't coherent with given material array");
            }

            // Bruteforce : vertices for topologies different than mesh are also copied this way, but MeshDefinition has its own buffers for such vertices.
            // Unused vertices are deleted upon interface conversion
            // Same goes for all vertex attributes : normals, tangents, colors, uvs, ...

            // Convert Vertices
            var uvertices = mesh.vertices;
            ivertices = new NativeInterface.Point3List(uvertices.Length);
            if (isZup)
                for (int i = 0; i < uvertices.Length; i++)
                    ivertices[i] = new NativeInterface.Point3 { x = uvertices[i].x / (scale * mirrorXF), y = -uvertices[i].z / scale, z = uvertices[i].y / scale };
            else
                for (int i = 0; i < uvertices.Length; i++)
                    ivertices[i] = new NativeInterface.Point3 { x = uvertices[i].x / (scale * mirrorXF), y = uvertices[i].y / scale, z = uvertices[i].z / scale };

            // Convert Vertex Colors
            var uvertexColors = mesh.colors;
            icolors = new NativeInterface.ColorAlphaList(uvertexColors.Length);
            for (int i = 0; i < uvertexColors.Length; i++)
                icolors[i] = new NativeInterface.ColorAlpha { r = uvertexColors[i].r, g = uvertexColors[i].g, b = uvertexColors[i].b, a = 1 };

            // Convert Normals
            var unormals = mesh.normals;
            inormals = new NativeInterface.Vector3List(unormals.Length);
            if (isZup) {
                for (int i = 0; i < unormals.Length; i++) {
                    unormals[i].Normalize();
                    inormals[i] = new NativeInterface.Point3 { x = unormals[i].x / mirrorXF, y = -unormals[i].z, z = unormals[i].y };
                }
            } else {
                for (int i = 0; i < unormals.Length; i++) {
                    unormals[i].Normalize();
                    inormals[i] = new NativeInterface.Point3 { x = unormals[i].x / mirrorXF, y = unormals[i].y, z = unormals[i].z };
                }
            }

            // Convert Tangents
            var utangents = mesh.tangents;
            itangents = new NativeInterface.Vector3List(utangents.Length);
            if (isZup) {
                for (int i = 0; i < utangents.Length; i++) {
                    utangents[i].Normalize();
                    itangents[i] = new NativeInterface.Point3 { x = utangents[i].x / mirrorXF, y = -utangents[i].z, z = utangents[i].y };
                }
            } else {
                for (int i = 0; i < utangents.Length; i++) {
                    utangents[i].Normalize();
                    itangents[i] = new NativeInterface.Point3 { x = utangents[i].x / mirrorXF, y = utangents[i].y, z = utangents[i].z };
                }
            }

            // Using uvChannels to map. Puts all 8 unity uvs. Can be improved.
            meshDefinition.uvs = new NativeInterface.Point2ListList(8);
            List<int> channels = new List<int>();
            for (int j = 0; j < 8; j++) {
                List<Vector2> uvs = new List<Vector2>();
                mesh.GetUVs(j, uvs);
                meshDefinition.uvs[j] = new NativeInterface.Point2List(uvs.Count);
                if (uvs.Count > 0) {
                    channels.Add(j);
                    for (int i = 0; i < uvs.Count; i++) {
                        meshDefinition.uvs[j].list[i] = new NativeInterface.Point2 { x = uvs[i].x, y = uvs[i].y };
                    }
                }
            }
            meshDefinition.uvChannels = new NativeInterface.IntList(channels.ToArray());

            // Prepare Triangles
            int lineVerticesCount = 0;
            int lineSubmeshCount = 0;
            triangles = new List<int>();
            dressedPolys = new List<NativeInterface.DressedPoly>();
            lineVertices = new List<NativeInterface.Point3>();
            lines = new List<NativeInterface.StylizedLine>();
            var freeVerticesColors = new NativeInterface.Vector3List(0);
            var freeVertices = new NativeInterface.Point3List(0);
            for (int s = 0; s < mesh.subMeshCount; s++) {
                switch (mesh.GetTopology(s)) {
                    case MeshTopology.Triangles:
                        var utriangles = mesh.GetTriangles(s);
                        int firstTriInt = triangles.Count;
                        triangles.AddRange(utriangles);
                        var dressedPoly = new NativeInterface.DressedPoly();
                        dressedPoly.firstTri = firstTriInt / 3;
                        dressedPoly.firstQuad = -1;
                        int triCountInt = (int)mesh.GetIndexCount(s);
                        dressedPoly.triCount = triCountInt / 3;
                        dressedPoly.quadCount = 0;
                        dressedPoly.externalId = (uint)dressedPolys.Count;
                        dressedPoly.material = (materials[s] == null) ? 0 : materials[s].id; // Material to IMaterial to do. Handle in MeshConverter or externally ?
                        dressedPolys.Add(dressedPoly);
                        for (int i = 0; i < triCountInt; i++) {
                            if (!mirrorX || i % 3 == 0)
                                triangles[firstTriInt + i] = utriangles[i];
                            else if (i % 3 == 1)
                                triangles[firstTriInt + i] = utriangles[i + 1];
                            else if (i % 3 == 2)
                                triangles[firstTriInt + i] = utriangles[i - 1];
                        }
                        break;
                    case MeshTopology.Lines:
                        lineSubmeshCount++;
                        var linesSubmesh = mesh.GetSubmesh(s);
                        var line = new NativeInterface.StylizedLine();
                        line.color = new NativeInterface.ColorAlpha();
                        line.color.r = materials[s].albedo.color.r;
                        line.color.g = materials[s].albedo.color.g;
                        line.color.b = materials[s].albedo.color.b;
                        line.color.a = 1;
                        line.lines = new NativeInterface.IntList(linesSubmesh.indices);
                        var vCount = linesSubmesh.verticesData.Length;
                        lineVerticesCount += vCount;
                        if (isZup) {
                            for (int ind = 0; ind < vCount; ind++) {
                                lineVertices.Add(new NativeInterface.Point3 { x = linesSubmesh.verticesData.vertices[ind].x / (scale * mirrorXF), y = -linesSubmesh.verticesData.vertices[ind].z / scale, z = linesSubmesh.verticesData.vertices[ind].y / scale });
                            }
                        } else {
                            for (int ind = 0; ind < vCount; ind++) {
                                lineVertices.Add(new NativeInterface.Point3 { x = linesSubmesh.verticesData.vertices[ind].x / (scale * mirrorXF), y = linesSubmesh.verticesData.vertices[ind].y / scale, z = linesSubmesh.verticesData.vertices[ind].z / scale });
                            }
                        }
                        lines.Add(line);
                        break;
                    case MeshTopology.Points:
                        var pointsSubmesh = mesh.GetSubmesh(s);
                        int offset = freeVertices.length;
                        Array.Resize(ref freeVertices.list, offset + pointsSubmesh.verticesData.Length);
                        if (isZup) {
                            for (int i = 0; i < pointsSubmesh.verticesData.Length; i++) {
                                freeVertices[i + offset] = new NativeInterface.Point3 { x = pointsSubmesh.verticesData.vertices[i].x / (scale * mirrorXF), y = -pointsSubmesh.verticesData.vertices[i].z / scale, z = pointsSubmesh.verticesData.vertices[i].y / scale };
                            }
                        } else {
                            for (int i = 0; i < pointsSubmesh.verticesData.Length; i++) {
                                freeVertices[i + offset] = new NativeInterface.Point3 { x = pointsSubmesh.verticesData.vertices[i].x / (scale * mirrorXF), y = pointsSubmesh.verticesData.vertices[i].y / scale, z = pointsSubmesh.verticesData.vertices[i].z / scale };
                            }
                        }
                        Array.Resize(ref freeVerticesColors.list, offset + pointsSubmesh.verticesData.Length);
                        for (int i = 0; i < pointsSubmesh.verticesData.Length; i++) {
                            freeVerticesColors[i + offset] = new NativeInterface.Point3 { x = 0.00392156862f * pointsSubmesh.verticesData.colors[i].r, y = 0.00392156862f * pointsSubmesh.verticesData.colors[i].g, z = 0.00392156862f * pointsSubmesh.verticesData.colors[i].b };
                        }
                        break;
                }
            }

            meshDefinition.vertices = ivertices;
            meshDefinition.vertexColors = icolors;
            meshDefinition.linesVertices = new NativeInterface.Point3List(lineVertices.ToArray());
            meshDefinition.lines = new NativeInterface.StylizedLineList(lines.ToArray());
            meshDefinition.triangles = new NativeInterface.IntList(triangles.ToArray());
            meshDefinition.dressedPolys = new NativeInterface.DressedPolyList(dressedPolys.ToArray());
            meshDefinition.normals = inormals;
            meshDefinition.tangents = itangents;
            meshDefinition.points = freeVertices;
            meshDefinition.pointsColors = freeVerticesColors;

            yield break;
        }
    }
}