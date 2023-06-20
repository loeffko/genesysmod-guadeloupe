cd ..
gams genesysmod.gms -gdxCompress=1 --emissionPathway=GradualDevelopment --emissionspenalty=435 --solver=gurobi --switch_test_data_load=0 -gdx=GradualDevelopment_435_484_gur --elmod_nthhour=484 --elmod_hour_steps=4 --threads=4 -o=BatchFiles\Logs\GD_435_484_gur.log --Info=GD_435_484_gur
pause