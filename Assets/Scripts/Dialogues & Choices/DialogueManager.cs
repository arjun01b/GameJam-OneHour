using Ink;
using Ink.Runtime;
using System.Collections;
using System.Collections.Generic;
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
    [SerializeField] [Range(1, 100)] protected int charactersPerSecond = 15;
    // This would only be used when instantText is disabled.

    [Header("Supporting Scripts")]
    [SerializeField] protected GameObject dialogueTextScript_Holder;
    [SerializeField] protected GameObject dialogueOptionsScript_Holder;
    [SerializeField] protected GameObject tagManagerScript_Holder;
    protected IDialogueTextDisplayable dialogueTextScript;
    protected IDialogueOptionsDisplayable dialogueOptionsScript;
    protected IInkTagActionable tagManagerScript;

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


    [Header("Availible Ink Files")]
    [SerializeField] protected TextAsset[] inkFiles;


    protected Story activeStory = null;
    public bool isDialogueActive { get => activeStory == null; }


    private void Awake()
    {
        InitializeStaticReference();
        FillScriptReferences();
    }


    #region Story Controls

    /// <summary>
    /// Sends the next chunck of text or set of options to the Script that displays them.
    /// If there is no story to display, it creates a new one.
    /// </summary>
    public virtual void ContinueStory()
    {
        // If our story is missing or finished.
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

        // If we have unresolved choices.
        else if (!activeStory.canContinue && activeStory.currentChoices.Count != 0)
        {
            Debug.LogError("Trying to continue the story but there are currently unresolved choices to pick from.");
            return;
        }


        string newText = activeStory.Continue();


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
                tagManagerScript.ActOnInkTag(key);
            else
                tagManagerScript.ActOnInkTag(key, value);
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
            ////////////////////////////////////////////////////////
            Debug.LogError("Non-instant text not yet implemented.");
            ////////////////////////////////////////////////////////
            
            instantText = false;
            dialogueTextScript.DisplayText(newText);

            if (activeStory.currentChoices.Count > 0)
                dialogueOptionsScript.DisplayOptions(activeStory.currentChoices.ToArray());
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
}
