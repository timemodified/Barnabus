;NORMAL

; The CMD file.
;
; Two parts: 1. Command definition and  2. State entry
; (state entry is after the commands def section)
;
; 1. Command definition
; ---------------------
; Note: The commands are CASE-SENSITIVE, and so are the command names.
; The eight directions are:
;   B, DB, D, DF, F, UF, U, UB     (all CAPS)
;   corresponding to back, down-back, down, downforward, etc.
; The six buttons are:
;   a, b, c, x, y, z               (all lower case)
;   In default key config, abc are are the bottom, and xyz are on the
;   top row. For 2 button characters, we recommend you use a and b.
;   For 6 button characters, use abc for kicks and xyz for punches.
;
; Each [Command] section defines a command that you can use for
; state entry, as well as in the CNS file.
; The command section should look like:
;
;   [Command]
;   name = some_name
;   command = the_command
;   time = time (optional -- defaults to 15 if omitted)
;
; - some_name
;   A name to give that command. You'll use this name to refer to
;   that command in the state entry, as well as the CNS. It is case-
;   sensitive (QCB_a is NOT the same as Qcb_a or QCB_A).
;
; - command
;   list of buttons or directions, separated by commas.
;   Directions and buttons can be preceded by special characters:
;   slash (/) - means the key must be held down
;          egs. command = /D       ;hold the down direction
;               command = /DB, a   ;hold down-back while you press a
;   tilde (~) - to detect key releases
;          egs. command = ~a       ;release the a button
;               command = ~D, F, a ;release down, press fwd, then a
;          If you want to detect "charge moves", you can specify
;          the time the key must be held down for (in game-ticks)
;          egs. command = ~30a     ;hold a for at least 30 ticks, then release
;   dollar ($) - Direction-only: detect as 4-way
;          egs. command = $D       ;will detect if D, DB or DF is held
;               command = $B       ;will detect if B, DB or UB is held
;   plus (+) - Buttons only: simultaneous press
;          egs. command = a+b      ;press a and b at the same time
;               command = x+y+z    ;press x, y and z at the same time
;   You can combine them:
;     eg. command = ~30$D, a+b     ;hold D, DB or DF for 30 ticks, release,
;                                  ;then press a and b together
;   It's recommended that for most "motion" commads, eg. quarter-circle-fwd,
;   you start off with a "release direction". This matches the way most
;   popular fighting games implement their command detection.
;
; - time (optional)
;   Time allowed to do the command, given in game-ticks. Defaults to 15
;   if omitted
;
; If you have two or more commands with the same name, all of them will
; work. You can use it to allow multiple motions for the same move.
;
; Some common commands examples are given below.
;
; [Command] ;Quarter circle forward + x
; name = "QCF_x"
; command = ~D, DF, F, x
;
; [Command] ;Half circle back + a
; name = "HCB_a"
; command = ~F, DF, D, DB, B, a
;
; [Command] ;Two quarter circles forward + y
; name = "2QCF_y"
; command = ~D, DF, F, D, DF, F, y
;
; [Command] ;Tap b rapidly
; name = "5b"
; command = b, b, b, b, b
; time = 30
;
; [Command] ;Charge back, then forward + z
; name = "charge_B_F_z"
; command = ~60$B, F, z
; time = 10
;
; [Command] ;Charge down, then up + c
; name = "charge_D_U_c"
; command = ~60$D, U, c
; time = 10
;

;-| Super Motions |--------------------------------------------------------
;The following two have the same name, but different motion.
;Either one will be detected by a "command = TripleKFPalm" trigger.
;Time is set to 20 (instead of default of 15) to make the move
;easier to do.
;[E] starts ai activation code

;***************************************************************************
; CMD
;***************************************************************************

;[Remap]
;
;  Note that if you modify the button remapping scheme, this character will
; still be able to correctly detect the basic commands of other characters
; complying with the basic command order specified below, as long as their
; buttons haven't been remapped.  But no character (not even one with the same
; remapping scheme, not even another instance of this character) will be able to
; correctly detect this character's commands.  This shouldn't ever result in any
; false positives, but it could delay correct positives, and could erroneously
; make the helper AI activation method trigger a false negative in team simul
; modes, in which case the XOR-ed commands method would be needed to provide
; backup.  But of course, this isn't an issue in any version of Mugen prior to
; version 2002.04.14.


