# Regular expressions

# Text Sample
str <- c("Game of Thrones is a medieval fantasy",
         "television series based on the fantasy novel series ",
         "A Song of Ice and Fire by George R. R. Martin", 
         "The series was first broadcast in 2011 on HBO")

?grep
# You can use grep to find patterns in your texts:
# Pattern Matching and Replacement
grep("fa", str, value = F) # in position 1 and 2 of vector we have 'fa'
grep("fa", str, value = T) # VALUE
grep("\\d", str, value = F) # Using regex
grep("\\d", str, value = T) 

# grepl() Returns of bool values

grepl("\\d+", str)
grepl("\\D", str)

# gsub() - # Substitue the pattern
gsub("medieval", "***", str )
gsub("medieval", "***", str, ignore.case = T)

# sub() - # Substitue the pattern 

sub("medieval", "***", str)

# Regexpr - Using regex
phrase <-  "I'm learning R"
regexpr(pattern = "e", phrase)

# Other variation of regexpr
gregexpr(pattern = "e", phrase)

gsub("\\d", "", str)
gsub("\\D", "", str)
gsub("\\s", "", str)
gsub("[iot]", "", str)
gsub("[[:punct:]]", "", str)

