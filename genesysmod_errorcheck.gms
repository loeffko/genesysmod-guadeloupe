**************************************************************
**************************************************************
****************   ERROR HANDLING BLOCK   ********************
**************************************************************
**************************************************************

* Check if Technologies are missing from the Sector list -> if yes, then exit
parameter error_TechMissingFromSectorList(TECHNOLOGY);
error_TechMissingFromSectorList(t)$(not sum(se,TagTechnologyToSector(t,se))) = 1;
if(sum(t,error_TechMissingFromSectorList(t)),abort "Technology missing from Sector list. Please check TagTechnologyToSector to include all Technologies. Missing Technologies are listed in the parameter error_TechMissingFromSectorList.");

* Check if TradeCosts are missing from a defined TradeRoute -> if yes, then exit
parameter error_TradeCostsMissingFromTradeRoute(f,r_full,rr_full);
error_TradeCostsMissingFromTradeRoute(f,r,rr)$(sum(y,TradeRoute(y,f,r,rr)) and not TradeCosts(f,r,rr)) = 1;
if(sum((f,r,rr),error_TradeCostsMissingFromTradeRoute(f,r,rr)),abort "TradeCosts are missing from a defined TradeRoute. Please check your TradeCosts to include all defined TradeRoutes. Missing TradeCosts are listed in the parameter error_TradeCostsMissingFromTradeRoute.");

* Check for errors in ModalSplit definitions -> if yes, then exit
parameter error_ModalSplitByModalTypeDefinition(f,*,r_full,y_full);
error_ModalSplitByModalTypeDefinition(f,'Error in ModalGroup',r,y)$(round(sum(ModalGroups,ModalSplitByFuelAndModalType(r,f,y,ModalGroups)),4)>1) = 1;
error_ModalSplitByModalTypeDefinition(f,'Error in SubGroup',r,y)$(round(sum(mt$(not sum(ModalGroups,diag(mt,ModalGroups))),ModalSplitByFuelAndModalType(r,f,y,mt)),4)>1) = 1;

* Added for debugging Guadeloupe
parameter error_ModalSplitByModalTypeDefinition2, error_ModalSplitByModalTypeDefinition3, error_ModalSplitByModalTypeDefinition4,

error_ModalSplitByModalTypeDefinition5;
error_ModalSplitByModalTypeDefinition2 = sum((f,r,y),error_ModalSplitByModalTypeDefinition(f,'Error in ModalGroup',r,y));
error_ModalSplitByModalTypeDefinition3 = sum((f,r,y),error_ModalSplitByModalTypeDefinition(f,'Error in SubGroup',r,y));
error_ModalSplitByModalTypeDefinition4(f,'Error in ModalGroup',r,y) = round(sum(ModalGroups,ModalSplitByFuelAndModalType(r,f,y,ModalGroups)),4);
error_ModalSplitByModalTypeDefinition5(f,'Error in SubGroup',r,y) = round(sum(mt$(not sum(ModalGroups,diag(mt,ModalGroups))),ModalSplitByFuelAndModalType(r,f,y,mt)),4)

display error_ModalSplitByModalTypeDefinition,error_ModalSplitByModalTypeDefinition2, error_ModalSplitByModalTypeDefinition3,
error_ModalSplitByModalTypeDefinition4, error_ModalSplitByModalTypeDefinition5, mt, ModalGroups, ModalSplitByFuelAndModalType;

* ---------------------------------------------------------------------------------------------------------------------------------

if(sum((f,r,y),error_ModalSplitByModalTypeDefinition(f,'Error in ModalGroup',r,y)),abort "ModalSplit is wrongly defined for a ModalGroup (e.g., MT_FRT_Road). The sum of ModalTypes cannot exceed 1. Please check your data. Problematic regions and years are listed in the parameter error_ModalSplitByModalTypeDefinition.");
if(sum((f,r,y),error_ModalSplitByModalTypeDefinition(f,'Error in SubGroup',r,y)),abort "ModalSplit is wrongly defined for a subgroup in the ModalSplit (e.g., MT_FRT_Road_RE). The sum of ModalTypes cannot exceed 1. Please check your data. Problematic regions and years are listed in the parameter error_ModalSplitByModalTypeDefinition.");

* Check for errors in OperationalLife data -> if yes, then exit
parameter error_OperationalLifeMissing(r_full,t);
$ifthen %switch_infeasibility_tech% == 0
error_OperationalLifeMissing(r,t)$(not OperationalLife(r,t) and not TagTechnologyToSector(t,'Infeasibility')) = 1;
$else
error_OperationalLifeMissing(r,t)$(not OperationalLife(r,t)) = 1;
$endif
if(sum((r,t),error_OperationalLifeMissing(r,t)),abort "OperationalLife is missing from a Technology. Please check your OperationalLife data to account for all technologies. Missing values are listed in the parameter error_OperationalLifeMissing.");

* Check for errors in CapacityFactor data -> if yes, then exit
parameter error_CapacityFactorDataMissing(r_full,t,y_full);
error_CapacityFactorDataMissing(r,t,y)$(not sum(l,CapacityFactor(r,t,l,y)) and AvailabilityFactor(r,t,y) and TotalAnnualMaxCapacity(r,t,y)) = 1;
if(sum((r,t,y),error_CapacityFactorDataMissing(r,t,y)),abort "CapacityFactor is missing from a Technology. Please check your Hourly data file to account for all technologies. Technologies where values are missing are listed in the parameter error_CapacityFactorDataMissing.");


*TODO:
**Error for missing SpecifiedDemandProfile



**************************************************************
**************************************************************
*********************   WARNING BLOCK   **********************
**************************************************************
**************************************************************

*TODO:
**Warning for zero in AvailabilityFactor
**Warning for missing demand data
**Warning for missing EmissionActicityRatio
**Warning for lower than expected InputActivityRatio
**Warning for EmissionLimits that are set to zero

parameter warning_TechnologyEfficiencies(r_full,t,m,y_full);
warning_TechnologyEfficiencies(r,t,m,y)$(not sum(se,TagTechnologyToSector(t,'Resources')) and not sum(se,TagTechnologyToSector(t,'Transportation')) and sum(f,OutputActivityRatio(r,t,f,m,y)) and ((sum(f,InputActivityRatio(r,t,f,m,y))/sum(f,OutputActivityRatio(r,t,f,m,y)))<1)$(sum(f,OutputActivityRatio(r,t,f,m,y)) and sum(f,InputActivityRatio(r,t,f,m,y)))) = 1;