; These 11 Single Button and Hold Dir commands must be placed here at the top
; of the CMD, above all other commands, and in the standard order shown here,
; in order for the "Compatibly Partnered" version (9742) of the helper AI
; activation method to work with different partners in simul team mode.
; (When the partner is not compatible, then it's best to just use the regular
; version (9741) and rely on the XOR method for backup in case a human
; partner's input turns off the CPU partner's AI.)
;   (Now, even if you do not intend to give your character any custom AI, it
; would still be nice if you would place the commands at the top of your CMD,
; for the sake of other characters which do use this AI activation method.
; And then, define Anim 9741 in your AIR file to indicate to other characters
; that your character is compatible.
;   It may slightly increase the chances of faulty AI activation if the user
; is using characters with a poor implementation of the old humanly-impossible
; commands AI activation method when fighting against your character, but
; other than that, there's really no particular reason not to.  And you can
; change the names of the commands if you want.  For compatibility, all that
; really matters is the "command" and "time" parameters.)
;
; Please don't add any extra definitions for any of these 11 basic command
; names, nor for any of the 7 "hold[button]" command names that follow.
; For example, things like this should be avoided:
;	[Command]
;	name = "z"
;	command = y+b
;	time = 1
; There are several workarounds possible to achieve the same effect.  Please
; feel free to ask me about it if you have any uncertainty.
; Violating this rule would cause the KeyCtrl Helper method and/or the XORed
; Commands method to malfunction, and could also interfere with other future
; applications of this command order standard.
;
;-| Single Button |---------------------------------------------------------
[Command]
name = "a"
command = a
time = 1

[Command]
name = "b"
command = b
time = 1

[Command]
name = "c"
command = c
time = 1

[Command]
name = "x"
command = x
time = 1

[Command]
name = "y"
command = y
time = 1

[Command]
name = "z"
command = z
time = 1

[Command]
name = "start"
command = s
time = 1

;-| Hold Dir |--------------------------------------------------------------
[Command]
name = "holdfwd";Required (do not remove)
command = /$F
time = 1

[Command]
name = "holdback";Required (do not remove)
command = /$B
time = 1

[Command]
name = "holdup" ;Required (do not remove)
command = /$U
time = 1

[Command]
name = "holddown";Required (do not remove)
command = /$D
time = 1

;-| Hold Button |----------------------------------------------------------
; Please define Anim 74140108 in your AIR file if AND ONLY IF you place these
; 7 Hold Button commands immediately after the 11 Single Button and Hold Dir
; commands at the very top of your CMD list, as demonstrated here.
; In this version of the AI code, these commands are only used by the XOR
; method, and thus are optional.  But there remains a possibility that a
; future version of the helper method might be helped by having these
; commands placed here, and Anim 74140108 would then be used to indicate
; that a partner character has a compatible CMD.

[Command]
name = "holda"
command = /a
time = 1

[Command]
name = "holdb"
command = /b
time = 1

[Command]
name = "holdc"
command = /c
time = 1

[Command]
name = "holdx"
command = /x
time = 1

[Command]
name = "holdy"
command = /y
time = 1

[Command]
name = "holdz"
command = /z
time = 1

[Command]
name = "holdstart"
command = /s
time = 1

;--- None of your own command definitions should be above this line. ---

;-| CPU |--------------------------------------------------------------
; Note that if you make any changes to the basic one-button or recovery
; commands, you'll need to make the same changes to their matching commands here
; and/or in the XOR VarSet controller.  That includes things like, for example:
;  * changing the recovery command to use a different combination of buttons.
;  * renaming the b button command as "d", or the start button command as "s".
;  * switching the button names around, e.g. so button y triggers "a" and button a triggers "y".
;  * having more than one way to trigger the same command name.
; If you understand how the XOR method works, the proper changes should be obvious.
; If you don't understand it, then simply disable the lines in the XOR VarSet
; controller that correspond to the commands you've altered.

