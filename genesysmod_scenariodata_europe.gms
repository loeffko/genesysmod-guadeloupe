* ############# genesysmod_scenariodata_europe.gms ##############
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

VariableCost(r,StorageDummies,m,y) = VariableCost(r,StorageDummies,m,y) / 5;
VariableCost(r,'R_Coal_Hardcoal',m,y) = VariableCost(r,'Z_Import_Hardcoal',m,y)*0.975;
VariableCost(r,'R_Gas',m,y) = VariableCost(r,'Z_Import_Gas',m,y)*0.975;
VariableCost(r,'R_Oil',m,y) = VariableCost(r,'Z_Import_Oil',m,y)*0.975;

TotalAnnualMaxCapacity(r,'RES_Hydro_Large',y) = ResidualCapacity(r,'RES_Hydro_Large','2018');

CapacityFactor(r,'RES_PV_Rooftop_Commercial',l,y) = CapacityFactor(r,'RES_PV_Utility_Avg',l,y) ;
CapacityFactor(r,'RES_PV_Rooftop_Residential',l,y) = CapacityFactor(r,'RES_PV_Utility_Avg',l,y) ;
CapacityFactor(r,'RES_CSP',l,y) = CapacityFactor(r,'RES_PV_Utility_Opt',l,y) ;
CapacityFactor(r,'HLR_Solar_Thermal',l,y) = CapacityFactor(r,'RES_PV_Utility_Avg',l,y) ;
CapacityFactor(r,'HLI_Solar_Thermal',l,y) = CapacityFactor(r,'RES_PV_Utility_Avg',l,y) ;

AvailabilityFactor(r,'HLI_Geothermal',y) = 0;
InputActivityRatio(r,CHPs,f,m,y) = InputActivityRatio(r,CHPs,f,m,y)*1.3;

GrowthRateTradeCapacity(y,'Power','TR',rr) = 0.01;
GrowthRateTradeCapacity(y,'Power',r,'TR') = 0.01;

TradeCosts('ETS',r,rr) = EmissionsPenalty(r,'CO2','2020');

TotalTechnologyAnnualActivityUpperLimit(r,'HHI_Scrap_EAF',y)$(YearVal(y)<2030) = 0.5*SpecifiedAnnualDemand(r,'Heat_High_Industrial',y);
TotalTechnologyAnnualActivityUpperLimit(r,'HHI_Scrap_EAF',y)$(YearVal(y)<2040) = 0.6*SpecifiedAnnualDemand(r,'Heat_High_Industrial',y);
TotalTechnologyAnnualActivityUpperLimit(r,'HHI_Scrap_EAF',y) = 0.7*SpecifiedAnnualDemand(r,'Heat_High_Industrial',y);

ReserveMargin(r,y) = 0;

AdditionalTradeCapacity(y,f,r,rr) = 0;

CapitalCost(r,CCS,y) = CapitalCost(r,CCS,y) *1.5;

*
* ####### Dispatch and Curtailment #############
*
TagDispatchableTechnology(TECHNOLOGY) = 1;
TagDispatchableTechnology(Solar) = 0;
TagDispatchableTechnology(Wind) = 0;
AvailabilityFactor(REGION,Solar,y) = 1;
TagDispatchableTechnology(Passenger) = 0;
Curtailment.fx(y,l,TransportFuels,r) = 0;


parameter VariableRES(t);
VariableRES(Solar) = 1;
VariableRES(Wind) = 1;
VariableRES('Res_Hydro_Small') = 1;



*
* ####### Subsets for Europe bounds #############
*
ImportTechnology('Z_Import_LNG') = yes;

AvailabilityFactor(r,'Z_Import_Gas',y) = 0;

