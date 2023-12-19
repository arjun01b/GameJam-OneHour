// Loop Dependant Variables
VAR whoHoldsTheClock = ""
VAR hasBeenFoundUnderDeskBefore = false
VAR isRingAvailible = true
VAR isDaggerAvailible = true
VAR isLetterAvailible = true

VAR hasTalkedToChar2 = false
VAR succesfullyHidFromChar2 = false
VAR wasChar2SentToChar1Room = false

VAR hasTalkedToChar3 = false
VAR didMurderGetTheDagger= false

VAR hasTalkedToChar4 = false
VAR wasChar4ConvincedToHelp = false

// Not-Loop dependant variables
VAR hasUsedClockBefore = false  // The clock is used before the loop starts.
VAR lastEndingSeen = 0
VAR hasHiddenBefore = false


=== resetAllGlobalVariables (-> nextScene) ===
// Not-loop dependant variables.
~ hasUsedClockBefore = false
~ hasHiddenBefore = false

-> resetGlobalVariablesAfterLoop (nextScene)

=== resetGlobalVariablesAfterLoop (-> nextScene) ===
// Loop Dependant Variables

~ whoHoldsTheClock = char0
~ hasBeenFoundUnderDeskBefore = false
~ isRingAvailible = true
~ isDaggerAvailible = true
~ isLetterAvailible = true

~ hasTalkedToChar2 = false
~ succesfullyHidFromChar2 = false
~ wasChar2SentToChar1Room = false

~ hasTalkedToChar3 = false
~ didMurderGetTheDagger = false

~ hasTalkedToChar4 = false
~ wasChar4ConvincedToHelp = false
-> nextScene