[Command]
name = "a2"
command = a
time = 1

[Command]
name = "b2"
command = b
time = 1

[Command]
name = "c2"
command = c
time = 1

[Command]
name = "x2"
command = x
time = 1

[Command]
name = "y2"
command = y
time = 1

[Command]
name = "z2"
command = z
time = 1

[Command]
name = "start2"
command = s
time = 1

[Command]
name = "holdfwd2"
command = /$F
time = 1

[Command]
name = "holdback2"
command = /$B
time = 1

[Command]
name = "holdup2"
command = /$U
time = 1

[Command]
name = "holddown2"
command = /$D
time = 1

[Command]
name = "holda2"
command = /a
time = 1

[Command]
name = "holdb2"
command = /b
time = 1

[Command]
name = "holdc2"
command = /c
time = 1

[Command]
name = "holdx2"
command = /x
time = 1

[Command]
name = "holdy2"
command = /y
time = 1

[Command]
name = "holdz2"
command = /z
time = 1

[Command]
name = "holdstart2"
command = /s
time = 1

[Command]
name = "recovery2"
command = x+y
time = 1

; Here add matching commands for any moves that must never be used randomly
; by the computer, such as suicide moves and super moves, and add the pairs
; to the XOR VarSet controller in State -3.

; If you're desperate to make sure that the AI always gets turned on as soon
; as possible, you can add more equivalents for your own commands here too,
; and add to the XOR VarSet controller's triggers accordingly.

; And of course, if you've run out of unique command labels (Mugen allows
; 128), you can remove as many of these as you want.  You'll of course need
; to modify the XOR VarSet controller's triggers accordingly, but Mugen
; will let you know if you forget to do so. :)

;[E] 
;ends ai activation code


;-----
;HUMAN
;-----
;-| Special Motions |-----------------------------------------------------------
[Command]
name = "QCF_P"     ;Required (do not remove)
command = ~D, DF,F, x
time = 10
[Command]
name = "QCF_P"     ;Required (do not remove)
command = ~D, DF,F, y
time = 10
[Command]
name = "QCF_K"     ;Required (do not remove)
command = ~D, DF,F, a
time = 10
[Command]
name = "QCF_K"     ;Required (do not remove)
command = ~D, DF,F, b
time = 10
[Command]
name = "QCB_P"     ;Required (do not remove)
command = ~D, DB,B, x
time = 10
[Command]
name = "QCB_P"     ;Required (do not remove)
command = ~D, DB,B, y
time = 10
[Command]
name = "QCB_K"     ;Required (do not remove)
command = ~D, DB,B, a
time = 10
[Command]
name = "QCB_K"     ;Required (do not remove)
command = ~D, DB,B, b
time = 10

[Command]
name = "DP_P"     ;Required (do not remove)
command = ~F, D,DF, x
time = 20
[Command]
name = "DP_P"     ;Required (do not remove)
command = ~F, D,DF, y
time = 20

[Command]
name = "RDP"     ;Required (do not remove)
command = B, D,DB
time = 10

[Command]
name = "HCF"     ;Required (do not remove)
command = B,DB,D,DF,F
time = 10

[Command]
name = "HCB"     ;Required (do not remove)
command = F,DF,D,DB,B
time = 10

;-| Double Tap |-----------------------------------------------------------
[Command]
name = "FF"     ;Required (do not remove)
command = F, F
time = 10

[Command]
name = "BB"     ;Required (do not remove)
command = B, B
time = 10

;-| 2/3 Button Combination |-----------------------------------------------
[Command]
name = "recovery";Required (do not remove)
command = x+y
time = 1

[Command]
name = "KM_Activate";Required (do not remove)
command = a+x

[Command]
name = "KM_Activate";Required (do not remove)
command = b+y

;-| Dir + Button |---------------------------------------------------------
[Command]
name = "down_a"
command = /$D,a
time = 1

[Command]
name = "down_b"
command = /$D,b
time = 1

;-| Single Button |---------------------------------------------------------
[Command]
name = "a"
command = a
time = 1

[Command]
name = "b"
command = b
time = 1

[Command]
name = "c"
command = c
time = 1

