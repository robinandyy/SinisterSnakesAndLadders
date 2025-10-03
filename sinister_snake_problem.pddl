(define (problem snakes_and_ladders_1)
    (:domain snakes_and_ladders)

    ; all 18 squares and four players
    (:objects
        s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12 s13 s14 s15 s16 s17 s18 - square
        p1 p2 p3 p4 - player
    )

    (:init

        ; all four players start in position s1
        (position p1 s1)
        (position p2 s1)
        (position p3 s1)
        (position p4 s1)

        ; player 1 starts
        (turn p1)

        ; player order
        (next-player p1 p2)
        (next-player p2 p3)
        (next-player p3 p4)
        (next-player p4 p1)

        ; evil friend moves player p one square backwards if they get a snack
        (evil-friend-moves-you s2 s1)
        (evil-friend-moves-you s3 s2)
        (evil-friend-moves-you s4 s3)
        (evil-friend-moves-you s5 s4)
        (evil-friend-moves-you s6 s5)
        (evil-friend-moves-you s7 s6)
        (evil-friend-moves-you s8 s7)
        (evil-friend-moves-you s9 s8)
        (evil-friend-moves-you s10 s9)
        (evil-friend-moves-you s11 s10)
        (evil-friend-moves-you s12 s11)
        (evil-friend-moves-you s13 s12)
        (evil-friend-moves-you s14 s13)
        (evil-friend-moves-you s15 s14)
        (evil-friend-moves-you s16 s15)
        (evil-friend-moves-you s17 s16)

        ; very evil friend moves player two square backwards if they get a snack
        (very-evil-friend-moves-you s3 s1)
        (very-evil-friend-moves-you s4 s2)
        (very-evil-friend-moves-you s5 s3)
        (very-evil-friend-moves-you s6 s4)
        (very-evil-friend-moves-you s7 s5)
        (very-evil-friend-moves-you s8 s6)
        (very-evil-friend-moves-you s9 s7)
        (very-evil-friend-moves-you s10 s8)
        (very-evil-friend-moves-you s11 s9)
        (very-evil-friend-moves-you s12 s10)
        (very-evil-friend-moves-you s13 s11)
        (very-evil-friend-moves-you s14 s12)
        (very-evil-friend-moves-you s15 s13)
        (very-evil-friend-moves-you s16 s14)
        (very-evil-friend-moves-you s17 s15)

        ; ; snakes that cause you to move backwards on the board
        (snake s5 s2)
        (snake s13 s7)
        (snake s16 s12)

        ; ; ladders that cause you to move forwards on the board
        (ladder s3 s11)
        (ladder s8 s14)
        (ladder s10 s15)

        ; options 1-6 for rolling the die
        ; there are 18 squares, but you need to roll the exact number to land on s18
        ; move backwards if you overshoot

        ; rolled a 1
        (roll1 s1 s2)
        (roll1 s2 s3)
        (roll1 s3 s4)
        (roll1 s4 s5)
        (roll1 s5 s6)
        (roll1 s6 s7)
        (roll1 s7 s8)
        (roll1 s8 s9)
        (roll1 s9 s10)
        (roll1 s10 s11)
        (roll1 s11 s12)
        (roll1 s12 s13)
        (roll1 s13 s14)
        (roll1 s14 s15)
        (roll1 s15 s16)
        (roll1 s16 s17)
        (roll1 s17 s18)

        ; rolled a 2
        (roll2 s1 s3)
        (roll2 s2 s4)
        (roll2 s3 s5)
        (roll2 s4 s6)
        (roll2 s5 s7)
        (roll2 s6 s8)
        (roll2 s7 s9)
        (roll2 s8 s10)
        (roll2 s9 s11)
        (roll2 s10 s12)
        (roll2 s11 s13)
        (roll2 s12 s14)
        (roll2 s13 s15)
        (roll2 s14 s16)
        (roll2 s15 s17)
        (roll2 s16 s18)
        (roll2 s17 s17)

        ; rolled a 3
        (roll3 s1 s4)
        (roll3 s2 s5)
        (roll3 s3 s6)
        (roll3 s4 s7)
        (roll3 s5 s8)
        (roll3 s6 s9)
        (roll3 s7 s10)
        (roll3 s8 s11)
        (roll3 s9 s12)
        (roll3 s10 s13)
        (roll3 s11 s14)
        (roll3 s12 s15)
        (roll3 s13 s16)
        (roll3 s14 s17)
        (roll3 s15 s18)
        (roll3 s16 s17)
        (roll3 s17 s16)

        ; rolled a 4
        (roll4 s1 s5)
        (roll4 s2 s6)
        (roll4 s3 s7)
        (roll4 s4 s8)
        (roll4 s5 s9)
        (roll4 s6 s10)
        (roll4 s7 s11)
        (roll4 s8 s12)
        (roll4 s9 s13)
        (roll4 s10 s14)
        (roll4 s11 s15)
        (roll4 s12 s16)
        (roll4 s13 s17)
        (roll4 s14 s18)
        (roll4 s15 s17)
        (roll4 s16 s16)
        (roll4 s17 s15)

        ; rolled a 5
        (roll5 s1 s6)
        (roll5 s2 s7)
        (roll5 s3 s8)
        (roll5 s4 s9)
        (roll5 s5 s10)
        (roll5 s6 s11)
        (roll5 s7 s12)
        (roll5 s8 s13)
        (roll5 s9 s14)
        (roll5 s10 s15)
        (roll5 s11 s16)
        (roll5 s12 s17)
        (roll5 s13 s18)
        (roll5 s14 s17)
        (roll5 s15 s16)
        (roll5 s16 s15)
        (roll5 s17 s14)

        ; rolled a 6
        (roll6 s1 s7)
        (roll6 s2 s8)
        (roll6 s3 s9)
        (roll6 s4 s10)
        (roll6 s5 s11)
        (roll6 s6 s12)
        (roll6 s7 s13)
        (roll6 s8 s14)
        (roll6 s9 s15)
        (roll6 s10 s16)
        (roll6 s11 s17)
        (roll6 s12 s18)
        (roll6 s13 s17)
        (roll6 s14 s16)
        (roll6 s15 s15)
        (roll6 s16 s14)
        (roll6 s17 s13)

    )

    ; Goal is for one of the players to get to the final square
    (:goal

        (position ?p s18)

    )

)