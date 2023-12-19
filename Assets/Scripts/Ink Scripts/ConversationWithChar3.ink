=== char3conversation ===
~ hasTalkedToChar3 = true
{char3} enters the room, one hand holding his coat while the other casually in his pocket. He strides towards a chair, sitting down.
{char0}: Hello Cole, it's been a while—
{char3}: You know I'm not one for pleasantries, get to it.
-> normalConversation

= normalConversation
    *[Talk about the will.]
        {char0}: Ah... Sure, let's see...
        ->willReading
    *[Stall for time.]
        {char0}: Its been so long, it wouldn't hurt to talk—
        {char3}: (Glares) I didn't come all the way here to listen to you prattle, brother.
        {char3}: Read that damn will and let me be on my way.
        {char0}: Ah... Sure, let's see...
        ->willReading
    /* ---------------------------------
    =later conversation
   *   [Q1]
        {char0}:
        {char3}:

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

 ----------------------------------*/

= willReading
I glance at Cole's section of the will, it reads:
// Change letter to daga.
"To my son Cole, this sealed letter. For may he be able to remember my words when I am no longer there...."

What should I tell him?
{char0}: It says here...
    *   {isDaggerAvailible} [Give the dagger]
        {char0}: To my son Cole, I leave the family dagger, may he be able to protect himself from harm...
        I pull the dagger from my suitcase and place it on the desk.
        {char3}: Protect myself?
        He picks up the dagger, unsheathing it with difficulty.
        {char3}: Ah, I understand. Of course...
        {char3}: Farewell, brother.
        He gets up before I can utter a word.
        
        // Change this, its not a lie.
        I wonder what he made of my lie... 
        I assume he'll be spiralling into a host of reasons.
        It might seem cruel, but I needed to do this to survive.
        I hope you forgive me, Cole.
        ~ isDaggerAvailible = false
        ~ didMurderGetTheDagger = true
        

    *   {(isRingAvailible or isLetterAvailible or whoHoldsTheClock == char0)}[Give an object]
        {char0}: To my son Cole, I leave ...
        
        **  {isRingAvailible}[Give the ring]
            {char0}: ... My wedding ring, to which he's so fondly attached...
            {char3}: His ring?
            
            I pull the ring from my suitcase and give it to him.
            He turns it in his hand, holding it to the light, as if he was trying to find some elusive detail within the metal.
            He stops when he notices my gaze, quickly pocketing the ring.
            
            {char3}: Anything else?
            {char0}: No, that's all.
            {char3}: I see.
            {char3}: Farewell then.
            
            He gets up before I can utter a word.
            Always the strange fellow this one.
            ~ isRingAvailible = false

        **  {isLetterAvailible}[Give the sealed letter]
            {char0}: ... This sealed letter, so he may remember my words when I am no longer there.
            I pull the letter from my suitcase and hand it over to him.
            {char3}: Interesting.
            He flips the letter around, trying to search for something. He brings out a key, quickly slicing the letter open.
            He pauses, looking up suddenly as if a deer caught in the headlights.
            {char3}: Apologies, I'll be on my way then.
            He gets up before I can utter a word.
            Strange, how he can still care for Father's words despite all he's done...
            Unless he treated them differently after he kicked me out...
            ~ isLetterAvailible = false
        
        **  {whoHoldsTheClock == char0}[Give the clock]
            {char0}: ... My clock, my prized possession, in the hands of one as capable as myself.
            I see his face instantly light up as I pull the clock from my bag and hand it over to him.
            {char3}: Thank you brother. I'll see you around.
            He gets up without another word, seeming... happy.
            That's odd, isn't it? I hadn't though any of us would be happy to receive that relic...
            Well, if it serves him well, who am I to judge?
            ~ whoHoldsTheClock = char3
            
    
    *   [Don't give anything]
        {char0}: ... Nothing, for I expect him to create his own path in life.
        {char3}: ...
        {char3}: He gave me nothing?
        {char0}: It seems so..
        {char3} narrows his eyes at me suspiciously.
        {char0}: I hope you don't take this the wrong way—
        {char3}: Of course not, dear brother.
        {char3}: I'm sure our father saw what was best for us.
        
        He stands up, walking away. I swallow nervously, waiting for him to leave. He pauses at the door, turning back.
        
        {char3}: Good day, brother.
        
        I manage a nervous smile. 

- He opens the office door and leaves.
{
    - succesfullyHidFromChar2:
        Before the door closes after Cole, someone stops it with their hand.
        -> char2conversation.char2_hideUnderDesk
}

-> afterConversation.beforeClock

/*
= coleResponse
{char3}: WHAT?! Why did he not leave me mum's ring?! It was the only thing I asked of him!
    *  [I do not know.]
        {char3}: Damn you father.
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
*/

= char3_hideUnderDesk

// Fill it up.

-> normalConversation