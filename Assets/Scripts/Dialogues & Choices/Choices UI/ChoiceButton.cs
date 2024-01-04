using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using Ink.Runtime;

[RequireComponent(typeof(Button))]
public class ChoiceButton : MonoBehaviour
{
    #region Self-Initialized Variables

    Button _myButton;
    public Button MyButton
    {
        get
        {
            if (_myButton == null)
                _myButton = GetComponent<Button>();

            return _myButton;
        }
    }


    Text _myButtonText;
    Text MyButtonText
    {
        get
        {
            if (_myButtonText == null)
                _myButtonText = GetComponentInChildren<Text>();

            return _myButtonText;
        }
    }

    #endregion


    public Choice currentChoice = null;

    public void PressButton()
    {
        if(currentChoice == null)
        {
            Debug.LogError(transform.name + " was pressed but no current Choice has been Applied to it.");
            return;
        }

        DialogueManager.instance.ChoiceMade(currentChoice);
    }

    public void ApplyNewChoice(Choice newChoice)
    {
        currentChoice = newChoice;

        if(newChoice != null)
            MyButtonText.text = newChoice.text;
    }
}
