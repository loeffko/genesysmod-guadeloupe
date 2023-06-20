cd ..
gams genesysmod.gms -gdxCompress=1 --emissionPathway=TechnoFriendly --emissionspenalty=900 --solver=cplex --switch_test_data_load=0 -gdx=TechnoFriendly_900_484_cpl --elmod_nthhour=484 --elmod_hour_steps=4 --threads=8 -o=BatchFiles\Logs\TF_900_484_cpl.log --Info=TF_900_484_cpl
pause