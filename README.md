# Bioinformatics-tools

## generate_md_systems ![](figures/logo.png)


## Description
This is a short bash script which helps the automatization of your md_simulation systems.
The script edits your script for each model and system you need for your md_simulation. 
After editing the scripts it runs the tleap first to extract the volume and density of your system and after integrates these values in a small perl script to calculate the number of atoms necessary for our system.
The user will need to respect the project structure mentioned in the pipe_structure.txt
In this pipeline directory the user needs to provide a tleap script with 2 variables set as default values that would be replaced in the generation of the script for each system.
These variables are model and number.

## Dependencies 
In order for this to work for your project there are some dependencies to be installed first:
* VMD [1.9.4 ](https://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=VMD)
* amber [22](https://ambermd.org/InstUbuntu.php)

## Pipeline 
![](figures/pipeline.png)

## Usage 
	generate_md_systems.sh  /path/to/root/directory
## Output 
* all the files and directories generated for the models provided as in example [files structure](https://github.com/roxanavas/bio-tools/blob/dev-r/pipeline/pipe_structure.txt)
* report with all the output data created and any errors in [log](https://github.com/roxanavas/bio-tools/blob/dev-r/pipeline/log_pipe.log)

	 




