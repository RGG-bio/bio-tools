#!/bin/bash 

source ~/bin/prepare_amber-22_tools-22_openmpi-4.1.4.sh
source ~/bin/prepare_vmd-1.9.4a55_bin.sh

project_dir=$1 #outside bash first given argument 
cd $project_dir
models_files=(models/*.pdb)
i=0

### create project structure based on the number of models
for f in "${models_files[@]}"; do
    cd $project_dir
    i=$(( i + 1 ))
    model="m_$i"
    mkdir $model
    echo "------------ The model for these systems is $model -----------"
    cp  vmd_select.tcl   $model
    cp $f $model
    cd $model
    ##generate the systems pdbs using VMD
    sed -i -e "s/model/$model/g" vmd_select.tcl
    vmd="$(vmd -e vmd_select.tcl)"
    vmd_pdbs=(*.pdb)
    # for each system create a directory with pdb and tleap_script
    for pdb_file in "${vmd_pdbs[@]}";do
        system_name="${pdb_file%.*}"
        mkdir $system_name
        mv $pdb_file $system_name  
        cp $project_dir/tleap_run.in $system_name   
        full_path="$project_dir/$model/$system_name/tleap_run.in"
	sed -i -e "s/model/$system_name/g" $full_path
	sed -i -e "s/dnd1_human.pdb/$system_name.pdb/g" $full_path
    done
    echo "   All the files were succesfully created "
    # for each system run tleap and calculate the volume and density for the systems
    for pdb_file in "${vmd_pdbs[@]}";do
        system_name="${pdb_file%.*}"
        cd $project_dir/$model/$system_name
        full_path="$project_dir/$model/$system_name/tleap_run.in"
	echo "---The system being analysed: $system_name"
        tleap -f tleap_run.in 2&> tleap.log
        volume="$(grep -oP 'Volume:\s*\K\d+' tleap.log)"
	echo "     The system volume: $volume"
	density="0.$(grep -oP 'Density 0.\s*\K\d+' tleap.log)"
	echo "     The system density:$density"
	ions_value="$(~/bin/calc_ions.pl -c 150 -v $volume -d $density)"
	ions="$(echo "$ions_value"| cut -d '=' -f4-)"
	ion=${ions:2:2}
	sed -i -e "s/number/$ion/g" $full_path
	tleap -f tleap_run.in 2&> tleap.log
	echo "all coordinates and topology files created"
	echo "                      "

    done
done
##### all systems have tleap.log file 
##### all errors and output are stored in log_pipe.log
echo "----all done check the log file----"


	









