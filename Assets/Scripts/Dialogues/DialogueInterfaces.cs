using UnityEngine.UI;

public interface IDialogueTextDisplayable
{
    /// <summary>
    /// Sets the Text that will be visible to the player.
    /// </summary>
    /// <param name="textToDisplay"></param>
    public void DisplayText(Text textToDisplay);
}

public interface IDialogueOptionsDisplayable
{
    public void DisplayOptions(string[] options);
    public void DisableOptions();
}

public interface IInkTagActionable
{
    /// <summary>
    /// Convert commands provided in an Ink file to in-game actions.
    /// \nThe commands should adhere to the following format inside the InkFile: #key:value
    /// </summary>
    /// <param name="key">The type of action to be performed.</param>
    /// <param name="value">The value of the action. This value variable can be empty.</param>
    public void ActOnInkTag(string key, string value = "");
}