=== char4conversation ===
{char4} 
{char0}: 
{char4}: 
-> normalConversation

= normalConversation
    *   [Q1]
        {char0}:
        {char4}:

    -> normalConversation

    *   [Personal Q.]
        {char0}: I wanted to ask you something.
    
        ** [BlaBla]
            {char0}: BlaBlaBla.
        
        ** [BlaBla2]
            {char0}: BlaBlaBla2.
        
    --  {char0}: TEMP focus on dad's will now.
        -> willReading

    *   [Skip to the will reading.]
        {char0}: TEMP let's focus on dad's will.
        -> willReading
        
= willReading
~ hasTalkedToChar4 = true
I look over what father had written for {char4}. It read:
"To my daughter {char4}, I leave this sealed letter, so she may remember my words when I am no longer there."

{char0}: Alright so here it says...
What should I give her?
    *   {isLetterAvailible}[Give the sealed letter]
        {char0}: To my daughter {char4}, I leave this sealed letter, so she may remember my words when I am no longer there.
        I pull the letter from my suitcase and hand it over to her.
         ~ isLetterAvailible = false

    *   {(isRingAvailible or isDaggerAvailible or whoHoldsTheClock == char0)}[Give another object]
        {char0}: To my daughter {char4}, I leave ...
        
        **  {isDaggerAvailible}[Give the dagger]
            {char0}: ... The family dagger, may she be able to protect herself from harm...
            I pull the dagger from my suitcase and hand it over to her.
             ~ isDaggerAvailible = false
            
        **  {isRingAvailible}[Give the ring]
            {char0}: ... My wedding ring, to which she's so fondly attached...
            I pull the ring from my suitcase and give it to her.
            
             ~ isRingAvailible = false
        
        **  {whoHoldsTheClock == char0}[Give the clock]
            {char0}: ... My clock, my prized possession, in the hands of one as capable as myself.
            
            I pull the clock from my bag and hand it over to her.
            She seems happy and content.
            
            {char4}: Thank you brother.
            
            She leaves with a big smile on her face and the clock's hanging its chain.
            ~ whoHoldsTheClock = char4
            -> afterConversation.afterClock

    
    *   [Don't give anything]
        {char0}: ... Nothing, for I expect him to create his own path in life.

- -> noClock


// Change. If she does not get the clock, she tries to bribe you to get it. In exchange for the clock (and learning how to use it), she agrees to help you.
= noClock
{char2}: WHAT?! Why did he not leave me mum's ring?! It was the only thing I asked of him!
    *   [I do not know.]
        {char2}: Damn you father.
        {char2} leaves the room.
        -> afterConversation.beforeClock
        
    *  [Someone else got the ring.]
        {char0}: Someone else asked for the ring from dad.
        {char2}: Who did?
        {char0}: I can't tell you.
        {char2}: (Getting red) Yes you can.
            **  [{char1} got it.]
                {char0}: {char1} got it.
                ~ wasChar2SentToChar1Room = true
                Still red, {char2} leaves the room.
                He seems to be headed towards {char1}'s room.
                -> afterConversation.beforeClock
                
        **  [{char3} got it.]
            {char0}: {char3} got it.
            Still red, {char2} leaves the room.
            Outside the room, you hear a loud conversation between {char2} and {char3}.
            However, they seem to die down after a bit.
            -> afterConversation.beforeClock
            
        **  [{char4} got it.]
            {char0}: {char4} got it.
            Still red, {char2} leaves the room.
            Outside the room, you hear a loud conversation between {char2} and {char4}.
            However, they seem to die down after a bit.
            -> afterConversation.beforeClock


= char4_hideUnderDesk
I hear a faint knock before {char4} lets herself into the room.
She walks towards the desk, her heels clacking over the floor as she stands beside it, too close for comfort.
She hasn't noticed me yet, I might be able to get away—
A thin hand reaches from the side, tugging on one of the drawers.
I yelp in surprise as the drawer opens with a jarring sound.
{char4} freezes.
{char4}: Benjamin?
~ hasBeenFoundUnderDeskBefore = true
+[I've already given myself away.]
    I stand up, brushing the dust off myself.
    {char0}: Hello Lilly.
    {char4}: And to you.
    She looks me over, seeming like she was assessing me.
    {char4}: You look... well enough.

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
        
    ++["Looking for my lucky penny."]
        {char0}: Sorry, I was just looking for my lucky penny.
        {char4}: Oh dear! Did you find it?
        {char0}: Yes, safely in my wallet now.
        {char4}: Why that's a relief.
        She looks me over, seeming like she was assessing me.
        {char4}: Looks like you need it.
        
--> normalConversation