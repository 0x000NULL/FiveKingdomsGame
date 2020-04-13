/*
 *
 *	Adventure Creator
 *	by Chris Burton, 2013-2019
 *	
 *	"BackgroundImage.cs"
 * 
 *	The BackgroundImage prefab is used to store a GUITexture for use in background images for 2.5D games.
 * 
 */

#if !UNITY_2017_3_OR_NEWER
#define ALLOW_LEGACY_UI
#endif

#if UNITY_STANDALONE && (UNITY_5 || UNITY_2017_1_OR_NEWER || UNITY_PRO_LICENSE) && !UNITY_2018_2_OR_NEWER
#define ALLOW_MOVIETEXTURES
#endif

#if UNITY_5_6_OR_NEWER && !UNITY_SWITCH
#define ALLOW_VIDEO
#endif

using UnityEngine;
using System.Collections;
#if ALLOW_VIDEO
using UnityEngine.Video;
#endif

namespace AC
{

	/**
	 * Controls a GUITexture for use in background images in 2.5D games.
	 */
	#if !(UNITY_4_6 || UNITY_4_7 || UNITY_5_0)
	[HelpURL("https://www.adventurecreator.org/scripting-guide/class_a_c_1_1_background_image.html")]
	#endif
	public class BackgroundImage : MonoBehaviour
	{

		#region Variables

		#if ALLOW_LEGACY_UI

		public enum BackgroundMethod25D { UnityUI, GUITexture };
		/** How 2.5D backgrounds are renderered (GUITexture, UnityUI) */
		public BackgroundMethod25D backgroundMethod25D = BackgroundMethod25D.GUITexture;
		protected GUITexture _guiTexture;

		#endif


		#if ALLOW_VIDEO

		public enum BackgroundImageSource { Texture, VideoClip };
		/** What type of asset is used as a background (Texture, VideoClip) */
		public BackgroundImageSource backgroundImageSource = BackgroundImageSource.Texture;
		/** The VideoClip to use as a background, if animated */
		public VideoClip backgroundVideo;
		protected VideoPlayer videoPlayer;

		#endif

		/** The Texture to use as a background, if static */
		public Texture backgroundTexture;


		#if ALLOW_MOVIETEXTURES

		/** If True, then any MovieTexture set as the background will be looped */
		public bool loopMovie = true;
		/** If True, then any MovieTexture set as the background will start from the beginning when the associated Camera is activated */
		public bool restartMovieWhenTurnOn = false;

		#endif


		protected float shakeDuration;
		protected float startTime;
		protected float startShakeIntensity;
		protected float shakeIntensity;
		protected Rect originalPixelInset;

		#endregion


		#region UnityStandards

		protected void Awake ()
		{
			#if ALLOW_VIDEO
			PrepareVideo ();
			#endif
			GetBackgroundTexture ();
		}


		protected void OnEnable ()
		{
			if (KickStarter.stateHandler) KickStarter.stateHandler.Register (this);
		}


		protected void Start ()
		{
			if (KickStarter.stateHandler) KickStarter.stateHandler.Register (this);
		}


		protected void OnDisable ()
		{
			if (KickStarter.stateHandler) KickStarter.stateHandler.Unregister (this);
		}

		#endregion


		#region PublicFunctions

		/**
		 * <summary>Sets the background image to a supplied texture</summary>
		 * <param name = "_texture">The texture to set the background image to</param>
		 */
		public void SetImage (Texture2D _texture)
		{
			SetBackgroundTexture (_texture);
		}


