cd ..
gams genesysmod.gms -gdxCompress=1 --emissionPathway=DirectedTransition --emissionspenalty=1000 --solver=gurobi --switch_test_data_load=0 -gdx=DirectedTransition_1000_788_gur --elmod_nthhour=788 --elmod_hour_steps=4 --threads=4 -o=BatchFiles\Logs\DT_1000_788_gur.log --Info=DT_1000_788_gur
pause