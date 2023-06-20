cd ..
gams genesysmod.gms -gdxCompress=1 --emissionPathway=DirectedTransition --emissionspenalty=1000 --solver=gurobi --switch_test_data_load=0 -gdx=DirectedTransition_1000_244_gur_nobaseyear --elmod_nthhour=244 --elmod_hour_steps=4 --threads=4 -o=BatchFiles\Logs\DT_1000_244_gur_nobaseyear.log --Info=DT_1000_244_gur_nobaseyear
pause