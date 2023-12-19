=== char2conversation ===
~ hasTalkedToChar2 = true
{char2} enters the room, his heavy boots causing the floorboards to squeak.
{char0}: Hello, Holden.
{char2}: Benjamin! It's good to see you.
-> normalConversation

= normalConversation
    *   [Ask how he's been.]
        {char0}: How are you? I haven't seen you in a while.
        {char2}: Doing well. A bit worried though. Harvest season's almost here and Old Jim's not doing well.
        **["Old Jim?"]
            {char2}: Oh right! You haven't met Old Jim. He's a Cream Draft stallion, best of all the horses I've worked with—
            ***[Interrupt Holden.]
                {char0}: I'm sorry Holden, maybe we should talk about something else.
                {char2}: Oh... Of course, I apologise for rambling.
                {char2}: You wouldn't want to know about the farm after all.
                {char2}: You're a city boy now. Good for you!
                -> normalConversation
                
            ***[Let Holden speak.]
                {char2}: —since Crimson. Do you remember Crimson?
                {char2}: He'd run wild in the fields until we gave him his favourite apples.
                {char0}: Of course I do. How could I forget.
                {char2} smiles at you, happy remembering memories from the past. 
                -> normalConversation
                
        **["I hope he gets better."]
        {char0}: I hope he gets better.
        {char2}: I hope so too. The harvest will be tough without that beast.
        -> normalConversation
    
    *   [Ask about the ring around his neck.]
        {char0}: The ring around your neck—
        {char2}: Mother's ring. She gave it to me before she passed.
        {char2}: That's all I have to remember her by...
        {char2}: (Sniffs back tears) Sorry, I just miss her.
        {char0}: I understand, I do too sometimes.
        -> normalConversation

    *   [Bring up the will.]
        {char0}: We can talk more later, let's focus on father's will now. Shall we?
        {char2}: Oh yes, that's why you've come back, haven't you? What does it say?
        -> willReading

= willReading
I glance through the the will, it reads:
"To my son Holden, I leave my wedding ring, to which he's so fondly attached..." //DevNote: Is there a way to italicize text?
Now what I give Holden might lead to or away from the events of the vision, what should I tell him?
{char0}: Alright so here it says...
    *   {isRingAvailible} [Give the ring]
        {char0}: To my son Holden, I leave my wedding ring, to which he's so fondly attached...
        {char2}: YES! It was the only thing I wanted! Thank you father!
        I pull the ring from my suitcase and hand it over to him.
        {char2} takes off the necklace, adding father's ring beside mother's before wearing it again.
        {char2}: Now it'll be like they're with me all the time!
        {char2}: Thank you brother!
        He leaves the room, humming a tune, clutching at the two rings.
        ~ isRingAvailible = false
        -> afterConversation.beforeClock

    *   {(isDaggerAvailible or isLetterAvailible or whoHoldsTheClock == char0)} [Give another object]
        {char0}: To my son Holden, I leave ...
        **  {isDaggerAvailible}[Give the dagger]
            {char0}: ... The family dagger, may he be able to protect himself from harm.
            I pull the dagger from my suitcase and place it on the desk.
            ~ isDaggerAvailible = false
            
        **  {isLetterAvailible}[Give the sealed letter]
            {char0}: ... This sealed letter, so he may remember my words when I am no longer there.
            I pull the letter from my suitcase and hand it over to him.
            ~ isLetterAvailible = false
        
        **  {whoHoldsTheClock == char0}[Give the clock]
            {char0}: ... My clock, my prized possession, in the hands of one as capable as myself.
            I pull the clock from my bag and hand it over to him.
            ~ whoHoldsTheClock = char2
            
        -- -> noRing
    
    *   [Don't give anything]
        {char0}: ... Nothing, for I expect him to create his own path in life.
        -> noRing

= noRing
{char2}: What... But... He promised...
{char2}: He said he'd give me his ring...
{char2}: Why would he do that?
    *  [Tell him you don't know.]
        {char0}: I don't know.
        {char2}: He wanted me to make my own path in life?
        {char2}: But haven't I been doing that?
        {char2} Looks down at the ring around his neck , holding it as he leaves, looking brokenhearted and lost.
        -> afterConversation.beforeClock
        
    *  [Tell him someone else got the ring.]
        {char0}: He gave someone else the ring.
        {char2}: To who?
        {char0}: I can't tell you that.
        {char2}: Yes, you can!
        {char2} leans over the table, looking fierce.
        I tell him...
        **  [{char1} has it.]
            {char0}: {char1} received it.
            ~ wasChar2SentToChar1Room = true
            Still angry, {char2} storms out of the room, probably headed towards {char1}'s room.
            -> afterConversation.beforeClock
                
        **  [{char3} has it.]
            {char0}: {char3} will recieve it.
            Still furious, {char2} leaves the room.
            Outside the room, you hear a loud conversation between {char2} and {char3}.
            However, it seems to die down after a few minutes.
            -> afterConversation.beforeClock
            
        **  [{char4} has it.]
            {char0}: {char4} will recieve it.
            Still furious, {char2} leaves the room.
            Outside the room, you hear a loud conversation between {char2} and {char4}.
            However, it seems to die down after a few minutes.
            -> afterConversation.beforeClock


// This is used when Holden walks into the room as Ben is finishing his conversation with Cole after he hid from him under the desk. It should be a confrontation and an automatic skip to the will reading part of the conversation.

= char2_hideUnderDesk
{char2}: There you are! Where did you go?
{char0}: Nowhere! I was right here.

//if Cole discovered him hiding, he comments something about it, else he comments about Holden being stupid.
//{char0}: Don't mind him Holden, you're here for the will aren't you?
//{char2}: Ah, yes...

-> willReading
// -> char2conversation