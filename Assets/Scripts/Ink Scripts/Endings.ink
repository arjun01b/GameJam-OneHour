=== ending ===


= basicEnding // (Ending 1) Main Ending. Ben and Jane are dead and the clock is with Cole
{char3} bursts into the room.
{char2} and {char4} follow after him.

{char3}: Someone has murdered {char1}.

Before much conversation can be had, a lighting strikes outside the house.
The lights go off for a few seconds.
"Bang!"

Unknown: "What was that?"
Unknown: "Someone shot a gun!?"

The clock is snatched from your hand.
You hear lots of movement in the room.

The lights go back up.
A smoking gun is laying in the middle of the room.
Blood comes out of your chest. You can feel the bullet burning inside you.
{char2}, {char3} and {char4} all look at you in utter shock.

~ lastEndingSeen = 1
-> restartLoop(true)

= stabbingDaggerEnding1 // (Ending 2) Jane and Holden are murdered with the Dagger.
{char4} bursts into the room. 

{char4}: Someone has murdered {char1} and {char2}.
{char4}: They have been stabbed with the family Dagger.

A lighting strikes outside the house.
The lights go off for a few seconds.

{char4}: I think it was {char3}, he killed them.

You remember that you gave the clock to {char2}.

The lights go back up.

~ lastEndingSeen = 2
-> restartLoop(false)

= stabbingDaggerEnding2 // (Ending 3) Everyone is killed with the Dagger by char3.
{char3} bursts into the room. He is covered in blood.
He is holding the family Dagger you gave him.
The blood doesn't seem to be his.

A lighting strikes outside the house and the electricity goes off.
Somehow, not having the lights up makes this a bit easier.
The knive enters your chest with ease. You have trouble breathing.

{
    - whoHoldsTheClock == char4:
        {char3}: (Whispering in your ear)
        {char4}: I already got the clock from {char4}.

    - whoHoldsTheClock == char0: 
        The clock is snatched from your hands.
        You cannot do anything about it.
}

The lights go back up. You are covered in your own blood.
{char3} is not in the room anymore.

~ lastEndingSeen = 3
-> restartLoop(true)

= stabbingDaggerEnding3 // (Ending 4) Char3 kills char1 & char2 with the Dagger, then get's ambushed by char4, who has the clock and has been convinced to help you. In the struggle after the ambush, char3 pulls out a gun and char4 ends up shooting him.
{char4} enters the office again, violently closing the door after her.

{char4}: The clock told me that if I stayed outside I would be killed!

You both hear firm steps heading towards the studio.
{char4} hides behid the door, holding a paper weight.

{char3} bursts into the room. He is covered in blood.
He is holding the family Dagger.
The blood doesn't seem to be his.

{char3}: I am afraid there cannot be survivors to incriminate me.

Suddently, {char4} jumps from behind the door unto {char3}.
She hits him with the paperweight in the back, missing the head.
A blood covered Dagger falls from within {char3}'s jacket as he falls on one knee.
{char4} drops the paperweight from the shock.

A lighting strikes outside the house. The electricity goes off.
You hear {char3} and {char4} struggling.

{char4}: Help please, he's got a gun!

Bang! Before you can do anything, a weapon is fired.
The lights come back on.

{char4} is covered in blood. She is holding the gun.
{char3} lies in the floor, a pool of blood growing bigger.

{char4} looks at the gun in shock. Then she looks at her dead brother, covered in blood from her other siblings.

She throws the clock at you.

{char4}: Reverse it! Use the damn clock and fix this!
{char4}: Please.

She cries.

~ lastEndingSeen = 4
-> restartLoop(false)

= char1SavedAndChar2Shot // (Ending 5) Char3 does not kill char1. Instead, he shoots char2 and steals the clock from them.
{char3} enters the office, followed by {char1} and {char2}.

{char2}: Isn't it lucky? {char3} went to wake up {char1} at the same time as me!

Immediatly after, {char4} enters the office.

{char4}: So here you are, I was wondering where the family obituary was.
{char2}: Hey {char4}! I got dad's clock and {char1} promised to gimme my ring!

A lighting strikes outside the house and the lights go off for a few seconds.
"Bang!"

Unknown: "What was that?"
Unknown: "Someone shot me!"

< Sounds of struggle. >

The lights go back up.
A smoking gun lays in the middle of the room.
{char2} is lying on the floor, bleeding heavily. He is not breathing.
Something tells you the clock is not with him any more.
{char3}, {char4}, and {char1} look at {char2} in shock.
{char1} starts crying and drops towards {char2}'s body.

~ lastEndingSeen = 5
-> restartLoop(false)

= char1DeadAndChar2Shot // (Ending 6) Char3 kills char1 looking for the clock. He then shoots char2 and steals the clock from him.
{char4} bursts into the office crying and screaming.
{char2} and {char3} follow after.

