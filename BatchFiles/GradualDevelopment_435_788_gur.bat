cd ..
gams genesysmod.gms -gdxCompress=1 --emissionPathway=GradualDevelopment --emissionspenalty=435 --solver=gurobi --switch_test_data_load=0 -gdx=GradualDevelopment_435_788_gur --elmod_nthhour=788 --elmod_hour_steps=4 --threads=2 -o=BatchFiles\Logs\GD_435_788_gur.log --Info=GD_435_788_gur
pause