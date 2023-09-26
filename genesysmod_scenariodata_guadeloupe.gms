* ############# genesysmod_scenariodata_middleearth.gms ##############
*
* GENeSYS-MOD v3.1 [Global Energy System Model]  ~ March 2022
*
* Based on OSEMOSYS 2011.07.07 conversion to GAMS by Ken Noble, Noble-Soft Systems - August 2012
*
* Updated to newest OSeMOSYS-Version (2016.08) and further improved with additional equations 2016 - 2022
* by Konstantin L�ffler, Thorsten Burandt, Karlo Hainsch
*
* #############################################################
*
* Copyright 2020 Technische Universit�t Berlin and DIW Berlin
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


AvailabilityFactor(r,'HLI_Geothermal',y) = 0;

TotalTechnologyAnnualActivityUpperLimit(r,'HHI_Scrap_EAF',y) = 0.7*SpecifiedAnnualDemand(r,'Heat_High_Industrial',y);

ReserveMargin(r,y) = 0;

CommissionedTradeCapacity(y,f,r,rr) = 0;


*
* ####### Dispatch and Curtailment #############
*
*TagDispatchableTechnology(TECHNOLOGY) = 1;
*TagDispatchableTechnology(Solar) = 0;
*TagDispatchableTechnology(Wind) = 0;
*AvailabilityFactor(REGION,Solar,y) = 1;
*TagDispatchableTechnology(Passenger) = 0;
*Curtailment.fx(y,l,TransportFuels,r) = 0;


*parameter VariableRES(t);
*VariableRES(Solar) = 1;
*VariableRES(Wind) = 1;
*VariableRES('Res_Hydro_Small') = 1;

AvailabilityFactor(r,'RES_Hydro_Small',y) = 1;

TradeCapacity(y,'gas_natural',r,rr) = Readin_PowerTradeCapacity('gas_natural',r,rr,y);

set GasFuels(f);
GasFuels(f) = no;
GasFuels('Gas_Natural') = yes;
GasFuels('Gas_Bio') = yes;
GasFuels('Gas_Synth') = yes;
GasFuels('H2') = yes;


AvailabilityFactor(r,'X_Liquifier',y)$(YearVal(y) > 2015) = 1;
AvailabilityFactor(r,'X_Gasifier',y)$(YearVal(y) > 2015) = 1;

TotalAnnualMaxCapacity(r,'X_Liquifier',y)$(YearVal(y) > 2015) = 9999;
TotalAnnualMaxCapacity(r,'X_Gasifier',y)$(YearVal(y) > 2015) = 9999;

*
* ##############* Pipeline Capacities & Investments #############
*
equation TrPl1a_TradeCapacityPipelinesLines(YEAR_FULL,TIMESLICE_FULL,REGION_FULL,rr_full);
TrPl1a_TradeCapacityPipelinesLines(y,l,r,rr).. sum(GasFuels$(TradeRoute(y,GasFuels,r,rr) > 0), Import(y,l,GasFuels,rr,r)) =l= TotalTradeCapacity(y,'Gas_Natural',r,rr);


*
* ############## Additions for NTNU Guadeloupe study
*

AvailabilityFactor(r,t,y)$(TagTechnologyToSubsets(t,'CHP')) = 0;
*AvailabilityFactor(r,'PSNG_Rail_Electric',y) = 0;
AvailabilityFactor(r,'PSNG_Rail_Conv',y) = 0;

*NewCapacity.lo('2018','HLR_Solar_Thermal','MarieGalante') = 3;
*NewCapacity.lo('2018','D_Heat_HLR','MarieGalante') = 2;
*ProductionByTechnologyAnnual.lo('2018','HLR_Solar_Thermal','Heat_Low_Residential','MarieGalante') =  2;
*ProductionByTechnologyAnnual.lo('2018','D_Heat_HLR','Heat_Low_Residential','MarieGalante') =  2;
*NewCapacity.up('%year%','HLR_Gas_Boiler',r) = 0;
*CapitalCost(r,'D_Heat_HLR',y) = 0.01;
NewCapacity.up(y,'D_PHS',r) = 0;





$ifthen %EmissionPathway% == Independence2040
ProductionByTechnologyAnnual.fx(y,t,'Gas_Natural',r)$(YearVal(y)>=2040) = 0;
UseByTechnologyAnnual.up(y,t,FossilFuels,r)$(not sum(CCS,diag(t,CCS)) and YearVal(y)>=2040) = 0;
*AnnualEmissionLimit should be defined


$endif

$ifthen %EmissionPathway% == Independence2050
ProductionByTechnologyAnnual.fx(y,t,'Gas_Natural',r)$(YearVal(y)>=2050) = 0;
UseByTechnologyAnnual.up(y,t,FossilFuels,r)$(not sum(CCS,diag(t,CCS)) and YearVal(y)>=2050) = 0;
*AnnualEmissionLimit should be defined
$endif


*InputActivityRatio(r,'HLR_Solar_Thermal',f,m,y) = 0;
*TagDispatchableTechnology('HLR_Solar_Thermal') = 1;