using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Velocity : MonoBehaviour
{
    [Header("Set Rotating")]

    public bool checkToRotate;
    public float rotateSpeed = 15.0f;

    [Header("Set Up/Down Motion")]

    public bool checkToFloat;
    public float Height = 0.5f;
    public float upDownSpeed = 1f;

    Vector3 startingPosition = new Vector3();
    Vector3 tempPosition = new Vector3();

    private void Start()
    {
        startingPosition = transform.position;
    }

    private void Update()
    {
        if (checkToRotate)
        {
            transform.Rotate(new Vector3(0f, Time.deltaTime * rotateSpeed, 0f), Space.World);
        }

        if (checkToFloat)
        {
            tempPosition = startingPosition;
            tempPosition.y += Mathf.Sin(Time.fixedTime * Mathf.PI * upDownSpeed) * Height;
            transform.position = tempPosition;
        }
    }
}