		/**
		 * Displays the background image full-screen.
		 */
		public void TurnOn ()
		{
			if (LayerMask.NameToLayer (KickStarter.settingsManager.backgroundImageLayer) == -1)
			{
				ACDebug.LogWarning ("No '" + KickStarter.settingsManager.backgroundImageLayer + "' layer exists - please define one in the Tags Manager.");
			}
			else
			{
				gameObject.layer = LayerMask.NameToLayer (KickStarter.settingsManager.backgroundImageLayer);
			}

			#if ALLOW_LEGACY_UI

			if (backgroundMethod25D == BackgroundMethod25D.GUITexture)
			{
				SetBackgroundCameraFarClipPlane (0.02f);
				if (GUITexture)
				{
					GUITexture.enabled = true;
				}
			}
			else if (backgroundMethod25D == BackgroundMethod25D.UnityUI)
			{
				TurnOnUI ();
			}

			#else

			TurnOnUI ();

			#endif

			#if ALLOW_MOVIETEXTURES

			if (GetBackgroundTexture () && GetBackgroundTexture () is MovieTexture)
			{
				MovieTexture movieTexture = (MovieTexture) GetBackgroundTexture ();
				if (restartMovieWhenTurnOn)
				{
					movieTexture.Stop ();
				}
				movieTexture.loop = loopMovie;
				movieTexture.Play ();
			}

			#endif
		}


		/**
		 * Hides the background image from view.
		 */
		public void TurnOff ()
		{
			gameObject.layer = LayerMask.NameToLayer (KickStarter.settingsManager.deactivatedLayer);

			#if ALLOW_LEGACY_UI

			if (backgroundMethod25D == BackgroundMethod25D.GUITexture)
			{
				if (GUITexture)
				{
					GUITexture.enabled = false;
				}
			}
			else if (backgroundMethod25D == BackgroundMethod25D.UnityUI)
			{
				TurnOffUI ();
			}

			#else

			TurnOffUI ();

			#endif
		}


		/**
		 * <summary>Shakes the background image (within the GUITexture) for an earthquake-like effect.</summary>
		 * <param name = "_shakeIntensity">How intense the shake effect should be</param>
		 * <param name = "_duration">How long the shake effect should last, in seconds</param>
		 */
		public void Shake (float _shakeIntensity, float _duration)
		{
			#if ALLOW_LEGACY_UI

			if (backgroundMethod25D == BackgroundMethod25D.GUITexture && GUITexture)
			{
				if (shakeIntensity > 0f)
				{
					GUITexture.pixelInset = originalPixelInset;
				}
				originalPixelInset = GUITexture.pixelInset;
			}

			#endif

			shakeDuration = _duration;
			startTime = Time.time;
			shakeIntensity = _shakeIntensity;

			startShakeIntensity = shakeIntensity;

			StopCoroutine (UpdateShake ());
			StartCoroutine (UpdateShake ());
		}

		
		#if ALLOW_VIDEO

		public void CancelVideoPlayback ()
		{
			if (videoPlayer != null)
			{
				videoPlayer.Stop ();
			}
			StopCoroutine ("PlayVideoCoroutine");
		}

		#endif

		#endregion


		#region ProtectedFunctions

		protected void TurnOnUI ()
		{
			SetBackgroundCameraFarClipPlane (0.02f);
			BackgroundImageUI.Instance.SetTexture (GetBackgroundTexture ());

			#if ALLOW_VIDEO

			if (Application.isPlaying && backgroundImageSource == BackgroundImageSource.VideoClip)
			{
				StartCoroutine (PlayVideoCoroutine ());
			}

			#endif
		}


		protected void TurnOffUI ()
		{
			#if ALLOW_VIDEO

			if (backgroundImageSource == BackgroundImageSource.VideoClip)
			{
				if (Application.isPlaying)
				{
				
					videoPlayer.Stop ();
					if (videoPlayer.isPrepared)
					{
						if (videoPlayer.texture != null)
						{
							BackgroundImageUI.Instance.ClearTexture (videoPlayer.texture);
						}
						return;
					}
				}
			}

			#endif

			Texture texture = GetBackgroundTexture ();
			if (texture != null)
			{
				BackgroundImageUI.Instance.ClearTexture (texture);
			}
		}


		protected void SetBackgroundCameraFarClipPlane (float value)
		{
			BackgroundCamera backgroundCamera = Object.FindObjectOfType <BackgroundCamera>();
			if (backgroundCamera)
			{
				backgroundCamera.GetComponent <Camera>().farClipPlane = value;
			}
			else
			{
				ACDebug.LogWarning ("Cannot find BackgroundCamera");
			}
		}


