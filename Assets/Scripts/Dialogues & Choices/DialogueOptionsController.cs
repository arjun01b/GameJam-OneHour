using Ink.Runtime;
using System.Collections.Generic;
using UnityEngine;

public class DialogueOptionsController : MonoBehaviour, IDialogueOptionsDisplayable
{
    // Button References
    [SerializeField] int numberOfExpectedChildButtons = 3; 
    ChoiceButton[] myChoiceButtons;

    private void InitializeButtonReferences()
    {
        ChoiceButton[] myChildChoiceButtons = GetComponentsInChildren<ChoiceButton>();

        if (myChildChoiceButtons.Length != numberOfExpectedChildButtons)
        {
            Debug.LogError("Why do you have " + myChildChoiceButtons.Length + " child buttons under " + name + "." +
                "\nThis script requires " + numberOfExpectedChildButtons + " child buttons.");
            return;
        }

        myChoiceButtons = new ChoiceButton[numberOfExpectedChildButtons];

        for (int i = 0; i < myChildChoiceButtons.Length; i++)
            myChoiceButtons[i] = myChildChoiceButtons[i];
    }


    private void Awake()
    {
        InitializeButtonReferences();
        DisableOptions();
    }

    public void DisableOptions()
    {
        foreach (var button in myChoiceButtons)
        {
            button.gameObject.SetActive(false);
        }
    }

    public void DisplayOptions(Choice[] choicesToDisplay)
    {
        if(choicesToDisplay.Length == 0)
        {
            Debug.LogError("You cannot enable 0 choice buttons.");
            return;
        }

        if(choicesToDisplay.Length > numberOfExpectedChildButtons)
        {
            Debug.LogError("Trying to display more choices than availible buttons.");
            return;
        }


        for (int i = 0; i < choicesToDisplay.Length; i++)
        {
            // Enabling the button.
            ChoiceButton choiceButton = myChoiceButtons[i];
            choiceButton.gameObject.SetActive(true);

            // Getting the choice.
            Choice newChoice = choicesToDisplay[i];
            choiceButton.ApplyNewChoice(newChoice);
        }
    }


    #region Managing Button and Text Size



    #endregion
}
