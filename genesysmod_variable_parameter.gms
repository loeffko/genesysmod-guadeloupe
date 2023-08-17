* ############# genesysmod_variable_parameter.gms #############    
*
* GENeSYS-MOD v3.1 [Global Energy System Model]  ~ March 2022
*
* Based on OSEMOSYS 2011.07.07 conversion to GAMS by Ken Noble, Noble-Soft Systems - August 2012
*
* Updated to newest OSeMOSYS-Version (2016.08) and further improved with additional equations 2016 - 2022
* by Konstantin L�ffler, Thorsten Burandt, Karlo Hainsch
*
* #############################################################


parameter RateOfTotalActivity(y_full,TIMESLICE_FULL,TECHNOLOGY,REGION_FULL);
RateOfTotalActivity(y,l,t,r) = sum(m, RateOfActivity.l(y,l,t,m,r));

parameter RateOfProductionByTechnologyByMode(y_full,TIMESLICE_FULL,TECHNOLOGY,MODE_OF_OPERATION,FUEL,REGION_FULL);
RateOfProductionByTechnologyByMode(y,l,t,m,f,r) = RateOfActivity.l(y,l,t,m,r)*OutputActivityRatio(r,t,f,m,y);

parameter RateOfUseByTechnologyByMode(y_full,TIMESLICE_FULL,TECHNOLOGY,MODE_OF_OPERATION,FUEL,REGION_FULL);
RateOfUseByTechnologyByMode(y,l,t,m,f,r) = RateOfActivity.l(y,l,t,m,r)*InputActivityRatio(r,t,f,m,y);

* Changed for Guadeloupe
*RateOfUseByTechnologyByMode(y,l,t,m,f,r) = RateOfActivity.l(y,l,t,m,r)*InputActivityRatio(r,t,f,m,y)*TimeDepEfficiency(r,t,l,y);

parameter RateOfProductionByTechnology(y_full,TIMESLICE_FULL,TECHNOLOGY,FUEL,REGION_FULL);
RateOfProductionByTechnology(y,l,t,f,r) = sum(m$(OutputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity.l(y,l,t,m,r)*OutputActivityRatio(r,t,f,m,y));

parameter RateOfUseByTechnology(y_full,TIMESLICE_FULL,TECHNOLOGY,FUEL,REGION_FULL);
RateOfUseByTechnology(y,l,t,f,r) = sum(m$(InputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity.l(y,l,t,m,r)*InputActivityRatio(r,t,f,m,y));

parameter ProductionByTechnology(y_full,TIMESLICE_FULL,TECHNOLOGY,FUEL,REGION_FULL);
ProductionByTechnology(y,l,t,f,r) = sum(m$(OutputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity.l(y,l,t,m,r)*OutputActivityRatio(r,t,f,m,y)) * YearSplit(l,y);

parameter UseByTechnology(y_full,TIMESLICE_FULL,TECHNOLOGY,FUEL,REGION_FULL);
UseByTechnology(y,l,t,f,r) = sum(m$(InputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity.l(y,l,t,m,r)*InputActivityRatio(r,t,f,m,y)) * YearSplit(l,y);

parameter RateOfProduction(y_full,TIMESLICE_FULL,FUEL,REGION_FULL);
RateOfProduction(y,l,f,r) = sum((t,m)$(OutputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity.l(y,l,t,m,r)*OutputActivityRatio(r,t,f,m,y));

parameter RateOfUse(y_full,TIMESLICE_FULL,FUEL,REGION_FULL);
RateOfUse(y,l,f,r) = sum((t,m)$(InputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity.l(y,l,t,m,r)*InputActivityRatio(r,t,f,m,y));

parameter Production(y_full,TIMESLICE_FULL,FUEL,REGION_FULL);
Production(y,l,f,r) = sum((t,m)$(OutputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity.l(y,l,t,m,r)*OutputActivityRatio(r,t,f,m,y))*YearSplit(l,y);

parameter Use(y_full,TIMESLICE_FULL,FUEL,REGION_FULL);
Use(y,l,f,r) = sum((t,m)$(InputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity.l(y,l,t,m,r)*InputActivityRatio(r,t,f,m,y))*YearSplit(l,y);

parameter ProductionAnnual(y_full,FUEL,REGION_FULL);
ProductionAnnual(y,f,r) = sum((l,t,m)$(OutputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity.l(y,l,t,m,r)*OutputActivityRatio(r,t,f,m,y)*YearSplit(l,y));

parameter UseAnnual(y_full,FUEL,REGION_FULL);
UseAnnual(y,f,r) = sum((l,t,m)$(InputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity.l(y,l,t,m,r)*InputActivityRatio(r,t,f,m,y)*YearSplit(l,y));
