parameters SectorEmissions
EmissionIntensity
output_emissionintensity;

SectorEmissions(y,r,'Power',e) =  sum((m,t),TechnologyEmissionsByMode(y,t,e,m,r)*OutputActivityRatio(r,t,'Power',m,y));
SectorEmissions(y,r,TierFive,e) = sum((m,t),TechnologyEmissionsByMode(y,t,e,m,r)*OutputActivityRatio(r,t,TierFive,m,y));


EmissionIntensity(y,r,'Power',e)$(sum(t,ProductionByTechnologyAnnual.l(y,t,'Power',r))) = SectorEmissions(y,r,'Power',e)/sum(t,ProductionByTechnologyAnnual.l(y,t,'Power',r)$(not TagTechnologyToSector(t,'Storages')));
EmissionIntensity(y,r,TierFive,e)$(AnnualProduction(y,TierFive,r)) = SectorEmissions(y,r,TierFive,e)/AnnualProduction(y,TierFive,r);

