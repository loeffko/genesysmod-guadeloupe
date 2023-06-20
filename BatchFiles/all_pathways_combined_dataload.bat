cd ..
echo "Load DT Data"
gams genesysmod.gms -gdxCompress=1 --emissionPathway=DirectedTransition --emissionspenalty=1000 --solver=gurobi --switch_test_data_load=1 -gdx=DT_dataload --elmod_nthhour=788 --elmod_hour_steps=4 --threads=2 -o=BatchFiles\Logs\DT_dataload.log --Info=DT_dataload

echo "Load GD Data"
gams genesysmod.gms -gdxCompress=1 --emissionPathway=GradualDevelopment --emissionspenalty=435 --solver=gurobi --switch_test_data_load=1 -gdx=GD_dataload --elmod_nthhour=788 --elmod_hour_steps=4 --threads=2 -o=BatchFiles\Logs\GD_dataload.log --Info=GD_dataload

echo "Load SC Data"
gams genesysmod.gms -gdxCompress=1 --emissionPathway=SocietalCommitment --emissionspenalty=1275 --solver=gurobi --switch_test_data_load=1 -gdx=SC_dataload --elmod_nthhour=788 --elmod_hour_steps=4 --threads=2 -o=BatchFiles\Logs\SC_dataload.log --Info=SC_dataload

echo "Load TF Data"
gams genesysmod.gms -gdxCompress=1 --emissionPathway=TechnoFriendly --emissionspenalty=900 --solver=gurobi --switch_test_data_load=1 -gdx=TF_dataload --elmod_nthhour=788 --elmod_hour_steps=4 --threads=2 -o=BatchFiles\Logs\TF_dataload.log --Info=TF_dataload
pause