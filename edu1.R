## 1.3 ##
install.packages("installr")
library(installr)

check.for.updates.R()
install.R()

## 1.5 ##
x <- c(1, 2, 3)
y <- c(3, 5, 6)

ls()

rm(x, y)

ls()

rm(list = ls())

## 1.6 ##
install.packages("dplyr")
install.packages("readxl")
install.packages("flextable")
install.packages("lubridate")

library(dplyr)
library(readxl)
library(flextable)
library(lubridate)

search()


## 1.7 ##
read.csv()

read.xls()
read.xlsx()


## 2.1 ##
print(1234)
print(TRUE)
print("조니뎁")

typeof(1234)
typeof(TRUE)
typeof("조니뎁")

## 2.2 ##
1 + 2
1 - 2
2 * 2
2 / 2

10 / 3
10 %/% 3
10 %% 3

2^4

2 > 2
2 >= 2
2 <= 2
2 == 2
2 != 2

(2 > 3) | (3 > 2)
(2 > 3) & (3 > 2)

## 2. 3 ## 
c(1, 2, 3, 4)
c("백두산", "설악산", "금강산")
c(T, T, F)
c(TRUE, TRUE, FALSE)

1:4

rep(x = 3, times = 5)
rep(x = c(1, 2, 3), each = 3)

seq(from = 1, to = 4)
seq(from = 1, to = 9, by = 2)
seq(from = 1, to = 9, legnth = 8)

y <- c(1, 2, 3, 4, 5)
y <- 1:5

## 2.3.1 ##
x <- c(a = 1, b = 2, c = 3, d = 4)
x

x <- 1:4
names(x) <- c("a", "b", "c", "d")
names(x)


x[c(1, 2, 3)]
x[1:3]
x[c("a", "b")]

x < 3
sum(x , 3)

x[x < 3]

## 2.3.2 ##
fac_data <- factor(c("남", "남", "여", "남", "여"), levels = c("남", "여"))

data <- c("남", "남", "여", "남", "여")
fac_data <- factor(data, levels = c("남", "여"))
fac_data

factor(c('초등학교','고등학교','중학교','중학교','고등학교','초등학교'), 
       levels = c("초등학교", "중학교", "고등학교"), ordered = TRUE)

## 2.3.3 ##
x <- 1:5
y <- 6:10

x + y
x - y
x * y
x / y

x == y
x >= y
x != y

## 2.3.3 ###
x <- c(1, 1, 1, 1, 1, 1)
y <- c(1, 2, 3)

x - y

## 2.4 ##
x <- 1:9
dim(x) <- c(3, 3)
x

matrix(1:9, nrow = 3, ncol = 3)
matrix(1:9, nrow = 3, ncol = 3, byrow = TRUE)

tmp.mat <- matrix(1:9, nrow = 3, ncol = 3)
tmp.mat[1, 1]

tmp.mat[, 1]
tmp.mat[1, ]

colnames(tmp.mat) <- c("a", "b", "c")
rownames(tmp.mat) <- c("x", "y", "z")

## 2.5 ##
tmp <- list(name = c("Kim", "Jang", "Kang"),
            score = c(100, 200, 50),
            age = c(30, 35, 40))

tmp[[1]]
tmp[["name"]]

## 3.1 ##
df <- data.frame(name = c("Kim", "Jung", "Jang"),
                 gender = factor(c("Female", "Male", "Male")),
                 income = c(1000, 3000, 10000))
df[, 1]
df[, "name"]
df$name

str(df)

## 3.2 ##
dim(iris)
str(iris)
head(iris)

colMeans(iris[, 1:4])
colSums(iris[, 1:4])
summary(iris[, 1:4])

iris[1, 3]

head(iris[1:100, ])
head(iris[, 1:2])
head(iris[-(1:100), ])

iris1 <- iris[1:75, ]
iris2 <- iris[76:150, ]

rbind.iris <- rbind(iris1, iris2)
str(rbind.iris)

iris.num <- iris[, 1:4]
iris.fac <- iris[, 5]

cbind.iris <- cbind(iris.num, iris.fac)
str(cbind.iris)

## 3.3 ##
iris$Species == "setosa"
iris[iris$Species == "setosa", ]

iris[iris$Sepal.Length > 5, ]

subset(iris, Species == "setosa")
subset(iris, Sepal.Length > 5)

subset(iris, Species == "setosa" | Species == "virginica")

ex1 <- subset(iris, Species == "setosa" | Species == "virginica",
              select = "Sepal.Length")
head(ex1)

ex2 <- iris[iris$Species == "setosa" | iris$Species == "virginica", "Sepal.Length"]
head(ex2)