AvailabilityFactor('LV','Z_Import_Gas',y) = 1;
AvailabilityFactor('LT','Z_Import_Gas',y) = 1;
AvailabilityFactor('EE','Z_Import_Gas',y) = 1;
AvailabilityFactor('NO','Z_Import_Gas',y) = 1;
AvailabilityFactor('FI','Z_Import_Gas',y) = 1;
AvailabilityFactor('SE','Z_Import_Gas',y) = 1;
AvailabilityFactor('PL','Z_Import_Gas',y) = 1;
AvailabilityFactor('BG','Z_Import_Gas',y) = 1;
AvailabilityFactor('RO','Z_Import_Gas',y) = 1;
AvailabilityFactor('HU','Z_Import_Gas',y) = 1;
AvailabilityFactor('SK','Z_Import_Gas',y) = 1;
AvailabilityFactor('NONEU_Balkan','Z_Import_Gas',y) = 1;
AvailabilityFactor('GR','Z_Import_Gas',y) = 1;
AvailabilityFactor('TR','Z_Import_Gas',y) = 1;

AvailabilityFactor(r,'Z_Import_LNG',y) = 0;
AvailabilityFactor('UK','Z_Import_LNG',y) = 1;
AvailabilityFactor('IE','Z_Import_LNG',y) = 1;
AvailabilityFactor('ES','Z_Import_LNG',y) = 1;
AvailabilityFactor('PT','Z_Import_LNG',y) = 1;
AvailabilityFactor('FR','Z_Import_LNG',y) = 1;
AvailabilityFactor('NL','Z_Import_LNG',y) = 1;
AvailabilityFactor('BE','Z_Import_LNG',y) = 1;
AvailabilityFactor('DE','Z_Import_LNG',y) = 1;
AvailabilityFactor('PL','Z_Import_LNG',y) = 1;
AvailabilityFactor('IT','Z_Import_LNG',y) = 1;
AvailabilityFactor('NONEU_Balkan','Z_Import_LNG',y) = 1;
AvailabilityFactor('TR','Z_Import_LNG',y) = 1;
AvailabilityFactor('GR','Z_Import_LNG',y) = 1;

TradeCapacity(y,'gas_natural',r,rr) = Readin_PowerTradeCapacity('gas_natural',r,rr,y);

set GasFuels(f);
GasFuels(f) = no;
GasFuels('Gas_Natural') = yes;
GasFuels('Gas_Bio') = yes;
GasFuels('Gas_Synth') = yes;
GasFuels('H2') = yes;

TotalAnnualMaxCapacity(r,ImportTechnology,y) = 999999;
CapacityFactor(r,ImportTechnology,l,y) = 1 ;
OperationalLife(r,ImportTechnology) = 1 ;
TotalTechnologyModelPeriodActivityUpperLimit(r,ImportTechnology) = 999999;

AvailabilityFactor(r,'X_Liquifier',y)$(YearVal(y) > %year%) = 1;
AvailabilityFactor(r,'X_Gasifier',y)$(YearVal(y) > %year%) = 1;

TotalAnnualMaxCapacity(r,'X_Liquifier',y)$(YearVal(y) > %year%) = 9999;
TotalAnnualMaxCapacity(r,'X_Gasifier',y)$(YearVal(y) > %year%) = 9999;

*
* ##############* Pipeline Capacities & Investments #############
*
equation TrPl1a_TradeCapacityPipelinesLines(YEAR_FULL,TIMESLICE_FULL,REGION_FULL,rr_full);
TrPl1a_TradeCapacityPipelinesLines(y,l,r,rr).. sum(GasFuels$(TradeRoute(y,GasFuels,r,rr) > 0), Import(y,l,GasFuels,rr,r)) =l= TotalTradeCapacity(y,'Gas_Natural',r,rr);

ProductionGrowthLimit('2020','Heat_Low_Residential') = 0.015;
ProductionGrowthLimit('2025','Heat_Low_Residential') = 0.03;


parameter Renovierungsrate;


*
* ##############* Pathway Quantification #############
*

$ifthen %EmissionPathway% == DirectedTransition

$if not set emissionspenalty       $setglobal emissionspenalty 1000

ModelPeriodEmissionLimit(e) = 999999;
RegionalModelPeriodEmissionLimit(e,r) = 999999;

*AvailabilityFactor(r,'X_DAC_LT',y) = 0;
*AvailabilityFactor(r,'X_DAC_HT',y) = 0;
AvailabilityFactor(r,'FRT_Road_OH',y) = 0;

AvailabilityFactor(r,'Z_Import_H2',y) = 0;

UseByTechnologyAnnual.up(y,t,FossilFuels,r)$(not sum(CCS,diag(t,CCS)) and YearVal(y)>2035) = 0;
UseByTechnologyAnnual.up(y,t,'Nuclear',r) = +INF;

