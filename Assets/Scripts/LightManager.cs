using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LightManager : MonoBehaviour
{
    #region Static Reference
    public static LightManager instance;

    void InitializeStaticReference()
    {
        if (instance != null)
        {
            Debug.LogError("There should not be multiple active copies of LightManager. " +
                "LightManager has a static reference." +
                "\nDestroying this script.");
            Destroy(this);
            return;
        }

        instance = this;
    }

    #endregion

    List<Light> myLights;

    [Range(0, 1)] public float lightIntensityMultiplier = 1;
    [SerializeField][Range(0, 1)] float lightMaxFlickeringIntensity = 0.1f;
    [SerializeField][Range(0, 20)] float waveVelocity = Mathf.PI * 3;
    [SerializeField][Range(0, Mathf.PI)] float waveDisplacement = 1;

    private float sinePosition = 0;


    private void Awake()
    {
        InitializeStaticReference();
        StoreLightReferences();
    }

    private void FixedUpdate()
    {
        CalculateNewWavePosition();
        UpdateLightIntensities();
    }

    private void StoreLightReferences()
    {
        Light[] availibleLights = transform.GetComponentsInChildren<Light>();

        myLights = new List<Light>();
        myLights.AddRange(availibleLights);
    }

    private void CalculateNewWavePosition()
    {
        sinePosition += waveVelocity * Time.deltaTime;

        if (sinePosition > Mathf.PI)
            sinePosition -= Mathf.PI;
    }

    private float CalculateNewFlickerMultiplierValue()
    {
        float waveValue = Mathf.Sin(sinePosition) * Mathf.Sin(sinePosition + waveDisplacement);

        return waveValue * lightMaxFlickeringIntensity;
    }

    private void UpdateLightIntensities()
    {
        float flickerValue = CalculateNewFlickerMultiplierValue();
        float newIntensity = lightIntensityMultiplier 
            + flickerValue * EasingFunctions.ApplyEase(lightIntensityMultiplier, EasingFunctions.Functions.OutExpo);

        if(newIntensity < 0)
            newIntensity = 0;


        foreach (Light light in myLights)
        {
            light.intensity = newIntensity;
        }
    }
}