{
    - didMurderGetTheDagger:
        {char4}: Someone has stabbed {char1}!
        {char4}: I went to talk to her and she had a knive stuck in her chest!
        
    - didMurderGetTheDagger:
        {char4}: Someone has killed {char1}!
        {char4}: I went to talk to her and she had a pillow on top of her head!
        {char4}: She wasn't breathing!
}

{char2}: (nervously fiddling with the clock, visibly distressed)
{
    - wasChar2SentToChar1Room:
        {char2}: I was talking to her not so long ago, she must have died right after I left!
    - else:
        {char2}: I was in the saloon all of this time!
}
{char2}: Who would do this horrible thing!

A lighting strikes outside the house and the lights go off for a few seconds.
"Bang!"

Unknown: What was that?
Unknown: Someone shot me!

Two people audibly struggle with each other.
You hear lots of movement in the room.

The lights go back up.
A smoking gun is laying in the middle of the room.
{char2} is lying on the floor, bleeding heavily. He is not breathing.
Something tells you the clock is not with him anymore.
{char3} and {char4} both look at {char2}'s body in shock.
Slowly and without taking and eye away from {char4} or you, {char3} walks backwards towards one of the room's corner.

~ lastEndingSeen = 6
-> restartLoop(false)

= char1DeadAndEveryoneElseSaved // (Ending 7) Char3 kills char1 looking for the clock. He is then ambushed by char4, who reduces him with the help of char2.
{char4} enters the office again, violently closing the door after her.
{char4}: The clock showed me that you would be killed if I did not fight {char3}!

You both hear 2 sets of steps heading towards the studio.
{char4} hides behid the door, holding a paper weight.

{char3} bursts into the room.

{char3}: Someone has murdered {char1}.

{char2} is entering through the door when {char4} jumps onto {char3}.

She lands a blow to his back with the paperweight.

{
    - didMurderGetTheDagger:
        A blood covered Dagger falls from within {char3}'s jacket as he falls on one knee.
    - else:
        {char3} falls on one knee.
        You notice that his face is covered with scratches.
}

{char2} is clearly in shock, unsure of who to help.

A lighting strikes outside the house. The electricity goes off.
You hear {char3} and {char4} struggling.

{char4}: Help please, he's got a gun!

...

{char3}: Let me go, you mindless bozo!

The lights come back on.
On his right hand, {char3} grabs the clock held by {char4}.
{char2} is holding on to his right arm, keeping a revolver aimed at the ceiling.

{char3}: I will kill you three like I killed Jane, that clock belongs to me!

From your seat, you see {char2} go red.

{char2}: YOU KILLED JANE?

With little resistance, {char2} forces {char3} to drop the gun with a swift wrist movement.
Immediatly after, he knocks him with quick punch to the face.
Before more follow, {char4} stops him.

{char4}: That's enough, he's already down.
{char2}: HE KILLED JANE.
{char4}: He is also YOUR brother.
{char2}: Not anymore.

A deep silence fills the room.

...

There has to be something I can do to save {char1}.

~ lastEndingSeen = 7
-> restartLoop(false)

= char1SavedAndChar4Shot // (Ending 8) Char3 does not kill char1. Instead, he shoots char4 and steals the clock from her.
{char3} enters the office, followed by {char1} and {char2}.
{char2}: Isn't it lucky? {char3} went to wake up {char1} at the same time as me!

Immediatly after, {char4} enters the office.
She is holding the clock from its chain. It keeps on swinging.

{char4}: So here you are, I was wondering where the family obituary was.
{char2}: Hey {char4}! {char1} promised to gimme my ring!

A lighting strikes outside the house and the lights go off for a few seconds.
"Bang!"
Unknown: Aw! It burns!
Unknown: What is happening?!
Unknown: Please stop that!

Two people audibly struggle with each other.
You hear lots of movement in the room.

The lights go back up.
A smoking gun is laying in the middle of the room.
{char4} is lying on the floor, bleeding heavily. She is not breathing.
Something tells you the clock is not with her anymore.
{char2}, {char3}, and {char1} stand around her body in shock.

A deep silence feels the room.

...

~ lastEndingSeen = 8
-> restartLoop(false)

= char1DeadAndChar4Shot // (Ending 9) Char3 kills char1 looking for the clock. He then shoots char4 and steals the clock from her.
{char4} bursts into the office crying and screaming.
She is holding the clock from its chain. It keeps on swinging.
{char2} and {char3} follow after.

{
    - didMurderGetTheDagger:
        {char4}: Someone has stabbed {char1}!
        {char4}: I went to talk to her and she had a knive stuck in her chest!
        
    - didMurderGetTheDagger:
        {char4}: Someone has killed {char1}!
        {char4}: I went to talk to her and she had a pillow on top of her head!
        {char4}: She wasn't breathing!
}

