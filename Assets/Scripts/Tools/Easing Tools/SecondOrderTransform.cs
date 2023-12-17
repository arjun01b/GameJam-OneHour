﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteAlways]
public class SecondOrderTransform : MonoBehaviour
{
    [Range(0.0001f, 8)] public float frequency = 1;
    [Range(0, 5)] public float damping = 1;
    [Range(-5, 5f)] public float initialResponse = 0;


    public GameObject eulerRotationScript;
    IEulerRotable rotationScript;
    IEulerRotable RotationScript
    {
        get
        {
            if(rotationScript == null)
            {
                if (eulerRotationScript.TryGetComponent<IEulerRotable>(out IEulerRotable script))
                    rotationScript = script;
                else
                    Debug.LogError("eulerRotationScript needs to implement the interface IEulerRotable.");
            }

            return rotationScript;
        }
    }


    // We create an enum to decide what transform values we want to follow.
    public enum typeOfFollow { position, scale, rotationDegrees, rotationQuaternion };
    public typeOfFollow whichSecondOrder = typeOfFollow.position;


    // Enum to store if we are getting and applying our transform in local/world space.
    public enum typeOfSpace { localSpace, worldSpace };

    // The properties Restart the dynamics if obtain/apply local/world space variables change.
    typeOfSpace obtainFromLocalOrWorld = typeOfSpace.localSpace;
    public typeOfSpace ObtainFromLocalOrWorld
    {
        get { return obtainFromLocalOrWorld; }
        set
        {
            if (value != obtainFromLocalOrWorld)
                RestartDynamics();

            obtainFromLocalOrWorld = value;
        }
    }

    typeOfSpace applyToLocalOrWorld = typeOfSpace.localSpace;
    public typeOfSpace ApplyToLocalOrWorld
    {
        get { return applyToLocalOrWorld; }
        set
        {
            if (value != applyToLocalOrWorld)
                RestartDynamics();

            applyToLocalOrWorld = value;
        }
    }


    // We create bool values for each 
    public bool applyX = true, applyY = true, applyZ = true;
    bool[] selectedApplies;

    public Transform followTransform;   // The transform that we are following.


    // We set Second Order references to hold all the components of the transform.
    SecondOrder_1D oneDimensionDyna;
    SecondOrder_2D twoDimensionDyna;
    SecondOrder_3D threeDimensionDyna;
    SecondOrder_Quaternion quaternionDimensionDyna;


    // And we create a TransformData to hold all of the old transform components of our target.
    TransformData oldFollowTransform;


    // This value is meant to store the old rotation value we are given (so that we can do transform.Rotate())
    float oldRotation = 0;

    // We also need a value for whether we want our script to run in-editor.
    public bool runInEditor = false;



    // We restart our script when we get disable. This will prevent old values from reappearing afterwards.
    private void OnDisable()
    {
        RestartDynamics();
    }


    private void Update()
    {
#if UNITY_EDITOR
        if (!runInEditor && !Application.isPlaying)
            return;
#endif

        if (frequency <= 0) // We check that our frequency has correct values (otherwise the whole thing doesn't work.
        {
            Debug.LogError("Frequency must have a value above 0. Current value equals " + frequency);
            return;
        }

        int selectedApplies = HowManySelectedApplies();

        Vector4 followValues = GetTargetValues(followTransform);
        Vector4 oldFollowValues = GetTargetValues(OldTransform());

        if(whichSecondOrder != typeOfFollow.rotationQuaternion)
            switch (selectedApplies)
        {
            case 0:
                break;

            case 1:
                float speed1;

                if (Time.deltaTime != 0)
                    speed1 = (followValues.x - oldFollowValues.x) / Time.deltaTime;

                else
                    speed1 = 0;

                float valueD1 = GetDyna1D().Update(Time.deltaTime, followValues.x, speed1);

                ApplyChanges(valueD1);

                break;


            case 2:
                Vector2 speed2;

                if (Time.deltaTime != 0)
                    speed2 = new Vector2(followValues.x - oldFollowValues.x, followValues.y - oldFollowValues.y) / Time.deltaTime;
                else
                    speed2 = Vector2.zero;

                Vector2 valueD2 = GetDyna2D().Update(Time.deltaTime, new Vector2(followValues.x, followValues.y), speed2);

                ApplyChanges(valueD2);

                break;


            case 3:
                    Vector3 speed3;

                    if (Time.deltaTime != 0)
                        speed3 = new Vector3(followValues.x - oldFollowValues.x, followValues.y - oldFollowValues.y,
                                             followValues.z - oldFollowValues.z) / Time.deltaTime;
                    else
                        speed3 = Vector3.zero;

                    Vector3 valueD3 = GetDyna3D().Update(Time.deltaTime, new Vector3(followValues.x, followValues.y, followValues.z), speed3);

                    ApplyChanges(valueD3);

                break;
        }

        else
        {
            Quaternion valueQuat = GetQuaternionDyna().Update(Time.deltaTime,
                new Quaternion(followValues.x, followValues.y, followValues.z, followValues.w));

            ApplyChanges(valueQuat);
        }

        UpdateOldTransform();

        /* Old check for wrong values
        if (speed.magnitude < 100)
        {

            Vector3 newPosition = GetPositionDyna().Update(Time.deltaTime, followTransform.position, speed);

            // We prevent a Vector3(NaN, NaN, NaN) from being applied to our position. I don't know why, but sometimes the Update() function returns that.
            if (newPosition != new Vector3(float.NaN, float.NaN, float.NaN))
                transform.position = newPosition;
        }
        */
    }


