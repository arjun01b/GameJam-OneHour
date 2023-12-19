INCLUDE CharacterNames.ink
INCLUDE GlobalVariables.ink
INCLUDE ConversationWithChar1.ink
INCLUDE ConversationWithChar2.ink
INCLUDE ConversationWithChar3.ink
INCLUDE ConversationWithChar4.ink
INCLUDE Prologue.ink
INCLUDE Endings.ink
INCLUDE CheckFuture.ink


-> storyBeginning

=== storyBeginning === // We begin our story in the prologue.
-> resetAllGlobalVariables(->prologue)

=== afterConversation === // After every conversation, come here.

= beforeClock
-> checkIfPlayerWantsToUseClock

= afterClock
{
    // Char 2 is approaching.
    - !hasTalkedToChar2 && !hasTalkedToChar3 && !hasTalkedToChar4 && !succesfullyHidFromChar2:
        -> hideUnderDesk(char2)
        
    // Conversation with Char 2 after having hidden under the desk.
    - !hasTalkedToChar2 && hasTalkedToChar3 && !hasTalkedToChar4:
        THIS IS AN ERROR
        YOU SHOULD NOT CALL afterConversation.afterClock for the Char2 CONVERSATION AFTER HIDING UNDER THE DESK
        -> char2conversation.char2_hideUnderDesk
    
    // Normal conversation with Char 3.   
    - !hasTalkedToChar2 && !hasTalkedToChar3 && !hasTalkedToChar4 && succesfullyHidFromChar2:
        -> hideUnderDesk(char3)
        
    // Normal conversation with Char 4.
    - hasTalkedToChar2 && hasTalkedToChar3 && !hasTalkedToChar4:
        -> hideUnderDesk(char4)
        
    - else:
        -> afterConversation.beginNextConversation
}

= beginNextConversation
{
    // Normal conversation with Char 2.
    - !hasTalkedToChar2 && !hasTalkedToChar3 && !hasTalkedToChar4 && !succesfullyHidFromChar2:
        -> char2conversation
        
    // Conversation with Char 2 after having hidden under the desk.
    - !hasTalkedToChar2 && hasTalkedToChar3 && !hasTalkedToChar4:
        -> char2conversation.char2_hideUnderDesk
    
    // Normal conversation with Char 3.   
    - !hasTalkedToChar2 && !hasTalkedToChar3 && !hasTalkedToChar4 && succesfullyHidFromChar2:
        -> char3conversation
        
    // Normal conversation with Char 4.
    - hasTalkedToChar2 && hasTalkedToChar3 && !hasTalkedToChar4:
        -> char4conversation
        
    // Ending scene.
    - hasTalkedToChar2 && hasTalkedToChar3 && hasTalkedToChar4:
        -> endOfLoopConversation
        
    - else:
        You should not be here. Check beginNextConversation knot for possible error.
        -> DONE
} 

