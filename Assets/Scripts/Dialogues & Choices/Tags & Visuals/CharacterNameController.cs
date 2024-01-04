using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CharacterNameController : MonoBehaviour
{
    [SerializeField][Range(0, 5)] float durationOfFade = 1;

    #region Self-Initialized Variables

    Image _myImage;
    Image MyImage
    {
        get
        {
            if (_myImage == null)
                _myImage = GetComponent<Image>();

            return _myImage;
        }
    }

    Text _myText;
    Text MyText
    {
        get
        {
            if (_myText == null)
                _myText = GetComponentInChildren<Text>();

            return _myText;
        }
    }

    Timer _myTimer;
    Timer MyTimer
    {
        get
        {
            if(_myTimer == null)
                _myTimer = new Timer(durationOfFade);

            return _myTimer;
        }
    }

    #endregion

    private void Awake()
    {
        // On Awake, no character is speaking so we set the transparency to 0.
        ChangeTransparencyOfAssets(0);    
    }

    private void ChangeTransparencyOfAssets(float alpha)
    {
        float smoothedAlpha = EasingFunctions.ApplyEase(alpha, EasingFunctions.Functions.OutCubic);

        Color oldImageColor = MyImage.color;
        MyImage.color = new Color(oldImageColor.r, oldImageColor.g, oldImageColor.b, smoothedAlpha);

        Color oldTextColor = MyText.color;
        MyText.color = new Color(oldTextColor.r, oldTextColor.g, oldTextColor.b, smoothedAlpha);
    }

    Coroutine activeCoroutine = null;
    private IEnumerator MakeCharacterNameVisible()
    {
        while (!MyTimer.IsComplete)
        {
            MyTimer.Update();

            ChangeTransparencyOfAssets(MyTimer.PercentageComplete);

            yield return null;
        }

        activeCoroutine = null;
    }
    private IEnumerator MakeCharacterNameInvisible()
    {
        while (MyTimer.Time != 0)
        {
            MyTimer.NegativeUpdate();

            ChangeTransparencyOfAssets(MyTimer.PercentageComplete);

            yield return null;
        }

        activeCoroutine = null;
    }


    #region Public Methods

    public void SetTransparencyOfCharacterName(bool makeVisible)
    {
        if(activeCoroutine != null)
        {
            StopCoroutine(activeCoroutine);
            activeCoroutine = null;
        }

        if(makeVisible && !MyTimer.IsComplete)
            activeCoroutine = StartCoroutine(MakeCharacterNameVisible());

        else if (!makeVisible && MyTimer.Time != 0)
            activeCoroutine = StartCoroutine(MakeCharacterNameInvisible());
    }
    public void SetCharacterName(string newName) => MyText.text = newName;

    #endregion
}