CapacityFactor(r,Offshore,l,y) = CapacityFactor(r,Offshore,l,y)*(1.025+(0.0025)*(ord(y)-2));

AvailabilityFactor(r,'R_Nuclear',y) = 1;
NewCapacity.up(y,'P_Nuclear',r)$(YearVal(y)>2025) = 6;

EmissionsPenalty(r,'CO2','2050') = %emissionspenalty%;
EmissionsPenalty(r,'CO2','2045') = EmissionsPenalty(r,'CO2','2050')*0.85;
EmissionsPenalty(r,'CO2','2040') = EmissionsPenalty(r,'CO2','2045')*0.8;
EmissionsPenalty(r,'CO2','2035') = EmissionsPenalty(r,'CO2','2040')*0.75;
EmissionsPenalty(r,'CO2','2030') = EmissionsPenalty(r,'CO2','2035')*0.7;
EmissionsPenalty(r,'CO2','2025') = EmissionsPenalty(r,'CO2','2030')*0.55;
EmissionsPenalty(r,'CO2','2020') = 30;
EmissionsPenalty(r,'CO2','%year%') = 15.06;

Renovierungsrate(y)=0.03;
Renovierungsrate(y)$(YearVal(y)>2020)=0.05;
Renovierungsrate(y)$(YearVal(y)>2025)=0.06;
Renovierungsrate(y)$(YearVal(y)>2030)=0.07;
Renovierungsrate(y)$(YearVal(y)>2035)=1;

PhaseOut(y)$(YearVal(y)>2035) = 3;
PhaseIn(y)$(YearVal(y)>2035) = 0.75;

ProductionGrowthLimit(y,'Power')=0.06;
ProductionGrowthLimit(y,'Power')$(YearVal(y)>2030)=0.07;

$setglobal bool_penalty 1
$endif

$ifthen %EmissionPathway% == SocietalCommitment

$if not set emissionspenalty       $setglobal emissionspenalty 550

ModelPeriodEmissionLimit(e) = 999999;
RegionalModelPeriodEmissionLimit(e,r) = 999999;

AvailabilityFactor(r,'X_DAC_LT',y) = 0;
AvailabilityFactor(r,'X_DAC_HT',y) = 0;
AvailabilityFactor(r,'FRT_Road_OH',y) = 0;

AvailabilityFactor(r,CCS,y) = 0;
NewCapacity.up(y,'P_Nuclear',r) =  0;

AvailabilityFactor(r,'Z_Import_H2',y) = 0;
AvailabilityFactor(r,'R_Nuclear',y) = 1;

InputActivityRatio(REGION,Passenger,FUEL,MODE_OF_OPERATION,y) = InputActivityRatio('%data_base_region%',Passenger,FUEL,MODE_OF_OPERATION,y);
CapacityFactor(r,'RES_PV_Rooftop_Commercial',l,y) = CapacityFactor(r,'RES_PV_Utility_opt',l,y);
CapacityFactor(r,'RES_PV_Rooftop_Residential',l,y) = CapacityFactor(r,'RES_PV_Utility_opt',l,y);
FixedCost(r,'RES_PV_Rooftop_Residential',y) = FixedCost(r,'RES_PV_Utility_opt',y);
FixedCost(r,'RES_PV_Rooftop_Commercial',y) = FixedCost(r,'RES_PV_Utility_opt',y);
CapitalCost(r,'X_Electrolysis',y)$(YearVal(y) > %year%)=  CapitalCost('AT','X_Electrolysis',y)*(1.025+(0.01)*(ord(y)-1));

parameter readin_sensitivity;
$onecho >%tempdir%temp_demandresponse.tmp
se=0
        par=readin_sensitivity    Rng=Combined!A2   rdim=4  cdim=0
$offecho

$ifi %switch_only_load_gdx%==0 $call "gdxxrw %inputdir%DemandResponse_oE_v01_kl_11_05_2020.xlsx @%tempdir%temp_demandresponse.tmp o=%gdxdir%sensitivity_data_demandresponse.gdx MaxDupeErrors=99 ";
$GDXin %gdxdir%sensitivity_data_demandresponse.gdx
$onUNDF
$loadm readin_sensitivity
$offUNDF
*SpecifiedDemandProfile(r,f,l,y)$(readin_sensitivity('%elmod_nthhour%',r,f,l)) = readin_sensitivity('%elmod_nthhour%',r,f,l);

