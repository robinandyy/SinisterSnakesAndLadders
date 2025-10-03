# SinisterSnakesAndLadders
A snakes and ladders game with fun twists and turns. Will you get a snack break instead of taking your turn? Will your friend move your position on the board while you are getting a snack? This AI model using pddl will answer those questions :).

This is a model of a snakes and ladder game with four players. Players take turns as they try to move along the board by rolling the six-sided die. That said, there are snakes and ladders as the name suggests! If you roll the die and land on a snake you move backwards from your current square to an earlier position on the board. If you land on a ladder, you move up to a square that is closer to the goal (square 18). The thing is, you need to roll the exact number to land on square 18. If you overshoot, you move backwards. 

Not to mention, we are all people. We get hungry and competitive. Players may choose to take a snack break instead of taking their turn, passing the turn onto the next player and setting them behind. While they get a snack, one of the other player's may opt to move their position backwards, since they are not looking! A simple game with sinister twists.

This model has four actions:

- roll
    - rolls a six sided die when it is player p's turn
- move
    - moves the player from their current square to their destination square based on their roll
    - accounts for snakes and ladders as well - player p may not land on their destination square after all!
- are you hungry
    - checks to see if player p is hungry when it is their turn - this could cause them to want a snack break
- snack break
    - if player p is hungry and it's their turn, they can opt to get a snack instead of rolling the die and moving from their current position