		protected IEnumerator UpdateShake ()
		{
			while (shakeIntensity > 0f)
			{
				float _size = Random.Range (0, shakeIntensity) * 0.2f;

				#if ALLOW_LEGACY_UI

				if (backgroundMethod25D == BackgroundMethod25D.GUITexture && GUITexture)
				{
					GUITexture.pixelInset = new Rect
					(
						originalPixelInset.x - Random.Range (0, shakeIntensity) * 0.1f,
						originalPixelInset.y - Random.Range (0, shakeIntensity) * 0.1f,
						originalPixelInset.width + _size,
						originalPixelInset.height + _size
					);
				}
				else if (backgroundMethod25D == BackgroundMethod25D.UnityUI)
				{
					BackgroundImageUI.Instance.SetShakeIntensity (_size);
				}

				#else

				BackgroundImageUI.Instance.SetShakeIntensity (_size);

				#endif

				shakeIntensity = Mathf.Lerp (startShakeIntensity, 0f, AdvGame.Interpolate (startTime, shakeDuration, MoveMethod.Linear, null));

				yield return new WaitForEndOfFrame ();
			}
			
			shakeIntensity = 0f;


			#if ALLOW_LEGACY_UI

			if (backgroundMethod25D == BackgroundMethod25D.GUITexture && GUITexture)
			{
				GUITexture.pixelInset = originalPixelInset;
			}
			else if (backgroundMethod25D == BackgroundMethod25D.UnityUI)
			{
				BackgroundImageUI.Instance.SetShakeIntensity (0f);
			}

			#else

			BackgroundImageUI.Instance.SetShakeIntensity (0f);

			#endif
		}


		protected Texture GetBackgroundTexture ()
		{
			if (backgroundTexture == null)
			{
				#if ALLOW_LEGACY_UI

				if (GUITexture)
				{
					backgroundTexture = GUITexture.texture;
				}

				#endif
			}
			return backgroundTexture;
		}


		protected void SetBackgroundTexture (Texture _texture)
		{
			backgroundTexture = _texture;

			#if ALLOW_LEGACY_UI

			if (GUITexture)
			{
				GUITexture.texture = _texture;
			}

			#endif
		}


		#if ALLOW_VIDEO

		protected IEnumerator PlayVideoCoroutine ()
		{
			foreach (BackgroundImage backgroundImage in KickStarter.stateHandler.BackgroundImages)
			{
				if (backgroundImage != null)
				{
					backgroundImage.CancelVideoPlayback ();
				}
			}
			yield return new WaitForEndOfFrame ();
			
			videoPlayer.Prepare ();
			while (!videoPlayer.isPrepared)
			{
				yield return new WaitForEndOfFrame ();
			}

			videoPlayer.Play ();
			yield return new WaitForEndOfFrame ();
			BackgroundImageUI.Instance.SetTexture (videoPlayer.texture);
		}


		protected void PrepareVideo ()
		{
			if (backgroundImageSource == BackgroundImageSource.VideoClip)
			{
				videoPlayer = GetComponent <VideoPlayer>();
				if (videoPlayer == null)
				{
					videoPlayer = gameObject.AddComponent <VideoPlayer>();
					videoPlayer.isLooping = true;
				}
				videoPlayer.playOnAwake = false;
				videoPlayer.renderMode = VideoRenderMode.APIOnly;
				videoPlayer.clip = backgroundVideo;
				//videoPlayer.Prepare ();
			}
		}

		#endif

		#endregion


		#region GetSet

		#if ALLOW_LEGACY_UI

		public GUITexture GUITexture
		{
			get
			{
				if (_guiTexture == null)
				{
					_guiTexture = GetComponent<GUITexture>();
					if (_guiTexture == null)
					{
						ACDebug.LogWarning (this.name + " has no GUITexture component", this);
					}
				}
				return _guiTexture;
			}
		}

		#endif

		#endregion
		
	}

}