    #region Get dynamics functions.
    // Returns our 1D dynamics.
    private SecondOrder_1D GetDyna1D()
    {
        Vector4 followedValues = GetTargetValues(followTransform);

        // If our dynamics have not been initialized.
        if (oneDimensionDyna == null)
            oneDimensionDyna = new SecondOrder_1D(frequency, damping, initialResponse, followedValues.x);

        // If our f, z and/or r has changed, we restart our script.
        else if (oneDimensionDyna.playerInputs != new Vector3(frequency, damping, initialResponse))
            oneDimensionDyna = new SecondOrder_1D(frequency, damping, initialResponse, followedValues.x);

        return oneDimensionDyna;
    }


    // Returns our 2D dynamics.
    private SecondOrder_2D GetDyna2D()
    {
        Vector4 followedValues = GetTargetValues(followTransform);

        // If our dynamics have not been initialized.
        if (twoDimensionDyna == null)
        {
            twoDimensionDyna = new SecondOrder_2D(frequency, damping, initialResponse, 
                new Vector2(followedValues.x, followedValues.y));
        }

        // If our f, z and/or r has changed, we restart our script.
        else if (twoDimensionDyna.playerInputs != new Vector3(frequency, damping, initialResponse))
        {
            twoDimensionDyna = new SecondOrder_2D(frequency, damping, initialResponse, 
                new Vector2(followedValues.x, followedValues.y));
        }

        return twoDimensionDyna;
    }


    // Returns our 3D dynamics.
    private SecondOrder_3D GetDyna3D()
    {
        Vector4 followedValues = GetTargetValues(followTransform);

        // If our dynamics have not been initialized.
        if (threeDimensionDyna == null)
        {
            threeDimensionDyna = new SecondOrder_3D(frequency, damping, initialResponse, 
                new Vector3(followedValues.x, followedValues.y, followedValues.z));
        }

        // If our f, z and/or r has changed, we restart our script.
        else if (threeDimensionDyna.playerInputs != new Vector3(frequency, damping, initialResponse))
        {
            threeDimensionDyna = new SecondOrder_3D(frequency, damping, initialResponse, 
                new Vector3(followedValues.x, followedValues.y, followedValues.z));
        }

        return threeDimensionDyna;
    }


    // Returns our Quaternion dynamics.
    private SecondOrder_Quaternion GetQuaternionDyna()
    {
        Vector4 followedValues = GetTargetValues(followTransform);

        // If our dynamics have not been initialized.
        if (quaternionDimensionDyna == null)
        {
            quaternionDimensionDyna = new SecondOrder_Quaternion(frequency, damping, initialResponse,
                new Quaternion(followedValues.x, followedValues.y, followedValues.z, followedValues.w));
        }

        // If our f, z and/or r has changed, we restart our script.
        else if (quaternionDimensionDyna.playerInputs != new Vector3(frequency, damping, initialResponse))
        {
            quaternionDimensionDyna = new SecondOrder_Quaternion(frequency, damping, initialResponse,
                new Quaternion(followedValues.x, followedValues.y, followedValues.z, followedValues.w));
        }

        return quaternionDimensionDyna;
    }
    #endregion


