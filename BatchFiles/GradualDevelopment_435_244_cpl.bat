cd ..
gams genesysmod.gms -gdxCompress=1 --emissionPathway=GradualDevelopment --emissionspenalty=435 --solver=cplex --switch_test_data_load=0 -gdx=GradualDevelopment_435_244_cpl --elmod_nthhour=244 --elmod_hour_steps=4 --threads=4 -o=BatchFiles\Logs\GD_435_244_cpl.log --Info=GD_435_244_cpl
pause