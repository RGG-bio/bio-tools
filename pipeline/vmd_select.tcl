##this is an example of short script to select the atoms from pdb

mol new model.pdb type pdb 

set model [ atomselect 0 "noh and {{resid 0 to 50 and chain A}} or {{resid 8 to 87 and chain B}}"]


$model writepdb model.pdb

quit