[Command]
name = "x"
command = x
time = 1

[Command]
name = "y"
command = y
time = 1

[Command]
name = "z"
command = z
time = 1

[Command]
name = "start"
command = s
time = 1

;-| Hold Dir |--------------------------------------------------------------
[Command]
name = "holdfwd";Required (do not remove)
command = /$F
time = 1

[Command]
name = "holdback";Required (do not remove)
command = /$B
time = 1

[Command]
name = "holdup" ;Required (do not remove)
command = /$U
time = 1

[Command]
name = "holddown";Required (do not remove)
command = /$D
time = 1

[Command]
name = "QCF_2K"     ;Required (do not remove)
command = ~D, DF,F, a+b
time = 10

[Command]
name = "QCB_2P"     ;Required (do not remove)
command = ~D, DB,B, x+y
time = 10

[Command]
name = "QCB_2K"     ;Required (do not remove)
command = ~D, DB,B, a+b
time = 10

[Command]
name = "DP_2P"     ;Required (do not remove)
command = ~F, D,DF, x+y
time = 20

[Command]
name = "DP_2k"     ;Required (do not remove)
command = ~F, D,DF, a+b
time = 20

[Statedef -1]

;===========================================================================
[State -1, Killer Mode - OFF]
type = ChangeState
value = 3010
triggerall = stateno != 3010
triggerall = command = "KM_Activate"
triggerall = var(10) != 0
trigger1 = ctrl
trigger2 = (var(2)&67108864) != 0

[State -1, Killer Mode - ON]
type = ChangeState
value = 3000+(5*!ctrl)
triggerall = stateno != 3000 && stateno != 3005
triggerall = command = "KM_Activate"
triggerall = power >= 2000 && var(10) = 0
triggerall = statetype != A
trigger1 = ctrl
trigger2 = (var(2)&65536) != 0

;===========================================================================
[State FATAL - Maelstrom Epiphany (QCB+2P)]
type = ChangeState
triggerall = numenemy = 1
triggerall = enemy,life<=330
triggerall = roundstate = 2
triggerall = !var(10)
triggerall = power >= 3000
triggerall = stateno != 4000
triggerall = statetype != A
triggerall = command = "QCB_2P"
trigger1 = ctrl
trigger2 = (var(2)&8192) != 0
value = 4000

[State Broken Flight (DP+2P)]
type = ChangeState
triggerall = !var(10)
triggerall = power >= 1000
triggerall = stateno != 2020
triggerall = statetype != A
triggerall = command = "DP_2P"
trigger1 = ctrl
trigger2 = (var(2)&8192) != 0
value = 2020

[State Hell Hound (QCF_2K)]
type = ChangeState
triggerall = !var(10)
triggerall = power >= 1000
triggerall = stateno != 2000
triggerall = !numhelper(2010)
triggerall = statetype != A
triggerall = command = "QCF_2K"
trigger1 = ctrl
trigger2 = (var(2)&8192) != 0
value = 2000

;===========================================================================
[State Split Scream (QCF+K)]
type = ChangeState
triggerall = !var(10)
triggerall = stateno != 1100
triggerall = !numhelper(11000)
triggerall = statetype != A
triggerall = command = "QCF_K"
trigger1 = ctrl
trigger2 = (var(2)&4096) != 0
value = 1100

[State Cosmic Mauler (DP+P)]
type = ChangeState
triggerall = !var(10)
triggerall = stateno != 1000
;triggerall = statetype != A
triggerall = command = "DP_P"
trigger1 = ctrl
trigger2 = (var(2)&4096) != 0
value = 1000

;===========================================================================
;---------------------------------------------------------------------------
[State -1, Run Fwd]
type = ChangeState
value = 100
triggerall = stateno != 100
triggerall = statetype = S
trigger1 = command = "FF"
trigger1 = ctrl

;---------------------------------------------------------------------------
[State -1, Run Back]
type = ChangeState
value = 105
triggerall = stateno != 105
triggerall = statetype = S
trigger1 = command = "BB"
trigger1 = ctrl

