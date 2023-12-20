using Ink.Runtime;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class DialogueOptionsController : MonoBehaviour, IDialogueOptionsDisplayable
{
    Dictionary<Button, Choice> myDictionaryOfChoices = new Dictionary<Button, Choice>();

    // Button References
    [SerializeField] int numberOfExpectedChildButtons = 3; 
    Button[] myButtons;

    private void InitializeButtonReferences()
    {
        Button[] myChildButtons = GetComponentsInChildren<Button>();

        if (myChildButtons.Length != numberOfExpectedChildButtons)
        {
            Debug.LogError("Why do you have " + myChildButtons.Length + " child buttons under " + name + "." +
                "\nThese script requires " + numberOfExpectedChildButtons + " child buttons.");
            return;
        }

        myButtons = new Button[numberOfExpectedChildButtons];

        for (int i = 0; i < myChildButtons.Length; i++)
            myButtons[i] = myChildButtons[i];
    }


    private void Awake()
    {
        InitializeButtonReferences();
        DisableOptions();
    }

    public void DisableOptions()
    {
        foreach (var button in myButtons)
        {
            button.gameObject.SetActive(false);
        }

        myDictionaryOfChoices.Clear();
    }

    public void DisplayOptions(Choice[] options)
    {
        if(options.Length == 0)
        {
            Debug.LogError("You cannot enable 0 options.");
            return;
        }

        if(options.Length == numberOfExpectedChildButtons)
        {
            Debug.LogError("Trying to display more options than availible buttons.");
            return;
        }

        myDictionaryOfChoices = new Dictionary<Button, Choice>();

        for (int i = 0; i < options.Length; i++)
        {
            // Enabling the button.
            Button button = myButtons[i];
            button.gameObject.SetActive(true);

            // Getting the choice.
            Choice choice = options[i];

            // Setting up the choices and stuff.
            myDictionaryOfChoices.Add(button, choice);
            button.GetComponentInChildren<Text>().text = choice.text;
        }
    }
}