    #region Old transform functions.

    // Returns our old TransformData. If neccessary, it initializes it for the editor.
    private TransformData OldTransform()
    {
        // If our oldFollowTransform isn't initialized, we create a new one.
        if (oldFollowTransform == null)
            oldFollowTransform = new TransformData(followTransform);

        return oldFollowTransform;
    }


    // Used to store the values of our follow object's transform.
    private void UpdateOldTransform()
    {
        oldFollowTransform.UpdateTransform(followTransform);
    }

    #endregion


    #region ApplyChanges functions.

    private void ApplyChanges(float v)
    {
        if (ApplyToLocalOrWorld == typeOfSpace.localSpace)
        {
            switch (whichSecondOrder)
            {
                case typeOfFollow.position:
                    if (applyX)
                        transform.localPosition = new Vector3(v, transform.localPosition.y, transform.localPosition.z);
                    else if (applyY)
                        transform.localPosition = new Vector3(transform.localPosition.x, v, transform.localPosition.z);
                    else   //applyZ
                        transform.localPosition = new Vector3(transform.localPosition.x, transform.localPosition.y, v);
                    break;

                case typeOfFollow.rotationDegrees:
                    if (applyX)
                        transform.Rotate(new Vector3(v - oldRotation, 0, 0), Space.Self);
                    else if (applyY)
                        transform.Rotate(new Vector3(0, v - oldRotation, 0), Space.Self);
                    else   //applyZ
                        transform.Rotate(new Vector3(0, 0, v - oldRotation), Space.Self);

                    oldRotation = v;
                    break;

                case typeOfFollow.rotationQuaternion:
                    Debug.LogError("Quaternion rotation should not be applied in this function.");
                    break;

                case typeOfFollow.scale:
                    if (applyX)
                        transform.localScale = new Vector3(v, transform.localScale.y, transform.localScale.z);
                    else if (applyY)
                        transform.localScale = new Vector3(transform.localScale.x, v, transform.localScale.z);
                    else   //applyZ
                        transform.localScale = new Vector3(transform.localScale.x, transform.localScale.y, v);
                    break;
            }
        }
        else if(ApplyToLocalOrWorld == typeOfSpace.worldSpace)
        {
            switch (whichSecondOrder)
            {
                case typeOfFollow.position:
                    if (applyX)
                        transform.position = new Vector3(v, transform.position.y, transform.position.z);
                    else if (applyY)
                        transform.position = new Vector3(transform.position.x, v, transform.position.z);
                    else   //applyZ
                        transform.position = new Vector3(transform.position.x, transform.position.y, v);
                    break;

                case typeOfFollow.rotationDegrees:
                    Debug.LogError("Euler Rotation should not be applied into World Space.");
                    break;

                case typeOfFollow.rotationQuaternion:
                    Debug.LogError("Quaternion rotation should not be applied in this function.");
                    break;

                case typeOfFollow.scale:
                    Debug.LogError("Scale should not be applied into World Space.");
                    break;
            }
        }
    }


    private void ApplyChanges(Vector2 v)
    {
        if (ApplyToLocalOrWorld == typeOfSpace.localSpace)
        {
            switch (whichSecondOrder)
            {
                case typeOfFollow.position:
                    if (applyX & applyY)
                        transform.localPosition = new Vector3(v.x, v.y, transform.localPosition.z);
                    else if (applyX & applyZ)
                        transform.localPosition = new Vector3(v.x, transform.localPosition.y, v.y);
                    else   //applyY & applyZ
                        transform.localPosition = new Vector3(transform.localPosition.x, v.x, v.y);
                    break;

                case typeOfFollow.rotationDegrees:
                    Debug.LogError("Rotation degrees only supports following 1 euler rotation.");
                    break;

                case typeOfFollow.rotationQuaternion:
                    Debug.LogError("Quaternion rotation should not be applied in this function.");
                    break;

                case typeOfFollow.scale:
                    if (applyX & applyY)
                        transform.localScale = new Vector3(v.x, v.y, transform.localScale.z);
                    else if (applyX & applyZ)
                        transform.localScale = new Vector3(v.x, transform.localScale.y, v.y);
                    else   //applyY & applyZ
                        transform.localScale = new Vector3(transform.localScale.x, v.x, v.y);
                    break;
            }
        }
        else if(ApplyToLocalOrWorld == typeOfSpace.worldSpace)
        {
            switch (whichSecondOrder)
            {
                case typeOfFollow.position:
                    if (applyX & applyY)
                        transform.position = new Vector3(v.x, v.y, transform.position.z);
                    else if (applyX & applyZ)
                        transform.position = new Vector3(v.x, transform.position.y, v.y);
                    else   //applyY & applyZ
                        transform.position = new Vector3(transform.position.x, v.x, v.y);
                    break;

                case typeOfFollow.rotationDegrees:
                    Debug.LogError("Rotation degrees only supports following 1 euler rotation.");
                    break;

                case typeOfFollow.rotationQuaternion:
                    Debug.LogError("Quaternion rotation should not be applied in this function.");
                    break;

                case typeOfFollow.scale:
                    Debug.LogError("Scale should not be applied into World Space.");
                    break;
            }
        }
    }


