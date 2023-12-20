using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class DialogueTextDisplayController : MonoBehaviour, IDialogueTextDisplayable
{
    #region Self-Initialized Properties
    Text MyText
    {
        get
        {
            if(_myText == null)
                _myText = GetComponent<Text>();

            return _myText;
        }
    }
    Text _myText;

    #endregion

    public void DisplayText(string stringToDisplay)
    {
        MyText.text = stringToDisplay;
    }
}
