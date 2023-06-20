* ############# genesysmod_scenariodata_china.gms ##############
*
* GENeSYS-MOD v3.0 [Global Energy System Model]  ~ December 2020
*
* Based on OSEMOSYS 2011.07.07 conversion to GAMS by Ken Noble, Noble-Soft Systems - August 2012
*
* Updated to newest OSeMOSYS-Version (2016.08) and further improved with additional equations 2016 - 2020
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
* ####### Subsets for China bounds and calibration #############
*
set HeatHighIndustrial(t);
HeatHighIndustrial(t) = no;
HeatHighIndustrial('HHI_BF_BOF') = yes;
HeatHighIndustrial('HHI_DRI_EAF') = yes;
HeatHighIndustrial('HHI_Scrap_EAF') = yes;
HeatHighIndustrial('HHI_H2DRI_EAF') = yes;
HeatHighIndustrial('HHI_Molten_Electrolysis') = yes;
HeatHighIndustrial('HHI_Bio_BF_BOF') = yes;
HeatHighIndustrial('HHI_BF_BOF_CCS') = yes;
HeatHighIndustrial('HHI_DRI_EAF_CCS') = yes;

set HardCoal(t);
HardCoal(t) = no;
HardCoal('P_Coal_Hardcoal') = yes;
HardCoal('HLR_Hardcoal') = yes;
HardCoal('HLR_Hardcoal_CHP') = yes;
HardCoal('HLI_Hardcoal') = yes;
HardCoal('HLI_Hardcoal_CHP') = yes;
HardCoal('HMI_HardCoal') = yes;
HardCoal('HHI_BF_BOF') = yes;
HardCoal('HHI_BF_BOF_CCS') = yes;
HardCoal('HLI_Hardcoal_CHP_CCS') = yes;
HardCoal('HLR_Hardcoal_CHP_CCS') = yes;
HardCoal('HMI_HardCoal_CCS') = yes;
HardCoal('P_Coal_Hardcoal_CCS') = yes;

*
* ####### Calibrating to "real-time" values #############
*
InputActivityRatio(r,HeatHighIndustrial,f,m,y) = InputActivityRatio(r,HeatHighIndustrial,f,m,y)*0.75;
InputActivityRatio(r,'P_Coal_Hardcoal',f,m,y) = InputActivityRatio(r,'P_Coal_Hardcoal',f,m,y)*1.25;


*
* ####### Additional bounds and limits #############
*
CurtailmentCostFactor(r,f,y) = 0;
* only CO2 cap
EmissionsPenalty(r,e,y) = 0;

$ifthen %switch_ccs% == 1
equation eq_CCS_Limit;
eq_CCS_Limit.. sum((y,CCS,r),TotalTechnologyAnnualActivity(y,CCS,r)) =l= sum(r,CCSLimit(r))*0.435;
$endif

equation B4a_BaseYearPowerLimit;
B4a_BaseYearPowerLimit.. sum((t,r),Productionbytechnologyannual('2015',t,'Power',r)) =e= 5802.13 * 3.6;

equation B4b_BaseYearHydroPowerProduction;
B4b_BaseYearHydroPowerProduction.. sum((r,Hydro),ProductionByTechnologyAnnual('2015',Hydro,'Power',r)) =e= 1130.27*3.6;

equation B4c_NuclearLimit(YEAR_FULL,t);
B4c_NuclearLimit(y,'P_Nuclear').. sum(r,TotalCapacityAnnual(y,'P_Nuclear',r)) =l= sum(r,ResidualCapacity(r,'P_Nuclear','2020'))*2;

Productionbytechnologyannual.up(y,'HLR_Geothermal','Heat_Low_Residential',r) = SpecifiedAnnualDemand(r,'Heat_Low_Residential',y) *0.3;
AccumulatedNewCapacity.fx(y,'P_Oil',r)$(YearVal(y) > 2020) = 0;

equation B4d_GeothermalLimit(YEAR_FULL);
B4d_GeothermalLimit(y).. sum((r,f,Geothermal),Productionbytechnologyannual(y,Geothermal,f,r)) =l= 15360;
*https://iopscience.iop.org/article/10.1088/1755-1315/81/1/012051/pdf

*
* ####### Calibrating #############
*

$ifthen %switch_aggregate_region% == 0
equation fiveYearPlanCoalTarget;
fiveYearPlanCoalTarget.. sum(r,TotalCapacityAnnual('2020','P_Coal_Hardcoal',r)) =g= 1100;

*equation fiveYearPlanHydropowerTarget;
*fiveYearPlanHydropowerTarget.. sum(r,TotalCapacityAnnual('2020','RES_Hydro_Large',r) + TotalCapacityAnnual('2020','RES_Hydro_Small',r)) =e= 350;
$endif

TotalAnnualMaxCapacity(r,'RES_Hydro_Large',y) = ResidualCapacity(r,'RES_Hydro_Large',y)*1.4;
TotalAnnualMaxCapacity(r,'RES_Hydro_Small',y) = ResidualCapacity(r,'RES_Hydro_Small',y)*1.4;

TradeCosts(f,r,rr) = 0;

*
* ####### FYP Targets #############
*