    private void ApplyChanges(Vector3 v)
    {
        if (ApplyToLocalOrWorld == typeOfSpace.localSpace)
        {
            switch (whichSecondOrder)
            {
                case typeOfFollow.position:
                    transform.localPosition = new Vector3(v.x, v.y, v.z);
                    break;

                case typeOfFollow.rotationDegrees:
                    Debug.LogError("Rotation degrees only supports following 1 euler rotation.");
                    break;

                case typeOfFollow.rotationQuaternion:
                    Debug.LogError("Quaternion rotation should not be applied in this function.");
                    break;

                case typeOfFollow.scale:
                    transform.localScale = new Vector3(v.x, v.y, v.z);
                    break;
            }
        }
        else if(ApplyToLocalOrWorld == typeOfSpace.worldSpace)
        {
            switch (whichSecondOrder)
            {
                case typeOfFollow.position:
                    transform.position = new Vector3(v.x, v.y, v.z);
                    break;

                case typeOfFollow.rotationDegrees:
                    Debug.LogError("Rotation degrees only supports following 1 euler rotation.");
                    break;

                case typeOfFollow.rotationQuaternion:
                    Debug.LogError("Quaternion rotation should not be applied in this function.");
                    break;

                case typeOfFollow.scale:
                    Debug.LogError("Scale should not be applied into World Space.");
                    break;
            }
        }
    }


    private void ApplyChanges(Quaternion v)
    {
        if (ApplyToLocalOrWorld == typeOfSpace.localSpace)
        {
            switch (whichSecondOrder)
            {
                case typeOfFollow.position:
                    Debug.LogError("Position should not be applied in this function.");
                    break;

                case typeOfFollow.rotationDegrees:
                    Debug.LogError("Euler rotation should not be applied in this function.");
                    break;

                case typeOfFollow.rotationQuaternion:
                    transform.localRotation = v;
                    break;

                case typeOfFollow.scale:
                    Debug.LogError("Scale should not be applied in this function.");
                    break;
            }
        }
        else if (ApplyToLocalOrWorld == typeOfSpace.worldSpace)
        {
            switch (whichSecondOrder)
            {
                case typeOfFollow.position:
                    Debug.LogError("Position should not be applied in this function.");
                    break;

                case typeOfFollow.rotationDegrees:
                    Debug.LogError("Euler rotation should not be applied in this function.");
                    break;

                case typeOfFollow.rotationQuaternion:
                    transform.rotation = v;
                    break;

                case typeOfFollow.scale:
                    Debug.LogError("Scale should not be applied in this function.");
                    break;
            }
        }
    }
    #endregion



