cd ..
gams genesysmod.gms -gdxCompress=1 --emissionPathway=GradualDevelopment --emissionspenalty=355 --solver=cplex --switch_test_data_load=0 -gdx=GradualDevelopment_355_484_gur --elmod_nthhour=484 --elmod_hour_steps=4 --threads=4 -o=BatchFiles\Logs\GD_355_484_cplex.log --Info=GD_435_484_cplex
pause