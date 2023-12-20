using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DialogueTagController : MonoBehaviour, IInkTagActionable
{
    public void ActOnInkTag(string key, string value = "")
    {
        switch (key)
        {
            default:
                Debug.LogError("Key [" + key + "] not implemented. Cannot perform expected action.");
                break;
        }
    }
}
