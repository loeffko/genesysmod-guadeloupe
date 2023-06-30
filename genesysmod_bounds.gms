* ###################### genesysmod_bounds.gms #######################
*
* GENeSYS-MOD v3.1 [Global Energy System Model]  ~ March 2022
*
* Based on OSEMOSYS 2011.07.07 conversion to GAMS by Ken Noble, Noble-Soft Systems - August 2012
*
* Updated to newest OSeMOSYS-Version (2016.08) and further improved with additional equations 2016 - 2022
* by Konstantin Löffler, Thorsten Burandt, Karlo Hainsch
*
* #############################################################
*
* Copyright 2020 Technische Universität Berlin and DIW Berlin
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*
* #############################################################



*
* ####### Default Values #############
*

RETagTechnology(r,RES,y) = 1;
RETagFuel(r,'Power',y) = 1;
RETagFuel(r,'Heat_Low_Residential',y) = 1;
RETagFuel(r,'Heat_Low_Industrial',y) = 1;
RETagFuel(r,'Heat_Medium_Industrial',y) = 1;
RETagFuel(r,'Heat_High_Industrial',y) = 1;

TotalAnnualMaxCapacityInvestment(REGION,TECHNOLOGY,y) = 999999;
TotalAnnualMinCapacityInvestment(REGION,TECHNOLOGY,y) = 0 ;
TotalTechnologyModelPeriodActivityUpperLimit(REGION,TECHNOLOGY) = 999999;
TotalTechnologyModelPeriodActivityLowerLimit(REGION,TECHNOLOGY) = 0;
TotalTechnologyAnnualActivityUpperLimit(REGION,TECHNOLOGY,y)$(TotalTechnologyAnnualActivityUpperLimit(REGION,TECHNOLOGY,y) = 0) = 999999;

TimeDepEfficiency(r,t,l,y) = 1;

TradeCosts('ETS',r,rr)$(not TradeCosts('ETS',r,rr)) = 0.01;
VariableCost(r,t,m,y)$(not VariableCost(r,t,m,y)) = 0.01;

*** Important multiplication due to 5-year-steps
EmissionActivityRatio(r,t,e,m,y) =  EmissionActivityRatio(r,t,e,m,y);
VariableCost(r,t,m,y) = VariableCost(r,t,m,y);
FixedCost(r,t,y) = FixedCost(r,t,y);

*** Same thing, only for resource limits
TotalTechnologyModelPeriodActivityUpperLimit(REGION,FossilFuelGeneration)$(not sameas('R_Nuclear',FossilFuelGeneration)) = Readin_TotalTechnologyModelPeriodActivityUpperLimit(REGION,FossilFuelGeneration);
*TotalTechnologyModelPeriodActivityUpperLimit(REGION,'A_CCS_Capacity') = Readin_TotalTechnologyModelPeriodActivityUpperLimit(REGION,'A_CCS_Capacity');

*** Error handling, in case residual capacity > maximum capacity
TotalAnnualMaxCapacity(r,t,y)$(ResidualCapacity(r,t,y) > TotalAnnualMaxCapacity(r,t,y)) = ResidualCapacity(r,t,y);

*
* ####### Dummy-Technologies [enable for test purposes, if model runs infeasible] #############
*
DummyTechnology('Infeasibility_HLI') = yes;
DummyTechnology('Infeasibility_HMI') = yes;
DummyTechnology('Infeasibility_HHI') = yes;
DummyTechnology('Infeasibility_HRI') = yes;
DummyTechnology('Infeasibility_Power') = yes;
DummyTechnology('Infeasibility_Mob_Passenger') = yes;
DummyTechnology('Infeasibility_Mob_Freight') = yes;
TagTechnologyToSector(DummyTechnology,'Infeasibility') = 1;

AvailabilityFactor(r,DummyTechnology,y) = 0;