= endOfLoopConversation
{
// These are all of the possible endings (EXCEPT FOR THE ONE WHERE we give the clock to the executor.)

    // Ending where char2 is given the clock and is sent to char1's room LATE, and char3 got the Dagger.
    - whoHoldsTheClock == char2 && wasChar2SentToChar1Room && succesfullyHidFromChar2 && didMurderGetTheDagger:
        -> ending.stabbingDaggerEnding1
        
    // Ending where char2 is NOT given the clock and is sent to char1's room LATE, and char3 got the Dagger. Char4 was NOT convinced to help.
    - whoHoldsTheClock != char2 && wasChar2SentToChar1Room &&  succesfullyHidFromChar2 && didMurderGetTheDagger && !wasChar4ConvincedToHelp:
        -> ending.stabbingDaggerEnding2
        
    // Ending where char4 is given the clock and CONVINCED to help. Char2 is sent to char1's room LATE and char3 got the Dagger.
    - whoHoldsTheClock == char4 && wasChar2SentToChar1Room &&  succesfullyHidFromChar2 && didMurderGetTheDagger && wasChar4ConvincedToHelp:
        -> ending.stabbingDaggerEnding3
        
    // Ending where char2 IS given the clock, IS sent LATE to char1's room, and char3 did NOT get the Dagger.
    - whoHoldsTheClock == char2 && wasChar2SentToChar1Room &&  succesfullyHidFromChar2 && !didMurderGetTheDagger:
        -> ending.char1SavedAndChar2Shot
                
    // Ending where char2 IS given the clock and is NOT sent late to char1's room.
    - whoHoldsTheClock == char2 && (!wasChar2SentToChar1Room ||  !succesfullyHidFromChar2):
        -> ending.char1DeadAndChar2Shot
        
    // Ending where char4 is given the clock but she is NOT convinced to help. Char2 is NOT sent late to char1's room.
    - whoHoldsTheClock == char4 && !wasChar4ConvincedToHelp && (!wasChar2SentToChar1Room ||  !succesfullyHidFromChar2):
        -> ending.char1DeadAndChar4Shot
        
    // Ending where char4 is given the clock but she is NOT convinced to help. Char2 IS sent late to char1's room. Char3 is not given the Dagger.
    - whoHoldsTheClock == char4 && !wasChar4ConvincedToHelp && !didMurderGetTheDagger && wasChar2SentToChar1Room &&  succesfullyHidFromChar2:
        -> ending.char1DeadAndChar4Shot //-> ending.char1SavedAndChar4Shot TEMP
        
    // Ending where char4 is given the clock and CONVINCED. Char2 is NOT sent late to char1's room.
    - whoHoldsTheClock == char4 && wasChar4ConvincedToHelp && (!wasChar2SentToChar1Room ||  !succesfullyHidFromChar2):
        -> ending.char1DeadAndEveryoneElseSaved
        
    // Good ending, everyone saved and murder stopped.
    - whoHoldsTheClock == char4 && wasChar4ConvincedToHelp && !didMurderGetTheDagger && wasChar2SentToChar1Room && succesfullyHidFromChar2:
        -> ending.goodEnding
        
    // Basic ending.    
    - else: 
        -> ending.basicEnding
}

=== checkIfPlayerWantsToUseClock === // Repeated action after conversation.
{
    - whoHoldsTheClock != char0:
    Since I no longer have the clock, I cannot see what lies ahead of them.
        -> afterConversation.afterClock
}

{
    - hasUsedClockBefore == false:
        -> firstTimeUsingClock
        
    - else:
        -> useClockNormally
}


= firstTimeUsingClock
I pull the clock out of my bag. It's ominous ticking felt like it was taunting me.
I don't see any of us wanting this relic.
+   [Mess around with the clock.]
-I shift the clock around, trying to see if there was something of interest.
What had my father seen?
I pause suddenly, sensing something at the base of the screen.
A button?
A hidden button.

+   [Press the button.]
-
~ hasUsedClockBefore = true
I press the button slightly, expecting a puzzle box to open.
Suddenly, the room begins to phase around me.
I try to stand but I cannot move.

The room settles and I see myself sitting in the chair, a sort of out of body experience.
I try to reach forward, but I notice that I'm just a wisp of blue.
{char3}, {char2} and {char4} are in the room with me, but they don't notice my ghostly presence.

There's a lightning strike outside, that causes the room to plunge into darkness.
A gun goes off and I hear someone cry out in pain.
Unknown: "What was that?!"
Unknown: "A gun!?"

The lights come back on.
A smoking gun lies in the middle of the room.
My other self stands with a wound in his chest.
{char2}, {char3} and {char4} look at him in utter shock.
He turns to me, as if he could see me.
{futchar0}: The clock shows you the future, use it well.
{futchar0}: This happens an hour from your time.
I see the light leave his eyes as he falls forward onto the desk.

I loose focus, the scene starts warping around me again until I'm back to the present.
I stuff the clock back into the bag, terrified by what I had seen.

+   [Take a deep breath]
- I force myself to take a deep breath.
This is no time to panic.
In an hour, I'll be dead.
Whatever I do next might lead to or away from that.
-> afterConversation.afterClock
        
        
= useClockNormally
I pull out the clock again. It seems to leer at me.
Should I check the future?
    + [Press the hidden button.]
        -> possibleFutures

    + [Ignore the clock and wait for the next person.]
        I patiently wait in my seat.
        -> afterConversation.afterClock

=== hideUnderDesk(characterApproaching) === // Before conversations with char2, char3, and char4; we come to this thread.
Someone's approaching the door.
{
    - hasHiddenBefore == false:      //Devnote: Change this to be hasHiddenBefore
    ~ hasHiddenBefore = true
    An idea flashes my mind.
    How about hiding under the desk? //Note: give another option to this in v2
    That way they might not see me and I can test if the vision changes!
    What should I do?
    
- else:
    //Note: Make two versions of this line in v2 for variety
    Maybe I could try hiding again!
    It couldn't hurt, could it?
}