;---------------------------------------------------------------------------
[State Punch Throw]
type = ChangeState
value = 800
triggerall = command = "y"
triggerall = statetype = S
triggerall = ctrl
triggerall = stateno != 800
triggerall = stateno != 100
triggerall = var(10)=0
triggerall = enemynear, name != "final"
triggerall = !(enemynear, name = "noroko" && enemynear, var(10)=1)
trigger1 = command = "holdfwd"
trigger1 = p2bodydist X < 3
trigger1 = (p2statetype = S) || (p2statetype = C)
trigger1 = p2movetype != H
trigger2 = command = "holdback"
trigger2 = p2bodydist X < 5
trigger2 = (p2statetype = S) || (p2statetype = C)
trigger2 = p2movetype != H

;---------------------------------------------------------------------------
[State Kick Throw]
type = ChangeState
value = 850
triggerall = command = "b"
triggerall = statetype = S
triggerall = ctrl
triggerall = stateno != 850
triggerall = stateno != 100
triggerall = var(10)=0
triggerall = enemynear, name != "final"
triggerall = !(enemynear, name = "noroko" && enemynear, var(10)=1)
trigger1 = command = "holdfwd"
trigger1 = p2bodydist X < 3
trigger1 = (p2statetype = S) || (p2statetype = C)
trigger1 = p2movetype != H
trigger2 = command = "holdback"
trigger2 = p2bodydist X < 5
trigger2 = (p2statetype = S) || (p2statetype = C)
trigger2 = p2movetype != H

;===========================================================================
;---------------------------------------------------------------------------
;Stand Light Punch
[State -1, Stand Light Punch]
type = ChangeState
value = 200
triggerall = ifelse(stateno = 200,(var(2)&134217728)!= 0,stateno != 200)
triggerall = command = "x"
triggerall = command != "holddown"
triggerall = var(24)<3
triggerall = statetype != A
trigger1 = ctrl
trigger2 = (var(2)&1) != 0 && (var(2)&1572864) != 1572864 ;Light Chaining != 1572864

;---------------------------------------------------------------------------
;Stand Strong Punch
[State -1, Stand Strong Punch]
type = ChangeState
value = 210
triggerall = ifelse(stateno = 210,(var(2)&134217728)!= 0,stateno != 210)
triggerall = command = "y"
triggerall = command != "holddown"
triggerall = var(24)<3
triggerall = statetype != A
trigger1 = ctrl
trigger2 = (var(2)&2) != 0

;---------------------------------------------------------------------------
;Stand Light Kick
[State -1, Stand Light Kick]
type = ChangeState
value = 230
triggerall = ifelse(stateno = 230,(var(2)&134217728)!= 0,stateno != 230)
triggerall = command = "a"
triggerall = command != "holddown"
triggerall = var(24)<3
triggerall = statetype != A
trigger1 = ctrl
trigger2 = (var(2)&4) != 0 && (var(2)&1572864) != 1572864 ;Light Chaining != 1572864

;---------------------------------------------------------------------------
;Standing Strong Kick
[State -1, Standing Strong Kick]
type = ChangeState
value = 240
triggerall = ifelse(stateno = 240,(var(2)&134217728)!= 0,stateno != 240)
triggerall = command = "b"
triggerall = command != "holddown"
triggerall = var(24)<3
triggerall = statetype != A
trigger1 = ctrl
trigger2 = (var(2)&8) != 0

;---------------------------------------------------------------------------
;Taunt
[State -1, Taunt]
type = ChangeState
value = 1950
triggerall = command = "start"
triggerall = var(24)<3
triggerall = statetype != A
trigger1 = ctrl

;---------------------------------------------------------------------------
;Crouching Light Punch
[State -1, Crouching Light Punch]
type = ChangeState
value = 400
triggerall = ifelse(stateno = 400,(var(2)&134217728)!= 0,stateno != 400)
triggerall = command = "x"
triggerall = command = "holddown"
triggerall = var(24)<3
triggerall = statetype != A
trigger1 = ctrl
trigger2 = (var(2)&16) != 0 && (var(2)&1572864) != 1572864 ;Light Chaining != 1572864

