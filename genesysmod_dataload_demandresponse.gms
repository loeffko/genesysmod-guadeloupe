$setglobal switch_test_data_load 1

$include genesysmod.gms

SpecifiedDemandProfile(r,f,l,y)$((SpecifiedDemandProfile(r,f,l,y)=0) and (sum(ll,SpecifiedDemandProfile(r,f,ll,y)))) = 0.00000001;
CapacityFactor(r,t,l,y)$(CapacityFactor(r,t,l,y)=0 and sum(ll,CapacityFactor(r,t,l,y))) = 0.00000001;


execute_unload "%gdxdir%demandsmoothing_%model_region%_%emissionPathway%_%emissionScenario%.gdx"
SpecifiedDemandProfile
CapacityFactor
;

$call gdxdump %gdxdir%demandsmoothing_%model_region%_%emissionPathway%_%emissionScenario%.gdx symb=SpecifiedDemandProfile format=csv Header="region,fuel,timeslice,year,value" > %tempdir%demandsmoothing_specifiedannualdemand.csv
$call gdxdump %gdxdir%demandsmoothing_%model_region%_%emissionPathway%_%emissionScenario%.gdx symb=CapacityFactor format=csv Header="region,technology,timeslice,year,value" > %tempdir%demandsmoothing_capacityfactor.csv
