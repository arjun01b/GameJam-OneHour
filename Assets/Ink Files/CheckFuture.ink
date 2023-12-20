// Last character spoken to is the Char number we give each character.
=== possibleFutures ===
I take a deep breath and activate the clock.
The room around begins to phase and the clock's arms spin.
I close my eyes and concentrate.
...

// Is last future possible still?
{
    // After first conversation.
    // (Ending 1) Basic ending.    
    - !hasTalkedToChar3 && lastEndingSeen == 1 && whoHoldsTheClock == char0:
        -> repeatSightOfLastFuture
    
    // (Ending 2) Ending where char2 is given the clock and is sent to char1's room LATE, and char3 got the Dagger.
    - !hasTalkedToChar3 && lastEndingSeen == 2 && succesfullyHidFromChar2:
        -> repeatSightOfLastFuture
        
    // (Ending 3) Ending where char2 is NOT given the clock and is sent to char1's room LATE, and char3 got the Dagger. Char4 was NOT convinced to help.
    - !hasTalkedToChar3 && lastEndingSeen == 3 &&  succesfullyHidFromChar2:
        -> repeatSightOfLastFuture
        
    // (Ending 4) Ending where char4 is given the clock and CONVINCED to help. Char2 is sent to char1's room LATE and char3 got the Dagger.
    - !hasTalkedToChar3 && lastEndingSeen == 4 &&  succesfullyHidFromChar2:
        -> repeatSightOfLastFuture
        
    // (Ending 5) Ending where char2 IS given the clock, IS sent LATE to char1's room, and char3 did NOT get the Dagger.
    - !hasTalkedToChar3 && lastEndingSeen == 5 &&  succesfullyHidFromChar2:
        -> repeatSightOfLastFuture
                
    // (Ending 6) Ending where char2 IS given the clock and is NOT sent late to char1's room.
    - !hasTalkedToChar3 && lastEndingSeen == 6 && (whoHoldsTheClock == char2 || succesfullyHidFromChar2):
        -> repeatSightOfLastFuture
        
    // (Ending 7) Ending where char4 is given the clock and CONVINCED. Char2 is NOT sent late to char1's room.
    - !hasTalkedToChar3 && lastEndingSeen == 7 && whoHoldsTheClock == 0:
        -> repeatSightOfLastFuture
        
    // (Ending 8) Ending where char4 is given the clock but she is NOT convinced to help. Char2 IS sent late to char1's room. Char3 is not given the Dagger.
    - !hasTalkedToChar3 && lastEndingSeen == 8 &&  succesfullyHidFromChar2:
        -> repeatSightOfLastFuture
        
    // (Ending 9) Ending where char4 is given the clock but she is NOT convinced to help. Char2 is NOT sent late to char1's room.
    - !hasTalkedToChar3 && lastEndingSeen == 9 && whoHoldsTheClock == char0:
        -> repeatSightOfLastFuture
        
    // (Ending 10) Char3 is given the clock. He escapes afterwards.
    - !hasTalkedToChar3 && lastEndingSeen == 10:
        -> repeatSightOfLastFuture
        
    ///////////////////////////////////////////////////////////////
    
    // After second conversation.
    // (Ending 1) Basic ending.    
    - hasTalkedToChar3 && !hasTalkedToChar4 && lastEndingSeen == 1 && whoHoldsTheClock == char0 && (!wasChar2SentToChar1Room ||  !succesfullyHidFromChar2):
        -> repeatSightOfLastFuture
    
    // (Ending 2) Ending where char2 is given the clock and is sent to char1's room LATE, and char3 got the Dagger.
    - hasTalkedToChar3 && !hasTalkedToChar4 && lastEndingSeen == 2 && whoHoldsTheClock == char2 && wasChar2SentToChar1Room && succesfullyHidFromChar2 && didMurderGetTheDagger:
        -> repeatSightOfLastFuture
        
    // (Ending 3) Ending where char2 is NOT given the clock and is sent to char1's room LATE, and char3 got the Dagger. Char4 was NOT convinced to help.
    - hasTalkedToChar3 && !hasTalkedToChar4 && lastEndingSeen == 3 && whoHoldsTheClock != char2 && wasChar2SentToChar1Room &&  succesfullyHidFromChar2 && didMurderGetTheDagger:
        -> repeatSightOfLastFuture
        
    // (Ending 4) Ending where char4 is given the clock and CONVINCED to help. Char2 is sent to char1's room LATE and char3 got the Dagger.
    - hasTalkedToChar3 && !hasTalkedToChar4 && lastEndingSeen == 4 && whoHoldsTheClock == char0 && wasChar2SentToChar1Room &&  succesfullyHidFromChar2 && didMurderGetTheDagger:
        -> repeatSightOfLastFuture
        
    // (Ending 5) Ending where char2 IS given the clock, IS sent LATE to char1's room, and char3 did NOT get the Dagger.
    - hasTalkedToChar3 && !hasTalkedToChar4 && lastEndingSeen == 5 && whoHoldsTheClock == char2 && wasChar2SentToChar1Room &&  succesfullyHidFromChar2 && !didMurderGetTheDagger:
        -> repeatSightOfLastFuture
                
    // (Ending 6) Ending where char2 IS given the clock and is NOT sent late to char1's room.
    - hasTalkedToChar3 && !hasTalkedToChar4 && lastEndingSeen == 6 && whoHoldsTheClock == char2 && (!wasChar2SentToChar1Room ||  !succesfullyHidFromChar2):
        -> repeatSightOfLastFuture
        
    // (Ending 7) Ending where char4 is given the clock and CONVINCED. Char2 is NOT sent late to char1's room.
    - hasTalkedToChar3 && !hasTalkedToChar4 && lastEndingSeen == 7 && whoHoldsTheClock == char0 && (!wasChar2SentToChar1Room || !succesfullyHidFromChar2):
        -> repeatSightOfLastFuture
        
    // (Ending 8) Ending where char4 is given the clock but she is NOT convinced to help. Char2 IS sent late to char1's room. Char3 is not given the Dagger.
    - hasTalkedToChar3 && !hasTalkedToChar4 && lastEndingSeen == 8 && whoHoldsTheClock == char0 && !didMurderGetTheDagger && wasChar2SentToChar1Room && succesfullyHidFromChar2:
        -> repeatSightOfLastFuture
        
    // (Ending 9) Ending where char4 is given the clock but she is NOT convinced to help. Char2 is NOT sent late to char1's room.
    - hasTalkedToChar3 && !hasTalkedToChar4 && lastEndingSeen == 9 && whoHoldsTheClock == char0 && (!wasChar2SentToChar1Room ||  !succesfullyHidFromChar2):
        -> repeatSightOfLastFuture
        
    // (Ending 10) Char3 is given the clock. He escapes afterwards.
    - hasTalkedToChar3 && !hasTalkedToChar4 && lastEndingSeen == 10 && whoHoldsTheClock == char3:
        -> repeatSightOfLastFuture
        
    ///////////////////////////////////////////////////////////////
    
    // After thrid conversation.
    // (Ending 1) Basic ending.    
    - hasTalkedToChar4 && lastEndingSeen == 1 && whoHoldsTheClock == char0 && (!wasChar2SentToChar1Room ||  !succesfullyHidFromChar2):
        -> repeatSightOfLastFuture
    
    // (Ending 2) Ending where char2 is given the clock and is sent to char1's room LATE, and char3 got the Dagger.
    - hasTalkedToChar4 && lastEndingSeen == 2 && whoHoldsTheClock == char2 && wasChar2SentToChar1Room && succesfullyHidFromChar2 && didMurderGetTheDagger:
        -> repeatSightOfLastFuture
        
    // (Ending 3) Ending where char2 is NOT given the clock and is sent to char1's room LATE, and char3 got the Dagger. Char4 was NOT convinced to help.
    - hasTalkedToChar4 && lastEndingSeen == 3 && whoHoldsTheClock != char2 && wasChar2SentToChar1Room &&  succesfullyHidFromChar2 && didMurderGetTheDagger && !wasChar4ConvincedToHelp:
        -> repeatSightOfLastFuture
        
    // (Ending 4) Ending where char4 is given the clock and CONVINCED to help. Char2 is sent to char1's room LATE and char3 got the Dagger.
    - hasTalkedToChar4 && lastEndingSeen == 4 && whoHoldsTheClock == char4 && wasChar2SentToChar1Room &&  succesfullyHidFromChar2 && didMurderGetTheDagger && wasChar4ConvincedToHelp:
        -> repeatSightOfLastFuture
        
    // (Ending 5) Ending where char2 IS given the clock, IS sent LATE to char1's room, and char3 did NOT get the Dagger.
    - hasTalkedToChar4 && lastEndingSeen == 5 && whoHoldsTheClock == char2 && wasChar2SentToChar1Room &&  succesfullyHidFromChar2 && !didMurderGetTheDagger:
        -> repeatSightOfLastFuture
                
    // (Ending 6) Ending where char2 IS given the clock and is NOT sent late to char1's room.
    - hasTalkedToChar4 && lastEndingSeen == 6 && whoHoldsTheClock == char2 && (!wasChar2SentToChar1Room ||  !succesfullyHidFromChar2):
        -> repeatSightOfLastFuture
        
    // (Ending 7) Ending where char4 is given the clock and CONVINCED. Char2 is NOT sent late to char1's room.
    - hasTalkedToChar4 && lastEndingSeen == 7 && whoHoldsTheClock == char4 && wasChar4ConvincedToHelp && (!wasChar2SentToChar1Room || !succesfullyHidFromChar2):
        -> repeatSightOfLastFuture
        
    // (Ending 8) Ending where char4 is given the clock but she is NOT convinced to help. Char2 IS sent late to char1's room. Char3 is not given the Dagger.
    - hasTalkedToChar4 && lastEndingSeen == 8 && whoHoldsTheClock == char4 && !wasChar4ConvincedToHelp && !didMurderGetTheDagger && wasChar2SentToChar1Room &&  succesfullyHidFromChar2:
        -> repeatSightOfLastFuture
        
    // (Ending 9) Ending where char4 is given the clock but she is NOT convinced to help. Char2 is NOT sent late to char1's room.
    - hasTalkedToChar4 && lastEndingSeen == 9 && whoHoldsTheClock == char4 && !wasChar4ConvincedToHelp && (!wasChar2SentToChar1Room ||  !succesfullyHidFromChar2):
        -> repeatSightOfLastFuture
        
    // (Ending 10) Char3 is given the clock. He escapes afterwards.
    - hasTalkedToChar4 && lastEndingSeen == 10 && whoHoldsTheClock == char3:
        -> repeatSightOfLastFuture
}
    