$ifthen %switch_infeasibility_tech% == 1
OutputActivityRatio(REGION,'Infeasibility_HLI','Heat_Low_Industrial','1',y) = 1;
OutputActivityRatio(REGION,'Infeasibility_HMI','Heat_Medium_Industrial','1',y) = 1;
OutputActivityRatio(REGION,'Infeasibility_HHI','Heat_High_Industrial','1',y) = 1;
OutputActivityRatio(REGION,'Infeasibility_HRI','Heat_Low_Residential','1',y) = 1;
OutputActivityRatio(REGION,'Infeasibility_Power','Power','1',y) = 1;
OutputActivityRatio(REGION,'Infeasibility_Mob_Passenger','Mobility_Passenger','1',y) = 1 ;
OutputActivityRatio(REGION,'Infeasibility_Mob_Freight','Mobility_Freight','1',y) = 1 ;


CapacityToActivityUnit(r,DummyTechnology) = 31.56;

TotalAnnualMaxCapacity(r,DummyTechnology,y) = 999999;

FixedCost(r,DummyTechnology,y) = 999;
CapitalCost(r,DummyTechnology,y) = 999;
VariableCost(r,DummyTechnology,m,y) = 999;
AvailabilityFactor(r,DummyTechnology,y) = 1;
CapacityFactor(r,DummyTechnology,l,y) = 1 ;
OperationalLife(r,DummyTechnology) = 1 ;
EmissionActivityRatio(r,DummyTechnology,e,m,y) = 0;
$endif

*
* ####### Bounds for non-supply technologies #############
*
TotalAnnualMaxCapacity(r,Transformation,y) = 999999;
TotalAnnualMaxCapacity(r,FossilPower,y) = 999999;
TotalAnnualMaxCapacity(r,FossilFuelGeneration,y) = 999999;
TotalAnnualMaxCapacity(r,CHPs,y) = 999999;
TotalAnnualMaxCapacity(r,Transport,y) = 999999;
TotalAnnualMaxCapacity(r,ImportTechnology,y) = 999999;
TotalAnnualMaxCapacity(r,Biomass,y) = 999999;
TotalAnnualMaxCapacity(r,'P_Biomass',y) = 999999;

AvailabilityFactor(r,ImportTechnology,y) = 1;
CapacityFactor(r,ImportTechnology,l,y) = 1 ;
OperationalLife(r,ImportTechnology) = 1 ;
TotalTechnologyModelPeriodActivityUpperLimit(r,ImportTechnology) = 999999;

*
* ####### Bounds for storage technologies #############
*

*StorageLevelYearFinish.fx(s,y,r) = 0;
StorageLevelDayTypeFinish.fx('S_Battery_Li-Ion',y,ls,ld,r) = 0;
StorageLevelDayTypeFinish.fx('S_Battery_Redox',y,ls,ld,r) = 0;

*
* ####### Capacity factor for heat technologies #############
*
CapacityFactor(r,Heat,l,y)$(sum(ll,CapacityFactor(r,Heat,ll,y)) = 0) = 1;

CapacityFactor(r,'HLI_Solar_Thermal',l,y) = CapacityFactor(r,'Res_PV_Rooftop_Commercial',l,y);
CapacityFactor(r,'HLR_Solar_Thermal',l,y) = CapacityFactor(r,'Res_PV_Rooftop_Commercial',l,y);
CapacityFactor(r,'Res_PV_Rooftop_Residential',l,y) = CapacityFactor(r,'Res_PV_Rooftop_Commercial',l,y);

*
* ####### No new capacity construction in 2015 #############
*

NewCapacity.fx('%year%',Transformation,r) = 0;
NewCapacity.fx('%year%',PowerSupply,r) = 0;
NewCapacity.fx('%year%',SectorCoupling,r) = 0;
NewCapacity.fx('%year%',Transformation,r) = 0;
NewCapacity.fx('%year%',StorageDummies,r) = 0;

