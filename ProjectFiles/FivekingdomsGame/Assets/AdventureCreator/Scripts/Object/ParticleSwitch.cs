/*
 *
 *	Adventure Creator
 *	by Chris Burton, 2013-2019
 *	
 *	"ParticleSwitch.cs"
 * 
 *	This can be used, via the Object: Send Message Action,
 *	to turn its attached particle systems on and off.
 * 
 */

using UnityEngine;

namespace AC
{

	/**
	 * This script provides functions to enable and disable the ParticleSystem component on the GameObject it is attached to.
	 * These functions can be called either through script, or with the "Object: Send message" Action.
	 */
	[AddComponentMenu("Adventure Creator/Misc/Particle switch")]
	#if !(UNITY_4_6 || UNITY_4_7 || UNITY_5_0)
	[HelpURL("https://www.adventurecreator.org/scripting-guide/class_a_c_1_1_particle_switch.html")]
	#endif
	public class ParticleSwitch : MonoBehaviour
	{

		#region Variables

		/** If True, then the Light component will be enabled when the game begins. */
		public bool enableOnStart = false;

		protected ParticleSystem _particleSystem;

		#endregion


		#region UnityStandards
		
		protected void Awake ()
		{
			Switch (enableOnStart);
		}

		#endregion


		#region PublicFunctions		

		/**
		 * Enables the ParticleSystem component on the GameObject this script is attached to.
		 */
		public void TurnOn ()
		{
			Switch (true);
		}
		

		/**
		 * Disables the ParticleSystem component on the GameObject this script is attached to.
		 */
		public void TurnOff ()
		{
			Switch (false);
		}


		/**
		 * Pauses the ParticleSystem component on the GameObject this script is attached to.
		 */
		public void Pause ()
		{
			if (ParticleSystem != null && !ParticleSystem.isPaused)
			{
				ParticleSystem.Pause ();
			}
		}


		/**
		 * Causes the ParticleSystem component on the GameObject to emit its maximum number of particles in one go.
		 */
		public void Interact ()
		{
			if (ParticleSystem != null)
			{
				#if UNITY_5_5_OR_NEWER
				ParticleSystem.Emit (ParticleSystem.main.maxParticles);
				#else
				ParticleSystem.Emit (ParticleSystem.maxParticles);
				#endif
			}
		}

		#endregion


		#region ProtectedFunctions
		
		protected void Switch (bool turnOn)
		{
			if (ParticleSystem != null)
			{
				if (turnOn)
				{
					ParticleSystem.Play ();
				}
				else
				{
					ParticleSystem.Stop ();
				}
			}
		}

		#endregion


		#region GetSet

		/** The ParticleSystem attached to the GameObject */
		protected ParticleSystem ParticleSystem
		{
			get
			{
				if (_particleSystem == null)
				{
					_particleSystem = GetComponent <ParticleSystem>();
					if (_particleSystem == null)
					{
						ACDebug.LogWarning ("No Particle System attached to Particle Switch!", this);
					}
				}
				return _particleSystem;
			}
		}

		#endregion
		
	}

}