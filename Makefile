# Search path
VPATH = data data-raw eda reports scripts

# Processed data files
DATA = birds.rds collisions.rds light_mp.rds bird_collisions_light.rds

# EDA studies
EDA = birds.md collisions.md light_mp.md bird_collisions_light.md

# Reports
REPORTS = report.md

# All targets
all : $(DATA) $(EDA) $(REPORTS)

# Data dependencies
birds.rds : birds.R birds.txt
collisions.rds : collisions.R collisions.csv
light_mp.rds : light_mp.R light_mp.csv
bird_collisions_light.rds : bird_collisions_light.R \
  birds.rds collisions.rds light_mp.rds

# EDA study and report dependencies
birds.md : birds.rds
collisions.md : collisions.rds
light_mp.md : light_mp.rds
bird_collisions_light.md : bird_collisions_light.rds
report.md : bird_collisions_light.rds

# Pattern rules
%.rds : %.R
	Rscript $<
%.md : %.Rmd
	Rscript -e 'rmarkdown::render(input = "$<", output_options = list(html_preview = FALSE))'
