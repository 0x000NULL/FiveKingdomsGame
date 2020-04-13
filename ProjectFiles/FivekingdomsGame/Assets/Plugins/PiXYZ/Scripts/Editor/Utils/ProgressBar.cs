using PiXYZ.Utils;
using UnityEditor;
using UnityEngine;

namespace PiXYZ.Editor {

    public class ProgressBar {

        private static ProgressBar _Instance;

        public VoidHandler canceled;

        private float latestProgress = 0f;
        private float progress = 0f;

        private string previousMessage = null;
        private string message = "";
        private bool closed = false;
        private bool cancelable = false;

        public ProgressBar(bool cancelable) {
            this.cancelable = cancelable;
            Dispatcher.OnUpdate += update;

            // Avoids 2 overlapping progress bars (cancels the previous one)
            if (_Instance != null && !_Instance.closed) {
                _Instance.setProgress(1, null);
                _Instance = null;
            }

            _Instance = this;
        }

        public void setProgress(float progress, string message) {
            this.progress = progress;
            this.message = message;
        }

        private void close() {
            closed = true;
            EditorUtility.ClearProgressBar();
            Dispatcher.OnUpdate -= update;
        }

        private float timeSinceLastRepaint;

        private void update() {

            if (closed)
                return;

            if (latestProgress != progress || previousMessage != message) {
                repaint();
            } else {
                timeSinceLastRepaint += Time.deltaTime;

                if (timeSinceLastRepaint > 1f) {
                    repaint();
                }
            }
        }

        private void repaint() {

            timeSinceLastRepaint = 0f;

            latestProgress = progress;
            previousMessage = message;

            if (progress >= 1f) {
                close();
                return;
            }

            if (cancelable) {
                if (EditorUtility.DisplayCancelableProgressBar("Processing...", message + " " + progress * 100 + "%", progress)) {
                    canceled?.Invoke();
                }
            } else {
                EditorUtility.DisplayProgressBar("Processing...", message + " " + progress * 100 + "%", progress);
            }
        }
    }

    public interface IProgressBar {
        void setProgress(float progress, string message);
        void update();
        void close();
    }
}