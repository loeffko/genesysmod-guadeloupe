cd ..
gams genesysmod.gms -gdxCompress=1 --emissionPathway=SocietalCommitment --emissionspenalty=1275 --solver=cplex --switch_test_data_load=0 -gdx=SocietalCommitment_1275_788_cplex --elmod_nthhour=788 --elmod_hour_steps=4 --threads=2 -o=BatchFiles\Logs\SC_1275_788_cplex.log --Info=SC_1275_788_cplex
pause