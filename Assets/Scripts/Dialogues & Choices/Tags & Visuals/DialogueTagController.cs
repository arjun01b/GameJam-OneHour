using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DialogueTagController : MonoBehaviour, IInkTagActionable
{
    [Header("References")]
    [SerializeField] CharacterNameController characterNameController;
    [SerializeField] CharacterPortraitsController characterPortraitsController;
    
    #region Self-Initialized Variables

    List<string> _myCharactersList;
    List<string> MyCharactersList
    {
        get
        {
            if (_myCharactersList == null)
                _myCharactersList = DialogueManager.instance.characterNames;

            return _myCharactersList;
        }
    }

    #endregion

    public void ActOnTag(string key, string value = "")
    {
        switch (key)
        {
            case "character":
                if (value == "" || MyCharactersList.Contains(value))
                {
                    HandleNewCharacter(value);
                    break;
                }
                Debug.LogError("Character name [" + value + "] not recognised in the Tag Controller.");
                break;

            default:
                Debug.LogError("Key [" + key + "] not implemented. Cannot perform expected action.");
                break;
        }
    }

    #region Character Changes

    private void HandleNewCharacter(string newCharacter)
    {
        ChangeDialogueName();
        ChangeCharacterSprite();

        void ChangeDialogueName()
        {
            if (newCharacter == "")
            {
                characterNameController.SetTransparencyOfCharacterName(false);
                return;
            }
            // Else
            characterNameController.SetTransparencyOfCharacterName(true);
            characterNameController.SetCharacterName(newCharacter);
        }
        void ChangeCharacterSprite()
        {
            characterPortraitsController.ChangeActiveCharacter(newCharacter);
        }
    }

    #endregion
}