// If no future is repeated, we determine which future is most likely to occur and show that future:
{
    // After the first conversation:
    // (Ending 1) Basic ending.   
    - !hasTalkedToChar3 && whoHoldsTheClock == char0:
        -> possibleFutures.basicEnding
        
    // (Ending 5) Ending where char2 IS given the clock, IS sent LATE to char1's room, and char3 did NOT get the Dagger.
    - !hasTalkedToChar3 && whoHoldsTheClock == char2:
        -> possibleFutures.char1DeadAndChar2Shot
        
    
    //////////////////////////////////////////////////////////////
    
    // After the second conversation:
    // (Ending 1) Basic ending.   
    - hasTalkedToChar3 && !hasTalkedToChar4 && whoHoldsTheClock == char0 && (!wasChar2SentToChar1Room ||  !succesfullyHidFromChar2):
        -> possibleFutures.basicEnding
        
    // (Ending 2) Ending where char2 is given the clock and is sent to char1's room LATE, and char3 got the Dagger.
    - hasTalkedToChar3 && !hasTalkedToChar4 && whoHoldsTheClock == char2 && wasChar2SentToChar1Room && succesfullyHidFromChar2 && didMurderGetTheDagger:
        -> possibleFutures.stabbingDaggerEnding1
        
    // (Ending 3) Ending where char2 is NOT given the clock and is sent to char1's room LATE, and char3 got the Dagger. Char4 was NOT convinced to help.
    - hasTalkedToChar3 && !hasTalkedToChar4 && whoHoldsTheClock == char0 && wasChar2SentToChar1Room && succesfullyHidFromChar2 && didMurderGetTheDagger:
        -> possibleFutures.stabbingDaggerEnding2
        
    // (Ending 5) Ending where char2 IS given the clock, IS sent LATE to char1's room, and char3 did NOT get the Dagger.
    - hasTalkedToChar3 && !hasTalkedToChar4 && whoHoldsTheClock == char2 && wasChar2SentToChar1Room && succesfullyHidFromChar2 && !didMurderGetTheDagger:
        -> possibleFutures.char1SavedAndChar2Shot
                
    // (Ending 6) Ending where char2 IS given the clock and is NOT sent late to char1's room.
    - hasTalkedToChar3 && !hasTalkedToChar4 && whoHoldsTheClock == char2 && (!wasChar2SentToChar1Room ||  !succesfullyHidFromChar2):
        -> possibleFutures.char1DeadAndChar2Shot
        
    // (Ending 8) Ending where char4 is given the clock but she is NOT convinced to help. Char2 IS sent late to char1's room. Char3 is not given the Dagger.
    - hasTalkedToChar3 && !hasTalkedToChar4 && whoHoldsTheClock == char0 && !didMurderGetTheDagger && wasChar2SentToChar1Room && succesfullyHidFromChar2:
        -> possibleFutures.char1SavedAndChar4Shot
        
    // (Ending 10) Char3 is given the clock. He escapes afterwards.
    - hasTalkedToChar3 && !hasTalkedToChar4 && whoHoldsTheClock == char3:
        -> possibleFutures.noDeadKillerEscapes
        
        
    //////////////////////////////////////////////////////////////
    
    // After the third conversation:
    // (Ending 1) Basic ending.    
    - hasTalkedToChar4 && whoHoldsTheClock == char0 && (!wasChar2SentToChar1Room ||  !succesfullyHidFromChar2):
        -> possibleFutures.basicEnding
    
    // (Ending 2) Ending where char2 is given the clock and is sent to char1's room LATE, and char3 got the Dagger.
    - hasTalkedToChar4 && whoHoldsTheClock == char2 && wasChar2SentToChar1Room && succesfullyHidFromChar2 && didMurderGetTheDagger:
        -> possibleFutures.stabbingDaggerEnding1
        
    // (Ending 3) Ending where char2 is NOT given the clock and is sent to char1's room LATE, and char3 got the Dagger. Char4 was NOT convinced to help.
    - hasTalkedToChar4 && whoHoldsTheClock != char2 && wasChar2SentToChar1Room &&  succesfullyHidFromChar2 && didMurderGetTheDagger && !wasChar4ConvincedToHelp:
        -> possibleFutures.stabbingDaggerEnding2
        
    // (Ending 4) Ending where char4 is given the clock and CONVINCED to help. Char2 is sent to char1's room LATE and char3 got the Dagger.
    - hasTalkedToChar4 && whoHoldsTheClock == char4 && wasChar2SentToChar1Room &&  succesfullyHidFromChar2 && didMurderGetTheDagger && wasChar4ConvincedToHelp:
        -> possibleFutures.stabbingDaggerEnding3
        
    // (Ending 5) Ending where char2 IS given the clock, IS sent LATE to char1's room, and char3 did NOT get the Dagger.
    - hasTalkedToChar4 && whoHoldsTheClock == char2 && wasChar2SentToChar1Room &&  succesfullyHidFromChar2 && !didMurderGetTheDagger:
        -> possibleFutures.char1SavedAndChar2Shot
                
    // (Ending 6) Ending where char2 IS given the clock and is NOT sent late to char1's room.
    - hasTalkedToChar4 && whoHoldsTheClock == char2 && (!wasChar2SentToChar1Room ||  !succesfullyHidFromChar2):
        -> possibleFutures.char1DeadAndChar2Shot
        
    // (Ending 7) Ending where char4 is given the clock and CONVINCED. Char2 is NOT sent late to char1's room.
    - hasTalkedToChar4 && whoHoldsTheClock == char4 && wasChar4ConvincedToHelp && (!wasChar2SentToChar1Room || !succesfullyHidFromChar2):
        -> possibleFutures.char1DeadAndEveryoneElseSaved
        
    // (Ending 8) Ending where char4 is given the clock but she is NOT convinced to help. Char2 IS sent late to char1's room. Char3 is not given the Dagger.
    - hasTalkedToChar4 && whoHoldsTheClock == char4 && !wasChar4ConvincedToHelp && !didMurderGetTheDagger && wasChar2SentToChar1Room &&  succesfullyHidFromChar2:
        -> possibleFutures.char1SavedAndChar4Shot
        
    // (Ending 9) Ending where char4 is given the clock but she is NOT convinced to help. Char2 is NOT sent late to char1's room.
    - hasTalkedToChar4 && whoHoldsTheClock == char4 && !wasChar4ConvincedToHelp && (!wasChar2SentToChar1Room ||  !succesfullyHidFromChar2):
        -> possibleFutures.char1DeadAndChar4Shot
        
    // (Ending 10) Char3 is given the clock. He escapes afterwards.
    - hasTalkedToChar4 && whoHoldsTheClock == char3:
        -> possibleFutures.noDeadKillerEscapes
        
    - else:
        ERROR YOU SHOULD NOT HAVE ARRIVED TO THE END OF THE POSSIBLE ENDINGS LIST
        -> afterConversation.afterClock
}
    


