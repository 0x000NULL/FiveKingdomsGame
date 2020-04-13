using PiXYZ.Plugin4Unity;
using System;
using UnityEngine;

namespace PiXYZ.Interface {

    public static class InterfaceExtensions {

        #region Matrices
        public static Vector3 ExtractTranslationFromMatrix(Matrix4x4 matrix, bool zup = false, bool mirrorX = false) {
            Vector3 translate;
            translate.x = mirrorX ? -matrix.m03 : matrix.m03;
            translate.y = zup ? matrix.m23 : matrix.m13;
            translate.z = zup ? -matrix.m13 : matrix.m23;
            return translate;
        }

        public static Quaternion QuaternionFromMatrix(Matrix4x4 matrix) {
            float s = 0.0f;
            float[] q = new float[4];
            q[0] = q[1] = q[2] = q[3] = 0;
            float trace = matrix.m00 + matrix.m11 + matrix.m22;
            if (trace > 0.000001f) {
                s = (float)Math.Sqrt(trace + 1.0);
                q[3] = s * 0.5f;
                s = 0.5f / s;
                q[0] = (matrix.m21 - matrix.m12) * s;
                q[1] = (matrix.m02 - matrix.m20) * s;
                q[2] = (matrix.m10 - matrix.m01) * s;
            } else {
                int i = 0, j = 0, k = 0;
                if (matrix.m11 > matrix.m00)
                    i = 1;
                if (matrix.m22 > matrix[i, i])
                    i = 2;
                j = (i + 1) % 3;
                k = (j + 1) % 3;
                s = (float)Math.Sqrt(matrix[i, i] - (matrix[j, j] + matrix[k, k]) + 1.0);
                q[i] = s * 0.5f;
                s = 0.5f / s;
                q[3] = (matrix[k, j] - matrix[j, k]) * s;
                q[j] = (matrix[j, i] + matrix[i, j]) * s;
                q[k] = (matrix[k, i] + matrix[i, k]) * s;
            }
            return new Quaternion(q[0], q[1], q[2], q[3]);
        }

        public static Matrix4x4 ExtractMatrixFromRotation(Quaternion q) {
            Matrix4x4 m = new Matrix4x4();

            float sqx = q.x * q.x;
            float sqw = q.w * q.w;
            float sqy = q.y * q.y;
            float sqz = q.z * q.z;

            // invs (inverse square length) is only required if quaternion is not already normalised
            float invs = 1 / (sqx + sqy + sqz + sqw);
            m.m00 = (sqx - sqy - sqz + sqw) * invs; // since sqw + sqx + sqy + sqz =1/invs*invs
            m.m11 = (-sqx + sqy - sqz + sqw) * invs;
            m.m22 = (-sqx - sqy + sqz + sqw) * invs;

            float tmp1 = q.x * q.y;
            float tmp2 = q.z * q.w;
            m.m10 = 2.0f * (tmp1 + tmp2) * invs;
            m.m01 = 2.0f * (tmp1 - tmp2) * invs;

            tmp1 = q.x * q.z;
            tmp2 = q.y * q.w;
            m.m20 = 2.0f * (tmp1 - tmp2) * invs;
            m.m02 = 2.0f * (tmp1 + tmp2) * invs;
            tmp1 = q.y * q.z;
            tmp2 = q.x * q.w;
            m.m21 = 2.0f * (tmp1 + tmp2) * invs;
            m.m12 = 2.0f * (tmp1 - tmp2) * invs;
            m.m33 = 1f;
            return m;
        }

        public static Quaternion ExtractRotationFromMatrix(Matrix4x4 matrix, Vector3 scale) {
            Matrix4x4 scale_m = Matrix4x4.identity;
            scale_m.m00 = scale.x;
            scale_m.m11 = scale.y;
            scale_m.m22 = scale.z;

            Matrix4x4 copy = matrix;
            copy.m03 = 0.0f;
            copy.m13 = 0.0f;
            copy.m23 = 0.0f;
            Matrix4x4 rotation = copy * scale_m.inverse;

            return QuaternionFromMatrix(rotation);
        }

        private static float ExtractDeterminant(Matrix4x4 matrix) {
            float det = matrix.m00 * (matrix.m11 * matrix.m22 - matrix.m12 * matrix.m21) -
                        matrix.m10 * (matrix.m01 * matrix.m22 - matrix.m02 * matrix.m21) +
                        matrix.m20 * (matrix.m01 * matrix.m12 - matrix.m02 * matrix.m11);
            return det;
        }

        private static Vector3 ExtractScaleFromMatrix(Matrix4x4 matrix) {
            Vector3 scale;
            scale.x = matrix.MultiplyVector(new Vector3(1, 0, 0)).magnitude;
            scale.y = matrix.MultiplyVector(new Vector3(0, 1, 0)).magnitude;
            scale.z = matrix.MultiplyVector(new Vector3(0, 0, 1)).magnitude;

            if (ExtractDeterminant(matrix) < 0)
                scale = -scale;

            return scale;
        }

        public static void SetTransformFromWorldMatrix(Transform transform, Matrix4x4 matrix, float scale = 1f, bool zup = false, bool mirrorX = false) {
            transform.localScale = ExtractScaleFromMatrix(matrix);
            transform.position = ExtractTranslationFromMatrix(matrix, zup, mirrorX);
            transform.position *= scale;
            transform.rotation = ExtractRotationFromMatrix(matrix, transform.localScale);
            if (zup)
                transform.rotation = new Quaternion(transform.rotation.x, transform.rotation.z, -transform.rotation.y, transform.rotation.w);
            if (mirrorX)
                transform.rotation = new Quaternion(transform.rotation.x, -transform.rotation.y, -transform.rotation.z, transform.rotation.w);
            if (zup)
                transform.localScale = new Vector3(transform.localScale.x, transform.localScale.z, transform.localScale.y);
        }

        public static void SetTransformFromMatrix(Transform transform, Matrix4x4 matrix, float scale = 1f, bool zup = false, bool mirrorX = false) {
            transform.localScale = ExtractScaleFromMatrix(matrix);
            transform.localPosition = ExtractTranslationFromMatrix(matrix, zup, mirrorX);
            transform.localPosition *= scale;
            transform.localRotation = ExtractRotationFromMatrix(matrix, transform.localScale);
            if (zup)
                transform.localRotation = new Quaternion(transform.localRotation.x, transform.localRotation.z, -transform.localRotation.y, transform.localRotation.w);
            if (mirrorX)
                transform.localRotation = new Quaternion(transform.localRotation.x, -transform.localRotation.y, -transform.localRotation.z, transform.localRotation.w);
            if (zup)
                transform.localScale = new Vector3(transform.localScale.x, transform.localScale.z, transform.localScale.y);
        }
        #endregion

        #region Materials
        private static bool Equals(this NativeInterface.ColorAlpha c1, NativeInterface.ColorAlpha c2) {
            return c1.r == c2.r && c1.g == c2.g && c1.b == c2.b && c1.a == c2.a;
        }

        private static string Id(this NativeInterface.ColorAlpha c) {
            var color = new Color((float)c.r, (float)c.g, (float)c.b, (float)c.a);
            return "#" + ColorUtility.ToHtmlStringRGBA(color);
        }
        #endregion
    }
}