Renovierungsrate(y)=0.03;
Renovierungsrate(y)$(YearVal(y)>2020)=0.05;
Renovierungsrate(y)$(YearVal(y)>2025)=0.06;
Renovierungsrate(y)$(YearVal(y)>2030)=0.07;
Renovierungsrate(y)$(YearVal(y)>2035)=1;

ProductionGrowthLimit(y,'Power')$(YearVal(y)>2030)=0.065;
ProductionGrowthLimit(y,HeatFuels)$(YearVal(y)>2030)=0.065;

EmissionsPenalty(r,'CO2','2050') = %emissionspenalty%*(1+SocialDiscountRate(r))**10;
EmissionsPenalty(r,'CO2','2045') = %emissionspenalty%*(1+SocialDiscountRate(r))**5;
EmissionsPenalty(r,'CO2','2040') = %emissionspenalty%;
EmissionsPenalty(r,'CO2','2035') = EmissionsPenalty(r,'CO2','2040')*0.75;
EmissionsPenalty(r,'CO2','2030') = EmissionsPenalty(r,'CO2','2035')*0.45;
EmissionsPenalty(r,'CO2','2025') = EmissionsPenalty(r,'CO2','2030')*0.35;
EmissionsPenalty(r,'CO2','2020') = 30;
EmissionsPenalty(r,'CO2','%year%') = 15.06;

$setglobal bool_penalty 1
$endif

$ifthen %EmissionPathway% == TechnoFriendly

$if not set emissionspenalty       $setglobal emissionspenalty 400

ModelPeriodEmissionLimit(e) = 999999;
RegionalModelPeriodEmissionLimit(e,r) = 999999;

ProductionByTechnologyAnnual.up(y,'FRT_Road_OH','Mobility_Freight',r) = 0.65*SpecifiedAnnualDemand(r,'Mobility_Freight',y)*ModalSplitByFuelAndModalType(r,'Mobility_Freight',y,'MT_FRT_ROAD');
CapacityFactor(r,Offshore,l,y) = CapacityFactor(r,Offshore,l,y)*(1.05+(0.02)*(ord(y)-2));
CapitalCost(r,SectorCoupling,y) = CapitalCost('DE',SectorCoupling,y);
CapitalCost(r,HydrogenTechnologies,y) = CapitalCost(r,HydrogenTechnologies,y)*0.85;
FixedCost(r,HydrogenTechnologies,y) = FixedCost(r,HydrogenTechnologies,y)*0.85;

Renovierungsrate(y)=0.03;
Renovierungsrate(y)$(YearVal(y)>2020)=0.045;
Renovierungsrate(y)$(YearVal(y)>2025)=0.055;
Renovierungsrate(y)$(YearVal(y)>2030)=0.065;
Renovierungsrate(y)$(YearVal(y)>2035)=0.2;

VariableCost(r,'Z_Import_H2',m,'2040') = VariableCost(r,'Z_Import_H2',m,'2040')*0.8;
VariableCost(r,'Z_Import_H2',m,'2045') = VariableCost(r,'Z_Import_H2',m,'2045')*0.75;
VariableCost(r,'Z_Import_H2',m,'2050') = VariableCost(r,'Z_Import_H2',m,'2050')*0.7;

ProductionGrowthLimit(y,'Power')=0.06;

EmissionsPenalty(r,'CO2','2050') = %emissionspenalty%*(1+SocialDiscountRate(r))**10;
EmissionsPenalty(r,'CO2','2045') = %emissionspenalty%*(1+SocialDiscountRate(r))**5;
EmissionsPenalty(r,'CO2','2040') = %emissionspenalty%;
EmissionsPenalty(r,'CO2','2035') = EmissionsPenalty(r,'CO2','2040')*0.55;
EmissionsPenalty(r,'CO2','2030') = EmissionsPenalty(r,'CO2','2035')*0.5;
EmissionsPenalty(r,'CO2','2025') = EmissionsPenalty(r,'CO2','2030')*0.45;
EmissionsPenalty(r,'CO2','2020') = 30;
EmissionsPenalty(r,'CO2','%year%') = 15.06;