    // Basing itself off the typeOfTransform enum and the selectedApplies bool[],
    // this function returns a Vector4 with an ordered selection of values.
    // When used together with GetSelectedApplies, it allows users to only obtain selected values from the followTransform.
    private Vector4 GetTargetValues(Transform t)
    {
        List<float> results = new List<float>();

        if (ObtainFromLocalOrWorld == typeOfSpace.localSpace)
        {
            if (whichSecondOrder != typeOfFollow.rotationQuaternion)
            {
                bool[] selection = GetSelectedApplies();

                for (int i = 0; i < selection.Length; i++)
                {
                    if (selection[i])
                    {
                        switch (whichSecondOrder)
                        {
                            case typeOfFollow.position:
                                switch (i)
                                {
                                    case 0:
                                        results.Add(t.localPosition.x);
                                        break;
                                    case 1:
                                        results.Add(t.localPosition.y);
                                        break;
                                    case 2:
                                        results.Add(t.localPosition.z);
                                        break;
                                }
                                break;

                            case typeOfFollow.rotationDegrees:
                                switch (i)
                                {
                                    case 0:
                                        results.Add(RotationScript.ReturnRotation());
                                        break;
                                    case 1:
                                        results.Add(RotationScript.ReturnRotation());
                                        break;
                                    case 2:
                                        results.Add(RotationScript.ReturnRotation());
                                        break;
                                }

                                break;

                            case typeOfFollow.scale:
                                switch (i)
                                {
                                    case 0:
                                        results.Add(t.localScale.x);
                                        break;
                                    case 1:
                                        results.Add(t.localScale.y);
                                        break;
                                    case 2:
                                        results.Add(t.localScale.z);
                                        break;
                                }
                                break;
                        }
                    }
                }
            }
            else
            {
                results.Add(followTransform.localRotation.x);
                results.Add(followTransform.localRotation.y);
                results.Add(followTransform.localRotation.z);
                results.Add(followTransform.localRotation.w);
            }
        }
        else if(ObtainFromLocalOrWorld == typeOfSpace.worldSpace)
        {
            if (whichSecondOrder != typeOfFollow.rotationQuaternion)
            {
                bool[] selection = GetSelectedApplies();

                for (int i = 0; i < selection.Length; i++)
                {
                    if (selection[i])
                    {
                        switch (whichSecondOrder)
                        {
                            case typeOfFollow.position:
                                switch (i)
                                {
                                    case 0:
                                        results.Add(t.position.x);
                                        break;
                                    case 1:
                                        results.Add(t.position.y);
                                        break;
                                    case 2:
                                        results.Add(t.position.z);
                                        break;
                                }
                                break;

                            case typeOfFollow.rotationDegrees:
                                Debug.LogError("Can't obtain ueler rotation from worldSpace.");
                                break;

                            case typeOfFollow.scale:
                                switch (i)
                                {
                                    case 0:
                                        results.Add(t.lossyScale.x);
                                        break;
                                    case 1:
                                        results.Add(t.lossyScale.y);
                                        break;
                                    case 2:
                                        results.Add(t.lossyScale.z);
                                        break;
                                }
                                break;
                        }
                    }
                }
            }
            else
            {
                results.Add(followTransform.rotation.x);
                results.Add(followTransform.rotation.y);
                results.Add(followTransform.rotation.z);
                results.Add(followTransform.rotation.w);
            }
        }

        // Preparing the result vector.
        Vector4 vector = Vector4.zero;

        for(int i = 0; i < results.Count; i++)
        {
            switch(i)
            {
                case 0:
                    vector = new Vector4(results[0], 0, 0, 0);
                    break;

                case 1:
                    vector = new Vector4(vector.x, results[1], 0, 0);
                    break;

                case 2:
                    vector = new Vector4(vector.x, vector.y, results[2], 0);
                    break;

                case 3:
                    vector = new Vector4(vector.x, vector.y, vector.z, results[3]);
                    break;

                default:
                    Debug.LogError("Something went horribly wrong.");
                    break;
            }
        }

        return vector;
    }