{char2}: (nervously fiddling with his hands, visibly distressed)
{
    - wasChar2SentToChar1Room:
        {char2}: I was talking to her not so long ago, she must have died right after I left!
    - else:
        {char2}: I was in the saloon all of this time!
}
{char2}: Who would do this horrible thing!

A lighting strikes outside the house and the lights go off for a few seconds.
"Bang!"

Unknown: Aw! It burns!
Unknown: What is happening?!

Two people audibly struggle with each other.
You hear lots of movement in the room.

The lights go back up.
A smoking gun is laying in the middle of the room.
{char4} lays on the floor, bleeding heavily. She is not breathing.
Something tells you the clock is not with her anymore.
{char2} and {char3} stand around her in shock.

A deep silence feels the room.

...

~ lastEndingSeen = 9
-> restartLoop(false)

= noDeadKillerEscapes // (Ending 10) Char3 is given the clock. He escapes afterwards.
{char4} enters the office with {char1}.

{char4}: Like I told you, my husband and I are willing to buy this property from the rest of the siblings.
{char4}: Thought you might have an issue with that so I wanted to ask you first.
{char1}: I could not care less about this hell hole. It's all yours.

{char2} enters the office.
{char2}: Hey, has any of you seen {char3}. I can't find him.
{char4}: I think I saw him leave 20 minutes ago. He seemed to be in a rush.
{char2}: Weird, he did not mention anything.
{char1}: Who cares, he clearly doesn't.

While this outcome seems peaceful, you know your brother.
And the clock has shown you what he is capable of.

...

It doesn't sit right by you that he is free, with the clock.
There must be a better outcome.

~ lastEndingSeen = 10
-> restartLoop(false)

= goodEnding // (Ending -) Char3 is NOT given the Dagger. Char2 is sent to char1's room LATE and stops char3 from killing char1. Finally, char4 is given the CLOCK and CONVINCED to help.
{char4} enters the office again, violently closing the door after her.
{char4}: The clock showed me that you would be killed if I did not fight {char3}!

You both hear 3 sets of steps heading towards the studio.
{char4} hides behid the door, holding a paper weight.

{char2} enters the room.

{char2}: I'm just happy that I will get ma ring!

{char3} follows after him.

{char3}: You and your damn ring.
{char3}: No one cares about that damn piece of scrap.

Right as {char1} set her foot through the entrance, {char4} jumps onto {char3}.
She lands a blow to his back with the paperweight.
{char3} falls on one knee and immediatly turns his head.
His eyes lock onto the clock.

{char3}: DAMN YOU!

He jumps towards {char3}.

A lighting strikes outside the house. The electricity goes off.
You hear {char3} and {char4} struggling.

{char4}: Help please, he's got a gun!
{char1}: Oh my god!
{char3}: Let me go, you mindless bozo!

The lights come back on.

On his right hand, {char3} grabs the clock held by {char4}.
{char2} is holding on to his right arm, keeping a revolver aimed at the ceiling.

{char1} stares in shock.

{char1}: Why do you have a gun, {char3}?!
{char4}: He was about to shoot me! To take the clock!
{char3}: That clock BELONGS TO ME! I studied it with dad for years!
{char3}: He didn't have the right to take it from me!
{char2}: Wait, are you saying that...
{char3}: Yes, you slow bafoon, I POISONED HIM!

With little resistance, {char2} forces {char3} to drop the gun with a swift wrist movement.
Immediatly after, he knocks him with quick punch to the face.

A silence traps the room.

...

{char1}: I guess we should call the police.
{char0}: Before the happens, we need to do something.
{char4}: What do we need to do?
{char0}: Destroy that clock.
{char4}: No, you gave it to me! We had a deal!
{char0}: You've seen what that thing can do to people.
{char0}: (Pointing at {char3}) I don't want this to happen ever again.

...

{char4}: (With little conviction) But I will use it better...
{char0}: You know I'm right.

...

{char4}: (Pointing at {char3}) I want his side of the inheritance.
{char0}: Deal.

{char4} places the clock on the ground and stomps it with her shoe.
The glass cracks, and the mechanism inside spills over the floor.

-> END

=== restartLoop(dead)===
I look at the pendulum clock. It marks exactly 23:15.
{
    - dead:
        With my last breath, I stand from the chair and look back at the desk.
        {char0}: I know you are there. Listen closely. This is how you die in an hour:
        ...
        I see myself collapse over the desk.
    - else:
        I get up from your chair, and look back at the space you just left.
        Yourself: I know you are there. This is not a hallucination. I am you in the future.
        Yourself: You don't have much time, so listen closely:
        ...
        Your past self/I looks/look back at yourself.
}

Then you feel the present dragging you back.
It is 22:15. You need to stop the murderer.
-> resetGlobalVariablesAfterLoop(-> afterConversation.afterClock)