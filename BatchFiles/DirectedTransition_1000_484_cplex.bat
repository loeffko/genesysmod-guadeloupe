cd ..
gams genesysmod.gms -gdxCompress=1 --emissionPathway=DirectedTransition --emissionspenalty=1000 --solver=cplex --switch_test_data_load=0 -gdx=DirectedTransition_1000_484_cplex --elmod_nthhour=484 --elmod_hour_steps=4 --threads=4 -o=BatchFiles\Logs\DT_1000_484_cplex.log --Info=DT_1000_484_cplex
pause