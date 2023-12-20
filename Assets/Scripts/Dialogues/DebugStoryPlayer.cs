using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DebugStoryPlayer : MonoBehaviour
{
    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Space))
            DialogueManager.instance.ContinueStory();
    }
}
