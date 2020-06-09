# Working with applicable families

# You can use some function that can be useful in your project's like functions apply.

quadratic_function <-function(x){x**2}
print(quadratic_function(20)) # 400


# apply () - arrays and matrix as arguments
# tapply () - vectors can be divided into different subsets as arguments
# lapply () - vectors and lists as arguments
# sapply () - friendly version of lapply as arguments
# vapply () - similar to sapply, with modified return value as arguments
# rapply () - similar to lapply () as arguments
# eapply () - generate a list as arguments
# mapply () - similar to sapply, multivariate as arguments
# by

## sapply()
lista <- list(a = c(1:5), b = c(10:50)) # Return sum of each element from list
sapply(lista, mean)
sapply(lista, quadratic_function)

## apply()
M <- matrix(c(1:10), nr = 5, nc = 5)
apply(M, 1, sum) # Sum of lines
apply(M, 2, sum) # Sum of columns

## tapply()
#Calculates the FUN of values of each category, equals group by, FUN = SUM
tapply(iris$Sepal.Length, iris$Species, sum)
tapply(iris$Sepal.Length, iris$Species, mean)


## by() - Function Similar with Families apply's
#Applying a function to a dataframe divided by factors
by(iris, iris$Species, function(x){mean_sepal <- mean(iris$Sepal.Length)})

## lapply()
lista <- list(a = c(1:5), b = c(10:50)) 
lapply(lista, sum) # Returns list
sapply(lista, sum) # Returns vector
vapply(lista, fivenum, c(Min. = 0, "1stQu." = 0, Median = 0, "3rd Qu." = 0, Max= 0))


## replicate()
replicate(7, runif(10)) # Repeat the 7x runif command

## mapply()
mapply(rep,1:4, 4:1) #1 2 3 4 <- (1,1,1,1), (2,2,2), (3,3),(4) return list

## rapply() - Recursively Apply a Function to a List

lista <- list(a = c(1:5), b = c(10:50)) 
rapply(lista, sum)
rapply(lista, sum, how = "list")