// List of possible endings.

// = goodEnding (Ending 0) // NOT POSSIBLE TO SEE IT WITH THE CLOCK

= basicEnding // (Ending 1) Main Ending. Ben and Jane are dead and the clock is with Cole
Just like the first time, my dead body is waiting for me, still shot through the chest.

Surrounding my corpse are {char2}, {char3}, {char4}. Again, they don't notice my ghostly presence.

{char2}: Someone shot him! Who did it!? I know it was one of you!
{char3}: Of course it was one of us, we all heard the shot from within the room.
{char4}: Oh, lord! Stay away from me!
{char3}: (looking at {char2}) Probably the same one who murdered {char1}.
{char2}: (Starting to get red) You take that dirty look away from me, I killed no one, I swear on my momma's grave.
{char3}: We all know who of the three of us is more prone to senseless violence!
{char4}: {char2}, what have you done?!
{char2}: I did NOTHING, what did YOU do?!

The argument is hard to follow as the voices rise higher and I loose my focus.

~ lastEndingSeen = 1
-> returnToMainThread

= stabbingDaggerEnding1 // (Ending 2) Jane and Holden are murdered with the Dagger.
{char4} and yourself are standing alone in the middle of the room.
{char4} seems to be extremely distressed.

{char4}: You don't know what I saw, Ben. They both bled to death. It is horrible.
{char0}: Alright, tell me everything you saw, step by step.
{char4}: Do you think you are a detective?! Is this a game to you?
{char0}: (Calmly) No, but it is important that we gather all the facts...
{char4}: The facts are {char3} went to {char1}'s room. The facts are that he stabbed {char2} and {char1}. The facts are that our family is broken.

