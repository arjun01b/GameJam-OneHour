using Ink;
using Ink.Runtime;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class DialogueManager : MonoBehaviour
{
    #region Static Reference

    public static DialogueManager instance;

    void InitializeStaticReference()
    {
        // Setting up the static reference to this script.
        if (instance == null)
            instance = this;
        else
        {
            Debug.LogError("You can't have 2 DialogueManager scripts. " +
                "DialogueManager contains a static reference.");
            Destroy(this);
        }
    }

    #endregion

    [Header("Configuration")]
    [SerializeField] protected bool instantText = true;
    protected enum SpedUpTextSpeed { none, x2, x3, x4, x5, x6, instant };
    [SerializeField] protected SpedUpTextSpeed textSpeedUpMode = SpedUpTextSpeed.x2;

    [Tooltip("If [Instant Text] is disabled, characters in the dialogue text appear at this speed.")]
    [SerializeField] [Range(1, 100)] protected int charactersPerSecond = 15;


    [Header("Supporting Scripts")]
    [SerializeField] protected GameObject dialogueTextScript_Holder;
    [SerializeField] protected GameObject dialogueOptionsScript_Holder;
    [SerializeField] protected GameObject tagManagerScript_Holder;
    protected IDialogueTextDisplayable dialogueTextScript;
    protected IDialogueOptionsDisplayable dialogueOptionsScript;
    protected IInkTagActionable tagManagerScript;


    [Header("Availible Ink Files")]
    [SerializeField] protected TextAsset[] inkFiles;


    [Header("Characters")]
    [SerializeField] protected bool trimCharacterNamesBeforeText;

    [Tooltip("The character names used in the story.")]
    public List<string> characterNames = new List<string>();


    protected virtual void FillScriptReferences()
    {
        if (dialogueTextScript_Holder == null)
        {
            Debug.LogError("dialogueTextScript_Holder cannot be equal to NULL if the DialogueManager is used.");
            return;
        }

        if (dialogueOptionsScript_Holder == null)
        {
            Debug.LogError("dialogueOptionsScript_Holder cannot be equal to NULL if the DialogueManager is used.");
            return;
        }

        if (tagManagerScript_Holder == null)
        {
            Debug.LogError("tagManagerScript_Holder cannot be equal to NULL if the DialogueManager is used.");
            return;
        }

        // The DialogueTextScript
        dialogueTextScript_Holder.TryGetComponent<IDialogueTextDisplayable>(out IDialogueTextDisplayable textScript);
        if(textScript != null)
            dialogueTextScript = textScript;
        else
        {
            Debug.LogError("Could not find a script that implemented IDialogueTextDisplayable inside ["
                + dialogueTextScript_Holder.name + "].");
        }


        // The DialogueOptionsScript
        dialogueOptionsScript_Holder.TryGetComponent<IDialogueOptionsDisplayable>
            (out IDialogueOptionsDisplayable optionsScript);
        if (optionsScript != null)
            dialogueOptionsScript = optionsScript;
        else
        {
            Debug.LogError("Could not find a script that implemented IDialogueOptionsDisplayable inside ["
                + dialogueOptionsScript_Holder.name + "].");
        }

        // The TagManagerScript
        tagManagerScript_Holder.TryGetComponent<IInkTagActionable>(out IInkTagActionable tagScript);
        if (tagScript != null)
            tagManagerScript = tagScript;
        else
        {
            Debug.LogError("Could not find a script that implemented IInkTagActionable inside ["
                + tagManagerScript_Holder.name + "].");
        }
    }


    protected Story activeStory = null;
    public bool isDialogueActive { get => activeStory == null; }


    private void Awake()
    {
        InitializeStaticReference();
        FillScriptReferences();
    }


    #region Story Controls

    /// <summary>
    /// Called when users click to continue our story. If users are not using instant text and the text display 
    /// is not yet complete, this will speed it up.
    /// </summary>
    public virtual void UserClickedContinue()
    {
        // If we don't have text animation, or that animation is over, we can continue our story.
        if (instantText || active_TextDisplay_AnimationCoroutine == null)
        {
            ContinueStory();
            return;
        }

        // If our text display animation is running but we are operation at our regular speed, we speed up.
        if(isTextSpeedingUp == false && textSpeedUpMode != SpedUpTextSpeed.none)
        {
            BeginTextDisplaySpeedUp();
            return;
        }

        // Maybe play a "cannot speed up more" sound here?
    }

    /// <summary>
    /// Sends the next chunck of text or set of options to the Script that displays them.
    /// If there is no story to display, it creates a new one.
    /// </summary>
    protected virtual void ContinueStory()
    {
        // Checking if our story is missing or finished.
        if (activeStory == null || (!activeStory.canContinue && activeStory.currentChoices.Count == 0))
        {
            TextAsset storyAsset = ObtainNewStory();
            activeStory = new Story(storyAsset.text);

            if (!activeStory.canContinue)
            {
                Debug.LogError("An Empty story was provided to the DialogueManager. " + storyAsset.name
                    + " does not contain text.");
                return;
            }
        }

        // And if we have unresolved choices.
        else if (!activeStory.canContinue && activeStory.currentChoices.Count != 0)
        {
            Debug.LogError("Trying to continue the story but there are currently unresolved choices to pick from.");
            return;
        }


        string newText = activeStory.Continue();

        // Trimming the new Text and sending the info to the Tag Manager.
        newText = TrimCharacterNamesFromText(newText);


        // Acting on whatever #tags were found in the new Ink line.
        foreach (var tag in activeStory.currentTags)
        {
            string[] tagSplitTexts = tag.Split(new char[':']);

            // If there is a ':' character in the tag, the tag is divided between [key] & [value].
            // Otherwise, it is only the [key].
            string key = tagSplitTexts[0].Trim();
            string value = "";

            if (tagSplitTexts.Length == 2)
            {
                value = tagSplitTexts[1].Trim();
            }
            else if (tagSplitTexts.Length > 2)
            {
                Debug.LogError("Incorrect Tag found in the Ink story [#" + tag + "]. " +
                    "\nTags cannot contain more than a single ':' character, " +
                    "and it should only be used to divide between [key] & [value].");
                value = tagSplitTexts[1].Trim();
            }

            // Sending the tag to be evaluated.
            if (value == "")
                tagManagerScript.ActOnTag(key);
            else
                tagManagerScript.ActOnTag(key, value);
        }


        // Displaying the text and choices.
        if (instantText)
        {
            dialogueTextScript.DisplayText(newText);

            if (activeStory.currentChoices.Count > 0)
                dialogueOptionsScript.DisplayOptions(activeStory.currentChoices.ToArray());
        }
        else
        {
            BeginTextDisplayAnimation(newText);
        }
    }

    /// <summary>
    /// Deletes the last story. Calling ContinueStory() afterwards will result in a new story being started.
    /// </summary>
    public virtual void StopStory()
    {
        activeStory = null;
    }

    /// <summary>
    /// Selects which choice players have made and continues the story with it.
    /// </summary>
    /// <param name="choiceMade"></param>
    public virtual void ChoiceMade(Choice choiceMade)
    {
        if(activeStory == null)
        {
            Debug.LogError("Cannot call ChoiceMade() when the story is no longer active.");
            return;
        }

        if (activeStory.currentChoices.Count == 0)
        {
            Debug.LogError("Cannot call ChoiceMade() when no choices are currently availible.");
            return;
        }

        for(int i = 0; i < activeStory.currentChoices.Count; i++)
        {
            if (activeStory.currentChoices[i] == choiceMade)
            {
                activeStory.ChooseChoiceIndex(i);
                dialogueOptionsScript.DisableOptions();
                ContinueStory();
                return;
            }
        }

        Debug.LogError("Choice [" + choiceMade.text + "] was not found among the possible choices list.");
    }

    #endregion

    #region Text animations

    protected void BeginTextDisplayAnimation(string text)
    {
        if(active_TextDisplay_AnimationCoroutine != null)
        {
            Debug.LogError("Should not be starting a Text Display Animation " +
                "while the previous animation is still running.");
            StopCoroutine(active_TextDisplay_AnimationCoroutine);
            active_TextDisplay_AnimationCoroutine = null;
        }

        isTextSpeedingUp = false;

        active_TextDisplay_AnimationCoroutine = StartCoroutine(TextDisplayAnimation(text));
    }

    protected void BeginTextDisplaySpeedUp() => isTextSpeedingUp = true;


    protected Coroutine active_TextDisplay_AnimationCoroutine = null;
    protected virtual IEnumerator TextDisplayAnimation(string textToAnimate)
    {
        int targetCharsToDisplay = textToAnimate.Length;
        int numberOfCharsDisplayed = 0;

        while (numberOfCharsDisplayed < targetCharsToDisplay)
        {
            // If we are asked to print our string instantly, we break the loop.
            if(isTextSpeedingUp == true && textSpeedUpMode == SpedUpTextSpeed.instant)
            {
                dialogueTextScript.DisplayText(textToAnimate);
                break;
            }

            // Every new loop, we increase the number of characters we display.
            numberOfCharsDisplayed++;

            // We then check how many characters we release.
            string updatedText = textToAnimate;
            if (numberOfCharsDisplayed < targetCharsToDisplay)
                updatedText = updatedText.Remove(numberOfCharsDisplayed);

            // And send them.
            dialogueTextScript.DisplayText(updatedText);

            float numberOfSecondsBeforeNextCharacter = 1 / (charactersPerSecond * TextSpeedUpMultiplier);
            yield return new WaitForSecondsRealtime(numberOfSecondsBeforeNextCharacter);
        }

        // Checking for possible choices.
        if (activeStory.currentChoices.Count > 0)
            dialogueOptionsScript.DisplayOptions(activeStory.currentChoices.ToArray());

        active_TextDisplay_AnimationCoroutine = null;
    }

    protected bool isTextSpeedingUp = false;
    protected float TextSpeedUpMultiplier
    {
        get
        {
            if (isTextSpeedingUp == false)
                return 1;

            // Speed Up multiplier values.
            switch (textSpeedUpMode)
            {
                case SpedUpTextSpeed.none:
                    return 1;
                case SpedUpTextSpeed.instant:
                    return 1;

                case SpedUpTextSpeed.x2:
                    return 2;
                case SpedUpTextSpeed.x3:
                    return 3;
                case SpedUpTextSpeed.x4:
                    return 4;
                case SpedUpTextSpeed.x5:
                    return 5;
                case SpedUpTextSpeed.x6:
                    return 6;

                default:
                    Debug.LogWarning("Speed Up Mode not recognised." +
                        "\nCannot get correct value for TextSpeedUpMultiplier");
                    return 1;
            }
        }
    }

    #endregion

    #region Managing the Ink Files.

    protected int nextStoryIdToDisplay = 0;

    protected virtual TextAsset ObtainNewStory()
    {
        return inkFiles[nextStoryIdToDisplay];
    }

    public virtual void ChangeWhichStoryToDisplayNext(int newStoryId)
    {
        if(inkFiles.Length - 1 < newStoryId)
        {
            Debug.LogError("Trying to set the value of nextStoryIdToDisplay to an int value [" + newStoryId +
                "] higher than the maximum id Value [" + (inkFiles.Length - 1) + "]." +
                "\nYou might be missing references to your Ink File in your DialogueManager script.");
            return;
        }

        nextStoryIdToDisplay = newStoryId;
    }

    #endregion

    #region Trimming character names

    /// <summary>
    /// Searches and trims character names at the beginning of text (Format used: "Name: " + "Actual Text").
    /// If a name is found, it is stored, removed from the text, and processed.
    /// </summary>
    /// <param name="originalText">The text to be trimmed.</param>
    /// <param name="sendCharacterNamesToTagManager">Whether the trimmed names should be sent to the Tag Manager.
    /// This also includes if no Character Name was found. Enabled by default.</param>
    /// <returns>A string without the outlined character names.</returns>
    protected string TrimCharacterNamesFromText(string originalText, bool sendCharacterNamesToTagManager = true)
    {
        if((characterNames == null || characterNames.Count == 0) && trimCharacterNamesBeforeText)
        {
            Debug.LogWarning("The Character Names cannot be trimmed from the text if " +
                "no Names are stored in the characterNames List<string>." +
                "\nDisable trimCharacterNamesBeforeText or add Character Names to the List." +
                "\nTemporarily disabling Name Trimming.");
            trimCharacterNamesBeforeText = false;
            return originalText;
        }

        string resultString = originalText;
        string characterName = "";

        foreach (string name in characterNames)
        {
            string fullStringToTrim = name + ": ";

            if (originalText.StartsWith(fullStringToTrim))
            {
                resultString = originalText.Remove(0, fullStringToTrim.Length);
                characterName = name;
                break;
            }
        }

        if (sendCharacterNamesToTagManager)
            tagManagerScript.ActOnTag("character", characterName);

        return resultString;
    }

    #endregion
}
