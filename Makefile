# Search path
VPATH = data data-raw scripts

# Processed data files
data = birds.rds collisions.rds light_mp.rds bird_collisions_light.rds

# Make all
all : $(data)

# Data dependencies
birds.rds : birds.txt
collisions.rds : collisions.csv
light_mp.rds : light_mp.csv
bird_collisions_light.rds : birds.rds collisions.rds light_mp.rds

# Pattern rules
%.rds : %.R
	Rscript $<