For a second, future-you glances towards your direction.

{char0}: Ok, did you see a clock anywhere in...
{char4}: Wake up, THEY ARE DEAD! BE MAD FOR CRYING OUT LOUD!

~ lastEndingSeen = 2
-> returnToMainThread

= stabbingDaggerEnding2 // (Ending 3) Everyone is killed with the Dagger by char3.
The room stops its transformation.
Immediatly, you notice your dead body laying on the desk.
The family Dagger is stuck inside of your chest.

You also notice a trail of blood droplets coming and leaving through the office door.
Only the wind can be heard. Silence ominously fills the room.

~ lastEndingSeen = 3
-> returnToMainThread

= stabbingDaggerEnding3 // (Ending 4) Char3 kills char1 & char2 with the Dagger, then get's ambushed by char4, who has the clock and has been convinced to help you. In the struggle after the ambush, char3 pulls out a gun and char4 ends up shooting him.
The room is no longer pristinely clean like it was before.

In its middle, {char3} lays dead with a bullet hole in its chest.
Kneeled next to him, {char4} cries uncontrollably. She is holding a gun.

{char3}: He, he killed bo-, both of them... I didnt mean to kill him... But, but, he killed them and he was going to, to ...

Future-you is above her, apparently trying to console her.

{char0}: It was self defence, he had the gun and the dagger. He attacked us.
{char4}: Just because the clock said, said so it does not mean he, he was gonna...
{char0}: I'm afraid it does. Trust me.

