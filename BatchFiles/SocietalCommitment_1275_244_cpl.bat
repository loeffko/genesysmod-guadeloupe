cd ..
gams genesysmod.gms -gdxCompress=1 --emissionPathway=SocietalCommitment --emissionspenalty=1275 --solver=cplex --switch_test_data_load=0 -gdx=SocietalCommitment_1275_244_cpl --elmod_nthhour=244 --elmod_hour_steps=4 --threads=4 -o=BatchFiles\Logs\SC_1275_244_cpl.log --Info=SC_1275_244_cpl
pause