$setglobal bool_penalty 1
$endif



$ifthen %EmissionPathway% == GradualDevelopment

$if not set emissionspenalty       $setglobal emissionspenalty 355

ModelPeriodEmissionLimit(e) = 999999;
RegionalModelPeriodEmissionLimit(e,r) = 999999;

CapitalCost(r,'X_Electrolysis',y)$(YearVal(y) > %year%)=  CapitalCost('AT','X_Electrolysis',y)*(1.1+(0.06)*(ord(y)-1));

AvailabilityFactor(r,'X_DAC_LT',y) = 0;
AvailabilityFactor(r,'X_DAC_HT',y) = 0;
AvailabilityFactor(r,'FRT_Road_OH',y) = 0;

AvailabilityFactor(r,CCS,y) = 0;

AvailabilityFactor(r,'Z_Import_H2',y) = 0;
AvailabilityFactor(r,'R_Nuclear',y) = 1;

EmissionsPenalty(r,'CO2','2050') = %emissionspenalty%;
EmissionsPenalty(r,'CO2','2045') = EmissionsPenalty(r,'CO2','2050')*0.7;
EmissionsPenalty(r,'CO2','2040') = EmissionsPenalty(r,'CO2','2045')*0.675;
EmissionsPenalty(r,'CO2','2035') = EmissionsPenalty(r,'CO2','2040')*0.675;
EmissionsPenalty(r,'CO2','2030') = EmissionsPenalty(r,'CO2','2035')*0.675;
EmissionsPenalty(r,'CO2','2025') = EmissionsPenalty(r,'CO2','2030')*0.675;
EmissionsPenalty(r,'CO2','2020') = 30;
EmissionsPenalty(r,'CO2','%year%') = 15.06;

ProductionGrowthLimit('2025','Power')=0.04;
PhaseOut(y) = 2;

Renovierungsrate(y)=0.03;
Renovierungsrate(y)$(YearVal(y)>2020)=0.04;
Renovierungsrate(y)$(YearVal(y)>2025)=0.05;
Renovierungsrate(y)$(YearVal(y)>2030)=0.06;
Renovierungsrate(y)$(YearVal(y)>2035)=0.15;

$setglobal bool_penalty 1
$endif







*--------- leave at the bottom ---------

$ifthen set emissionspenalty
$ifthen not set bool_penalty
EmissionsPenalty(r,'CO2','2050') = %emissionspenalty%;
EmissionsPenalty(r,'CO2','2045') = EmissionsPenalty(r,'CO2','2050')*0.65;
EmissionsPenalty(r,'CO2','2040') = EmissionsPenalty(r,'CO2','2045')*0.6;
EmissionsPenalty(r,'CO2','2035') = EmissionsPenalty(r,'CO2','2040')*0.55;
EmissionsPenalty(r,'CO2','2030') = EmissionsPenalty(r,'CO2','2035')*0.5;
EmissionsPenalty(r,'CO2','2025') = EmissionsPenalty(r,'CO2','2030')*0.45;
EmissionsPenalty(r,'CO2','2020') = 30;
EmissionsPenalty(r,'CO2','%year%') = 15.06;
$endif
$endif

*
* ######### Coal and Nuclear Phase-Out #############
*
AvailabilityFactor('AT','P_Nuclear',y) = 0;

*decomissioning of old power plants until 2021, no new constructions
AvailabilityFactor('DE','P_Nuclear',y)$(YearVal(y) > 2020) = 0;

AvailabilityFactor('DE','R_Coal_Hardcoal',y)$(YearVal(y) > 2020) = 0;
AvailabilityFactor('ES','R_Coal_Lignite',y)$(YearVal(y) > 2018) = 0;
AvailabilityFactor('PT','R_Coal_Lignite',y) = 0;
AvailabilityFactor('DE','P_Coal_Hardcoal',y)$(YearVal(y) > 2020) = 0;
AvailabilityFactor('ES','P_Coal_Lignite',y)$(YearVal(y) > 2018) = 0;
AvailabilityFactor('ES','P_Coal_Hardcoal',y)$(YearVal(y) >= 2030) = 0;
AvailabilityFactor('ES','CHP_Coal_Hardcoal',y)$(YearVal(y) >= 2030) = 0;
AvailabilityFactor('PT','P_Coal_Lignite',y) = 0;

