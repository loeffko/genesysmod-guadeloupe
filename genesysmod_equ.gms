* ###################### genesysmod_equ.gms #######################
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



* ######################
* # Objective Function #
* ######################

free variable z;
positive variable RegionalBaseYearProduction_neg(y_full,r_full,t,f);
RegionalBaseYearProduction_neg.fx(y,r,t,f) = 0;

equation cost;
cost.. z =e= sum((y,r), TotalDiscountedCost(y,r))
+ sum((y,r), DiscountedAnnualTotalTradeCosts(y,r))
+ sum((y,f,r,rr), DiscountedNewTradeCapacityCosts(y,f,r,rr))
+ sum((y,f,r), DiscountedAnnualCurtailmentCost(y,f,r))
+ sum((y,r,f,t),RegionalBaseYearProduction_neg(y,r,t,f)*9999)
+ sum((y,r,f,t),BaseYearOvershoot(r,t,f,y)*999)
- sum((y,r),DiscountedSalvageValueTransmission(y,r))
;

* #########################
* # Parameter assignments #
* #########################

RateOfDemand(y,l,f,r) = SpecifiedAnnualDemand(r,f,y)*SpecifiedDemandProfile(r,f,l,y) / YearSplit(l,y);
Demand(y,l,f,r) = RateOfDemand(y,l,f,r)*YearSplit(l,y);

Demand(y,l,f,r)$(Demand(y,l,f,r) < 0.000001) = 0;
CapacityFactor(r,t,l,y)$(CapacityFactor(r,t,l,y) < 0.000001) = 0;

parameter CanFuelBeUsedByModeByTech(YEAR_FULL, FUEL, REGION_FULL,TECHNOLOGY,MODE_OF_OPERATION);
CanFuelBeUsedByModeByTech(y,f,r,t,m)$
(InputActivityRatio(r,t,f,m,y)*
            TotalAnnualMaxCapacity(r,t,y)*
            sum(l,CapacityFactor(r,t,l,y))*
            AvailabilityFactor(r,t,y)*
            TotalTechnologyModelPeriodActivityUpperLimit(r,t)*
            TotalTechnologyAnnualActivityUpperLimit(r,t,y)
 > 0) = 1;

parameter CanFuelBeUsedByTech(YEAR_FULL, FUEL, REGION_FULL,TECHNOLOGY);
CanFuelBeUsedByTech(y,f,r,t)$
(sum((m), InputActivityRatio(r,t,f,m,y)*
            TotalAnnualMaxCapacity(r,t,y)*
            sum(l,CapacityFactor(r,t,l,y))*
            AvailabilityFactor(r,t,y)*
            TotalTechnologyModelPeriodActivityUpperLimit(r,t)*
            TotalTechnologyAnnualActivityUpperLimit(r,t,y))
 > 0) = 1;

parameter CanFuelBeUsed(YEAR_FULL, FUEL, REGION_FULL);
CanFuelBeUsed(y,f,r)$
(sum((m,t), InputActivityRatio(r,t,f,m,y)*
            TotalAnnualMaxCapacity(r,t,y)*
            sum(l,CapacityFactor(r,t,l,y))*
            AvailabilityFactor(r,t,y)*
            TotalTechnologyModelPeriodActivityUpperLimit(r,t)*
            TotalTechnologyAnnualActivityUpperLimit(r,t,y))
 > 0) = 1;

parameter CanFuelBeUsedInTimeslice(YEAR_FULL, TIMESLICE_FULL, FUEL, REGION_FULL);
CanFuelBeUsedInTimeslice(y,l,f,r)$
(sum((m,t), InputActivityRatio(r,t,f,m,y)*
            TotalAnnualMaxCapacity(r,t,y)*
            CapacityFactor(r,t,l,y)*
            AvailabilityFactor(r,t,y)*
            TotalTechnologyModelPeriodActivityUpperLimit(r,t)*
            TotalTechnologyAnnualActivityUpperLimit(r,t,y))
 > 0) = 1;

parameter CanFuelBeUsedOrDemanded(YEAR_FULL, FUEL, REGION_FULL);
CanFuelBeUsedOrDemanded(y,f,r)$
(sum((m,t), InputActivityRatio(r,t,f,m,y)*
            TotalAnnualMaxCapacity(r,t,y)*
            sum(l,CapacityFactor(r,t,l,y))*
            AvailabilityFactor(r,t,y)*
            TotalTechnologyModelPeriodActivityUpperLimit(r,t)*
            TotalTechnologyAnnualActivityUpperLimit(r,t,y))
 > 0 or SpecifiedAnnualDemand(r,f,y) > 0) = 1;

parameter CanFuelBeProducedByModeByTech(YEAR_FULL, FUEL, REGION_FULL,TECHNOLOGY,MODE_OF_OPERATION);
CanFuelBeProducedByModeByTech(y,f,r,t,m)$
(OutputActivityRatio(r,t,f,m,y)*
            TotalAnnualMaxCapacity(r,t,y)*
            sum(l,CapacityFactor(r,t,l,y))*
            AvailabilityFactor(r,t,y)*
            TotalTechnologyModelPeriodActivityUpperLimit(r,t)*
            TotalTechnologyAnnualActivityUpperLimit(r,t,y)
 > 0) = 1;

parameter CanFuelBeProducedByTech(YEAR_FULL, FUEL, REGION_FULL,TECHNOLOGY);
CanFuelBeProducedByTech(y,f,r,t)$
(sum((m), OutputActivityRatio(r,t,f,m,y)*
            TotalAnnualMaxCapacity(r,t,y)*
            sum(l,CapacityFactor(r,t,l,y))*
            AvailabilityFactor(r,t,y)*
            TotalTechnologyModelPeriodActivityUpperLimit(r,t)*
            TotalTechnologyAnnualActivityUpperLimit(r,t,y))
 > 0) = 1;

parameter CanFuelBeProduced(YEAR_FULL, FUEL, REGION_FULL);
CanFuelBeProduced(y,f,r)$
(sum((m,t), OutputActivityRatio(r,t,f,m,y)*
            TotalAnnualMaxCapacity(r,t,y)*
            sum(l,CapacityFactor(r,t,l,y))*
            AvailabilityFactor(r,t,y)*
            TotalTechnologyModelPeriodActivityUpperLimit(r,t)*
            TotalTechnologyAnnualActivityUpperLimit(r,t,y))
 > 0) = 1;

parameter CanFuelBeProducedInTimeslice(YEAR_FULL, TIMESLICE_FULL, FUEL, REGION_FULL);
CanFuelBeProducedInTimeslice(y,l,f,r)$
(sum((m,t), OutputActivityRatio(r,t,f,m,y)*
            TotalAnnualMaxCapacity(r,t,y)*
            CapacityFactor(r,t,l,y)*
            AvailabilityFactor(r,t,y)*
            TotalTechnologyModelPeriodActivityUpperLimit(r,t)*
            TotalTechnologyAnnualActivityUpperLimit(r,t,y))
 > 0) = 1;

parameter IgnoreFuel(YEAR_FULL, FUEL, REGION_FULL);
IgnoreFuel(y,f,r)$
(CanFuelBeUsedOrDemanded(y,f,r) = 1 and CanFuelBeProduced(y,f,r) = 0) = 1;

parameter PureDemandFuel(YEAR_FULL, FUEL, REGION_FULL);
PureDemandFuel(y,f,r)$
(CanFuelBeUsed(y,f,r) = 0 and SpecifiedAnnualDemand(r,f,y) > 0) = 1;


* ###############
* # Constraints #
* ###############

*
* ############### Capacity Adequacy A #############

*
equation CAa1_TotalNewCapacity(YEAR_FULL,TECHNOLOGY,REGION_FULL);
CAa1_TotalNewCapacity(y,t,r)$(sum(yy$((YearVal(y)-YearVal(yy) < OperationalLife(r,t)) AND (YearVal(y)-YearVal(yy) >= 0)), TotalAnnualMaxCapacity(r,t,yy)) > 0 and TotalTechnologyModelPeriodActivityUpperLimit(r,t) > 0).. AccumulatedNewCapacity(y,t,r) =e= sum(yy$((YearVal(y)-YearVal(yy) < OperationalLife(r,t)) AND (YearVal(y)-YearVal(yy) >= 0)), NewCapacity(yy,t,r));
AccumulatedNewCapacity.fx(y,t,r)$(sum(yy$((YearVal(y)-YearVal(yy) < OperationalLife(r,t)) AND (YearVal(y)-YearVal(yy) >= 0)), TotalAnnualMaxCapacity(r,t,yy)) = 0 or TotalTechnologyModelPeriodActivityUpperLimit(r,t) = 0) = 0;
AccumulatedNewCapacity.fx(y,t,r)$(sum(yy$((YearVal(y)-YearVal(yy) < OperationalLife(r,t)) AND (YearVal(y)-YearVal(yy) >= 0)), TotalAnnualMaxCapacity(r,t,yy)) = 0 or TotalTechnologyModelPeriodActivityUpperLimit(r,t) = 0) = 0;

equation CAa2_TotalAnnualCapacity(YEAR_FULL,TECHNOLOGY,REGION_FULL);
CAa2_TotalAnnualCapacity(y,t,r)$(AccumulatedNewCapacity.up(y,t,r) > 0 or ResidualCapacity(r,t,y) > 0).. AccumulatedNewCapacity(y,t,r) + ResidualCapacity(r,t,y) =e= TotalCapacityAnnual(y,t,r);
TotalCapacityAnnual.fx(y,t,r)$(AccumulatedNewCapacity.up(y,t,r) = 0 and ResidualCapacity(r,t,y) = 0) = 0;
AccumulatedNewCapacity.fx(y,t,r)$(AccumulatedNewCapacity.up(y,t,r) = 0) = 0;

parameter CanBuildTechnology(YEAR_FULL, TECHNOLOGY, REGION_FULL);
CanBuildTechnology(y,t,r)$
(TotalAnnualMaxCapacity(r,t,y)*
 sum(l,CapacityFactor(r,t,l,y))*
 AvailabilityFactor(r,t,y)*
 TotalTechnologyModelPeriodActivityUpperLimit(r,t)*
 TotalTechnologyAnnualActivityUpperLimit(r,t,y)
 > 0 and TotalCapacityAnnual.up(y,t,r) > 0) = 1;

RateOfActivity.fx(y,l,t,m,r)$
  (CapacityFactor(r,t,l,y) = 0
or AvailabilityFactor(r,t,y) = 0
or TotalTechnologyModelPeriodActivityUpperLimit(r,t) = 0
or TotalTechnologyAnnualActivityUpperLimit(r,t,y) = 0
or TotalAnnualMaxCapacity(r,t,y) = 0
or TotalCapacityAnnual.up(y,t,r) = 0
) = 0;


$ifthen  %switch_intertemporal% == 1
equation CAa4_Constraint_Capacity(REGION_FULL,TIMESLICE_FULL,TECHNOLOGY,YEAR_FULL);
CAa4_Constraint_Capacity(r,l,t,y)$(CapacityFactor(r,t,l,y) > 0 and AvailabilityFactor(r,t,y) > 0 and TotalAnnualMaxCapacity(r,t,y) > 0 and TotalTechnologyModelPeriodActivityUpperLimit(r,t) > 0).. RateOfTotalActivity(y,l,t,r) =e= TotalActivityPerYear(r,l,t,y)*AvailabilityFactor(r,t,y) - DispatchDummy(r,l,t,y)*TagDispatchableTechnology(t);

equation CAaT_TotalActivityPerYear_Intertemporal(REGION_FULL,TIMESLICE_FULL,TECHNOLOGY,YEAR_FULL);
CAaT_TotalActivityPerYear_Intertemporal(r,l,t,y)$((sum(yy$((YearVal(y)-YearVal(yy) < OperationalLife(r,t)) AND (YearVal(y)-YearVal(yy) >= 0)),CapacityFactor(r,t,l,yy)) > 0 or CapacityFactor(r,t,l,'%year%') > 0) and TotalTechnologyModelPeriodActivityUpperLimit(r,t) > 0 and AvailabilityFactor(r,t,y) > 0 and TotalAnnualMaxCapacity(r,t,y) > 0).. TotalActivityPerYear(r,l,t,y) =e= sum(yy$((YearVal(y)-YearVal(yy) < OperationalLife(r,t)) AND (YearVal(y)-YearVal(yy) >= 0)),(NewCapacity(yy,t,r) * CapacityFactor(r,t,l,yy) * CapacityToActivityUnit(r,t)))+(ResidualCapacity(r,t,y)*CapacityFactor(r,t,l,'%year%') * CapacityToActivityUnit(r,t));
$else

