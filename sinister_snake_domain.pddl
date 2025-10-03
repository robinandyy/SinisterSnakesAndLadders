;Header and description

(define (domain snakes_and_ladders)

    (:requirements :conditional-effects :typing :negative-preconditions :equality :adl :non-deterministic)

    (:types
        square player
    )

    (:predicates

        ; possible die dierolls

        (roll1 ?current - square ?dest - square)
        (roll2 ?current - square ?dest - square)
        (roll3 ?current - square ?dest - square)
        (roll4 ?current - square ?dest - square)
        (roll5 ?current - square ?dest - square)
        (roll6 ?current - square ?dest - square)

        ; player p is in current position
        (position ?p ?current - square)

        ; die has been rolled to some destination square
        (dieroll ?dest - square)

        ; player p's turn
        (turn ?p - player)

        ; nextp's turn is after player p
        (next-player ?p - player ?nextp - player)

        ; player p is hungry
        (hungry ?p)

        ; evil friend moves player back one square
        (evil-friend-moves-you ?current - square ?dest - square)

        ; very evil friend moves player back two squares
        (very-evil-friend-moves-you ?current - square ?dest - square)

        ; snake from destination square to some square sq
        (snake ?dest - square ?sq - square)

        ; ladder from destination square to some square sq
        (ladder ?dest - square ?sq - square)

    )

    (:action roll
        :parameters (?current - square ?dest - square ?p - player ?nextp - player)

        ; roll if player p is on the board, it is their turn, 
        ; and they don't have a pre-existing roll dieroll (don't roll twice)
        :precondition (and
            (position ?p ?current)
            (not (dieroll ?dest))
            (turn ?p)
            (next-player ?p ?nextp))

        ; roll 1-6 and make it true that player p has rolled to land on position y
        :effect (and
            (oneof
                (and(roll1 ?current ?dest)(dieroll ?dest))
                (and(roll2 ?current ?dest)(dieroll ?dest))
                (and(roll3 ?current ?dest)(dieroll ?dest))
                (and(roll4 ?current ?dest)(dieroll ?dest))
                (and(roll5 ?current ?dest)(dieroll ?dest))
                (and(roll6 ?current ?dest)(dieroll ?dest))

            )
        )
    )

    ; when it is a player's turn, they could realize they are hungry
    (:action are-you-hungry
        :parameters (?p - player)

        :precondition (and (turn ?p))

        :effect (and
            (oneof
                (hungry ?p)
                (not (hungry ?p))))
    )

    (:action move

        :parameters (?current - square ?dest - square ?p - player ?nextp - player)

        ; player is in current position but has rolled the die to some destination
        ; there is some next player nextp
        :precondition (and
            (position ?p ?current)
            (dieroll ?dest)
            (next-player ?p ?nextp)
        )

        :effect (and

            ; if there is a snake at destination square, move backwards to position sq
            (forall
                (?sq - square)
                (when
                    (snake ?dest ?sq)
                    (and (position ?p ?sq)
                        (not (position ?p ?current)))))

            ; if there is a ladder at destination square, move forwards to position q
            (forall
                (?q - square)
                (when
                    (ladder ?dest ?q)
                    (and (position ?p ?q)
                        (not (position ?p ?current)))))

            ; if there are no snakes or ladders at destination square, 
            ; move from current square and stay at destination square
            (when
                (and
                    (forall
                        (?q - square)
                        (not (ladder ?dest ?q)))

                    (forall
                        (?sq - square)
                        (not (snake ?dest ?sq))))

                (and (position ?p ?dest)
                    (not (position ?p ?current)))

            )

            (not (dieroll ?dest))
        )
    )

    ; a player could get a snack break if they are hungry, but they give up their turn and do not roll
    (:action snack-break
        :parameters (?p - player ?current - square ?nextp - player ?dest - square)

        ; player p's turn, they are hungry, there is a next player
        :precondition (and (turn ?p)(hungry ?p)(next-player ?p ?nextp)(position ?p ?current))

        :effect (and

            (oneof

                (oneof
                    ; some player x moves player p back one square while player p snacks - evil

                    (and (evil-friend-moves-you ?current ?dest)
                        (not (position ?p ?current)))

                    ; some player x moves player p back two squares while player p snacks - very evil

                    (and (very-evil-friend-moves-you ?current ?dest)
                        (not (position ?p ?current)))

                )

                ; other players decided to be nice while player p was snacking 
                ; and leave player p in tact
                (position ?p ?current)

            )

            ; skip player p's turn and onto next player, but at least player p is not hungry anymore
            ; adds to cost regardless of not taking turn
            (not (turn ?p))
            (turn ?nextp)
            (not (hungry ?p))

        )

    )

)