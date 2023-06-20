cd ..
gams genesysmod.gms -gdxCompress=1 --emissionPathway=SocietalCommitment --emissionspenalty=1275 --solver=gurobi --switch_test_data_load=1 -gdx=SC_dataload --elmod_nthhour=788 --elmod_hour_steps=4 --threads=2 -o=BatchFiles\Logs\SC_dataload.log --Info=SC_dataload
pause