;---------------------------------------------------------------------------
;Crouching Strong Punch
[State -1, Crouching Strong Punch]
type = ChangeState
value = 410
triggerall = ifelse(stateno = 410,(var(2)&134217728)!= 0,stateno != 410)
triggerall = command = "y"
triggerall = var(11) < 1 ;LIMITER
triggerall = command = "holddown"
triggerall = var(24)<3
triggerall = !numhelper(410) && !numhelper(411) && !numhelper(412) && !numhelper(413) && !numhelper(414)
triggerall = statetype != A
trigger1 = ctrl
trigger2 = (var(2)&32) != 0

;---------------------------------------------------------------------------
;Crouching Light Kick
[State -1, Crouching Light Kick]
type = ChangeState
value = 430
triggerall = ifelse(stateno = 430,(var(2)&134217728)!= 0,stateno != 430)
triggerall = command = "a"
triggerall = command = "holddown"
triggerall = var(24)<3
triggerall = statetype != A
trigger1 = ctrl
trigger2 = (var(2)&64) != 0 && (var(2)&1572864) != 1572864 ;Light Chaining != 1572864

;---------------------------------------------------------------------------
;Crouching Strong Kick
[State -1, Crouching Strong Kick]
type = ChangeState
value = 440
triggerall = ifelse(stateno = 440,(var(2)&134217728)!= 0,stateno != 440)
triggerall = command = "b"
triggerall = command = "holddown"
triggerall = var(24)<3
triggerall = statetype != A
trigger1 = ctrl
trigger2 = (var(2)&128) != 0

;---------------------------------------------------------------------------
;Jump Light Punch
[State -1, Jump Light Punch]
type = ChangeState
value = 600
triggerall = ifelse(stateno = 600,(var(2)&134217728)!= 0,stateno != 600)
triggerall = command = "x"
triggerall = var(24)<3
triggerall = statetype = A
trigger1 = ctrl
trigger2 = (var(2)&256) != 0 && (var(2)&1572864) != 1572864 ;Light Chaining != 1572864

;---------------------------------------------------------------------------
;Jump Strong Punch
[State -1, Jump Strong Punch]
type = ChangeState
value = 610
triggerall = ifelse(stateno = 610,(var(2)&134217728)!= 0,stateno != 610)
triggerall = command = "y"
triggerall = var(24)<3
triggerall = statetype = A
trigger1 = ctrl
trigger2 = (var(2)&512) != 0

;---------------------------------------------------------------------------
;Jump Light Kick
[State -1, Jump Light Kick]
type = ChangeState
value = 630
triggerall = ifelse(stateno = 630,(var(2)&134217728)!= 0,stateno != 630)
triggerall = command = "a"
triggerall = var(24)<3
triggerall = statetype = A
trigger1 = ctrl
trigger2 = (var(2)&1024) != 0 && (var(2)&1572864) != 1572864 ;Light Chaining != 1572864

;---------------------------------------------------------------------------
;Jump Strong Kick
[State -1, Jump Strong Kick]
type = ChangeState
value = 640
triggerall = ifelse(stateno = 640,(var(2)&134217728)!= 0,stateno != 640)
triggerall = command = "b"
triggerall = var(24)<3
triggerALL = statetype = A
trigger1 = ctrl
trigger2 = (var(2)&2048) != 0 && (var(2)&1572864) != 1572864 ;Light Chaining != 1572864

;-----------------------------------

[State Super Jump]
type = ChangeState
value = 40
triggerall = stateno != 40
triggerall = command = "holdup"
trigger1 = (var(2)&32768) != 0


;-------------------------------------------------------------------
;-------------------------------------------------------------------
;-----AI------------------------------------------------------------
;-------------------------------------------------------------------
;-------------------------------------------------------------------

;[State AI Difficulty]
;type = varset
;trigger1 = (var(2)&2097152) !=0 && (var(2)&12582912) = 0 ;AI is on and difficulty isn't set yet
;var(2) = 4194304 * ((roundno >=3) + (roundno >=5))

[State AI Difficulty]
type = varset
trigger1 = (var(2)&2097152) !=0 && !var(24); && (var(2)&12582912) = 0 ;AI is on and difficulty isn't set yet
var(24) =  ((roundno >=3) + (roundno >=5))






