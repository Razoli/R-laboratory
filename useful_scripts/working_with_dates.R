# Dates

# Date and Hours of System

Today <- Sys.Date()
class(Today) # Class of variable Today - Date
Sys.time() # Time of computer now
Sys.timezone() # Continent/City

# Dates in R are stored in numeric format since January 1, 1970 (Numbers of days) 
# Time by POSIXct. (Number of seconds)

# Formatting Dates
# %d: 2-digit day of the month (13)
# %m: month in 2 digits (01)
# %y: year in 2 digits (82)
# %Y: year in 4 digits (1982)
# %A: day of the week (Friday)
# %a: abbreviated day of the week (Fri)
# %B: month (July)
# %b: abbreviated month (Jul)


# Formatting time
# %H: hour (00-23)
# %M: minute
# %S: second
# %T: formed reduced to% H:%M:%S

string <- "2018-06-28"
as.Date(string)
as.Date("Jun-28-18", format = "%b-%d-%y") #"2018-06-28"


as.POSIXct() ## Format where you have the number of seconds since 1970.
date_convert <- as.POSIXct(as.Date(string))

date = as.Date(string)
print(date)
date + 1 # Increment +1 on day

my_time <-  as.POSIXct("2016-05-14 11:24:134") # Working with time + 1 (second)
my_time + 1

# You can have a date in full format
dts = c(1127056501, 1104295503)
mydates = dts

#POSIXt -> Class ("POSIXct, POSIXlt) -> subclass
class(mydates) =  c("POSIXt", "POSIXct")
print(mydates)

# or you can use:
structure(dts, class = c("POSIXt", "POSIXct"))

# função ISODate

a1 <- ISOdate(2011,3,23)
a2 <- ISOdate(2011,3,24)

# Difference between days
difftime(a2,a1, units = "days")


##### Other package very useful to manipulate dates is the lubridate
library(lubridate)

# Change the formats
ymd("20180604")
mdy("06-04-2018")
dmy("06/04/2018")

wday("2018-07-08") #weekday number
wday("2018-07-08", label = TRUE) #weekday label