I...
+ [Hide under the desk.]
    I rush to hide under the desk, holding my breath as I waited.
    {
        - characterApproaching == char2:
            //-> char2approaching //Remove if hidingfromchar series works
            -> char2conversation.char2_hideUnderDesk
            
        - characterApproaching == char3:
            //-> char3approaching //Remove if hidingfromchar series works
            -> char3conversation.char3_hideUnderDesk
            
        - characterApproaching == char4:
            //-> char4approaching //Remove if hidingfromchar series works
            -> char4conversation.char4_hideUnderDesk
            
        - else:
            Devnote: I should not have arrived to this point. Check the hideUnderDesk node.
    }
    
+ [Stay where I am.]
    I resist my childish impulsions.
    I should face this head on.
    -> afterConversation.beginNextConversation
    
/* Remove if hidingfromchar series works
= char2approaching
{char2} enters the room, his heavy boots causing the floorboards to squeak.
I silently pray he doesn't notice me...
{char2}: Benjamin? Are you here?
{char2}: Huh... Maybe he left to get some water.
{char2}: I should check in the kitchen.
I hear him leaving, the squeaking boards following his footsteps.
I breathe a sigh of relief.
~ succesfullyHidFromChar2 = true
-> afterConversation.beforeClock

= char3approaching
I hear {char3} enter the room, pausing at the door for a moment.
Maybe he'll leave?
He walks around the desk, sitting in the chair, his gaze directly meeting mine.
I almost shriek out of utter surprise.
{char3}: You were never good at hide and seek, Benji.
~ hasBeenFoundUnderDeskBefore = true

+[Tell him you were checking if you'd gotten better.]
    {char0}: (Forcing a laugh) I was just checking if I'd gotten any better.
    {char0}: Guess not?
    {char3} gives me a disbelieving look before getting up.
    {char3}: Get out of there.
    He walks to the other side of the desk, sitting down on the chair as I take a seat, dusting myself off.
    -> char3conversation.char3_hideUnderDesk
+[Tell him you weren't expecting him yet.]
    {char0}: I wasn't expecting you yet.
    {char3} gives me a disbelieving look before getting up.
    {char3}: Get out of there.
    He walks to the other side of the desk, sitting down on the chair as I take a seat, dusting myself off.
    -> char3conversation.char3_hideUnderDesk

= char4approaching
I hear a faint knock before {char4} lets themself into the room. She walks towards the desk, her heels clacking over the wooden floor as she stands next to the desk, too close for comfort.
She hasn't noticed me yet, I might be able to get away—
A thin hand reaches from the side, tugging on one of the drawers making me yelp as the drawer opens with a jarring sound.
{char4} freezes.
{char4}: Benjamin?
~ hasBeenFoundUnderDeskBefore = true
+[I've already given myself away.]
    I stand up, brushing the dust off myself.
    {char0}: Hello Lilly.
    {char4}: And to you.
    She looks me over, seeming like she was assessing me.
    {char4}: You look... well enough.
    -> char4conversation.char4_hideUnderDesk
+[She probably didn't notice me.]
    A quick patter of her heels, she whips away the chair, revealing my awkwardly hunched form under the desk.
    {char4}: What are you doing?
    ++["Tying my shoelaces."]
        {char0}: I was tying my shoelaces and I got stuck under there.
        {char0}: Thanks for helping me out.
        {char4}: I... see.
        She looks me over, seeming like she was assessing me.
        {char4}: You look... well enough.
        {char0}: I'm jolly good, thanks for noticing, how about yourself?
        {char4}: (Unamused) I'm doing great, thanks for asking I suppose.
        -> char4conversation.char4_hideUnderDesk    
    ++["Looking for my lucky penny."]
        {char0}: Sorry, I was just looking for my lucky penny.
        {char4}: Oh dear! Did you find it?
        {char0}: Yes, safely in my wallet now.
        {char4}: Why that's a relief.
        She looks me over, seeming like she was assessing me.
        {char4}: Looks like you need it.
        -> char4conversation.char4_hideUnderDesk

*/