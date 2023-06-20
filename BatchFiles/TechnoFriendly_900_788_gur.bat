cd ..
gams genesysmod.gms -gdxCompress=1 --emissionPathway=TechnoFriendly --emissionspenalty=900 --solver=gurobi --switch_test_data_load=0 -gdx=TechnoFriendly_900_788_gur --elmod_nthhour=788 --elmod_hour_steps=4 --threads=2 -o=BatchFiles\Logs\TF_900_788_gur.log --Info=TF_900_788_gur
pause