NewCapacity.up('%year%',Biomass,r) = +INF;
NewCapacity.up('%year%','HLR_Gas_Boiler',r) = +INF;
NewCapacity.up('%year%','HLI_Gas_Boiler',r) = +INF;
NewCapacity.up('%year%','HHI_BF_BOF',r) = +INF;
NewCapacity.up('%year%','HHI_Bio_BF_BOF',r) = +INF;
NewCapacity.up('%year%','HHI_Scrap_EAF',r) = +INF;
NewCapacity.up('%year%','HHI_DRI_EAF',r) = +INF;
NewCapacity.up('%year%',t,r)$(TagTechnologyToSector(t,'CHP')) = +INF;


*** ReserveMargin initialization
ReserveMargin(r,y)$(not ReserveMargin(r,y)) = 0;



*** Term for error handling
parameter ToSmallResidualCapacity;
ToSmallResidualCapacity(r,t,y)$(ResidualCapacity(r,t,y) > TotalAnnualMaxCapacity(r,t,y)) = ResidualCapacity(r,t,y);
TotalAnnualMaxCapacity(r,t,y)$(ResidualCapacity(r,t,y) > TotalAnnualMaxCapacity(r,t,y)) = ResidualCapacity(r,t,y);

*** Relevant for Europe due to unimplemented data
AdditionalTradeCapacity(y,f,r,rr) = 0;

*** Adds (negligible) variable costs to transport technologies, since they only had fuel costs before
*** This is to combat strange "curtailment" effects of some transportation technologies
VariableCost(r,Transport,m,y) = 0.09;

ModelPeriodExogenousEmission(REGION,EMISSION) = 0;
REMinProductionTarget(r,f,y) = 0;

*
* ####### Dispatch and Curtailment #############
*
TagDispatchableTechnology(TECHNOLOGY) = 1;
TagDispatchableTechnology(Solar) = 0;
TagDispatchableTechnology(Wind) = 0;
AvailabilityFactor(REGION,Solar,y) = 1;
TagDispatchableTechnology(Transport) = 0;
TagDispatchableTechnology('RES_Hydro_Small') = 0;
Curtailment.fx(y,l,TransportFuels,r) = 0;
Curtailment.up(y,l,'Heat_High_Industrial',r) = 1;
Curtailment.up(y,l,'Heat_Medium_Industrial',r) = 1;
Curtailment.up(y,l,'Heat_Low_Industrial',r) = 1;
Curtailment.up(y,l,'Heat_Low_Residential',r) = 0.5;
Curtailment.up(y,l,'Heat_District',r) = 1;

AnnualSectoralEmissionLimit(e,se,y)$(not AnnualSectoralEmissionLimit(e,se,y)) = 999999;

*
* ####### CCS #############
*

$ifthen %switch_ccs% == 1
AvailabilityFactor(r,CCS,y) = 0;
AvailabilityFactor(r,CCS,y)$(YearVal(y) > 2020 and RegionalCCSLimit(r)) = 0.95;

TotalAnnualMaxCapacity(r,CCS,y) = 99999;
TotalAnnualMaxCapacity(r,CCS,y)$(AvailabilityFactor(r,CCS,y) = 0) = 0;

TotalTechnologyAnnualActivityUpperLimit(r,CCS,y) = 99999;
TotalTechnologyAnnualActivityUpperLimit(r,CCS,y)$(AvailabilityFactor(r,CCS,y) = 0) = 0;

Productionbytechnologyannual.up(y,CCS,f,r) = +INF;
Productionbytechnologyannual.fx(y,CCS,f,r)$(AvailabilityFactor(r,CCS,y) = 0) = 0;

TotalAnnualMaxCapacity(r,'A_Air',y) = 99999;
TotalTechnologyAnnualActivityUpperLimit(r,'A_Air',y) = 99999;

EmissionActivityRatio(r,'X_DAC_HT',e,m,y) = -1;
EmissionActivityRatio(r,'X_DAC_LT',e,m,y) = -1;

$else

AvailabilityFactor(r,CCS,y) = 0;
TotalAnnualMaxCapacity(r,CCS,y) = 0;

