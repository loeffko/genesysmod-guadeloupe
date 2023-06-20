cd ..
gams genesysmod.gms -gdxCompress=1 --emissionPathway=TechnoFriendly --emissionspenalty=900 --solver=cplex --switch_test_data_load=0 -gdx=TechnoFriendly_900_244_cpl --elmod_nthhour=244 --elmod_hour_steps=4 --threads=4 -o=BatchFiles\Logs\TF_900_244_cpl.log --Info=TF_900_244_cpl
pause