With those last words, future-you turns towards where you currently stand.

~ lastEndingSeen = 4
-> returnToMainThread


= char1SavedAndChar2Shot // (Ending 5) Char3 does not kill char1. Instead, he shoots char2 and steals the clock from them.
Before you open your eyes, you can already listen to a big argument.
In the floor lies {char2}, bleeding to death through a gun shot in the chest.
Around his body stand {char3}, {char4}, {char1} and yourself.

{char1}: What kind of monster would shoot their own brother!?
{char0}: I don't know, but it was one of us.
{char4}: Oh, lord!
{char3}: Of course it was one of us, we all heard the shot from within the room.
{char0}: It is also interesting that the clock she was holding is no longer on her.
{char3}: Stop worrying about the damn clock, someone is DEAD!

You catch a quick glance from future-you towards your direction.

~ lastEndingSeen = 5
-> returnToMainThread

= char1DeadAndChar2Shot // (Ending 6) Char3 kills char1 looking for the clock. He then shoots char2 and steals the clock from him.
With your eyes still blurry, you identify a pool of blood on the floor ahead of you.
There lies the body of {char2}, shot through the chest.
Around the body stands {char3}, {char4} and yourself.

{char3}: (Visibly altered) Both of you stay the hell away from me!
{char4}: You stay you creep! You killed {char1} and {char2}. You are the only one that could kill both! 
{char3}: Yeah, blame me. But the one that has secretly been altering dad's will the whole night is Mr. Executor here.
{char0}: I've been doing that to stop the killer from murdering me. I just did not expect it to end this way...
{char2}: (Clenching his fist) You knew there was a murder and you did nothing to warn us?
{char0}: It wouldn't have worked even if I tried... It doesn't matter anymore.