    // Same function as before, but working with TransformData class.
    private Vector4 GetTargetValues(TransformData t)
    {
        List<float> results = new List<float>();

        if (ObtainFromLocalOrWorld == typeOfSpace.localSpace)
        {
            if (whichSecondOrder != typeOfFollow.rotationQuaternion)
            {
                bool[] selection = GetSelectedApplies();

                for (int i = 0; i < selection.Length; i++)
                {
                    if (selection[i])
                    {
                        switch (whichSecondOrder)
                        {
                            case typeOfFollow.position:
                                switch (i)
                                {
                                    case 0:
                                        results.Add(t.localPosition.x);
                                        break;
                                    case 1:
                                        results.Add(t.localPosition.y);
                                        break;
                                    case 2:
                                        results.Add(t.localPosition.z);
                                        break;
                                }
                                break;

                            case typeOfFollow.rotationDegrees:
                                switch (i)
                                {
                                    case 0:
                                        results.Add(RotationScript.ReturnRotation());
                                        break;
                                    case 1:
                                        results.Add(RotationScript.ReturnRotation());
                                        break;
                                    case 2:
                                        results.Add(RotationScript.ReturnRotation());
                                        break;
                                }
                                break;

                            case typeOfFollow.scale:
                                switch (i)
                                {
                                    case 0:
                                        results.Add(t.localScale.x);
                                        break;
                                    case 1:
                                        results.Add(t.localScale.y);
                                        break;
                                    case 2:
                                        results.Add(t.localScale.z);
                                        break;
                                }
                                break;
                        }
                    }
                }
            }
            else
            {
                results.Add(t.localRotation.x);
                results.Add(t.localRotation.y);
                results.Add(t.localRotation.z);
                results.Add(t.localRotation.w);
            }
        }
        else if (ObtainFromLocalOrWorld == typeOfSpace.worldSpace)
        {
            if (whichSecondOrder != typeOfFollow.rotationQuaternion)
            {
                bool[] selection = GetSelectedApplies();

                for (int i = 0; i < selection.Length; i++)
                {
                    if (selection[i])
                    {
                        switch (whichSecondOrder)
                        {
                            case typeOfFollow.position:
                                switch (i)
                                {
                                    case 0:
                                        results.Add(t.position.x);
                                        break;
                                    case 1:
                                        results.Add(t.position.y);
                                        break;
                                    case 2:
                                        results.Add(t.position.z);
                                        break;
                                }
                                break;

                            case typeOfFollow.rotationDegrees:
                                Debug.LogError("Can't obtain ueler rotation from worldSpace.");
                                break;

                            case typeOfFollow.scale:
                                switch (i)
                                {
                                    case 0:
                                        results.Add(t.lossyScale.x);
                                        break;
                                    case 1:
                                        results.Add(t.lossyScale.y);
                                        break;
                                    case 2:
                                        results.Add(t.lossyScale.z);
                                        break;
                                }
                                break;
                        }
                    }
                }
            }
            else
            {
                results.Add(t.rotation.x);
                results.Add(t.rotation.y);
                results.Add(t.rotation.z);
                results.Add(t.rotation.w);
            }
        }


        // Preparing the result vector.
        Vector4 vector = Vector4.zero;

        for (int i = 0; i < results.Count; i++)
        {
            switch (i)
            {
                case 0:
                    vector = new Vector4(results[0], 0, 0, 0);
                    break;

                case 1:
                    vector = new Vector4(vector.x, results[1], 0, 0);
                    break;

                case 2:
                    vector = new Vector4(vector.x, vector.y, results[2], 0);
                    break;

                case 3:
                    vector = new Vector4(vector.x, vector.y, vector.z, results[3]);
                    break;

                default:
                    Debug.LogError("Something went horribly wrong.");
                    break;
            }
        }

        return vector;
    }



    // Returns and initializes the bool[] selectedApplies,
    // which contains user selections about which x,y,z or w values to follow.
    private bool[] GetSelectedApplies()
    {
        if (selectedApplies == null)
            selectedApplies = new bool[3];

        selectedApplies[0] = applyX;
        selectedApplies[1] = applyY;
        selectedApplies[2] = applyZ;

        return selectedApplies;
    }


    // Returns how many values are selected to follow.
    public int HowManySelectedApplies()
    {
        int result = 0;

        if (applyX)
            result++;

        if (applyY)
            result++;

        if (applyZ)
            result++;

        return result;
    }



    // Function used to change type of second order operations while cleaning old dynamics holders.
    public void ChangeTransformType(typeOfFollow t)
    {
        if (whichSecondOrder == t)  // If we are trying to change into the current transform type, we don't do anything.
            return;

        // We reset all-dimensional dynamics.
        RestartDynamics();

        whichSecondOrder = t;
    }


    // Erases the content of all of the dynamic holders.
    public void RestartDynamics()
    {
        oneDimensionDyna = null;
        twoDimensionDyna = null;
        threeDimensionDyna = null;
        quaternionDimensionDyna = null;
        oldRotation = 0;
    }


#if UNITY_EDITOR
    // This function makes the script execute in real time during editor if the target is selected by the user.
    private void OnDrawGizmos()
    {
        // Only continue if we're repainting the scene & we want to draw in editor.
        if (Event.current.type != EventType.Repaint || !runInEditor)
            return;


        // Ensure continuous Update calls.
        if (!Application.isPlaying & UnityEditor.Selection.activeTransform == followTransform)
        {
            UnityEditor.EditorApplication.QueuePlayerLoopUpdate();
            UnityEditor.SceneView.RepaintAll();
        }
    }
#endif
}
