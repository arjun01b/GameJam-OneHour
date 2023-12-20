=== prologue ===
Early morning,
The day of the will-reading.
*[Continue]
- After half a day of flying, the last thing I want to do is sit in a taxi in this blistering heat.
But I guess that’s what my father wished for me.
Even after his death, he can’t help making our lives difficult.

The taxi driver, Mr. Hendriks speaks up.
{driver}: "It's been a while since you've been here, hasn't it?"

*   [Hasn't been that long.]
    ->Hendriks1A
*   [Yes, has much changed?]
    ->Hendriks1B
*   [I'm just here for the will reading.]
    ->Hendriks1C

=== Hendriks1A ===
{char0}: Hasn't been that long. Has it?
{driver}: I guess time flies different for you city-dwellers then.
{driver}: Been a good 20 years it has, if my memory serves me right.
{driver}: Matter of fact, if it wasn't for your father's will, I doubt you'd ever remember our wee town.
->PrologueContinue1

=== Hendriks1B ===
{char0}: Yes... It's been a decade or two, has much changed around here?
{driver}: To be honest with you son, I don't think it has. This town's the same old beauty as she was all those years ago.
{driver}: But you be the judge, maybe take a short trip into town soon. After your father's will is read, I mean.
->PrologueContinue1

=== Hendriks1C ===
{char0}: I'm just here for the will reading.
{driver}: Ah. Right. Of course.
->PrologueContinue1

=== PrologueContinue1 ===
I gaze out the window, watching as the city recedes, placing us smack in the middle of the countryside.
It felt foreign, but I remember the warmth this place had when we were younger.
-> HendriksChoices2

=== HendriksChoices2 ===
*   [Ask Hendriks about Father]
    ->Hendriks2A

*   [Ask Hendriks about my siblings.]
    ->Hendriks2C

+   {not Hendriks2BsplitA and not Hendriks2BsplitB and not Hendriks2BsplitC} [Stay silent]
    ->Hendriks2B

*   {Hendriks2A and Hendriks2B}
    -> PrologueEndPiece

=== Hendriks2A === 
{char0}: Did you know father?
{driver}: Well, everyone knew of the man. A storm cloud of a person he was. Never seen outside the mansion.
{driver}: A very private man. But Holden might know more, lived with the man unto his death he did, ever the dutiful son.
{driver}: Ahem! Not to say you weren't...
{driver}: (Awkwardly) You know what I mean...
->HendriksChoices2

=== Hendriks2B ===
I choose to stay silent, watching the scenery as I let myself reminisce for the first time in years.
My thoughts go to...
*   [My parents]
    ->Hendriks2BsplitA
*   [Why I left home]
    -> Hendriks2BsplitB
*   [The will]
    ->Hendriks2BsplitC

===Hendriks2BsplitA
My parents.
The golden fields remind me of my mother.
As bright as the sun, her compassion and charm shining through everything she did.
I often wondered why she married Father, her antithesis.
Frigid, distant.
Nothing you did could please him.
Breathe wrong at dinner and he’d recede into his sanctum with a blazing glare.
->HendriksChoices2

===Hendriks2BsplitB
How I ended up leaving home.
After mother died, our family fell apart, all of us fending for ourselves under the absence of our father.
The man enrolled me at a boarding school, Jane and Lily at a convent, he thought we were too troublesome to keep around. Didn't even bother to drop us off himself.
I was far too enraged with the man to ever come back here. I moved to the city after school and never looked back, until today.
Oh, the irony. The man who broke us apart is the reason we're all back here.
->HendriksChoices2

===Hendriks2BsplitC
The will.
Knowing my father, I wouldn't be surprised if Cole and Holden got all of inheritance.
After all, he thought of Jane, Lily and I as troublemakers.
Not that I mind. What could be in that wretched will anyway? I've never seen him work a day, so not money.
Maybe that decrepit mansion and the farms. Holden would be vying for those...
And of course! That blasted clock! The apple of his eye, the object he obsessed over, held it over the wellbeing of his own children.
I doubt anyone of us wants anything to do with that cursed piece of junk.
->HendriksChoices2

=== Hendriks2C ===
{char0}: Do you know my siblings?
{driver}: Holden and Jane, yes, they are the only ones who stuck around town.
{not Hendriks2A: //Not yet talked about Holden
{driver}: Holden's been working the farm and taking care of the mansion, rarely see 'im around.
} 
{Hendriks2A: //Already talked about Holden
{driver}: Like I said, Holden looked after your old man, the mansion and the farms. Rarely saw him around town, unless it was on an errand.
}
{driver}: Jane on the other hand moved into town after marriage, works as a teacher at the school.
{driver}: Her husband owned a store in town, Jacob, her son has been running it for over three years now, since her husband passed.
{driver}: As for the other two, Lily and Cole, they'll show up to the mansion later today from what I heard.
* [Ask more about Cole]
{char0}: Know anything about Cole?
{driver}: Ah… That brother of yours was… unique, to say the least. 
{driver}: No one knows what he does now, still not a man of words
{driver}: Quite like your father that one.
->HendriksChoices2
* [Ask more about Lily]
{char0}: Know anything about Lily?
{driver}: (Scoffs) Who doesn't? Your sister was… of a business mindset, for as long as I can remember.
{driver}: Married into a rich family across the country. You can only guess what she’s here for.
->Hendriks2Csplit

=== Hendriks2Csplit ===
*[For the Money.]
{driver}: Damn right.
->HendriksChoices2
*[For Family.]
{char0}: She could be here to meet all of us, it's been a while.
{driver}: (Laughs) You always try to see the best in people, don’t ya?
->HendriksChoices2

=== PrologueEndPiece ===
{Hendriks2BsplitA and Hendriks2BsplitB:
Mr. Hendriks calls me out of my reverie. 
} 
We drive up to an old gateway, tall trees looming over it.
{driver}: We’re here.
{char0}: Thanks, Mr. Hendriks.
I snatch my bags, getting out of the car, landing on fresh green grass.
{driver}: See you around Ben.
{char0}: Actually, it’s Benjamin—
He’s already driving away.
I sigh, looking up at the mansion in front of me. Not as derelict as I’d expected…

Let’s see what other surprises it has in store for me.

+[Continue] -> char1conversation
