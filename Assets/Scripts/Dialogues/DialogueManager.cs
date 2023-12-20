using Ink.Parsed;
using System.Collections;
using System.Collections.Generic;
using Unity.IO.LowLevel.Unsafe;
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

    [Header("Availible Ink Files")]
    [SerializeField] TextAsset[] inkFiles;

    [Header("Supporting Scripts")]
    [SerializeField] IDialogueTextDisplayable dialogueTextScript;
    [SerializeField] IDialogueOptionsDisplayable dialogueOptionsScript;
    [SerializeField] IInkTagActionable tagManagerScript;

    Story activeStory = null;
    public bool isDialogueActive { get => activeStory == null; }


    private void Awake()
    {
        InitializeStaticReference();
    }



    #region Managing the Ink Files.

    int nextStoryIdToDisplay = 0;

    protected virtual TextAsset ObtainStoryToDisplay()
    {
        return inkFiles[nextStoryIdToDisplay];
    }

    public void ChangeWhichStoryToDisplayNext(int newStoryId)
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
