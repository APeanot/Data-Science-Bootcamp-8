print("Hello, human ... ")
print("Tell me your name")
name <- readLines("stdin", n = 1)
print(paste("Welcome to the challenge of the Rock-Paper-Scissors game, ", name))

Weapon <- c("Rock", "Paper", "Scissors")
Select_Weapon <- c("R", "P", "S")
x <- data.frame(Weapon, Select_Weapon)
print(x)

Boss <- c("R", "P", "S")
Win <- 0
Lose <- 0
Equal <- 0

while(TRUE) {
  print("Select your weapon: [R] Rock, [P] Paper, [S] Scissors")
  print("Press [Q] to leave the match")
  B <- sample(Boss, 1)
  player <- readLines("stdin", n = 1)
  print(paste("You choose ", player, " as your weapon"))
  if (player != B) {
    if (player == "R" & B == "S" |
        player == "S" & B == "P" |
        player == "P" & B == "R") {
        print(paste("The Boss choose ", B, " as its weapon."))
        print("You win the fight!")
        print("Select your weapon to fight more!")
        Win <- Win + 1
} else 
    if (player == "R" & B == "P" |
        player == "P" & B == "S" |
        player == "S" & B == "R") {
        print(paste("The Boss choose ", B, " as its weapon."))
        print("You lose the fight!")
        print("Select your weapon to fight again!")
        Lose <- Lose + 1
} else
    if (player == "Q") {
        print("If you want to conquer me, come at any time human.")
        print("Scoreboard")
        break
    }
} else 
    if (player == B) {
        print(paste("The Boss choose ", B, " as its weapon,"))
        print("Withdraw!")
        print("Select your weapon to fight again!")
        Equal <- Equal + 1
    }
}

print(paste("You win", Win, "times"))
print(paste("You lose", Lose, "times"))
print(paste("You equal", Equal, "times"))
