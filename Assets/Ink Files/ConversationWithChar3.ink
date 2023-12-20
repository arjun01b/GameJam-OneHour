=== char3conversation ===
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
~ hasTalkedToChar3 = true
I glance at Cole's section of the will, it reads:
"To my son Cole, I leave the family dagger, may he be able to protect himself from harm..."

{char0}: It says here...
What should I give him?

    *   {isDaggerAvailible} [Give the dagger]
        {char0}: To my son Cole, I leave the family dagger, may he be able to protect himself from harm...
        
        I pull the dagger from my suitcase and place it on the desk.
        {char3}: Protect myself?
        He picks up the dagger, unsheathing it with difficulty.
        
        {char3}: Ah, I understand. Of course...
        ~ isDaggerAvailible = false
        ~ didMurderGetTheDagger = true
        
        {not succesfullyHidFromChar2:   //only displays if Holden doesn't barge in
        {char3}: Farewell, brother.
        
        He leaves with a determined stride.
        Always the strange fellow this one.
        }
        

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
            ~ isRingAvailible = false
            
            {not succesfullyHidFromChar2:   //only displays if Holden doesn't barge in
            {char3}: Farewell then.
            
            He leaves hurriedly.
            
            I wonder what he made of my lie... 
            I assume he'll be spiralling into a host of reasons.
            It might seem cruel, but I needed to do this to survive.
            I hope you forgive me, Cole.
            }

        **  {isLetterAvailible}[Give the sealed letter]
            {char0}: ... This sealed letter, so he may remember my words when I am no longer there.
            I pull the letter from my suitcase and hand it over to him.
            {char3}: Interesting.
            
            He flips the letter around, trying to search for something. He brings out a key, quickly slicing the letter open.
            He pauses, looking up suddenly as if a deer caught in the headlights.
            He puts the letter in his coat pocket.
            {char3}: Apologies, I'll be on my way then.
            ~ isLetterAvailible = false
            
            {not succesfullyHidFromChar2:   //only displays if Holden doesn't barge in
            He leaves before I can utter a word.
            Strange, how he can still care for Father's words despite all he's done...
            Unless he treated them differently after he kicked me out...
            }
        
        **  {whoHoldsTheClock == char0}[Give the clock]
            {char0}: ... My clock, my prized possession, in the hands of one as capable as myself.
            I see his face instantly light up as I pull the clock from my bag and hand it over to him.
            He swiftly pockets the clock.
            {char3}: Thank you brother. I'll see you around.
            ~ whoHoldsTheClock = char3
            
            {not succesfullyHidFromChar2:   //only displays if Holden doesn't barge in
            He leaves without another word, seeming... happy.
            That's odd, isn't it? I hadn't though any of us would be happy to receive that relic...
            Well, if it serves him well, who am I to judge?
            }
    
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
        
        I manage an anxious smile.

-   {succesfullyHidFromChar2:
    -> char2conversation.char2_returns
    }

-> afterConversation.beforeClock

= char3_hideUnderDesk
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
    
+[Tell him you weren't expecting him yet.]
    {char0}: I wasn't expecting you yet.
    {char3} gives me a disbelieving look before getting up.
    {char3}: Get out of there.
    He walks to the other side of the desk, sitting down on the chair as I take a seat, dusting myself off.
    
--> normalConversation