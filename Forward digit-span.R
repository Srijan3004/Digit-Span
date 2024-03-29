#### Author : SRIJAN CHATTOPADHYAY
#### Affiliation : INDIAN STATISTICAL INSTITUTE, KOLKATA
#### Designation : STUDENT, B.STAT 2ND YEAR
#FORWARD DIGIT SPAN TEST

random.numbers <- function(){
  
  random.digits <- function(n){
    
    # Randomly generating distinct digits of the numbers
    
    k=0
    l=0
    while (k==0) 
    {
      number <- sample(1:9 , size = n , replace = FALSE)
      for(i in 2:length(number))
      {
        if(number[i]==number[i-1]+1 || number[i]==number[i-1]-1) #checking the intra-line conditions
          l=l+1
      }
      if(l == 0) k=1
      else 
      {k=0
      l=0}}
    
    return(number)
  }
  
  test.data <- c()
  data <- c()
  a=random.digits(3)
  test.data = c(test.data, a)
  data = c(data, as.numeric(paste(a, collapse = "")))
  for (i in 4:9) {
    h=0
    while(h==0)
    {
      a=c(test.data[(i-3)*(i+2)/2-(i-1)+1] : test.data[(i-3)*(i+2)/2])
      g=0
      h=0
      b=random.digits(i)
      if(b[1]==a[1] || b[1]==a[length(a)] || b[length(b)]==a[length(a)] || b[length(b)]==a[1]) #checking the inter line conditions 
      {
        g=g+1
      }
      if(g==0) h=1
      else h=0}
    test.data = c(test.data, b)
    data = c(data, as.numeric(paste(b, collapse = "")))
  }
  
  return(data) # Vector containing all the numbers
}



cat("\f")
cat("\nStarting the digit span test...\n\n")  # Instructions
Sys.sleep(2)

cat("The purpose of this experiment is to find out your digit span / 
memory span. \n\n")
cat("=====================================================================\n\n")
Sys.sleep(3)

cat("INSTRUCTIONS :\n\n")
cat("(1) Starting from a 3-digit number, each number will 
appear one by one after an interval of 2 seconds. In order to proceed,
you'll have to make the correct guess.\n\n")
cat("(2) At each step, the number of digits will increase by 1. If you
make one mistake somewhere, you'll be able to proceed. If you make 2 
mistakes, the experiment will stop there.\n\n")
cat("(3) The test will be conducted 2 times.\n\n")
Sys.sleep(2)

cat("All the best !\n\n")

## Details about the participant ##

name <- readline(prompt = "Enter your name : ")
age <- readline(prompt = "Enter your age : ")
gender <- readline(prompt = "Enter your gender [M / F] : ")
education <- readline(prompt = "Enter your years of education : ")
  
if (gender != "M" && gender !="m" && gender != "F" && gender != "f"){
    print("Invalid gender input !") # Checkpoint for invalid gender input
    stop("\n\nPlease try again.\n\n")
}
if (gender == "M" || gender == "m"){gender <- "MALE"}
if (gender == "F" || gender == "f"){gender <- "FEMALE"}

cat("\n\n")


## Main function for conducting the experiment ##

final.exp <- function(d){
  begin <- readline(prompt = "Ready to start the test ? [Y / N] : ")
  cat("\f")
  
  if (begin == "Y" || begin == "y") {
    
    # Random numbers are generated for a particular experiment
    exp.data <- random.numbers()
    
    cat("Experiment number ",d," will start in 4 seconds...\n\n")
    Sys.sleep(4)
    cat("\f")
    
    # Initial count for number of mistakes
    count <- 0
    response = 0
    for (num in exp.data) {
      
      # Each number is printed in the R Console
      print(num)
      
      # Waiting time of 2 seconds
      Sys.sleep(2)
      cat("\f")
      
      # Subject's response
      guess <- readline(prompt = "Guess the number : ")
      response = c(response, guess)
      
      # Condition for CORRECT guess
      if (guess == num){
        if (num != exp.data[length(exp.data)]){
          cat("\f")
          cat("The next number will appear in 3 seconds...\n\n")
          Sys.sleep(3)
        }
        
        if (num == exp.data[length(exp.data)]) {
          cat("\n Your test #",d,"is over. You guessed ",
              floor(log10(num))-1-count,
              " numbers correctly.\n\n")
          return(c(floor(log10(num))-1-count,floor(log10(num))+1,exp.data,response[-1]))
        }
      }
      
      cat("\f")
      
      # Condition for INCORRECT guess
      if (guess != num){
        count <- count + 1
        
        # 1st mistake
        if (count == 1){
          if (num != exp.data[length(exp.data)]){
            first <- floor(log10(num)) + 1
            cat("The next number will appear in 3 seconds...\n\n")
            Sys.sleep(3)
            cat("\f")
          }
          
          if (num == exp.data[length(exp.data)]){
            cat("Your test #",d,"is over. You guessed ",
            floor(log10(num)) - 2," numbers correctly.\n\n")
            return(c(floor(log10(num))-1-count,log10(num),exp.data,response[-1]))
            print(guess)
            print(num)
          }
        }
          
        # 2nd mistake
        if (count == 2){
          second <- floor(log10(num)) + 1
          if (num == exp.data[2]) {return(c(floor(log10(num))-1-count,0,exp.data,response[-1]))}
          
          cat("Your test #",d,"is over. You guessed ",
              floor(log10(num))-3," numbers correctly.\n\n")
            
          if (first != second - 1) {return(c(floor(log10(num))-1-count,second - 1,exp.data,response[-1]))}
          if (first == second - 1) {return(c(floor(log10(num))-1-count,first - 1,exp.data,response[-1]))}
        }
      }
    }
  }
  else stop("You have chosen not to proceed !\n\n")
}



## 1st test ##

F1 <- final.exp(1)
for(i in 3:9){
  print(as.numeric(F1[i]))
}
for(i in 10:length(F1)){
  print(as.numeric(F1[i]))
}
if (F1[1] == 0) {
  cat("\n\nYour test could not be completed.\n\n")
  cat("If you want, you may try again. Thank you.\n\n")
  stop("Good luck.\n\n")
}


## 2nd test ##

F2 <- final.exp(2)
for(i in 3:9){
  print(as.numeric(F2[i]))
}
for(i in 10:length(F2)){
  print(as.numeric(F2[i]))
}
if (F2[1] == 0) {
  cat("\n\nYour test could not be completed.\n\n")
  cat("If you want, you may try again. Thank you.\n\n")
  stop("Good luck.\n\n")
}


# Final calculation of the participant's forward digit span
digit.span <- mean(c(F1[1],F2[1])) # Average digit span

# Digits span printed as a sentence
cat("As per the most recent test, the digit span of",name,"is",digit.span,".\n\n")
Sys.sleep(2)
cat("Thank you for taking the test.\n\n")

# Overall result stored as a data frame variable
result <- data.frame(NAME = name , AGE = age , GENDER = gender ,
                     EDUCATION = education , TEST.1 = F1[1] , TEST.2 = F2[1] , 
                     DIGIT.SPAN = digit.span)

print(result)
cat("\n")
View(result) # Overall result printed in a chart format