equation CAa4_Constraint_Capacity(REGION_FULL,TIMESLICE_FULL,TECHNOLOGY,YEAR_FULL);
CAa4_Constraint_Capacity(r,l,t,y)$(CapacityFactor(r,t,l,y) > 0 and AvailabilityFactor(r,t,y) > 0 and TotalAnnualMaxCapacity(r,t,y) > 0 and TotalTechnologyModelPeriodActivityUpperLimit(r,t) > 0).. sum(m, RateOfActivity(y,l,t,m,r)) =e= TotalCapacityAnnual(y,t,r) * CapacityFactor(r,t,l,y) * CapacityToActivityUnit(r,t) *AvailabilityFactor(r,t,y) - DispatchDummy(r,l,t,y)*TagDispatchableTechnology(t);
$endif

$ifthen  %UseMipSolver% == yes
equation CAa5_TotalNewCapacity(YEAR_FULL,TECHNOLOGY,REGION_FULL);
CAa5_TotalNewCapacity(y,t,r)$(CapacityOfOneTechnologyUnit(y,t,r) <> 0 and AvailabilityFactor(r,t,y) > 0).. CapacityOfOneTechnologyUnit(y,t,r) * NumberOfNewTechnologyUnits(y,t,r) =e= NewCapacity(y,t,r);
$endif

*
* ############### Capacity Adequacy B #############
*
equation CAb1_PlannedMaintenance(YEAR_FULL,TECHNOLOGY,REGION_FULL);
CAb1_PlannedMaintenance(y,t,r)$(AvailabilityFactor(r,t,y)<1 and TotalAnnualMaxCapacity(r,t,y) > 0 and TotalTechnologyModelPeriodActivityUpperLimit(r,t) > 0 and TotalCapacityAnnual.up(y,t,r) > 0).. sum(l, sum(m, RateOfActivity(y,l,t,m,r))*YearSplit(l,y)) =l= sum(l,TotalCapacityAnnual(y,t,r)*CapacityFactor(r,t,l,y)*YearSplit(l,y)*AvailabilityFactor(r,t,y)*CapacityToActivityUnit(r,t));

*
* ##############* Energy Balance A #############
*


equation EBa10_EnergyBalanceEachTS4(YEAR_FULL,TIMESLICE_FULL,FUEL,r_full,rr_FULL);
EBa10_EnergyBalanceEachTS4(y,l,f,r,rr)$(TradeRoute(y,f,r,rr)).. Import(y,l,f,r,rr) =e= Export(y,l,f,rr,r);
Import.fx(y,l,f,r,rr)$(TradeRoute(y,f,r,rr) = 0) = 0;
Export.fx(y,l,f,rr,r)$(TradeRoute(y,f,r,rr) = 0) = 0;

NetTrade.fx(y,l,f,r)$(sum(rr,TradeRoute(y,f,r,rr)) = 0) = 0;