Productionbytechnologyannual.fx(y,CCS,f,r) = 0;
$endif


*
* ####### Ramping #############
*

$ifthen %switch_ramping% == 1

RampingUpFactor(r,'RES_Hydro_Large',y) = 0.25;
RampingUpFactor(r,PowerBiomass,y) = 0.04;
RampingUpFactor(r,FossilPower,y) = 0.04;
RampingUpFactor(r,Coal,y) = 0.02;
RampingUpFactor(r,Gas,y) = 0.2;
RampingUpFactor(r,'P_Nuclear',y) = 0.01;
RampingUpFactor(r,HeatSlowRamper,y) = 0.1;
RampingUpFactor(r,HeatQuickRamper,y) = 0;

RampingDownFactor(r,'RES_Hydro_Large',y) = 0.25;
RampingDownFactor(r,PowerBiomass,y) = 0.04;
RampingDownFactor(r,FossilPower,y) = 0.04;
RampingDownFactor(r,Coal,y) = 0.02;
RampingDownFactor(r,Gas,y) = 0.2;
RampingDownFactor(r,'P_Nuclear',y) = 0.01;
RampingDownFactor(r,HeatSlowRamper,y) = 0.1;
RampingDownFactor(r,HeatQuickRamper,y) = 0;

ProductionChangeCost(r,'RES_Hydro_Large',y) = 50/3.6;
ProductionChangeCost(r,PowerBiomass,y) = 100/3.6;
ProductionChangeCost(r,FossilPower,y) = 100/3.6;
ProductionChangeCost(r,Coal,y) = 50/3.6;
ProductionChangeCost(r,Gas,y) = 20/3.6;
ProductionChangeCost(r,'P_Nuclear',y) = 200/3.6;
ProductionChangeCost(r,HeatSlowRamper,y) = 100/3.6;
ProductionChangeCost(r,HeatQuickRamper,y) = 0;

MinActiveProductionPerTimeslice(y,l,'Power','RES_Hydro_Large',r) = 0.1;
MinActiveProductionPerTimeslice(y,l,'Power','RES_Hydro_Small',r) = 0.05;

$endif

*marginal costs for better numerical stability
CapitalCostStorage(r,s,y) = 0.01;
CapitalCost(r,t,y)$(CapitalCost(r,t,y) = 0) = 0.01;

CurtailmentCostFactor(r,f,y) = 0;

TrajectoryLowerLimit('2020') = 0.5;
TrajectoryUpperLimit('2020') = 2;

SelfSufficiency(y, f, r) = 0;

parameter YearlyDifferenceMultiplier(YEAR_FULL);
YearlyDifferenceMultiplier(y) = max(1,YearVal(y+1)-YearVal(y));

scalar hour_steps;
hour_steps = mod(%elmod_nthhour%,24);
if (hour_steps=0,execute "echo Timeseries issue - you are moving 0 hours between each time step. Please choose a different elmod_nthhour.";abort "ERROR: You have chosen a time resolution with an hourly stepsize of 0. This would cause issues in your time series!";);
scalar start_hour /%elmod_starthour%/;

StorageLevelTSStart.fx('S_Battery_Li-Ion',y,l,r)$(mod((ord(l)+(start_hour/hour_steps) and hour_steps),(24/hour_steps)) = 0) = 0;
StorageLevelTSStart.fx('S_Battery_Redox',y,l,r)$(mod((ord(l)+(start_hour/hour_steps) and hour_steps),(24/hour_steps)) = 0) = 0;
StorageLevelTSStart.fx('S_Heat_HLR',y,l,r)$(mod((ord(l)+(start_hour/hour_steps) and hour_steps),(24/hour_steps)) = 0) = 0;
StorageLevelTSStart.fx('S_Heat_HLI',y,l,r)$(mod((ord(l)+(start_hour/hour_steps and hour_steps)),(24/hour_steps)) = 0) = 0;
