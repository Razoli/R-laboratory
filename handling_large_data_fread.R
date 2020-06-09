# How to read large data in R

# Packages

library("data.table")

# You can use many functions that can be useful to read large datas > 400Mb in your memory.

# Use fread to large datas - Fast and Friendly
?fread 

system.time(df <- fread())