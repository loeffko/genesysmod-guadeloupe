cd ..
gams genesysmod.gms -gdxCompress=1 --emissionPathway=DirectedTransition --emissionspenalty=1000 --solver=gurobi --switch_test_data_load=0 -gdx=test_DT_nobaseyearbounds_hlr_oil_bis2050 --elmod_nthhour=484 --elmod_hour_steps=4 --threads=4 -o=BatchFiles\Logs\DT_1000_484_gur.log
pause