equation EBa11_EnergyBalanceEachTS5(YEAR_FULL,TIMESLICE_FULL,FUEL,REGION_FULL);
EBa11_EnergyBalanceEachTS5(y,l,f,r)$(IgnoreFuel(y,f,r) = 0).. sum((t,m)$(OutputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity(y,l,t,m,r)*OutputActivityRatio(r,t,f,m,y))*YearSplit(l,y) =e= (Demand(y,l,f,r) + sum((t,m)$(InputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity(y,l,t,m,r)*InputActivityRatio(r,t,f,m,y)*TimeDepEfficiency(r,t,l,y))*YearSplit(l,y) + NetTrade(y,l,f,r) + Curtailment(y,l,f,r));

equation EBa12_NetTradeBalance(YEAR_FULL,TIMESLICE_FULL,FUEL,REGION_FULL);
EBa12_NetTradeBalance(y,l,f,r)$(sum(rr,TradeRoute(y,f,r,rr)) > 0).. sum(rr$(TradeRoute(y,f,r,rr)), Export(y,l,f,r,rr)*(1+TradeLossBetweenRegions(y,f,r,rr)) - Import(y,l,f,r,rr)) =e= NetTrade(y,l,f,r);

equation EBa13_CurtailmentAnnual(YEAR_FULL,FUEL,REGION_FULL);
EBa13_CurtailmentAnnual(y,f,r)$(sum(l,Curtailment.up(y,l,f,r)) > 0).. CurtailmentAnnual(y,f,r) =e= sum(l,Curtailment(y,l,f,r));
CurtailmentAnnual.fx(y,f,r)$(sum(l,Curtailment.up(y,l,f,r)) = 0) = 0;

equation EBa14_SelfSufficiency(YEAR_FULL,FUEL,REGION_FULL);
EBa14_SelfSufficiency(y,f,r)$(SelfSufficiency(y,f,r) <> 0).. sum((l,t,m)$(OutputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity(y,l,t,m,r)*OutputActivityRatio(r,t,f,m,y)*YearSplit(l,y)) =g= (SpecifiedAnnualDemand(r,f,y)+sum((l,t,m)$(InputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity(y,l,t,m,r)*InputActivityRatio(r,t,f,m,y)*TimeDepEfficiency(r,t,l,y)*YearSplit(l,y)))*SelfSufficiency(y,f,r);

*
* ##############* Energy Balance B #############
*

equation EBb3_EnergyBalanceEachYear3(YEAR_FULL,FUEL,REGION_FULL);
EBb3_EnergyBalanceEachYear3(y,f,r)$(sum(rr,TradeRoute(y,f,r,rr)) > 0).. sum(l, (NetTrade(y,l,f,r))) =e= NetTradeAnnual(y,f,r);
NetTradeAnnual.fx(y,f,r)$(sum(rr,TradeRoute(y,f,r,rr)) = 0) = 0;

equation EBb4_EnergyBalanceEachYear4(YEAR_FULL,FUEL,REGION_FULL);
EBb4_EnergyBalanceEachYear4(y,f,r).. sum((l,t,m)$(OutputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity(y,l,t,m,r)*OutputActivityRatio(r,t,f,m,y)*YearSplit(l,y)) =g= sum((l,t,m)$(InputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity(y,l,t,m,r)*InputActivityRatio(r,t,f,m,y)*TimeDepEfficiency(r,t,l,y)*YearSplit(l,y)) + NetTradeAnnual(y,f,r);


*
* ##############* Trade Capacities & Investments #############
*
equation TrC1a_TradeCapacityPowerLinesImport(YEAR_FULL,TIMESLICE_FULL,FUEL,REGION_FULL,rr_full);
TrC1a_TradeCapacityPowerLinesImport(y,l,'Power',r,rr)$(TradeRoute(y,'Power',rr,r) > 0).. (Import(y,l,'Power',r,rr)) =l= TotalTradeCapacity(y,'Power',rr,r)*YearSplit(l,y)*31.536;
equation TrC1b_TradeCapacityPowerLinesExport(YEAR_FULL,TIMESLICE_FULL,FUEL,REGION_FULL,rr_full);
TrC1b_TradeCapacityPowerLinesExport(y,l,'Power',r,rr)$(TradeRoute(y,'Power',r,rr) > 0).. (Export(y,l,'Power',r,rr)) =l= TotalTradeCapacity(y,'Power',r,rr)*YearSplit(l,y)*31.536;

equation TrC2a_TotalTradeCapacity(YEAR_FULL,FUEL,REGION_FULL,rr_full);
TrC2a_TotalTradeCapacity(y,f,r,rr)$(TradeRoute(y,f,r,rr) > 0 and YearVal(y) = %year%).. TotalTradeCapacity(y,f,r,rr) =e= TradeCapacity(y,f,r,rr);
equation TrC2b_TotalTradeCapacity(YEAR_FULL,FUEL,REGION_FULL,rr_full);
TrC2b_TotalTradeCapacity(y,f,r,rr)$(TradeRoute(y,f,r,rr) > 0 and YearVal(y) > %year%).. TotalTradeCapacity(y,f,r,rr) =e= TotalTradeCapacity(y-1,f,r,rr) + NewTradeCapacity(y,f,r,rr) + AdditionalTradeCapacity(y,f,r,rr);
equation TrC3_NewTradeCapacityLimit(YEAR_FULL,FUEL,REGION_FULL,rr_full);
TrC3_NewTradeCapacityLimit(y,f,r,rr)$(TradeRoute(y,f,r,rr) > 0 and GrowthRateTradeCapacity(y,f,r,rr) > 0).. (1+GrowthRateTradeCapacity(y,f,r,rr)*YearlyDifferenceMultiplier(y))*TotalTradeCapacity(y-1,f,r,rr) =g= NewTradeCapacity(y,f,r,rr);
NewTradeCapacity.fx(y,'Power',r,rr)$(TradeRoute(y,'Power',r,rr) = 0 or GrowthRateTradeCapacity(y,'Power',r,rr) = 0) = 0;
NewTradeCapacity.fx(y,f,r,rr)$(not sameAs('Power',f)) = 0;

equation TrC4_NewTradeCapacityCosts(YEAR_FULL,FUEL,REGION_FULL,rr_full);
TrC4_NewTradeCapacityCosts(y,'Power',r,rr)$(TradeRoute(y,'Power',r,rr) > 0)..  NewTradeCapacity(y,'Power',r,rr)*TradeCapacityGrowthCosts('Power',r,rr)*TradeRoute(y,'Power',r,rr) =e= NewTradeCapacityCosts(y,'Power',r,rr);
equation TrC5_DiscountedNewTradeCapacityCosts(YEAR_FULL,FUEL,REGION_FULL,rr_full);
TrC5_DiscountedNewTradeCapacityCosts(y,'Power',r,rr)$(TradeRoute(y,'Power',r,rr) > 0).. NewTradeCapacityCosts(y,'Power',r,rr)/((1+GeneralDiscountRate(r))**(YearVal(y)-smin(yy, YearVal(yy))+0.5)) =e= DiscountedNewTradeCapacityCosts(y,'Power',r,rr);
DiscountedNewTradeCapacityCosts.fx(y,f,r,rr)$(TradeRoute(y,f,r,rr) = 0 or (not sameAs('Power',f))) = 0;

$ifthen set set_symmetric_transmission
equation TrC1c_SymmetricalTransmissionExpansion(YEAR_FULL,REGION_FULL,RR_FULL);
TrC1c_SymmetricalTransmissionExpansion(y,r,rr)$(TradeRoute(y,'Power',rr,r) > 0).. NewTradeCapacity(y,'Power',r,rr) =g= NewTradeCapacity(y,'Power',rr,r)*%set_symmetric_transmission%;
$endif

*
* ##############* Trading Costs #############
*
equation Tc1_TradeCosts(y_full,REGION_FULL);
Tc1_TradeCosts(y,r)$(sum((f,rr),TradeRoute(y,f,r,rr)) > 0).. sum((l,f,rr)$(TradeRoute(y,f,r,rr)),Import(y,l,f,r,rr) * TradeCosts(f,r,rr)) =e= AnnualTotalTradeCosts(y,r);
AnnualTotalTradeCosts.fx(y,r)$(sum((f,rr),TradeRoute(y,f,r,rr)) = 0) = 0;

equation Tc3_DiscountedAnnualTradeCosts(y_full,REGION_FULL);
Tc3_DiscountedAnnualTradeCosts(y,r)..  AnnualTotalTradeCosts(y,r)/((1+GeneralDiscountRate(r))**(YearVal(y)-smin(yy, YearVal(yy))+0.5)) =e= DiscountedAnnualTotalTradeCosts(y,r);

*
* ##############* Accounting Technology Production/Use #############
*

equation Acc3_AverageAnnualRateOfActivity(YEAR_FULL,TECHNOLOGY,MODE_OF_OPERATION,REGION_FULL);
Acc3_AverageAnnualRateOfActivity(y,t,m,r)$(CanBuildTechnology(y,t,r) > 0).. sum(l, RateOfActivity(y,l,t,m,r)*YearSplit(l,y)) =e= TotalAnnualTechnologyActivityByMode(y,t,m,r);
TotalAnnualTechnologyActivityByMode.fx(y,t,m,r)$(CanBuildTechnology(y,t,r) = 0) = 0;

equation Acc4_ModelPeriodCostByRegion(REGION_FULL);
Acc4_ModelPeriodCostByRegion(r)..sum((y), TotalDiscountedCost(y,r)) =e= ModelPeriodCostByRegion(r);

*
* ############### Capital Costs #############
*
equation CC1_UndiscountedCapitalInvestment(YEAR_FULL,TECHNOLOGY,REGION_FULL);
CC1_UndiscountedCapitalInvestment(y,t,r).. CapitalCost(r,t,y) * NewCapacity(y,t,r) =e= CapitalInvestment(y,t,r);
equation CC2_DiscountingCapitalInvestmenta(YEAR_FULL,TECHNOLOGY,REGION_FULL);
CC2_DiscountingCapitalInvestmenta(y,t,r).. CapitalInvestment(y,t,r)/((1+TechnologyDiscountRate(r,t))**(YearVal(y)-StartYear)) =e= DiscountedCapitalInvestment(y,t,r);

*
* ############### Investment & Capacity Limits #############
*

$ifthen %switch_investLimit% == 1

equation CC3_InvestmentLimit(YEAR_FULL);
CC3_InvestmentLimit(y)$(YearVal(y) > %year%).. sum((t,r),CapitalInvestment(y,t,r)) =l= 1/(smax(yy,Yearval(yy))-smin(yy,YearVal(yy)))*YearlyDifferenceMultiplier(y-1)*InvestmentLimit*sum(yy,sum((t,r),CapitalInvestment(yy,t,r)));


equation CC4_CapacityLimit(YEAR_FULL,REGION_FULL,TECHNOLOGY);
CC4_CapacityLimit(y,r,Renewables)$(ord(y)>1).. NewCapacity(y,Renewables,r) =l= YearlyDifferenceMultiplier(y-1)*NewRESCapacity*TotalAnnualMaxCapacity(r,Renewables,y);

equation CC5c_PhaseInLowerLimit(YEAR_FULL,REGION_FULL,TECHNOLOGY,FUEL);
CC5c_PhaseInLowerLimit(y,r,PhaseInSet,f)$(Yearval(y) > %year%).. ProductionByTechnologyAnnual(y,PhaseInSet,f,r) =g= ProductionByTechnologyAnnual(y-1,PhaseInSet,f,r)*PhaseIn(y)*((SpecifiedAnnualDemand(r,f,y)/SpecifiedAnnualDemand(r,f,y-1))$(SpecifiedAnnualDemand(r,f,y))+1$(not SpecifiedAnnualDemand(r,f,y)));

equation CC5d_PhaseOutUpperLimit(YEAR_FULL,REGION_FULL,TECHNOLOGY,FUEL);
CC5d_PhaseOutUpperLimit(y,r,PhaseOutSet,f)$(Yearval(y) > %year%).. ProductionByTechnologyAnnual(y,PhaseOutSet,f,r) =l= ProductionByTechnologyAnnual(y-1,PhaseOutSet,f,r)*PhaseOut(y)*((SpecifiedAnnualDemand(r,f,y)/SpecifiedAnnualDemand(r,f,y-1))$(SpecifiedAnnualDemand(r,f,y))+1$(not SpecifiedAnnualDemand(r,f,y)));

equation CC5f_AnnualProductionChangeLimit(YEAR_FULL,FUEL);
CC5f_AnnualProductionChangeLimit(y,f)$(Yearval(y) > %year% and ProductionGrowthLimit(y,f)>0).. sum((t,r)$(RETagTechnology(r,t,y)=1),ProductionByTechnologyAnnual(y,t,f,r)-ProductionByTechnologyAnnual(y-1,t,f,r)) =l= YearlyDifferenceMultiplier(y-1)*ProductionGrowthLimit(y,f)*sum((t,r),ProductionByTechnologyAnnual(y-1,t,f,r))-sum((StorageDummies,r),ProductionByTechnologyAnnual(y-1,StorageDummies,f,r));

$ifthen %switch_ccs% == 1
equation CC5g_CCSAddition(YEAR_FULL,REGION_FULL,FUEL);
CC5g_CCSAddition(y,r,f)$(Yearval(y) > %year% and not sameas(f,'DAC_Dummy')).. sum(CCS,ProductionByTechnologyAnnual(y,CCS,f,r)-ProductionByTechnologyAnnual(y-1,CCS,f,r)) =l= YearlyDifferenceMultiplier(y-1)*(ProductionGrowthLimit(y,'Air'))*sum((t),ProductionByTechnologyAnnual(y-1,t,f,r));

equation CC5i_CCSLimit(REGION_FULL);
CC5i_CCSLimit(r)$(sum(rr,RegionalCCSLimit(rr)) > 0)..
sum((y,CCS),
         sum((f,m,e),
                 TotalAnnualTechnologyActivityByMode(y,CCS,m,r)*EmissionContentPerFuel(f,e)*InputActivityRatio(r,CCS,f,m,y)*YearlyDifferenceMultiplier(y)*(((1-EmissionActivityRatio(r,CCS,e,m,y))$(EmissionActivityRatio(r,CCS,e,m,y)>0))+
                 ((-1)*EmissionActivityRatio(r,CCS,e,m,y))$(EmissionActivityRatio(r,CCS,e,m,y)<0))
         )
) =l= RegionalCCSLimit(r);
$endif

equation CC5h_AnnualStorageChangeLimit(YEAR_FULL,REGION_FULL,FUEL);
CC5h_AnnualStorageChangeLimit(y,r,f)$(Yearval(y) > %year% and ProductionGrowthLimit(y,f)>0).. sum(StorageDummies,ProductionByTechnologyAnnual(y,StorageDummies,f,r)-ProductionByTechnologyAnnual(y-1,StorageDummies,f,r)) =l= YearlyDifferenceMultiplier(y-1)*(ProductionGrowthLimit(y,f)+StorageLimitOffset)*sum((t),ProductionByTechnologyAnnual(y-1,t,f,r))

$endif

*
* ##############* Salvage Value #############
*
equation SV1_SalvageValueAtEndOfPeriod1(YEAR_FULL,TECHNOLOGY,REGION_FULL);
SV1_SalvageValueAtEndOfPeriod1(y,t,r)$(DepreciationMethod(r)=1 and ((YearVal(y) + OperationalLife(r,t)-1 > smax(yy, YearVal(yy))) and (TechnologyDiscountRate(r,t) > 0)))..
SalvageValue(y,t,r) =e= CapitalCost(r,t,y)*NewCapacity(y,t,r)*(1-(((1+TechnologyDiscountRate(r,t))**(smax(yy, YearVal(yy)) - YearVal(y)+1) -1)
/((1+TechnologyDiscountRate(r,t))**OperationalLife(r,t)-1)));
equation SV2_SalvageValueAtEndOfPeriod2(YEAR_FULL,TECHNOLOGY,REGION_FULL);
SV2_SalvageValueAtEndOfPeriod2(y,t,r)$((((YearVal(y) + OperationalLife(r,t)-1 > smax(yy, YearVal(yy))) and (TechnologyDiscountRate(r,t) = 0)) or (DepreciationMethod(r)=2 and (YearVal(y) + OperationalLife(r,t)-1 > smax(yy, YearVal(yy))))))..
SalvageValue(y,t,r) =e= CapitalCost(r,t,y)*NewCapacity(y,t,r)*(1-(smax(yy, YearVal(yy))- YearVal(y)+1)/OperationalLife(r,t));
equation SV3_SalvageValueAtEndOfPeriod3(YEAR_FULL,TECHNOLOGY,REGION_FULL);
SV3_SalvageValueAtEndOfPeriod3(y,t,r)$(YearVal(y) + OperationalLife(r,t)-1 <= smax(yy, YearVal(yy)))..
SalvageValue(y,t,r) =e= 0;
equation SV1b_SalvageValueAtEndOfPeriod1(YEAR_FULL,REGION_FULL);
SV1b_SalvageValueAtEndOfPeriod1(y,r)$(DepreciationMethod(r)=1 and ((YearVal(y) + 40 > smax(yy, YearVal(yy)))))..
DiscountedSalvageValueTransmission(y,r) =e= (sum((f,rr),TradeCapacityGrowthCosts(f,r,rr)*TradeRoute(y,f,r,rr)*NewTradeCapacity(y,f,r,rr)*(1-(((1+GeneralDiscountRate(r))**(smax(yy, YearVal(yy)) - YearVal(y)+1) -1)
/((1+GeneralDiscountRate(r))**40)))))/((1+GeneralDiscountRate(r))**(1+smax(yy, YearVal(yy)) - smin(yy, YearVal(yy))));

equation SV4_SalvageValueDiscToStartYr(YEAR_FULL,TECHNOLOGY,REGION_FULL);
SV4_SalvageValueDiscToStartYr(y,t,r)..
DiscountedSalvageValue(y,t,r) =e= SalvageValue(y,t,r)/((1+TechnologyDiscountRate(r,t))**(1+smax(yy, YearVal(yy)) - smin(yy, YearVal(yy))));

*
* ############### Operating Costs #############
*
equation OC1_OperatingCostsVariable(YEAR_FULL,TECHNOLOGY,REGION_FULL);
OC1_OperatingCostsVariable(y,t,r)$(sum(m,VariableCost(r,t,m,y) > 0) and CanBuildTechnology(y,t,r) > 0).. sum(m, (TotalAnnualTechnologyActivityByMode(y,t,m,r)*VariableCost(r,t,m,y))) =e= AnnualVariableOperatingCost(y,t,r);
AnnualVariableOperatingCost.fx(y,t,r)$(CanBuildTechnology(y,t,r) = 0) = 0;

equation OC2_OperatingCostsFixedAnnual(YEAR_FULL,TECHNOLOGY,REGION_FULL);
OC2_OperatingCostsFixedAnnual(y,t,r)$(FixedCost(r,t,y) > 0 and CanBuildTechnology(y,t,r) > 0).. sum(yy$((YearVal(y)-YearVal(yy) < OperationalLife(r,t)) AND (YearVal(y)-YearVal(yy) >= 0)), NewCapacity(yy,t,r)*FixedCost(r,t,yy))+ResidualCapacity(r,t,y)*FixedCost(r,t,y) =e= AnnualFixedOperatingCost(y,t,r);
AnnualFixedOperatingCost.fx(y,t,r)$(CanBuildTechnology(y,t,r) = 0) = 0;

equation OC3_OperatingCostsTotalAnnual(YEAR_FULL,TECHNOLOGY,REGION_FULL);
OC3_OperatingCostsTotalAnnual(y,t,r)$(AnnualVariableOperatingCost.up(y,t,r) > 0 and AnnualFixedOperatingCost.up(y,t,r)  > 0).. (AnnualFixedOperatingCost(y,t,r) + AnnualVariableOperatingCost(y,t,r))*YearlyDifferenceMultiplier(y) =e= OperatingCost(y,t,r);
OperatingCost.fx(y,t,r)$(AnnualVariableOperatingCost.up(y,t,r) = 0 and AnnualFixedOperatingCost.up(y,t,r)  = 0) = 0;

equation OC4_DiscountedOperatingCostsTotalAnnual(YEAR_FULL,TECHNOLOGY,REGION_FULL);
OC4_DiscountedOperatingCostsTotalAnnual(y,t,r)$(OperatingCost.up(y,t,r) > 0).. OperatingCost(y,t,r)/((1+TechnologyDiscountRate(r,t))**(YearVal(y)-smin(yy, YearVal(yy))+0.5)) =e= DiscountedOperatingCost(y,t,r);
DiscountedOperatingCost.fx(y,t,r)$(OperatingCost.up(y,t,r) = 0) = 0;

*
* ############### Total Discounted Costs #############
*
equation TDC1_TotalDiscountedCostByTechnology(YEAR_FULL,TECHNOLOGY,REGION_FULL);
TDC1_TotalDiscountedCostByTechnology(y,t,r).. DiscountedOperatingCost(y,t,r)+DiscountedCapitalInvestment(y,t,r)+DiscountedTechnologyEmissionsPenalty(y,t,r)-DiscountedSalvageValue(y,t,r)
$ifthen %switch_ramping% == 1
+DiscountedAnnualProductionChangeCost(y,t,r)
$endif
=e= TotalDiscountedCostByTechnology(y,t,r);


equation TDC2_TotalDiscountedCost(YEAR_FULL,REGION_FULL);
TDC2_TotalDiscountedCost(y,r).. sum(t,TotalDiscountedCostByTechnology(y,t,r))+sum(s,TotalDiscountedStorageCost(s,y,r)) =e= TotalDiscountedCost(y,r);

*
* ############### Total Capacity Constraints ##############
*
equation TCC1_TotalAnnualMaxCapacityConstraint(YEAR_FULL,TECHNOLOGY,REGION_FULL);
TCC1_TotalAnnualMaxCapacityConstraint(y,t,r)$(TotalAnnualMaxCapacity(r,t,y) < 999999 and TotalAnnualMaxCapacity(r,t,y) > 0).. TotalCapacityAnnual(y,t,r) =l= TotalAnnualMaxCapacity(r,t,y);
TotalCapacityAnnual.fx(y,t,r)$(TotalAnnualMaxCapacity(r,t,y) = 0) = 0;

equation TCC2_TotalAnnualMinCapacityConstraint(YEAR_FULL,TECHNOLOGY,REGION_FULL);
TCC2_TotalAnnualMinCapacityConstraint(y,t,r)$(TotalAnnualMinCapacity(r,t,y)>0).. TotalCapacityAnnual(y,t,r) =g= TotalAnnualMinCapacity(r,t,y);

*
* ############### New Capacity Constraints ##############
*
equation NCC1_TotalAnnualMaxNewCapacityConstraint(YEAR_FULL,TECHNOLOGY,REGION_FULL);
NCC1_TotalAnnualMaxNewCapacityConstraint(y,t,r)$(TotalAnnualMaxCapacityInvestment(r,t,y) < 999999).. NewCapacity(y,t,r) =l= TotalAnnualMaxCapacityInvestment(r,t,y);
equation NCC2_TotalAnnualMinNewCapacityConstraint(YEAR_FULL,TECHNOLOGY,REGION_FULL);
NCC2_TotalAnnualMinNewCapacityConstraint(y,t,r)$(TotalAnnualMinCapacityInvestment(r,t,y) > 0).. NewCapacity(y,t,r) =g= TotalAnnualMinCapacityInvestment(r,t,y);

*
* ################ Annual Activity Constraints ##############
*

equation AAC1_TotalAnnualTechnologyActivity(YEAR_FULL,TECHNOLOGY,REGION_FULL);
AAC1_TotalAnnualTechnologyActivity(y,t,r)$(CanBuildTechnology(y,t,r) > 0 and sum(f,ProductionByTechnologyAnnual.up(y,t,f,r)) > 0).. sum(f,ProductionByTechnologyAnnual(y,t,f,r)) =e= TotalTechnologyAnnualActivity(y,t,r);
TotalTechnologyAnnualActivity.fx(y,t,r)$(CanBuildTechnology(y,t,r) = 0 or sum(f,ProductionByTechnologyAnnual.up(y,t,f,r)) = 0) = 0;

equation AAC2_TotalAnnualTechnologyActivityUpperLimit(YEAR_FULL,TECHNOLOGY,REGION_FULL);
AAC2_TotalAnnualTechnologyActivityUpperLimit(y,t,r)$(TotalTechnologyAnnualActivityUpperLimit(r,t,y) < 999999).. TotalTechnologyAnnualActivity(y,t,r) =l= TotalTechnologyAnnualActivityUpperLimit(r,t,y);


equation AAC3_TotalAnnualTechnologyActivityLowerLimit(YEAR_FULL,TECHNOLOGY,REGION_FULL);
AAC3_TotalAnnualTechnologyActivityLowerLimit(y,t,r)$(TotalTechnologyAnnualActivityLowerLimit(r,t,y) > 0).. TotalTechnologyAnnualActivity(y,t,r) =g= TotalTechnologyAnnualActivityLowerLimit(r,t,y);

*
* ################ Total Activity Constraints ##############
*
equation TAC1_TotalModelHorizenTechnologyActivity(TECHNOLOGY,REGION_FULL);
TAC1_TotalModelHorizenTechnologyActivity(t,r).. sum(y, TotalTechnologyAnnualActivity(y,t,r)*YearlyDifferenceMultiplier(y)) =e= TotalTechnologyModelPeriodActivity(t,r);


equation TAC2_TotalModelHorizenTechnologyActivityUpperLimit(TECHNOLOGY,REGION_FULL);
TAC2_TotalModelHorizenTechnologyActivityUpperLimit(t,r)$(TotalTechnologyModelPeriodActivityUpperLimit(r,t) < 999999).. TotalTechnologyModelPeriodActivity(t,r) =l= TotalTechnologyModelPeriodActivityUpperLimit(r,t);


equation TAC3_TotalModelHorizenTechnologyActivityLowerLimit(YEAR_FULL,TECHNOLOGY,REGION_FULL);
TAC3_TotalModelHorizenTechnologyActivityLowerLimit(y,t,r)$(TotalTechnologyModelPeriodActivityLowerLimit(r,t) > 0).. TotalTechnologyModelPeriodActivity(t,r) =g= TotalTechnologyModelPeriodActivityLowerLimit(r,t);

*
* ############### Reserve Margin Constraint #############* NTS: Should change demand for production
*
$ifthen %switch_dispatch% == 0

equation RM1_ReserveMargin_TechologiesIncluded_In_Activity_Units(YEAR_FULL,TIMESLICE_FULL,REGION_FULL);
RM1_ReserveMargin_TechologiesIncluded_In_Activity_Units(y,l,r).. sum ((t,f), (sum(m$(OutputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity(y,l,t,m,r)*OutputActivityRatio(r,t,f,m,y)) * YearSplit(l,y) *ReserveMarginTagTechnology(r,t,y) * ReserveMarginTagFuel(r,f,y))) =e= TotalActivityInReserveMargin(r,y,l);
equation RM2_ReserveMargin_FuelsIncluded(YEAR_FULL,TIMESLICE_FULL,REGION_FULL);
RM2_ReserveMargin_FuelsIncluded(y,l,r).. sum (f, (sum((t,m)$(OutputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity(y,l,t,m,r)*OutputActivityRatio(r,t,f,m,y)) * YearSplit(l,y) * ReserveMarginTagFuel(r,f,y))) =e= DemandNeedingReserveMargin(y,l,r);
equation RM3_ReserveMargin_Constraint(YEAR_FULL,TIMESLICE_FULL,REGION_FULL);
RM3_ReserveMargin_Constraint(y,l,r)$(ReserveMargin(r,y) > 0).. DemandNeedingReserveMargin(y,l,r) * ReserveMargin(r,y) =l= TotalActivityInReserveMargin(r,y,l);

$endif
*
* ############### RE Production Target #############* NTS: Should change demand for production
*
equation RE1_FuelProductionByTechnologyAnnual(YEAR_FULL,TECHNOLOGY,FUEL,REGION_FULL);
RE1_FuelProductionByTechnologyAnnual(y,t,f,r)$(sum(m, OutputActivityRatio(r,t,f,m,y)) > 0 and AvailabilityFactor(r,t,y) > 0 and TotalAnnualMaxCapacity(r,t,y) > 0 and TotalTechnologyModelPeriodActivityUpperLimit(r,t) > 0 and TotalCapacityAnnual.up(y,t,r) > 0).. sum(l, sum(m$(OutputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity(y,l,t,m,r)*OutputActivityRatio(r,t,f,m,y)) * YearSplit(l,y)) =e= ProductionByTechnologyAnnual(y,t,f,r);
ProductionByTechnologyAnnual.fx(y,t,f,r)$(sum(m, OutputActivityRatio(r,t,f,m,y)) = 0 or AvailabilityFactor(r,t,y) = 0 or TotalAnnualMaxCapacity(r,t,y) = 0 or TotalTechnologyModelPeriodActivityUpperLimit(r,t) = 0 or TotalCapacityAnnual.up(y,t,r) = 0) = 0;

equation RE2_TechIncluded(YEAR_FULL,REGION_FULL,FUEL);
RE2_TechIncluded(y,r,f).. sum(RES,ProductionByTechnologyAnnual(y,RES,f,r)) =e= TotalREProductionAnnual(y,r,f);

equation RE4_EnergyConstraint(YEAR_FULL,REGION_FULL,FUEL);
RE4_EnergyConstraint(y,r,f).. REMinProductionTarget(r,f,y)*sum((l,t,m)$(OutputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity(y,l,t,m,r)*OutputActivityRatio(r,t,f,m,y)*YearSplit(l,y))*RETagFuel(r,f,y) =l= TotalREProductionAnnual(y,r,f);

equation RE5_FuelUseByTechnologyAnnual(YEAR_FULL,TECHNOLOGY,FUEL,REGION_FULL);
RE5_FuelUseByTechnologyAnnual(y,t,f,r)$(sum(m, InputActivityRatio(r,t,f,m,y)) > 0 and AvailabilityFactor(r,t,y) > 0 and TotalAnnualMaxCapacity(r,t,y) > 0 and TotalTechnologyModelPeriodActivityUpperLimit(r,t) > 0 and TotalCapacityAnnual.up(y,t,r) > 0).. sum(l, (sum(m$(InputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity(y,l,t,m,r)*InputActivityRatio(r,t,f,m,y))*YearSplit(l,y))) =e= UseByTechnologyAnnual(y,t,f,r);
UseByTechnologyAnnual.fx(y,t,f,r)$(sum(m, InputActivityRatio(r,t,f,m,y)) = 0 or AvailabilityFactor(r,t,y) = 0 or TotalAnnualMaxCapacity(r,t,y) = 0 or TotalTechnologyModelPeriodActivityUpperLimit(r,t) = 0 or TotalCapacityAnnual.up(y,t,r) = 0) = 0;

equation RE6_RETargetPath(YEAR_FULL,REGION_FULL,FUEL);
RE6_RETargetPath(y,r,f)$(YearVal(y)>%year% and SpecifiedAnnualDemand(r,f,y)).. TotalREProductionAnnual(y,r,f) =g= TotalREProductionAnnual(y-1,r,f)*((SpecifiedAnnualDemand(r,f,y)/SpecifiedAnnualDemand(r,f,y-1)));

*
* ################ Emissions Accounting ##############
*
equation E1_AnnualEmissionProductionByMode(YEAR_FULL,TECHNOLOGY,EMISSION,MODE_OF_OPERATION,REGION_FULL);
E1_AnnualEmissionProductionByMode(y,t,e,m,r)$(CanBuildTechnology(y,t,r) > 0).. EmissionActivityRatio(r,t,e,m,y)*sum(f,(TotalAnnualTechnologyActivityByMode(y,t,m,r)*EmissionContentPerFuel(f,e)*InputActivityRatio(r,t,f,m,y))) =e= AnnualTechnologyEmissionByMode(y,t,e,m,r);
AnnualTechnologyEmissionByMode.fx(y,t,e,m,r)$(CanBuildTechnology(y,t,r) = 0) = 0;

equation E2_AnnualEmissionProduction(YEAR_FULL,TECHNOLOGY,EMISSION,REGION_FULL);
E2_AnnualEmissionProduction(y,t,e,r).. sum(m, AnnualTechnologyEmissionByMode(y,t,e,m,r)) =e= AnnualTechnologyEmission(y,t,e,r);

equation E3_EmissionsPenaltyByTechAndEmission(YEAR_FULL,TECHNOLOGY,EMISSION,REGION_FULL);
E3_EmissionsPenaltyByTechAndEmission(y,t,e,r).. (AnnualTechnologyEmission(y,t,e,r)*EmissionsPenalty(r,e,y)*EmissionsPenaltyTagTechnology(r,t,e,y))*YearlyDifferenceMultiplier(y) =e= AnnualTechnologyEmissionPenaltyByEmission(y,t,e,r);
equation E4_EmissionsPenaltyByTechnology(YEAR_FULL,TECHNOLOGY,REGION_FULL);
E4_EmissionsPenaltyByTechnology(y,t,r).. sum(e, AnnualTechnologyEmissionPenaltyByEmission(y,t,e,r)) =e= AnnualTechnologyEmissionsPenalty(y,t,r);
equation E5_DiscountedEmissionsPenaltyByTechnology(YEAR_FULL,TECHNOLOGY,REGION_FULL);
E5_DiscountedEmissionsPenaltyByTechnology(y,t,r).. AnnualTechnologyEmissionsPenalty(y,t,r)/((1+SocialDiscountRate(r))**(YearVal(y)-smin(yy, YearVal(yy))+0.5)) =e= DiscountedTechnologyEmissionsPenalty(y,t,r);
equation E6_EmissionsAccounting1(YEAR_FULL,EMISSION,REGION_FULL);
E6_EmissionsAccounting1(y,e,r).. sum(t, AnnualTechnologyEmission(y,t,e,r)) =e= AnnualEmissions(y,e,r);


equation E8_RegionalAnnualEmissionsLimit(YEAR_FULL,EMISSION,REGION_FULL);
E8_RegionalAnnualEmissionsLimit(y,e,r).. AnnualEmissions(y,e,r)+AnnualExogenousEmission(r,e,y) =l= RegionalAnnualEmissionLimit(r,e,y);
equation E9_AnnualEmissionsLimit(YEAR_FULL,EMISSION);
E9_AnnualEmissionsLimit(y,e).. sum(r,AnnualEmissions(y,e,r)+AnnualExogenousEmission(r,e,y)) =l= AnnualEmissionLimit(e,y);
equation E10_ModelPeriodEmissionsLimit(EMISSION);
E10_ModelPeriodEmissionsLimit(e).. sum(r,ModelPeriodEmissions(e,r)) =l= ModelPeriodEmissionLimit(e);
equation E11_RegionalModelPeriodEmissionsLimit(EMISSION,REGION_FULL);
E11_RegionalModelPeriodEmissionsLimit(e,r)$(RegionalModelPeriodEmissionLimit(e,r) < 999999).. ModelPeriodEmissions(e,r) =l= RegionalModelPeriodEmissionLimit(e,r);

equation E7_EmissionsAccounting2(EMISSION,REGION_FULL);
$ifthen %switch_weighted_emissions% == 1
E7_EmissionsAccounting2(e,r)..
  sum(y$(YearVal(y+1)-YearVal(y) > 0), WeightedAnnualEmissions(y,e,r)*(YearVal(y+1)-YearVal(y)))
+ sum(y$(YearVal(y)=smax(yy,YearVal(yy))),  WeightedAnnualEmissions(y,e,r))
=e= ModelPeriodEmissions(e,r)- ModelPeriodExogenousEmission(r,e);
equation E12a_WeightedEmissions(year_full,EMISSION,REGION_FULL);
E12a_WeightedEmissions(y,e,r)$(YearVal(y)<smax(yy,YearVal(yy))).. (AnnualEmissions(y,e,r)+AnnualEmissions(y+1,e,r))/2 =e= WeightedAnnualEmissions(y,e,r);
equation E12b_WeightedLastYearEmissions(year_full,EMISSION,REGION_FULL);
E12b_WeightedLastYearEmissions(y,e,r)$(YearVal(y)=smax(yy,YearVal(yy))).. AnnualEmissions(y,e,r) =e= WeightedAnnualEmissions(y,e,r);

$else
E7_EmissionsAccounting2(e,r)..
sum(y$(YearVal(y+1)-YearVal(y) > 0), AnnualEmissions(y,e,r)*(YearVal(y+1)-YearVal(y)))
+ sum(y$(YearVal(y)=smax(yy,YearVal(yy))),  AnnualEmissions(y,e,r))
=e= ModelPeriodEmissions(e,r)- ModelPeriodExogenousEmission(r,e);

$endif

*
* ################ Sectoral Emissions Accounting ##############
*

equation ES1_AnnualSectorEmissions(YEAR_FULL,EMISSION,SECTOR,REGION_FULL);
ES1_AnnualSectorEmissions(y,e,se,r).. sum(t$(TagTechnologyToSector(t,se) <> 0), AnnualTechnologyEmission(y,t,e,r)) =e= AnnualSectoralEmissions(y,e,se,r);

equation ES2_AnnualSectorEmissionsLimit(YEAR_FULL,EMISSION,SECTOR);
ES2_AnnualSectorEmissionsLimit(y,e,se).. sum(r, AnnualSectoralEmissions(y,e,se,r)) =l= AnnualSectoralEmissionLimit(e,se,y);

*
* ######### Short-Term Storage Constraints #############
*


$ifthen %switch_short_term_storage% == 1

equation S1a_StorageLevelYearStart(STORAGE, REGION_FULL, YEAR_FULL);
S1a_StorageLevelYearStart(s,r,y).. StorageLevelYearStart(s,y,r) =l=  StorageLevelYearStartUpperLimit *
((sum((yy,t)$(OperationalLifeStorage(r,s,yy) >= Yearval(y)-Yearval(yy) and Yearval(y)-Yearval(yy) >= 0 and TechnologyToStorage(y,'1',t,s)), NewCapacity(yy,t,r)*StorageMaxChargeRate(r,s))) + sum(t$TechnologyToStorage(y,'1',t,s),ResidualCapacity(r,t,y)*StorageMaxChargeRate(r,s)));

equation S1b_StorageLevelYearStart(STORAGE, REGION_FULL, YEAR_FULL);
S1b_StorageLevelYearStart(s,r,y).. StorageLevelYearStart(s,y,r) =g=  StorageLevelYearStartLowerLimit *
((sum((yy,t)$(OperationalLifeStorage(r,s,yy) >= Yearval(y)-Yearval(yy) and Yearval(y)-Yearval(yy) >= 0 and TechnologyToStorage(y,'1',t,s)), NewCapacity(yy,t,r)*StorageMaxChargeRate(r,s))) + sum(t$TechnologyToStorage(y,'1',t,s),ResidualCapacity(r,t,y)*StorageMaxChargeRate(r,s)));

equation S2_StorageLevelTSStart(REGION_FULL, STORAGE, YEAR_FULL, TIMESLICE_FULL);
S2_StorageLevelTSStart(r,s,y, l)..  (StorageLevelTSStart(s,y,l-1,r) +
      (sum((t,m)$(TechnologyToStorage(y,m,t,s)>0), RateOfActivity(y,l-1,t,m,r) * TechnologyToStorage(y,m,t,s))
     - sum((t,m)$(TechnologyFromStorage(y,m,t,s)>0), RateOfActivity(y,l-1,t,m,r) / TechnologyFromStorage(y,m,t,s))) * YearSplit(l-1,y))$(ord(l) > 1)
     + (StorageLevelYearStart(s,y,r))$(ord(l) = 1)
=e= StorageLevelTSStart(s,y,l,r);

equation S3_StorageRefilling(REGION_FULL, STORAGE, YEAR_FULL);
S3_StorageRefilling(r,s,y)..
sum((l), (sum((t,m)$(TechnologyToStorage(y,m,t,s)>0), RateOfActivity(y,l,t,m,r) * TechnologyToStorage(y,m,t,s))
          - sum((t,m)$(TechnologyFromStorage(y,m,t,s)>0), RateOfActivity(y,l,t,m,r) / TechnologyFromStorage(y,m,t,s)))) =e= 0;

equation S7_StorageLevelYearFinish(STORAGE,YEAR_FULL,REGION_FULL);
S7_StorageLevelYearFinish(s,y,r).. StorageLevelYearStart(s,y,r) =e=  StorageLevelYearFinish(s,y,r);

equation SC1_LowerLimit(STORAGE,YEAR_FULL,TIMESLICE_FULL,REGION_FULL);
SC1_LowerLimit(s,y,l,r)$(MinStorageCharge(r,s,y) > 0)..
MinStorageCharge(r,s,y)*sum(yy$(yearval(y)-yearval(yy) < OperationalLifeStorage(r,s,yy) and yearval(y)-yearval(yy) >= 0), NewStorageCapacity(s,y,r) + ResidualStorageCapacity(r,s,y))
=l= StorageLevelTSStart(s,y,l,r);

equation SC2_UpperLimit(STORAGE,YEAR_FULL,TIMESLICE_FULL,REGION_FULL);
SC2_UpperLimit(s,y,l,r)..
sum(yy$(yearval(y)-yearval(yy) < OperationalLifeStorage(r,s,yy) and yearval(y)-yearval(yy) >= 0), NewStorageCapacity(s,y,r) + ResidualStorageCapacity(r,s,y))
=g= StorageLevelTSStart(s,y,l,r);

equation SC9d_StorageActivityLimit(STORAGE,TECHNOLOGY,YEAR_FULL,TIMESLICE_FULL,REGION_FULL,MODE_OF_OPERATION);
SC9d_StorageActivityLimit(s,t,y,l,r,m)$(TechnologyFromStorage(y,m,t,s)>0)..
RateOfActivity(y,l,t,m,r)/TechnologyFromStorage(y,m,t,s)*YearSplit(l,y) =l= StorageLevelTSStart(s,y,l,r);

equation SI4_UndiscountedCapitalInvestmentStorage(STORAGE,YEAR_FULL,REGION_FULL);
SI4_UndiscountedCapitalInvestmentStorage(s,y,r).. CapitalCostStorage(r,s,y) * NewStorageCapacity(s,y,r) =e= CapitalInvestmentStorage(s,y,r);
equation SI5_DiscountingCapitalInvestmentStorage(STORAGE,YEAR_FULL,REGION_FULL);
SI5_DiscountingCapitalInvestmentStorage(s,y,r)..  CapitalInvestmentStorage(s,y,r)/((1+GeneralDiscountRate(r))**(YearVal(y)-smin(yy, YearVal(yy))+0.5)) =e= DiscountedCapitalInvestmentStorage(s,y,r);
equation SI6_SalvageValueStorageAtEndOfPeriod1(STORAGE,YEAR_FULL,REGION_FULL);
SI6_SalvageValueStorageAtEndOfPeriod1(s,y,r)$((yearval(y)+OperationalLifeStorage(r,s,y)-1) le sum(yy_full$(ord(yy_full)=card(yy_full)),yearval(yy_full)) )..    0 =e= SalvageValueStorage(s,y,r);
equation SI7_SalvageValueStorageAtEndOfPeriod2(STORAGE,YEAR_FULL,REGION_FULL);
SI7_SalvageValueStorageAtEndOfPeriod2(s,y,r)$((DepreciationMethod(r)=1 and (yearval(y)+OperationalLifeStorage(r,s,y)-1) > sum(yy_full$(ord(yy_full)=card(yy_full)),yearval(yy_full)) and GeneralDiscountRate(r)=0) or (DepreciationMethod(r)=2 and (yearval(y)+OperationalLifeStorage(r,s,y)-1) > sum(yy_full$(ord(yy_full)=card(yy_full)),yearval(yy_full)) and GeneralDiscountRate(r)=0)).. CapitalInvestmentStorage(s,y,r)*(1- sum(yy_full$(ord(yy_full)=card(yy_full)),yearval(yy_full))  - yearval(y)+1)/OperationalLifeStorage(r,s,y) =e= SalvageValueStorage(s,y,r);
equation SI8_SalvageValueStorageAtEndOfPeriod3(STORAGE,YEAR_FULL,REGION_FULL);
SI8_SalvageValueStorageAtEndOfPeriod3(s,y,r)$(DepreciationMethod(r)=1 and ((yearval(y)+OperationalLifeStorage(r,s,y)-1) > sum(yy_full$(ord(yy_full)=card(yy_full)),yearval(yy_full)) and GeneralDiscountRate(r)>0)).. CapitalInvestmentStorage(s,y,r)*(1-(((1+GeneralDiscountRate(r))**(sum(yy_full$(ord(yy_full)=card(yy_full)),yearval(yy_full)) - yearval(y)+1)-1)/((1+GeneralDiscountRate(r))**OperationalLifeStorage(r,s,y)-1))) =e= SalvageValueStorage(s,y,r);
equation SI9_SalvageValueStorageDiscountedToStartYear(STORAGE,YEAR_FULL,REGION_FULL);
SI9_SalvageValueStorageDiscountedToStartYear(s,y,r).. SalvageValueStorage(s,y,r)/((1+GeneralDiscountRate(r))**(1+smax(yy, YearVal(yy)) - smin(yy, YearVal(yy)))) =e= DiscountedSalvageValueStorage(s,y,r);
equation SI10_TotalDiscountedCostByStorage(STORAGE,YEAR_FULL,REGION_FULL);
SI10_TotalDiscountedCostByStorage(s,y,r).. DiscountedCapitalInvestmentStorage(s,y,r)-DiscountedSalvageValueStorage(s,y,r) =e= TotalDiscountedStorageCost(s,y,r);


$else

positive variable  NumberOfStorageUnits(REGION_FULL,YEAR_FULL,STORAGE);
*
* ######### Storage Constraints #############
*
equation SC1_LowerLimit(STORAGE,YEAR_FULL,SEASON,DAYTYPE,DAILYTIMEBRACKET,REGION_FULL);
SC1_LowerLimit(s,y,ls,ld,lh,r).. 0 =l= (StorageLevelDayTypeStart(s,y,ls,ld,r)+sum(lhlh$(ord(lh)-ord(lhlh) > 0),NetChargeWithinDay(s,y,ls,ld,lhlh,r)))-StorageLowerLimit(s,y,r);
equation SC1_UpperLimit(STORAGE,YEAR_FULL,SEASON,DAYTYPE,DAILYTIMEBRACKET,REGION_FULL);
SC1_UpperLimit(s,y,ls,ld,lh,r).. (StorageLevelDayTypeStart(s,y,ls,ld,r)+sum(lhlh$(ord(lh)-ord(lhlh) > 0),NetChargeWithinDay(s,y,ls,ld,lhlh,r)))-StorageUpperLimit(s,y,r) =l= 0;
equation SC2_LowerLimit(STORAGE,YEAR_FULL,SEASON,DAYTYPE,DAILYTIMEBRACKET,REGION_FULL);
SC2_LowerLimit(s,y,ls,ld,lh,r).. 0 =l= (StorageLevelDayTypeStart(s,y,ls,ld,r)-sum(lhlh$(ord(lh)-ord(lhlh) < 0), NetChargeWithinDay(s,y,ls,ld-1,lhlh,r) ))$(ord(ld) > 1)-StorageLowerLimit(s,y,r);
equation SC2_UpperLimit(STORAGE,YEAR_FULL,SEASON,DAYTYPE,DAILYTIMEBRACKET,REGION_FULL);
SC2_UpperLimit(s,y,ls,ld,lh,r).. (StorageLevelDayTypeStart(s,y,ls,ld,r)-sum(lhlh$(ord(lh)-ord(lhlh) < 0), NetChargeWithinDay(s,y,ls,ld-1,lhlh,r) ))$(ord(ld) > 1) -StorageUpperLimit(s,y,r) =l= 0;
equation SC3_LowerLimit(STORAGE,YEAR_FULL,SEASON,DAYTYPE,DAILYTIMEBRACKET,REGION_FULL);
SC3_LowerLimit(s,y,ls,ld,lh,r)..  0 =l= (StorageLevelDayTypeFinish(s,y,ls,ld,r) - sum(lhlh$(ord(lh)-ord(lhlh) <0), NetChargeWithinDay(s,y,ls,ld,lhlh,r)))-StorageLowerLimit(s,y,r);
equation SC3_UpperLimit(STORAGE,YEAR_FULL,SEASON,DAYTYPE,DAILYTIMEBRACKET,REGION_FULL);
SC3_UpperLimit(s,y,ls,ld,lh,r).. (StorageLevelDayTypeFinish(s,y,ls,ld,r) - sum(lhlh$(ord(lh)-ord(lhlh) <0), NetChargeWithinDay(s,y,ls,ld,lhlh,r)) )-StorageUpperLimit(s,y,r) =l= 0;
equation SC4_LowerLimit(STORAGE,YEAR_FULL,SEASON,DAYTYPE,DAILYTIMEBRACKET,REGION_FULL);
SC4_LowerLimit(s,y,ls,ld,lh,r).. 0 =L= (StorageLevelDayTypeFinish(s,y,ls,ld-1,r)+sum(lhlh$(ord(lh)-ord(lhlh) >0), NetChargeWithinDay(s,y,ls,ld,lhlh,r) ))$(ord(ld) > 1) -StorageLowerLimit(s,y,r);
equation SC4_UpperLimit(STORAGE,YEAR_FULL,SEASON,DAYTYPE,DAILYTIMEBRACKET,REGION_FULL);
SC4_UpperLimit(s,y,ls,ld,lh,r).. (StorageLevelDayTypeFinish(s,y,ls,ld-1,r)+sum(lhlh$(ord(lh)-ord(lhlh) >0), NetChargeWithinDay(s,y,ls,ld,lhlh,r) ))$(ord(ld) > 1) -StorageUpperLimit(s,y,r) =l= 0;
equation SC5_MaxChargeConstraint(STORAGE,YEAR_FULL,SEASON,DAYTYPE,DAILYTIMEBRACKET,REGION_FULL);
SC5_MaxChargeConstraint(s,y,ls,ld,lh,r).. RateOfStorageCharge(s,y,ls,ld,lh,r) =l= StorageMaxChargeRate(r,s)*StorageUpperLimit(s,y,r);
equation SC6_MaxDischargeConstraint(STORAGE,YEAR_FULL,SEASON,DAYTYPE,DAILYTIMEBRACKET,REGION_FULL);
SC6_MaxDischargeConstraint(s,y,ls,ld,lh,r).. RateOfStorageDischarge(s,y,ls,ld,lh,r) =l= StorageMaxDischargeRate(r,s)*StorageUpperLimit(s,y,r);

*
* ######### Storage Investments #############
*
equation SI1_StorageUpperLimit(STORAGE,YEAR_FULL,REGION_FULL);
SI1_StorageUpperLimit(s,y,r).. AccumulatedNewStorageCapacity(s,y,r)+ResidualStorageCapacity(r,s,y) =e= StorageUpperLimit(s,y,r);
equation SI2_StorageLowerLimit(STORAGE,YEAR_FULL,REGION_FULL);
SI2_StorageLowerLimit(s,y,r).. MinStorageCharge(r,s,y)*StorageUpperLimit(s,y,r) =e= StorageLowerLimit(s,y,r);
equation SI3_TotalNewStorage(STORAGE,YEAR_FULL,REGION_FULL);
SI3_TotalNewStorage(s,y,r)..  sum(yy$(yearval(y)-yearval(yy) < OperationalLifeStorage(r,s,yy) and yearval(y)-yearval(yy) >= 0), NewStorageCapacity(s,yy,r) ) =e= AccumulatedNewStorageCapacity(s,y,r);
equation SI4_UndiscountedCapitalInvestmentStorage(STORAGE,YEAR_FULL,REGION_FULL);
SI4_UndiscountedCapitalInvestmentStorage(s,y,r).. CapitalCostStorage(r,s,y) * NewStorageCapacity(s,y,r) =e= CapitalInvestmentStorage(s,y,r);
equation SI5_DiscountingCapitalInvestmentStorage(STORAGE,YEAR_FULL,REGION_FULL);
SI5_DiscountingCapitalInvestmentStorage(s,y,r)..  CapitalInvestmentStorage(s,y,r)/((1+GeneralDiscountRate(r))**(YearVal(y)-smin(yy, YearVal(yy))+0.5)) =e= DiscountedCapitalInvestmentStorage(s,y,r);
equation SI6_SalvageValueStorageAtEndOfPeriod1(STORAGE,YEAR_FULL,REGION_FULL);
SI6_SalvageValueStorageAtEndOfPeriod1(s,y,r)$((yearval(y)+OperationalLifeStorage(r,s,y)-1) le sum(yy_full$(ord(yy_full)=card(yy_full)),yearval(yy_full)) )..    0 =e= SalvageValueStorage(s,y,r);
equation SI7_SalvageValueStorageAtEndOfPeriod2(STORAGE,YEAR_FULL,REGION_FULL);
SI7_SalvageValueStorageAtEndOfPeriod2(s,y,r)$((DepreciationMethod(r)=1 and (yearval(y)+OperationalLifeStorage(r,s,y)-1) > sum(yy_full$(ord(yy_full)=card(yy_full)),yearval(yy_full)) and GeneralDiscountRate(r)=0) or (DepreciationMethod(r)=2 and (yearval(y)+OperationalLifeStorage(r,s,y)-1) > sum(yy_full$(ord(yy_full)=card(yy_full)),yearval(yy_full)) and GeneralDiscountRate(r)=0)).. CapitalInvestmentStorage(s,y,r)*(1- sum(yy_full$(ord(yy_full)=card(yy_full)),yearval(yy_full))  - yearval(y)+1)/OperationalLifeStorage(r,s,y) =e= SalvageValueStorage(s,y,r);
equation SI8_SalvageValueStorageAtEndOfPeriod3(STORAGE,YEAR_FULL,REGION_FULL);
SI8_SalvageValueStorageAtEndOfPeriod3(s,y,r)$(DepreciationMethod(r)=1 and ((yearval(y)+OperationalLifeStorage(r,s,y)-1) > sum(yy_full$(ord(yy_full)=card(yy_full)),yearval(yy_full)) and GeneralDiscountRate(r)>0)).. CapitalInvestmentStorage(s,y,r)*(1-(((1+GeneralDiscountRate(r))**(sum(yy_full$(ord(yy_full)=card(yy_full)),yearval(yy_full)) - yearval(y)+1)-1)/((1+GeneralDiscountRate(r))**OperationalLifeStorage(r,s,y)-1))) =e= SalvageValueStorage(s,y,r);
equation SI9_SalvageValueStorageDiscountedToStartYear(STORAGE,YEAR_FULL,REGION_FULL);
SI9_SalvageValueStorageDiscountedToStartYear(s,y,r).. SalvageValueStorage(s,y,r)/((1+GeneralDiscountRate(r))**(1+smax(yy, YearVal(yy)) - smin(yy, YearVal(yy)))) =e= DiscountedSalvageValueStorage(s,y,r);
equation SI10_TotalDiscountedCostByStorage(STORAGE,YEAR_FULL,REGION_FULL);
SI10_TotalDiscountedCostByStorage(s,y,r).. DiscountedCapitalInvestmentStorage(s,y,r)-DiscountedSalvageValueStorage(s,y,r) =e= TotalDiscountedStorageCost(s,y,r);

*
* ######### Storage Equations #############
*
StorageLevelYearStart.fx(s,y,r)$(ord(y) = 1) = StorageLevelStart(r,s);

equation S1_RateOfStorageCharge(STORAGE,YEAR_FULL,SEASON,DAYTYPE,DAILYTIMEBRACKET,REGION_FULL);
S1_RateOfStorageCharge(s,y,ls,ld,lh,r)..  sum((t, m, l)$(TechnologyToStorage(y,m,t,s)>0), RateOfActivity(y,l,t,m,r) * TechnologyToStorage(y,m,t,s) * Conversionls(l,ls) * Conversionld(l,ld) * Conversionlh(l,lh)) =e= RateOfStorageCharge(s,y,ls,ld,lh,r);
equation S2_RateOfStorageDischarge(STORAGE,YEAR_FULL,SEASON,DAYTYPE,DAILYTIMEBRACKET,REGION_FULL);
S2_RateOfStorageDischarge(s,y,ls,ld,lh,r)..  sum((t, m, l)$(TechnologyFromStorage(y,m,t,s)>0),RateOfActivity(y,l,t,m,r) * TechnologyFromStorage(y,m,t,s) * Conversionls(l,ls) * Conversionld(l,ld) * Conversionlh(l,lh)) =e= RateOfStorageDischarge(s,y,ls,ld,lh,r);
equation S3_NetChargeWithinYear(STORAGE,YEAR_FULL,SEASON,DAYTYPE,DAILYTIMEBRACKET,REGION_FULL);
S3_NetChargeWithinYear(s,y,ls,ld,lh,r).. sum(l$(Conversionls(l,ls)>0 AND Conversionld(l,ld)>0 AND Conversionlh(l,lh)>0),  (RateOfStorageCharge(s,y,ls,ld,lh,r) - RateOfStorageDischarge(s,y,ls,ld,lh,r)) * YearSplit(l,y) * Conversionls(l,ls) * Conversionld(l,ld) * Conversionlh(l,lh)) =e= NetChargeWithinYear(s,y,ls,ld,lh,r);
equation S4_NetChargeWithinDay(STORAGE,YEAR_FULL,SEASON,DAYTYPE,DAILYTIMEBRACKET,REGION_FULL);
S4_NetChargeWithinDay(s,y,ls,ld,lh,r).. (RateOfStorageCharge(s,y,ls,ld,lh,r) - RateOfStorageDischarge(s,y,ls,ld,lh,r)) * sum(l, DaySplit(y,l) * Conversionls(l,ls) * Conversionld(l,ld) * Conversionlh(l,lh)) =e= NetChargeWithinDay(s,y,ls,ld,lh,r);
equation S5_StorageLeveYearStart(STORAGE,YEAR_FULL,REGION_FULL);
S5_StorageLeveYearStart(s,y,r)$(ord(y) > 1).. StorageLevelYearStart(s,y-1,r) + sum((ls,ld,lh), NetChargeWithinYear(s,y-1,ls,ld,lh,r)) =E= StorageLevelYearStart(s,y,r);
equation S7_StorageLevelYearFinish(STORAGE,YEAR_FULL,REGION_FULL);
S7_StorageLevelYearFinish(s,y,r)$(ord(y) < card(y)).. StorageLevelYearStart(s,y+1,r) =e=  StorageLevelYearFinish(s,y,r);
equation S8_StorageLevelYearFinish(STORAGE,YEAR_FULL,REGION_FULL);
S8_StorageLevelYearFinish(s,y,r)$(ord(y) = card(y)).. StorageLevelYearStart(s,y,r) + sum((ls , ld , lh), NetChargeWithinYear(s,y,ls,ld,lh,r)) =e= StorageLevelYearFinish(s,y,r);
equation S9_StorageLevelSeasonStart(STORAGE,YEAR_FULL,SEASON,REGION_FULL);
S9_StorageLevelSeasonStart(s,y,ls,r)$(ord(ls) = 1)..  StorageLevelSeasonStart(s,y,ls,r) =e= StorageLevelYearStart(s,y,r);
equation S10_StorageLevelSeasonStart(STORAGE,YEAR_FULL,SEASON,REGION_FULL);
S10_StorageLevelSeasonStart(s,y,ls,r)$(ord(ls) > 1)..  StorageLevelSeasonStart(s,y,ls,r) =e= StorageLevelSeasonStart(s,y,ls-1,r) + sum((ld,lh), NetChargeWithinYear(s,y,ls-1,ld,lh,r)) ;
equation S11_StorageLevelDayTypeStart(STORAGE,YEAR_FULL,SEASON,DAYTYPE,REGION_FULL);
S11_StorageLevelDayTypeStart(s,y,ls,ld,r)$(ord(ld) = 1).. StorageLevelSeasonStart(s,y,ls,r) =e=  StorageLevelDayTypeStart(s,y,ls,ld,r);
equation S12_StorageLevelDayTypeStart(STORAGE,YEAR_FULL,SEASON,DAYTYPE,REGION_FULL);
S12_StorageLevelDayTypeStart(s,y,ls,ld,r)$(ord(ld) > 1).. StorageLevelDayTypeStart(s,y,ls,ld-1,r) + sum(lh, NetChargeWithinDay(s,y,ls,ld-1,lh,r) * DaysInDayType(y,ls,ld-1) )  =e=  StorageLevelDayTypeStart(s,y,ls,ld,r);
equation S13_StorageLevelDayTypeFinish(STORAGE,YEAR_FULL,SEASON,DAYTYPE,REGION_FULL);
S13_StorageLevelDayTypeFinish(s,y,ls,ld,r)$(ord(ls)=card(ls) and ord(ld)=card(ld))..  StorageLevelYearFinish(s,y,r) =e= StorageLevelDayTypeFinish(s,y,ls,ld,r);
equation S14_StorageLevelDayTypeFinish(STORAGE,YEAR_FULL,SEASON,DAYTYPE,REGION_FULL);
S14_StorageLevelDayTypeFinish(s,y,ls,ld,r)$(ord(ld)=card(ld) and not ord(ls)=card(ls))..  StorageLevelSeasonStart(s,y,ls+1,r) =e= StorageLevelDayTypeFinish(s,y,ls,ld,r);
equation S15_StorageLevelDayTypeFinish(STORAGE,YEAR_FULL,SEASON,DAYTYPE,REGION_FULL);
S15_StorageLevelDayTypeFinish(s,y,ls,ld,r)$(not ord(ld)=card(ld) and not ord(ls)=card(ls)).. StorageLevelDayTypeFinish(s,y,ls,ld+1,r) - sum(lh,  NetChargeWithinDay(s,y,ls,ld+1,lh,r)  * DaysInDayType(y,ls,ld+1) ) =e= StorageLevelDayTypeFinish(s,y,ls,ld,r);

$endif
*$ontext
*
* ######### Transportation Equations #############
*
equation T1a_SpecifiedAnnualDemandByModalSplit(MODALTYPE,TIMESLICE_FULL,REGION_FULL,FUEL,YEAR_FULL);
T1a_SpecifiedAnnualDemandByModalSplit(mt,l,r,TransportFuels,y)$(SpecifiedAnnualDemand(r,TransportFuels,y) <> 0)..  SpecifiedAnnualDemand(r,TransportFuels,y)*ModalSplitByFuelAndModalType(r,TransportFuels,y,mt)*SpecifiedDemandProfile(r,TransportFuels,l,y) =e= DemandSplitByModalType(mt,l,r,TransportFuels,y);

equation T2_ProductionOfTechnologyByModalSplit(MODALTYPE,TIMESLICE_FULL,REGION_FULL,FUEL,YEAR_FULL);
T2_ProductionOfTechnologyByModalSplit(mt,l,r,TransportFuels,y)$(sum((t,m),TagTechnologyToModalType(t,m,mt)) <> 0)..  sum((t,m)$(OutputActivityRatio(r,t,TransportFuels,m,y) <> 0),TagTechnologyToModalType(t,m,mt)*RateOfActivity(y,l,t,m,r)*OutputActivityRatio(r,t,TransportFuels,m,y)*YearSplit(l,y)) =e= ProductionSplitByModalType(mt,l,r,TransportFuels,y);

equation T3_ModalSplitBalance(MODALTYPE,TIMESLICE_FULL,REGION_FULL,FUEL,YEAR_FULL);
T3_ModalSplitBalance(mt,l,r,TransportFuels,y)$(sum((t,m),TagTechnologyToModalType(t,m,mt)) <> 0).. ProductionSplitByModalType(mt,l,r,TransportFuels,y) =g= DemandSplitByModalType(mt,l,r,TransportFuels,y);

ProductionSplitByModalType.fx('MT_FRT_SHIP_RE',l,r,'Mobility_Passenger',y) = 0;
ProductionSplitByModalType.fx('MT_FRT_ROAD_RE',l,r,'Mobility_Passenger',y) = 0;
ProductionSplitByModalType.fx('MT_FRT_RAIL_RE',l,r,'Mobility_Passenger',y) = 0;
ProductionSplitByModalType.fx('MT_FRT_SHIP_CONV',l,r,'Mobility_Passenger',y) = 0;
ProductionSplitByModalType.fx('MT_FRT_ROAD_CONV',l,r,'Mobility_Passenger',y) = 0;
ProductionSplitByModalType.fx('MT_FRT_RAIL_CONV',l,r,'Mobility_Passenger',y) = 0;

ProductionSplitByModalType.fx('MT_PSNG_AIR_RE',l,r,'Mobility_Freight',y) = 0;
ProductionSplitByModalType.fx('MT_PSNG_ROAD_RE',l,r,'Mobility_Freight',y) = 0;
ProductionSplitByModalType.fx('MT_PSNG_RAIL_RE',l,r,'Mobility_Freight',y) = 0;
ProductionSplitByModalType.fx('MT_PSNG_AIR_CONV',l,r,'Mobility_Freight',y) = 0;
ProductionSplitByModalType.fx('MT_PSNG_ROAD_CONV',l,r,'Mobility_Freight',y) = 0;
ProductionSplitByModalType.fx('MT_PSNG_RAIL_CONV',l,r,'Mobility_Freight',y) = 0;
*$offtext

$ifthen %switch_ramping% == 1
*
* ##############* Ramping #############
*
equation R1_ProductionChange(YEAR_FULL,TIMESLICE_FULL,FUEL,TECHNOLOGY,REGION_FULL);
R1_ProductionChange(y,l,f,t,r)$(ord(l) > 1 and TagDispatchableTechnology(t)=1 and (RampingUpFactor(r,t,y) <> 0 or RampingDownFactor(r,t,y) <> 0 and AvailabilityFactor(r,t,y) > 0 and TotalAnnualMaxCapacity(r,t,y) > 0 and TotalTechnologyModelPeriodActivityUpperLimit(r,t) > 0)).. ((sum(m$(OutputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity(y,l,t,m,r)*OutputActivityRatio(r,t,f,m,y))*YearSplit(l,y)) - (RateOfProductionByTechnology(y,l-1,t,f,r)*YearSplit(l-1,y))) =e= ProductionUpChangeInTimeslice(y,l,f,t,r) - ProductionDownChangeInTimeslice(y,l,f,t,r);
equation R2_RampingUpLimit(YEAR_FULL,TIMESLICE_FULL,FUEL,TECHNOLOGY,REGION_FULL);
R2_RampingUpLimit(y,l,f,t,r)$(ord(l) > 1 and TagDispatchableTechnology(t)=1 and RampingUpFactor(r,t,y) <> 0 and AvailabilityFactor(r,t,y) > 0 and TotalAnnualMaxCapacity(r,t,y) > 0 and TotalTechnologyModelPeriodActivityUpperLimit(r,t) > 0).. ProductionUpChangeInTimeslice(y,l,f,t,r) =l= TotalCapacityAnnual(y,t,r)*AvailabilityFactor(r,t,y)*CapacityToActivityUnit(r,t)*RampingUpFactor(r,t,y)*YearSplit(l,y);
equation R3_RampingDownLimit(YEAR_FULL,TIMESLICE_FULL,FUEL,TECHNOLOGY,REGION_FULL);
R3_RampingDownLimit(y,l,f,t,r)$(ord(l) > 1 and TagDispatchableTechnology(t)=1 and RampingDownFactor(r,t,y) <> 0 and AvailabilityFactor(r,t,y) > 0 and TotalAnnualMaxCapacity(r,t,y) > 0 and TotalTechnologyModelPeriodActivityUpperLimit(r,t) > 0).. ProductionDownChangeInTimeslice(y,l,f,t,r) =l= TotalCapacityAnnual(y,t,r)*AvailabilityFactor(r,t,y)*CapacityToActivityUnit(r,t)*RampingDownFactor(r,t,y)*YearSplit(l,y);

*
* ##############* Ramping Costs #############
*
equation RC1_AnnualProductionChangeCosts(YEAR_FULL,FUEL,TECHNOLOGY,REGION_FULL);
RC1_AnnualProductionChangeCosts(y,f,t,r)$(TagDispatchableTechnology(t)=1 and ProductionChangeCost(r,t,y) <> 0 and AvailabilityFactor(r,t,y) > 0 and TotalAnnualMaxCapacity(r,t,y) > 0 and TotalTechnologyModelPeriodActivityUpperLimit(r,t) > 0).. sum(l,(ProductionUpChangeInTimeslice(y,l,f,t,r) + ProductionDownChangeInTimeslice(y,l,f,t,r))*ProductionChangeCost(r,t,y)) =e= AnnualProductionChangeCost(y,t,r);
equation RC2_DiscountedAnnualProductionChangeCost(YEAR_FULL,FUEL,TECHNOLOGY,REGION_FULL);
RC2_DiscountedAnnualProductionChangeCost(y,f,t,r)$(TagDispatchableTechnology(t)=1 and ProductionChangeCost(r,t,y) <> 0 and AvailabilityFactor(r,t,y) > 0 and TotalAnnualMaxCapacity(r,t,y) > 0 and TotalTechnologyModelPeriodActivityUpperLimit(r,t) > 0).. AnnualProductionChangeCost(y,t,r)/((1+TechnologyDiscountRate(r,t))**(YearVal(y)-smin(yy, YearVal(yy))+0.5)) =e= DiscountedAnnualProductionChangeCost(y,t,r);

DiscountedAnnualProductionChangeCost.fx(y,t,r)$(TagDispatchableTechnology(t) = 0 or sum((m,f), OutputActivityRatio(r,t,f,m,y)) = 0 or ProductionChangeCost(r,t,y) = 0 or AvailabilityFactor(r,t,y) = 0 or TotalAnnualMaxCapacity(r,t,y) = 0 or TotalTechnologyModelPeriodActivityUpperLimit(r,t) = 0) = 0;
AnnualProductionChangeCost.fx(y,t,r)$(TagDispatchableTechnology(t) = 0 or sum((m,f), OutputActivityRatio(r,t,f,m,y)) = 0 or ProductionChangeCost(r,t,y) = 0 or AvailabilityFactor(r,t,y) = 0 or TotalAnnualMaxCapacity(r,t,y) = 0 or TotalTechnologyModelPeriodActivityUpperLimit(r,t) = 0) = 0;

*
* ##############* Min Runing Constraint #############
*
equation MRC1_MinRunningConstraint(YEAR_FULL,TIMESLICE_FULL,FUEL,TECHNOLOGY,REGION_FULL);
MRC1_MinRunningConstraint(y,l,f,t,r)$(MinActiveProductionPerTimeslice(y,l,f,t,r) > 0).. sum(m$(OutputActivityRatio(r,t,f,m,y) <> 0), RateOfActivity(y,l,t,m,r)*OutputActivityRatio(r,t,f,m,y)) =g= TotalCapacityAnnual(y,t,r)*AvailabilityFactor(r,t,y)*CapacityToActivityUnit(r,t)*MinActiveProductionPerTimeslice(y,l,f,t,r);

$endif


*
* ##############* Curtailment Costs #############
*

equation CC1_AnnualCurtailmentCosts(YEAR_FULL,FUEL,REGION_FULL);
CC1_AnnualCurtailmentCosts(y,f,r).. sum((l),Curtailment(y,l,f,r)*CurtailmentCostFactor(r,f,y)) =e= AnnualCurtailmentCost(y,f,r);
equation CC2_DiscountedAnnualCurtailmentCosts(YEAR_FULL,FUEL,REGION_FULL);
CC2_DiscountedAnnualCurtailmentCosts(y,f,r).. AnnualCurtailmentCost(y,f,r)/((1+GeneralDiscountRate(r))**(YearVal(y)-smin(yy, YearVal(yy))+0.5)) =e= DiscountedAnnualCurtailmentCost(y,f,r);



$ifthen %switch_base_year_bounds% == 1
*
* ##############* General BaseYear Limits and trajectories #############
*

equation B4a_RegionalBaseYearProductionLowerBound(YEAR_FULL,REGION_FULL,t,f);
B4a_RegionalBaseYearProductionLowerBound(y,r,t,f)$(RegionalBaseYearProduction(r,t,f,y) <> 0).. ProductionByTechnologyAnnual(y,t,f,r) =g= RegionalBaseYearProduction(r,t,f,y)*(1-BaseYearSlack(f)) - RegionalBaseYearProduction_neg(y,r,t,f);

equation B4b_RegionalBaseYearProductionUpperBound(YEAR_FULL,REGION_FULL,t,f);
B4b_RegionalBaseYearProductionUpperBound(y,r,t,'Power')$(RegionalBaseYearProduction(r,t,'Power',y) <> 0).. ProductionByTechnologyAnnual(y,t,'Power',r) =l= RegionalBaseYearProduction(r,t,'Power',y)+BaseYearOvershoot(r,t,'Power',y);

equation B4d_RegionalBaseYearPowerProductionLowerBound(YEAR_FULL,REGION_FULL,t,f);
B4d_RegionalBaseYearPowerProductionLowerBound('2025',r,Coal,'Power')$((AvailabilityFactor(r,Coal,'2025')))..
ProductionByTechnologyAnnual('2025',Coal,'Power',r) =g= ProductionByTechnologyAnnual('%year%',Coal,'Power',r)*0.4;

*equation B4e_RegionalBaseYearPowerProductionLowerBound(YEAR_FULL,REGION_FULL,t,f);
*B4e_RegionalBaseYearPowerProductionLowerBound('2030',r,Coal,'Power')$((AvailabilityFactor(r,Coal,'2030') <> 0))..
*ProductionByTechnologyAnnual('2030',Coal,'Power',r) =g= ProductionByTechnologyAnnual('%year%',Coal,'Power',r)*0.05;

*
* ####### limiting 2020 trajectory #############
*

*equation B8a_TrajectoryProductionLowerBound(YEAR_FULL,t,f);
*B8a_TrajectoryProductionLowerBound(y,t,f)$(sum(r,ResidualCapacity(r,t,'%year%')) > 0 and TrajectoryLowerLimit(y) <> 0 and YearVal(y) > %year%).. sum(r,ProductionByTechnologyAnnual(y,t,f,r)) =g= sum(r,ProductionByTechnologyAnnual(y-1,t,f,r))*TrajectoryLowerLimit(y);

*equation B8b_TrajectoryProductionUpperBound(YEAR_FULL,t,f);
*B8b_TrajectoryProductionUpperBound(y,t,f)$(sum(r,ResidualCapacity(r,t,'%year%')) > 0 and TrajectoryUpperLimit(y) <> 0 and YearVal(y) > %year%).. sum(r,ProductionByTechnologyAnnual(y,t,f,r)) =l= sum(r,ProductionByTechnologyAnnual(y-1,t,f,r))*TrajectoryUpperLimit(y);

$endif

*
* ######### Peaking Equations #############
*
$ifthen.equ_peaking_capacity %switch_peaking_capacity% == 1
positive variable PeakingDemand(YEAR_FULL,REGION_FULL);
positive variable PeakingCapacity(YEAR_FULL,REGION_FULL);
scalar GWh_to_PJ /0.0036/;
scalar PeakingSlack /%set_peaking_slack%/;
scalar MinRunShare /%set_peaking_minrun_share%/;
scalar RenewableCapacityFactorReduction /%set_peaking_res_cf%/;
scalar MinThermalShare /%set_peaking_min_thermal%/

equation PC1_PowerPeakingDemand(YEAR_FULL,REGION_FULL);
PC1_PowerPeakingDemand(y,r)..
PeakingDemand(y,r) =e=
  sum((se,t)$(x_peakingDemand(r,se) and TagTechnologyToSector(t,se) and sum((s,m),TechnologyToStorage(y,m,t,s)) = 0),
    UseByTechnologyAnnual(y,t,'power',r)/GWh_to_PJ*x_peakingDemand(r,se)/8760
*     Demand per Year in PJ             to Gwh     Highest peak hour value   /number hours per year
  ) + SpecifiedAnnualDemand(r,'power',y)/GWh_to_PJ*x_peakingDemand(r,'power')/8760
;

equation PC2_PowerPeakingCapacity(YEAR_FULL,REGION_FULL);
PC2_PowerPeakingCapacity(y,r)..
PeakingCapacity(y,r) =e=
  sum((t)$(sum(m,OutputActivityRatio(r,t,'power',m,y)) and sum((s,m),TechnologyToStorage(y,m,t,s)) = 0),
    (TotalCapacityAnnual(y,t,r)*AvailabilityFactor(r,t,y)*RenewableCapacityFactorReduction*(sum(l,CapacityFactor(r,t,l,y))/card(l)))$(sum(l,CapacityFactor(r,t,l,y)) < card(l))
  + (TotalCapacityAnnual(y,t,r)*AvailabilityFactor(r,t,y))$(sum(l,CapacityFactor(r,t,l,y)) >= card(l))
  )
;

equation PC3_PeakingConstraint(YEAR_FULL,REGION_FULL);
PC3_PeakingConstraint(y,r)$(YearVal(y) > %set_peaking_startyear%)..
  PeakingCapacity(y,r)
$ifthen.equ_peaking_with_trade %switch_peaking_with_trade% == 1
+ sum(rr,TotalTradeCapacity(y,'Power',rr,r))
$endif.equ_peaking_with_trade
$ifthen.equ_peaking_with_storages %switch_peaking_with_storages% == 1
+ sum(t$(sum(m,OutputActivityRatio(r,t,'power',m,y)) and sum((s,m),TechnologyToStorage(y,m,t,s)) = 0), TotalCapacityAnnual(y,t,r))
$endif.equ_peaking_with_storages
=g= PeakingDemand(y,r)*PeakingSlack
;

$ifthen.equ_peaking_minThermal %switch_peaking_with_storages% == 1
equation PC3b_PeakingConstraint_Thermal(YEAR_FULL,REGION_FULL);
PC3b_PeakingConstraint_Thermal(y,r).. PeakingCapacity(y,r) =g= MinThermalShare*PeakingDemand(y,r)*PeakingSlack;
$endif.equ_peaking_minThermal

$ifthen.equ_peaking_minrun %switch_peaking_minrun% == 1
equation PC4_MinRunConstraint(YEAR_FULL,TECHNOLOGY,REGION_FULL);
PC4_MinRunConstraint(y,t,r)$(TagTechnologyToSector(t,'Power')=1 and AvailabilityFactor(r,t,y)<=1 and TagDispatchableTechnology(t)=1 and AvailabilityFactor(r,t,y) > 0 and TotalAnnualMaxCapacity(r,t,y) > 0 and TotalTechnologyModelPeriodActivityUpperLimit(r,t) > 0 and TotalCapacityAnnual.up(y,t,r) > 0 and YearVal(y) > %set_peaking_startyear%)..
sum(l, sum(m, RateOfActivity(y,l,t,m,r))*YearSplit(l,y)) =g= sum(l,TotalCapacityAnnual(y,t,r)*CapacityFactor(r,t,l,y)*YearSplit(l,y)*AvailabilityFactor(r,t,y)*CapacityToActivityUnit(r,t))*MinRunShare;
$endif.equ_peaking_minrun

$endif.equ_peaking_capacity


$ifthen %switch_endogenous_employment% == 1

*
* ##############* Employment effects #############
*
positive variable TotalJobs(r_full,y_full);

$include genesysmod_employment.gms

equation Jobs1_TotalJobs(r_full,y_full);
Jobs1_TotalJobs(r,y)..  sum((t,f),((NewCapacity(y,t,r)*EFactorManufacturing(t,y)*RegionalAdjustmentFactor('%model_region%',y)*LocalManufacturingFactor('%model_region%',y))
                 +(NewCapacity(y,t,r)*EFactorConstruction(t,y)*RegionalAdjustmentFactor('%model_region%',y))
                 +(TotalCapacityAnnual(y,t,r)*EFactorOM(t,y)*RegionalAdjustmentFactor('%model_region%',y))
                 +(UseByTechnologyAnnual(y,t,f,r)*EFactorFuelSupply(t,y)))*(1-DeclineRate(t,y))**YearlyDifferenceMultiplier(y)
                 +((UseByTechnologyAnnual(y,'HLI_Hardcoal','Hardcoal',r)+UseByTechnologyAnnual(y,'HMI_HardCoal','Hardcoal',r)
                 +(UseByTechnologyAnnual(y,'HHI_BF_BOF','Hardcoal',r))*EFactorCoalJobs('Coal_Heat',y)*CoalSupply(r,y)))
                 +(CoalSupply(r,y)*CoalDigging('%model_region%','Coal_Export','%emissionPathway%_%emissionScenario%',y)*EFactorCoalJobs('Coal_Export',y)))
                 =e= TotalJobs(r,y);

$ontext
Manufacturing: NewCapacity(y,t,r)*EFactorManufacturing(t,y)*RegionalAdjustmentFactor('%model_region%',y)*LocalManufacturingFactor('%model_region%',y)*(1-DeclineRate(t,y))**YearlyDifferenceMultiplier(y)
Construction:  NewCapacity(y,t,r)*EFactorConstruction(t,y)*RegionalAdjustmentFactor('%model_region%',y)*(1-DeclineRate(t,y))**YearlyDifferenceMultiplier(y)
OMJobs: TotalCapacityAnnual(y,t,r)*EFactorOM(t,y)*RegionalAdjustmentFactor('%model_region%',y)*(1-DeclineRate(t,y))**YearlyDifferenceMultiplier(y)
FuelSupply: UseByTechnologyAnnual(y,t,f,r)*EFactorFuelSupply(t,y)*(1-DeclineRate(t,y))**YearlyDifferenceMultiplier(y)
CoalHeat:  (UseByTechnologyAnnual(y,'HLI_Hardcoal','Hardcoal',r)+UseByTechnologyAnnual(y,'HMI_HardCoal','Hardcoal',r)+UseByTechnologyAnnual(y,'HHI_BF_BOF','Hardcoal',r))*EFactorCoalJobs('Coal_Heat',y)*CoalSupply(r,y)
Export: CoalSupply(r,y)*CoalDigging('model_region','Coal_Export','%emissionPathway%_%emissionScenario%',y)*EFactorCoalJobs('Coal_Export',y)
$offtext

$endif