AvailabilityFactor('BE','P_Nuclear',y)$(YearVal(y) > 2025) = 0;
AvailabilityFactor('LU','P_Nuclear',y)$(YearVal(y) > 2025) = 0;
AvailabilityFactor('ES','P_Nuclear',y)$(YearVal(y) > 2035) = 0;

*no new constructions after 2020
NewCapacity.fx(y,'P_Nuclear','CH')$(YearVal(y) > 2015) = 0;
NewCapacity.fx(y,'P_Nuclear','IT') = 0;
NewCapacity.fx(y,'P_Nuclear','AT') = 0;
NewCapacity.fx(y,'P_Nuclear','DE') = 0;
NewCapacity.fx(y,'P_Nuclear','LT') = 0;
NewCapacity.fx(y,'P_Nuclear','LU') = 0;
NewCapacity.fx(y,'P_Nuclear','NO') = 0;
NewCapacity.fx(y,'P_Nuclear','NL') = 0;

*no new nuclear before 2025
NewCapacity.fx(y,'P_Nuclear',r)$(YearVal(y)<=2025) = 0;

AvailabilityFactor('AT','P_Coal_Hardcoal',y)$(YearVal(y) >= 2020) = 0;
AvailabilityFactor('AT','CHP_Coal_Hardcoal',y)$(YearVal(y) >= 2020) = 0;
AvailabilityFactor('AT','P_Coal_Hardcoal_CCS',y)$(YearVal(y) >= 2020) = 0;

AvailabilityFactor('LV','P_Coal_Hardcoal',y)$(YearVal(y)>%year%)  = 0;
AvailabilityFactor('LV','CHP_Coal_Hardcoal',y)$(YearVal(y)>%year%)  = 0;
AvailabilityFactor('LV','P_Coal_Hardcoal_CCS',y)$(YearVal(y)>%year%)  = 0;
AvailabilityFactor('LV','P_Coal_Hardcoal',y)$(YearVal(y)>%year%)  = 0;
AvailabilityFactor('LV','CHP_Coal_Hardcoal',y)$(YearVal(y)>%year%)  = 0;
AvailabilityFactor('LV','P_Coal_Hardcoal_CCS',y)$(YearVal(y)>%year%)  = 0;
AvailabilityFactor('EE','P_Coal_Hardcoal',y)$(YearVal(y)>%year%)  = 0;
AvailabilityFactor('EE','CHP_Coal_Hardcoal',y)$(YearVal(y)>%year%) = 0;
AvailabilityFactor('EE','P_Coal_Hardcoal_CCS',y)$(YearVal(y)>%year%)  = 0;

AvailabilityFactor('SK','P_Coal_Hardcoal',y)$(YearVal(y) >= 2025) = 0;
AvailabilityFactor('SK','CHP_Coal_Hardcoal',y)$(YearVal(y) >= 2025) = 0;
AvailabilityFactor('SK','P_Coal_Hardcoal_CCS',y)$(YearVal(y) >= 2025) = 0;

AvailabilityFactor('BE','P_Coal_Hardcoal',y)$(YearVal(y) >= 2020) = 0;
AvailabilityFactor('BE','CHP_Coal_Hardcoal',y)$(YearVal(y) >= 2020) = 0;
AvailabilityFactor('BE','P_Coal_Hardcoal_CCS',y)$(YearVal(y) >= 2020) = 0;

AvailabilityFactor('FR','P_Coal_Hardcoal',y)$(YearVal(y) >= 2025) = 0;
AvailabilityFactor('FR','CHP_Coal_Hardcoal',y)$(YearVal(y) >= 2025) = 0;
AvailabilityFactor('FR','P_Coal_Hardcoal_CCS',y)$(YearVal(y) >= 2025) = 0;

