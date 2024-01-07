using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CharacterPortraitsController : MonoBehaviour
{
    #region Self-Initialized variables

    Image _myImage;
    Image MyImage
    {
        get
        {
            if (_myImage == null)
                _myImage = GetComponent<Image>();

            return _myImage;
        }
    }

    #endregion

    [Header("Character Sprites")]
    [SerializeField] Sprite char0_Sprite;
    [SerializeField] Sprite char1_Sprite, char2_Sprite, char3_Sprite, char4_Sprite;

    string activeCharacter = "";

    #region Public Functions

    /// <summary>
    /// Changes the character that is displayed as talking. 
    /// </summary>
    /// <param name="newActiveCharacter">[ -1 = Narration] [ 0 = Executor] [ 1 = Jane] [ 2 = Holden] 
    ///                                  [ 3 = Cole] [ 4 = Lilly]</param>
    public void ChangeActiveCharacter(string newCharacter)
    {
        if (activeCharacter == newCharacter)
            return;

        switch (newCharacter)
        {
            // Narration
            case "":
                MyImage.enabled = false;
                break;

            // Executor (Ben)
            case "Ben":
                MyImage.enabled = true;
                MyImage.sprite = char0_Sprite;
                MyImage.SetNativeSize();
                break;

            // Jane
            case "Jane":
                MyImage.enabled = true;
                MyImage.sprite = char1_Sprite;
                MyImage.SetNativeSize();
                break;

            // Holden
            case "Holden":
                MyImage.enabled = true;
                MyImage.sprite = char2_Sprite;
                MyImage.SetNativeSize();
                break;

            // Cole
            case "Cole":
                MyImage.enabled = true;
                MyImage.sprite = char3_Sprite;
                MyImage.SetNativeSize();
                break;

            // Lilly
            case "Lilly":
                MyImage.enabled = true;
                MyImage.sprite = char4_Sprite;
                MyImage.SetNativeSize();
                break;

            default:
                Debug.LogWarning("Trying to set the Active Character to an invalid character " +
                    "[" + newCharacter + "].");
                MyImage.enabled = false;
                return;
        }

        activeCharacter = newCharacter;
    }

    #endregion
}
