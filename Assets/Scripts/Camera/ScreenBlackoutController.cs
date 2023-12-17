using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(SpriteRenderer))]
public class ScreenBlackoutController : MonoBehaviour
{
    #region Static Reference

    public static ScreenBlackoutController instance;

    void InitializeStaticReference()
    {
        // Setting up the static reference to this script.
        if (instance == null)
            instance = this;
        else
        {
            Debug.LogError("You can't have 2 ScreenBlackoutController scripts. " +
                "ScreenBlackoutController contains a static reference.");
            Destroy(this);
        }
    }

    #endregion


    SpriteRenderer _mySpriteRenderer;
    SpriteRenderer MySpriteRenderer
    {
        get
        {
            if (_mySpriteRenderer == null)
            {
                if (TryGetComponent<SpriteRenderer>(out SpriteRenderer i))
                    _mySpriteRenderer = i;
                else
                    Debug.LogError("ScreenBlackoutController needs to be attached to an object " +
                        "with an Image component in it.");
            }

            return _mySpriteRenderer;
        }
    }


    private void Awake()
    {
        InitializeStaticReference();
    }


    public void ChangeTransparency(float alpha)
    {
        if (alpha < 0 || alpha > 1)
        {
            Debug.LogError("Blackout alpha value needs to be in the Range [0,1].");
            return;
        }

        MySpriteRenderer.color = new Color(0, 0, 0, alpha);
    }
}