AvailabilityFactor('LU','P_Coal_Hardcoal',y)$(YearVal(y) >= 2020) = 0;
AvailabilityFactor('LU','CHP_Coal_Hardcoal',y)$(YearVal(y) >= 2020) = 0;
AvailabilityFactor('LU','P_Coal_Hardcoal_CCS',y)$(YearVal(y) >= 2020) = 0;

AvailabilityFactor('UK','P_Coal_Hardcoal',y)$(YearVal(y) >= 2030) = 0;
AvailabilityFactor('UK','CHP_Coal_Hardcoal',y)$(YearVal(y) >= 2030) = 0;
AvailabilityFactor('UK','P_Coal_Hardcoal_CCS',y)$(YearVal(y) >= 2030) = 0;

AvailabilityFactor('IT','P_Coal_Hardcoal',y)$(YearVal(y) >= 2030) = 0;
AvailabilityFactor('IT','CHP_Coal_Hardcoal',y)$(YearVal(y) >= 2030) = 0;
AvailabilityFactor('IT','P_Coal_Hardcoal_CCS',y)$(YearVal(y) >= 2030) = 0;

AvailabilityFactor('IE','P_Coal_Hardcoal',y)$(YearVal(y) >= 2030) = 0;
AvailabilityFactor('IE','CHP_Coal_Hardcoal',y)$(YearVal(y) >= 2030) = 0;
AvailabilityFactor('IE','P_Coal_Hardcoal_CCS',y)$(YearVal(y) >= 2030) = 0;

AvailabilityFactor('NL','P_Coal_Hardcoal',y)$(YearVal(y) >= 2035) = 0;
AvailabilityFactor('NL','CHP_Coal_Hardcoal',y)$(YearVal(y) >= 2035) = 0;
AvailabilityFactor('NL','P_Coal_Hardcoal_CCS',y)$(YearVal(y) >= 2035) = 0;

AvailabilityFactor('FI','P_Coal_Hardcoal',y)$(YearVal(y) >= 2035) = 0;
AvailabilityFactor('FI','CHP_Coal_Hardcoal',y)$(YearVal(y) >= 2035) = 0;
AvailabilityFactor('FI','P_Coal_Hardcoal_CCS',y)$(YearVal(y) >= 2035) = 0;

AvailabilityFactor('NO','P_Coal_Hardcoal',y)$(YearVal(y) >= 2035) = 0;
AvailabilityFactor('NO','CHP_Coal_Hardcoal',y)$(YearVal(y) >= 2035) = 0;
AvailabilityFactor('NO','P_Coal_Hardcoal_CCS',y)$(YearVal(y) >= 2035) = 0;

AvailabilityFactor('SE','P_Coal_Hardcoal',y)$(YearVal(y) >= 2035) = 0;
AvailabilityFactor('SE','CHP_Coal_Hardcoal',y)$(YearVal(y) >= 2035) = 0;
AvailabilityFactor('SE','P_Coal_Hardcoal_CCS',y)$(YearVal(y) >= 2035) = 0;

AvailabilityFactor('CH','P_Coal_Hardcoal',y) = 0;
AvailabilityFactor('CH','CHP_Coal_Hardcoal',y) = 0;
AvailabilityFactor('CH','P_Coal_Hardcoal_CCS',y) = 0;

AvailabilityFactor('HU','P_Coal_Hardcoal',y)$(YearVal(y) >= 2035) = 0;
AvailabilityFactor('HU','CHP_Coal_Hardcoal',y)$(YearVal(y) >= 2035) = 0;
AvailabilityFactor('HU','P_Coal_Hardcoal_CCS',y)$(YearVal(y) >= 2035) = 0;

AvailabilityFactor('GR','P_Coal_Hardcoal',y)$(YearVal(y) >= 2030) = 0;
AvailabilityFactor('GR','CHP_Coal_Hardcoal',y)$(YearVal(y) >= 2030) = 0;
AvailabilityFactor('GR','P_Coal_Hardcoal_CCS',y)$(YearVal(y) >= 2030) = 0;

TotalCapacityAnnual.up(y,'RES_Wind_Onshore_Opt','NO')$(YearVal(y)<2030) = 4.6;
TotalCapacityAnnual.up(y,'RES_Wind_Onshore_Avg','NO')$(YearVal(y)<2030) = 0;
TotalCapacityAnnual.up(y,'RES_Wind_Onshore_Inf','NO')$(YearVal(y)<2030) = 0;

