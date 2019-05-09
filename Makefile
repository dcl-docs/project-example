# Search path
VPATH = data data-raw scripts

# Processed data files
data = test.rds

# Make all
all : $(data)

# Data dependencies
test.rds : test.csv

# Pattern rules
%.rds : %.R
	Rscript $<