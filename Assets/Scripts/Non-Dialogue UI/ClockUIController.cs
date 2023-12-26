using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ClockUIController : MonoBehaviour
{
    #region Static Reference

    public static ClockUIController instance;

    void InitializeStaticReference()
    {
        // Setting up the static reference to this script.
        if (instance == null)
            instance = this;
        else
        {
            Debug.LogError("You can't have 2 ClockUIController scripts. " +
                "ClockUIController contains a static reference.");
            Destroy(this);
        }
    }

    #endregion

    [Header("References")]
    [SerializeField] RectTransform bigHandRectTransform, smallHandRectTransform;

    [Header("Second Order Dampening")]
    [SerializeField] Vector3 secondOrderValues = new Vector3(1, 1, 0);

    float bigHandOriginalZRotation, smallHandOriginalZRotation;
    float bigHandTargetZRotation, smallHandTargetZRotation;

    int hour = 22;
    int minute = 0;

    #region Second Order Properties
    SecondOrder_1D BigHandSecondOrder
    {
        get
        {
            if (_bigHandSecondOrder == null)
                _bigHandSecondOrder = new SecondOrder_1D(secondOrderValues.x, secondOrderValues.y, 
                    secondOrderValues.z, bigHandRectTransform.localEulerAngles.z);

            return _bigHandSecondOrder;
        }
    }
    SecondOrder_1D _bigHandSecondOrder;

    SecondOrder_1D SmallHandSecondOrder
    {
        get
        {
            if (_smallHandSecondOrder == null)
                _smallHandSecondOrder = new SecondOrder_1D(secondOrderValues.x, secondOrderValues.y,
                    secondOrderValues.z, smallHandRectTransform.localEulerAngles.z);

            return _smallHandSecondOrder;
        }
    }
    SecondOrder_1D _smallHandSecondOrder;

    #endregion


    private void Awake()
    {
        InitializeStaticReference();

        bigHandOriginalZRotation    = bigHandRectTransform.localEulerAngles.z;
        smallHandOriginalZRotation  = smallHandRectTransform.localEulerAngles.z;

        bigHandTargetZRotation = bigHandOriginalZRotation;
        smallHandTargetZRotation = smallHandOriginalZRotation;
    }

    private void Update()
    {
        bigHandRectTransform.localRotation = Quaternion.Euler(0, 0,
            BigHandSecondOrder.Update(Time.deltaTime, bigHandTargetZRotation, 0, true));
        smallHandRectTransform.localRotation = Quaternion.Euler(0, 0,
            SmallHandSecondOrder.Update(Time.deltaTime, smallHandTargetZRotation, 0, true));


        /* DEBUG:
        if (Input.GetKeyDown(KeyCode.Space))
        {
            int newHour = hour;
            int newMinute = minute + 15;

            if(newMinute == 60)
            {
                newMinute = 0;
                newHour++;
            }

            SetTargetRotationForTime(newHour, newMinute);
        }

        if (Input.GetKeyDown(KeyCode.Backspace))
        {
            int newHour = 22;
            int newMinute = 0;

            SetTargetRotationForTime(newHour, newMinute);
        } */
    }

    public void SetTargetRotationForTime(int newHour, int newMinute)
    {
        if(newHour < 22 || newHour > 24)
        {
            Debug.LogError("Hour value " + newHour + " is not valid.");
            return;
        }

        if (!(newMinute == 0 || newMinute == 15 || newMinute == 30 || newMinute == 45))
        {
            Debug.LogError("Minute value " + newMinute + " is not valid.");
            return;
        }

        hour = newHour;
        minute = newMinute;

        // Setting new Target Rotation Values.
        smallHandTargetZRotation = smallHandOriginalZRotation - 30 * (hour - 22) - 7.5f * (minute / 15);
        bigHandTargetZRotation = bigHandOriginalZRotation - 360 * (hour - 22) - 90 * (minute / 15);
    }
}
