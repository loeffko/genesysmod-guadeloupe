cd ..
gams genesysmod.gms -gdxCompress=1 --emissionPathway=GradualDevelopment --emissionspenalty=435 --solver=gurobi --switch_test_data_load=1 -gdx=GD_dataload --elmod_nthhour=788 --elmod_hour_steps=4 --threads=2 -o=BatchFiles\Logs\GD_dataload.log --Info=GD_dataload
pause