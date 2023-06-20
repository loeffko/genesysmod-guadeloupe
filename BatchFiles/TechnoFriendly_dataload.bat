cd ..
gams genesysmod.gms -gdxCompress=1 --emissionPathway=TechnoFriendly --emissionspenalty=900 --solver=gurobi --switch_test_data_load=1 -gdx=TF_dataload --elmod_nthhour=788 --elmod_hour_steps=4 --threads=2 -o=BatchFiles\Logs\TF_dataload.log --Info=TF_dataload
pause