TotalTradeCapacity.lo('2030','Power','ES','FR') = 5;
TotalTradeCapacity.lo('2030','Power','FR','ES') = 5;


NewCapacity.up('%year%',Heat,r) = +INF;
*RegionalBaseYearProduction('NONEU_Balkan',t,'Heat_Low_Residential',y) = 0;
*RegionalBaseYearProduction('TR',t,'Heat_Low_Industrial',y) = 0;
NewCapacity.up(y,'HLR_Gas_Boiler','NO') = 0;

*RegionalBaseYearProduction(r,'HHI_Bio_BF_BOF','Heat_High_Industrial',y) = 0;


CurtailmentCostFactor(r,f,y) = 0.1;


equation Add_NuclearCapacityLimits(YEAR_FULL);
Add_NuclearCapacityLimits(y).. sum(r,NewCapacity(y,'P_Nuclear',r)) =l= sum(r,ResidualCapacity(r,'P_Nuclear','%year%'))*0.25;

equation Add_BuildingsInertia(REGION_FULL,TECHNOLOGY,YEAR_FULL);
Add_BuildingsInertia(r,t,y)$(TagTechnologyToSector(t,'Buildings') and YearVal(y)>%year%).. ProductionByTechnologyAnnual(y,t,'Heat_Low_Residential',r) =g= (1-Renovierungsrate(y)*(YearVal(y)-%year%))*ProductionByTechnologyAnnual(y-1,t,'Heat_Low_Residential',r);

ProductionGrowthLimit(y,'Air')$(YearVal(y)<2030) = 0.005;
NewCapacity.up('2025',CCS,r) = 0.5;

set LiquidFuels(f);
LiquidFuels(f) = no;
LiquidFuels('Oil') = yes;
LiquidFuels('LH2') = yes;
LiquidFuels('LNG') = yes;
LiquidFuels('LSG') = yes;
LiquidFuels('LBG') = yes;
LiquidFuels('Powerfuel') = yes;
LiquidFuels('Biofuel') = yes;

set SolidFuels(f);
SolidFuels(f) = no;
SolidFuels('Hardcoal') = yes;
SolidFuels('Biomass') = yes;

TradeLossBetweenRegions(y,GasFuels,r,rr) = 0.0267;
TradeLossBetweenRegions(y,'H2',r,rr) = 0.0194;
TradeLossBetweenRegions(y,LiquidFuels,r,rr) = 0.0078;
TradeLossBetweenRegions(y,SolidFuels,r,rr) = 0;

***
$ifthen %emissionScenario% == Osterpaket
equations Add_OnshoreWind, Add_OffshoreWind, Add_SolarPV;
Add_OnshoreWind.. sum(Onshore,TotalCapacityAnnual('2030',Onshore,'DE')) =e= 115;
Add_OffshoreWind.. sum(Offshore,TotalCapacityAnnual('2030',Offshore,'DE')) =e= 30;
Add_SolarPV.. sum(Solar,TotalCapacityAnnual('2030',Solar,'DE')) =e= 215;
ProductionByTechnologyAnnual.fx('2030',t,'Power','DE')$(sum(m,InputActivityRatio('DE',t,'Hardcoal',m,'2030'))) = 0;
ProductionByTechnologyAnnual.fx('2030',t,'Power','DE')$(sum(m,InputActivityRatio('DE',t,'Lignite',m,'2030'))) = 0;
$endif




*** MOVE TO EXCEL
TradeRoute(y,f,'ES','FR')$(TradeRoute(y,f,'ES','FR')$(not sameas(f,'ETS'))) = 854;
TradeRoute(y,f,'FR','ES')$(TradeRoute(y,f,'FR','ES')$(not sameas(f,'ETS'))) = 854;
TradeCapacityGrowthCosts(f,r,rr) = 2.1425;
VariableCost(r,'R_Nuclear',m,y) = 1.2723;
InputActivityRatio(r,'P_Nuclear',f,m,y) = InputActivityRatio(r,'P_Nuclear',f,m,'2018');
FixedCost(r,'P_Nuclear',y) = FixedCost(r,'P_Nuclear','2018');