~ lastEndingSeen = 6
-> returnToMainThread

= char1DeadAndEveryoneElseSaved // (Ending 7) Char3 kills char1 looking for the clock. He is then ambushed by char4, who reduces him with the help of char2.
You open you eyes to a crowd surrounding an inmobile Cole that lays on the floor.
{char2} stands nearby, throughly inspecting a pistol.
{char4} and yourself are next to {char2}.

{char4}: How could you do it you bastard!
{char4}: Dang murderer!
{char2}: The police better take him away before he wakes up. Or I'll have my way with him.

{
    - didMurderGetTheDagger:
        {char0}: (Checking {char2}'s right hand) He has dry blood in his finger tips, there's no doubt he did it.
    - else:
        {char0}: (Checking {char2}'s bruished face) Punch aside, his face is also covered with small scratches.
        {char2}: What does that mean?
        {char0}: {char1} was fought back.
}

{char2}'s fist tighten.
{
    - wasChar2SentToChar1Room:
        {char2}: If only I had arrived a few minutes later to her room. I could have SAVED HER!
        He punches the table, leaving a considerable mark.
    - else:
        {char2}: He should have tried this with me in the room. How different things would be...
}

~ lastEndingSeen = 7
-> returnToMainThread

= char1SavedAndChar4Shot // (Ending 8) Char3 does not kill char1. Instead, he shoots char4 and steals the clock from her.
Before you open your eyes, you can already listen to a big argument.
In the floor lies {char4}, bleeding to death through a gun shot in the chest.
Around her body stand {char2}, {char3}, {char1} and yourself.

{char1}: What kind of monster would shoot their own sister!?
{char0}: I don't know, but it was one of us.
{char3}: Of course it was one of us, we all heard the shot from within the room.
{char2}: Where is dad's clock? {char4} was holding when she entered the room.
{char3}: Stop worrying about the damn clock, someone is DEAD!

You catch a quick glance from future-you towards your direction.

~ lastEndingSeen = 8
-> returnToMainThread

= char1DeadAndChar4Shot // (Ending 9) Char3 kills char1 looking for the clock. He then shoots char4 and steals the clock from her.
With your eyes still blurry, you identify a pool of blood on the floor ahead of you.
There lies the body of Lilly, shot through the chest.
Around the body stands {char2}, {char3} and yourself.

{char3}: (Visibly altered) Both of you stay the hell away from me!
{char2}: I could never kill {char4}, let alone {char1}? I bet this is your doing!
{char3}: Yeah, blame me. But the one that has secretly been altering dad's will the whole night is Mr. Executor here.
{char0}: I've been doing that to stop the killer from murdering me. I just did not expect it to end this way...
{char2}: (Clenching his fist) You knew there was a murder and you did nothing to warn us?
{char0}: It wouldn't have worked even if I tried... It doesn't matter anymore.

~ lastEndingSeen = 9
-> returnToMainThread

= noDeadKillerEscapes // (Ending 10) Char3 is given the clock. He escapes afterwards.
You open your eyes and in the room stands Lilly, Jane, Holden and yourself.
The group is discussing various matters.
Only future-you seems aware of your presence.

{char4}: I can't believe that fool {char2} would leave us to discuss the general matters of the inheritance.
{char4}: We can know distribute everything that Dad forgot to include as we please.
{char2}: I know right? But does it really matter? His loss.

~ lastEndingSeen = 10
-> returnToMainThread


=== repeatSightOfLastFuture === // We do this when players are seeing the last future they experience. It saves time for them.
The last possible future I experienced is still possible. So the clock will just show me the same future again.

*   [I watch it regardless.]
    {
        - lastEndingSeen == 1:
            -> possibleFutures.basicEnding
        - lastEndingSeen == 2:
            -> possibleFutures.stabbingDaggerEnding1
        - lastEndingSeen == 3:
            -> possibleFutures.stabbingDaggerEnding2
        - lastEndingSeen == 4:
            -> possibleFutures.stabbingDaggerEnding3
        - lastEndingSeen == 5:
            -> possibleFutures.char1SavedAndChar2Shot
        - lastEndingSeen == 6:
            -> possibleFutures.char1DeadAndChar2Shot
        - lastEndingSeen == 7:
            -> possibleFutures.char1DeadAndEveryoneElseSaved
        - lastEndingSeen == 8:
            -> possibleFutures.char1SavedAndChar4Shot
        - lastEndingSeen == 9:
            -> possibleFutures.char1DeadAndChar4Shot
        - lastEndingSeen == 10:
            -> possibleFutures.noDeadKillerEscapes
        - else:
            ERROR, NO POSSIBLE FUTURE REGISTERED FOR lastEndingSeen == {lastEndingSeen}.
            -> afterConversation.afterClock
    }

*   [I change my mind.]
    I break my focus to return to the present.
    The room is no longer phasing and the clock ticks like usual.
    -> afterConversation.afterClock


=== returnToMainThread ===
My strained concentration fails me, and the meditative state I was in collapses.
As I'm are pulled from the vision, the world around me warps back into the present.
-> afterConversation.afterClock