ResidualCapacity(r,PowerSupply,y) = ResidualCapacity(r,PowerSupply,y)*1.05;
ResidualCapacity(r,Heat,y) = ResidualCapacity(r,Heat,y)*1.05;
ResidualCapacity(r,HeatLowInd,y) = ResidualCapacity(r,HeatLowInd,y)*1.50;
TotalAnnualMaxCapacity(r,t,y)$(ResidualCapacity(r,t,y) > TotalAnnualMaxCapacity(r,t,y)) = ResidualCapacity(r,t,y);

TrajectoryLowerLimit('2025') = 0.7;
TrajectoryUpperLimit('2025') = 1.45;

TrajectoryLowerLimit('2030') = 0.7;
TrajectoryUpperLimit('2030') = 1.45;

$ifthen %switch_ramping% == 1
RampingUpFactor(r,HeatHighInd,y) = 0;
RampingDownFactor(r,HeatHighInd,y) = 0;
ProductionChangeCost(r,HeatHighInd,y) = 0;
$endif

*
* ####### Scenario Parameters #############
*

equation eq_2025CoalTarget;
eq_2025CoalTarget.. sum((r,Hardcoal),ProductionByTechnologyAnnual('2025',Hardcoal,'Power',r)) =g= 9000;

* ### 2 degree ###
$ifthen %emissionPathway% == 2degree
equation fiveYearPlanCoalProdTarget;
fiveYearPlanCoalProdTarget.. sum(r,ProductionByTechnologyAnnual('2020','P_Coal_Hardcoal','Power',r)) =g= 1100/sum(r,ResidualCapacity(r,'P_Coal_Hardcoal','2015'))*sum(r,ProductionByTechnologyAnnual('2015','P_Coal_Hardcoal','Power',r))*0.9;

ModelPeriodEmissionLimit(EMISSION) = 293184.1638;
PowerStability = 0.27;
$endif

* ### 1.5 degree ###
$ifthen %emissionPathway% == 1p5degree
equation fiveYearPlanCoalProdTarget;
fiveYearPlanCoalProdTarget.. sum(r,ProductionByTechnologyAnnual('2020','P_Coal_Hardcoal','Power',r)) =g= 1100/sum(r,ResidualCapacity(r,'P_Coal_Hardcoal','2015'))*sum(r,ProductionByTechnologyAnnual('2015','P_Coal_Hardcoal','Power',r))*0.8;

ModelPeriodEmissionLimit(EMISSION) = 115081.6344*1.05;
PowerStability = 0.33;
$endif

* ### noBudget ###
$ifthen %emissionPathway% == noBudget


ModelPeriodEmissionLimit(EMISSION) = 9999999;

equation fiveYearPlanCoalProdTarget;
fiveYearPlanCoalProdTarget.. sum(r,ProductionByTechnologyAnnual('2020','P_Coal_Hardcoal','Power',r)) =g= 1100/sum(r,ResidualCapacity(r,'P_Coal_Hardcoal','2015'))*sum(r,ProductionByTechnologyAnnual('2015','P_Coal_Hardcoal','Power',r))*0.9;

ModalSplitByFuelAndModalType(r,'Mobility_Passenger','2050','MT_PSNG_ROAD_CONV') = ModalSplitByFuelAndModalType(r,'Mobility_Passenger','2035','MT_PSNG_ROAD_CONV');

PhaseInSet('P_Coal_Hardcoal') = yes;
AvailabilityFactor(r,'FRT_Road_OH',y) = 0;
AvailabilityFactor(r,'PSNG_Air_Bio',y) = 0;
AvailabilityFactor(r,'PSNG_Air_H2',y) = 0;

PowerStability = 0.2;
$endif


* ### 100% RES ###
$ifthen %emissionPathway% == 100percent

ModelPeriodEmissionLimit(EMISSION) = 9999999;

equation fiveYearPlanCoalProdTarget;
fiveYearPlanCoalProdTarget.. sum((r,HardCoal),ProductionByTechnologyAnnual('2020',HardCoal,'Power',r)) =g= 1100/sum(r,ResidualCapacity(r,'P_Coal_Hardcoal','2015'))*sum(r,ProductionByTechnologyAnnual('2015','P_Coal_Hardcoal','Power',r))*0.9;

AvailabilityFactor(r,FF,'2050') = 0;
AvailabilityFactor(r,'R_Nuclear','2050') = 1;

PowerStability = 0.30;
$endif

* ### Reserve-Margin Calculations ###
ReserveMargin(r,'2015') = (ResidualCapacity(r,'D_PHS','2015') +
                          ResidualCapacity(r,'D_CAES','2015') +
                          ResidualCapacity(r,'P_Gas','2015') +
                          ResidualCapacity(r,'P_Oil','2015') +
                          ResidualCapacity(r,'RES_Hydro_Large','2015')
)/sum(t,ResidualCapacity(r,t,'2015'))*0.5;
ReserveMargin(r,'2020') = ReserveMargin(r,'2015') + 0.005;
ReserveMargin(r,'2025') = ReserveMargin(r,'2020') + 0.005;
ReserveMargin(r,'2030') = ReserveMargin(r,'2025') + 0.005;
ReserveMargin(r,'2035') = ReserveMargin(r,'2030') + 0.005;
ReserveMargin(r,'2040') = ReserveMargin(r,'2035') + 0.005;
ReserveMargin(r,'2045') = ReserveMargin(r,'2040') + 0.005;
ReserveMargin(r,'2050') = ReserveMargin(r,'2045') + 0.005;

