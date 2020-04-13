/*
 *
 *	Adventure Creator
 *	by Chris Burton, 2013-2019
 *	
 *	"MenuLink.cs"
 * 
 *	This script connects to a Menu Element defined
 *  in the Menu Manager, allowing for 3D, scene-based menus
 * 
 */

#if !UNITY_2017_2_OR_NEWER
#define ALLOW_LEGACY_UI
#endif

using UnityEngine;

namespace AC
{

	/**
	 * Before Unity's UI system was introduced, this component was used to link GameObjects to Menu elements defined in the MenuManager, allowing for 3D menus.
	 * This is now considered outdated, as Unity UIs that render in World Space can now be linked to the MenuManager instead.
	 */
	#if !(UNITY_4_6 || UNITY_4_7 || UNITY_5_0)
	[HelpURL("https://www.adventurecreator.org/scripting-guide/class_a_c_1_1_menu_link.html")]
	#endif
	public class MenuLink : MonoBehaviour
	{

		#region Variables

		/** The name of the associated Menu */
		public string menuName = "";
		/** The name of the associated MenuElement */
		public string elementName = "";
		/** The slot index of the associated MenuElement */
		public int slot = 0;
		/** If True, then any GUIText or TextMesh components will have their text values overridden by that of the associated MenuElement */
		public bool setTextLabels = false;

		protected AC.Menu menu;
		protected MenuElement element;

		#if ALLOW_LEGACY_UI
		protected GUIText _guiText;
		#endif
		protected TextMesh textMesh;

		#endregion


		#region UnityStandards	

		protected void Start ()
		{
			if (string.IsNullOrEmpty (menuName) || string.IsNullOrEmpty (elementName))
			{
				return;
			}

			#if ALLOW_LEGACY_UI
			_guiText = GetComponent <GUIText>();
			#endif
			textMesh = GetComponent <TextMesh>();

			try
			{
				menu = PlayerMenus.GetMenuWithName (menuName);
				element = PlayerMenus.GetElementWithName (menuName, elementName);
			}
			catch
			{
				ACDebug.LogWarning ("Cannot find Menu Element with name: " + elementName + " on Menu: " + menuName);
			}
		}


		protected void FixedUpdate ()
		{
			if (element && setTextLabels)
			{
				int languageNumber = Options.GetLanguage ();
				#if ALLOW_LEGACY_UI
				if (_guiText != null)
				{
					_guiText.text = GetLabel (languageNumber);
				}
				#endif
				if (textMesh != null)
				{
					textMesh.text = GetLabel (languageNumber);
				}
			}
		}


		protected void OnDestroy ()
		{
			element = null;
			menu = null;
		}

		#endregion


		#region PublicFunctions

		/**
		 * <summary>Gets the associated MenuElement's label.</summary>
		 * <param name = "languageNumber">The language index to get the label for.</param>
		 * <returns>The associated MenuElement's label, translated if necessary.</returns>
		 */
		public string GetLabel (int languageNumber)
		{
			if (element)
			{
				return element.GetLabel (slot, languageNumber);
			}

			return "";
		}


		/**
		 * <summary>Checks if the associated MenuElement is currently visible.</summary>
		 * <returns>True if the associatated MenuElement is currently visible.</returns>
		 */
		public bool IsVisible ()
		{
			if (element && menu)
			{
				if (!menu.IsVisible ())
				{
					return false;
				}

				return element.IsVisible;
			}

			return false;
		}


		/**
		 * Simulates the clicking of the associated MenuElement.
		 */
		public void Interact ()
		{
			if (element)
			{
				if (!element.isClickable)
				{
					ACDebug.Log ("Cannot click on " + elementName);
				}

				PlayerMenus.SimulateClick (menuName, element, slot);
			}
		}

		#endregion

	}

}