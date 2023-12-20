=== char1conversation ===
I walk into the mansion, entering the room at the end of the old saloon, closing the door behind me.
I could use this space to speak to each of my siblings...
I take a few minutes to prepare, reading the will, before I take my seat.
Shortly after, someone knocks on the door.

*["Come in."]
- Jane walks in. 
She looks much more like our mother than I had anticipated.
The same caring smile from our childhood greets me.

{char1}: Benjamin! It’s good to finally see you!

* [Greet Jane.] 
    -> Jane1A
    
* [Get to the matter at hand.]
    {char0}: Likewise. I wouldn't want to take too much of your time.
    -> Jane1B

=== Jane1A ===
{char0}: It’s good to see you too sis, I hope you’ve been well.
{char1}: Oh I’m quite alright.
{char0}: That’s not what Jacob had to say—
{char1}: Oh why that boy, snitching on his own mother!
{char0}: (Laughs) Sounds like you when you were younger.
{char1}: (Scoffs) I did nothing of the sort!
{char0}: Looks like you're feeling better now.

*   [Ask about Jacob.] 
    -> Jane1Asplit
    
*   [Bring up the will.] 
    {char0}: Now, if we could talk about why we're here...
    -> Jane1B

=== Jane1Asplit ===
{char0}: And how's Jacob been?
{char1}: Doing good. He would've loved to meet you, but I insisted he shouldn't visit the mansion.
{char0}: He's never been here, has he?
{char1}: Never has and never will if I can help it.
{char1}: (Scowls) I'd like to keep my boy away from the memory of that man as much as I can.
{char0}: I see...

*   [Bring up the will.]
    {char0}: Jane, I know you’d prefer to talk more, but there's something important I need to discuss...
    -> Jane1B
    
    
=== Jane1B ===
{char1}: (Nods) Let’s get on with it, I hope this is the last I hear of him

I bring out the old clock.
Jane is instantly shocked, horrified even.

{char0}: Father left you the clock, he also said—
{char1}: (Interrupts) I’m not taking that clock. I want nothing to do with it.
{char1}: He spent more time with that blasted thing than with any of us.

*   [Try to convince Jane.] 
    ->Jane2A
    
*   [Agree with Jane.] 
    ->Jane2B
    

=== Jane2A ===
{char0}: I understand, I really do. But what if there’s something within this clock that explains it? Maybe we’ll finally understand why he was so fixated on it.
{char1}: (Upset) I cannot, Benjamin.  I will not have that accursed thing in my home, and you best get rid of it before it consumes you too, brother. 
{char1}: (Gets up) I need to go.
{char0}: Jane, please. I didn't mean to upset you.

She rushes away in a fury, hissing under a breath that Father had dared to bequeathed her the clock.
-> afterConversation.beforeClock

=== Jane2B ===
{char0}: (Sighs) To that, I agree... I don't see anyone of us taking kindly to this clock.
{char1}: I'm glad you see my point.
{char0}: But that also means there is nothing else I can give you.
{char1}: I expected nothing from that man, I just came here because I was required.
{char1}: If there's nothing else, I'll excuse myself.
{char0}: I'll see you in town sometime.
{char1}: Very well, see you around Benjamin.

Jane leaves in a rush, still angered at the notion of being given the clock.
I hear her venting to Holden that Father had bequeathed her the clock before they fall silent.
-> afterConversation.beforeClock
