* ###################### genesysmod_subsets.gms #######################
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


set Solar(t);
Solar(t) = no;
Solar('Res_pv_Rooftop_Residential') = yes ;
Solar('Res_pv_Rooftop_commercial') = yes ;
Solar('Res_pv_utility_opt') = yes ;
Solar('Res_pv_utility_avg') = yes ;
Solar('Res_pv_utility_inf') = yes ;
Solar('Res_csp') = yes ;
Solar('HLR_Solar_Thermal') = yes;
Solar('HLI_Solar_Thermal') = yes;
Solar('RES_PV_Utility_Tracking') = yes;

set Wind(t);
Wind(t) = no;
Wind('Res_Wind_Offshore_Deep') = yes;
Wind('Res_Wind_Offshore_Shallow') = yes;
Wind('Res_Wind_Offshore_Transitional') = yes;
Wind('Res_Wind_Onshore_opt') = yes;
Wind('Res_Wind_Onshore_avg') = yes;
Wind('Res_Wind_Onshore_inf') = yes;

set Renewables(t);
alias (Renewables,RES);
Renewables(t) = no;
Renewables('Res_Wind_Offshore_Deep') = yes;
Renewables('Res_Wind_Offshore_Shallow') = yes;
Renewables('Res_Wind_Offshore_Transitional') = yes;
Renewables('Res_Wind_Onshore_opt') = yes;
Renewables('Res_Wind_Onshore_avg') = yes;
Renewables('Res_Wind_Onshore_inf') = yes;
Renewables('Res_PV_Rooftop_Residential') = yes;
Renewables('Res_PV_Rooftop_commercial') = yes;
Renewables('Res_PV_utility_opt') = yes;
Renewables('Res_PV_utility_avg') = yes;
Renewables('Res_PV_utility_inf') = yes;
Renewables('Res_CSP') = yes;
Renewables('Res_Geothermal') = yes;
Renewables('Res_Hydro_Small') = yes;
Renewables('Res_Hydro_Large') = yes;
Renewables('Res_Ocean') = yes;
*Renewables('Res_BioMass') = yes;
Renewables('P_Biomass') = yes;
Renewables('P_Biomass_CCS') = yes;
Renewables('HLR_Biomass') = yes;
*Renewables('HLR_Biomass_CHP') = yes;
Renewables('HLR_Direct_Electric') = yes;
Renewables('HLR_Solar_Thermal') = yes;
Renewables('HLR_Heatpump_Aerial') = yes;
Renewables('HLR_Heatpump_Ground') = yes;
Renewables('HLR_Geothermal') = yes;
Renewables('HLI_Biomass') = yes;
*Renewables('HLI_Biomass_CHP') = yes;
Renewables('HLI_Direct_Electric') = yes;
Renewables('HLI_Solar_Thermal') = yes;
Renewables('HLI_Fuelcell') = yes;
Renewables('HLI_Geothermal') = yes;
Renewables('HMI_Biomass') = yes;
Renewables('HMI_Steam_Electric') = yes;
Renewables('HHI_Scrap_EAF') = yes;
Renewables('HHI_H2DRI_EAF') = yes;
Renewables('HHI_Molten_Electrolysis') = yes;
Renewables('HHI_Bio_BF_BOF') = yes;
Renewables('HLR_H2_Boiler') = yes;
Renewables('HLI_H2_Boiler') = yes;
Renewables('CHP_Biomass_Solid') = yes;
Renewables('CHP_Biomass_Solid_CCS') = yes;
Renewables('CHP_Gas_CCGT_Biogas') = yes;
Renewables('CHP_Gas_CCGT_SynGas') = yes;
Renewables('CHP_Gas_CCGT_Biogas_CCS') = yes;
Renewables('RES_PV_Utility_Tracking') = yes;

set CCS(t);
CCS(t) = no;
CCS('P_Biomass_CCS') = yes;
CCS('HHI_BF_BOF_CCS') = yes;
CCS('HHI_DRI_EAF_CCS') = yes;
*CCS('HLI_Biomass_CHP_CCS') = yes;
*CCS('HLI_Hardcoal_CHP_CCS') = yes;
*CCS('HLI_Lignite_CHP_CCS') = yes;
*CCS('HLR_Biomass_CHP_CCS') = yes;
*CCS('HLR_Hardcoal_CHP_CCS') = yes;
*CCS('HLR_Lignite_CHP_CCS') = yes;
CCS('HMI_Gas_CCS') = yes;
CCS('HMI_HardCoal_CCS') = yes;
CCS('P_Coal_Hardcoal_CCS') = yes;
CCS('P_Coal_Lignite_CCS') = yes;
CCS('P_Gas_CCS') = yes;
CCS('X_SMR_CCS') = yes;
CCS('X_DAC_HT') = yes;
CCS('X_DAC_LT') = yes;
CCS('CHP_Biomass_Solid_CCS') = yes;
CCS('CHP_Coal_Hardcoal_CCS') = yes;
CCS('CHP_Coal_Lignite_CCS') = yes;
CCS('CHP_Gas_CCGT_Natural_CCS') = yes;
CCS('CHP_Gas_CCGT_Biogas_CCS') = yes;

set Transformation(t);
Transformation(t) = no;
Transformation('X_FUEL_CELL') = yes;
Transformation('X_Electrolysis') = yes;
Transformation('X_Methanation') = yes;
Transformation('X_Biofuel') = yes;
Transformation('X_Powerfuel') = yes;
Transformation('HLR_Gas_Boiler') = yes;
*Transformation('HLR_Gas_CHP') = yes;
Transformation('HLR_Biomass') = yes;
*Transformation('HLR_Biomass_CHP') = yes;
Transformation('HLR_Hardcoal') = yes;
Transformation('HLR_Lignite') = yes;
*Transformation('HLR_Hardcoal_CHP') = yes;
*Transformation('HLR_Lignite_CHP') = yes;
Transformation('HLR_Direct_Electric') = yes;
Transformation('HLR_Solar_Thermal') = yes;
Transformation('HLR_Heatpump_Aerial') = yes;
Transformation('HLR_Heatpump_Ground') = yes;
Transformation('HLR_Geothermal') = yes;
Transformation('HLR_Oil_Boiler') = yes;
Transformation('HLR_H2_Boiler') = yes;
Transformation('HLI_Gas_Boiler') = yes;
*Transformation('HLI_Gas_CHP') = yes;
Transformation('HLI_Biomass') = yes;
*Transformation('HLI_Biomass_CHP') = yes;
Transformation('HLI_Hardcoal') = yes;
Transformation('HLI_Lignite') = yes;
*Transformation('HLI_Hardcoal_CHP') = yes;
*Transformation('HLI_Lignite_CHP') = yes;
Transformation('HLI_Direct_Electric') = yes;
Transformation('HLI_Solar_Thermal') = yes;
Transformation('HLI_Fuelcell') = yes;
Transformation('HLI_Geothermal') = yes;
Transformation('HLI_Oil_Boiler') = yes;
*Transformation('HLI_Oil_CHP') = yes;
Transformation('HLI_H2_Boiler') = yes;
Transformation('HMI_Gas') = yes;
Transformation('HMI_Biomass') = yes;
Transformation('HMI_HardCoal') = yes;
Transformation('HMI_Steam_Electric') = yes;
Transformation('HMI_Oil') = yes;
Transformation('HHI_BF_BOF') = yes;
Transformation('HHI_DRI_EAF') = yes;
Transformation('HHI_Scrap_EAF') = yes;
Transformation('HHI_H2DRI_EAF') = yes;
Transformation('HHI_Molten_Electrolysis') = yes;
Transformation('HHI_Bio_BF_BOF') = yes;
Transformation('HHI_BF_BOF_CCS') = yes;
Transformation('HHI_DRI_EAF_CCS') = yes;
*Transformation('HLI_Biomass_CHP') = yes;
*Transformation('HLI_Hardcoal_CHP_CCS') = yes;
*Transformation('HLI_Lignite_CHP_CCS') = yes;
*Transformation('HLR_Biomass_CHP') = yes;
*Transformation('HLR_Hardcoal_CHP_CCS') = yes;
*Transformation('HLR_Lignite_CHP_CCS') = yes;
Transformation('HMI_Gas_CCS') = yes;
Transformation('HMI_HardCoal_CCS') = yes;
Transformation('HLR_H2_Boiler') = yes;
Transformation('HLI_H2_Boiler') = yes;
Transformation('X_SMR') = yes;
Transformation('X_SMR_CCS') = yes;
Transformation('P_H2_OCGT') = yes;

Transformation('CHP_Biomass_Solid') = yes;
Transformation('CHP_Coal_Hardcoal') = yes;
Transformation('CHP_Coal_Lignite') = yes;
Transformation('CHP_Gas_CCGT_Natural') = yes;
Transformation('CHP_Gas_CCGT_Biogas') = yes;
Transformation('CHP_Gas_CCGT_SynGas') = yes;
Transformation('CHP_Biomass_Solid_CCS') = yes;
Transformation('CHP_Coal_Hardcoal_CCS') = yes;
Transformation('CHP_Coal_Lignite_CCS') = yes;
Transformation('CHP_Gas_CCGT_Natural_CCS') = yes;
Transformation('CHP_Gas_CCGT_Biogas_CCS') = yes;
Transformation('CHP_Hydrogen_FuelCell') = yes;
Transformation('CHP_Oil') = yes;


set RenewableTransformation(t);
RenewableTransformation(t) = no;
RenewableTransformation('X_FUEL_CELL') = yes;
*RenewableTransformation('X_Electrolysis') = yes;
*RenewableTransformation('X_Methanation') = yes;
RenewableTransformation('HLR_Biomass') = yes;
*RenewableTransformation('HLR_Biomass_CHP') = yes;
RenewableTransformation('HLR_Direct_Electric') = yes;
RenewableTransformation('HLR_Solar_Thermal') = yes;
RenewableTransformation('HLR_Heatpump_Aerial') = yes;
RenewableTransformation('HLR_Heatpump_Ground') = yes;
RenewableTransformation('HLR_Geothermal') = yes;
RenewableTransformation('HLI_Biomass') = yes;
*RenewableTransformation('HLI_Biomass_CHP') = yes;
RenewableTransformation('HLI_Direct_Electric') = yes;
RenewableTransformation('HLI_Solar_Thermal') = yes;
RenewableTransformation('HLI_Fuelcell') = yes;
RenewableTransformation('HLI_Geothermal') = yes;
RenewableTransformation('HMI_Biomass') = yes;
RenewableTransformation('HMI_Steam_Electric') = yes;
RenewableTransformation('HHI_H2DRI_EAF') = yes;
RenewableTransformation('HHI_Molten_Electrolysis') = yes;
RenewableTransformation('HLR_H2_Boiler') = yes;
RenewableTransformation('HLI_H2_Boiler') = yes;
RenewableTransformation('P_H2_OCGT') = yes;
RenewableTransformation('CHP_Biomass_Solid') = yes;
RenewableTransformation('CHP_Biomass_Solid_CCS') = yes;
RenewableTransformation('CHP_Gas_CCGT_Biogas') = yes;
RenewableTransformation('CHP_Gas_CCGT_SynGas') = yes;
RenewableTransformation('CHP_Gas_CCGT_Biogas_CCS') = yes;

set FossilFuelGeneration(t);
FossilFuelGeneration(t) = no;
FossilFuelGeneration('R_Coal_Hardcoal') = yes;
FossilFuelGeneration('R_Coal_Lignite') = yes;
FossilFuelGeneration('R_Oil') = yes;
FossilFuelGeneration('R_Nuclear') = yes;
FossilFuelGeneration('R_Gas') = yes;
FossilFuelGeneration('Z_Import_Gas') = yes;
FossilFuelGeneration('Z_Import_Oil') = yes;
FossilFuelGeneration('Z_Import_Hardcoal') = yes;

set FossilFuels(f);
FossilFuels(f) = no;
FossilFuels('Hardcoal') = yes;
FossilFuels('Lignite') = yes;
FossilFuels('Nuclear') = yes;
FossilFuels('Oil') = yes;
FossilFuels('Gas_Natural') = yes;

set FossilPower(t);
FossilPower(t) = no;
FossilPower('P_Coal_Hardcoal') = yes;
FossilPower('P_Coal_Lignite') = yes;
*FossilPower('P_Gas') = yes;
FossilPower('P_Nuclear') = yes;
FossilPower('P_Oil') = yes;
FossilPower('P_Coal_Hardcoal_CCS') = yes;
FossilPower('P_Coal_Lignite_CCS') = yes;
FossilPower('P_Gas_CCS') = yes;

FossilPower('P_Gas_CCGT') = yes;
FossilPower('P_Gas_OCGT') = yes;
FossilPower('P_Gas_Engines') = yes;

FossilPower('CHP_Coal_Hardcoal') = yes;
FossilPower('CHP_Coal_Lignite') = yes;
FossilPower('CHP_Gas_CCGT_Natural') = yes;
FossilPower('CHP_Coal_Hardcoal_CCS') = yes;
FossilPower('CHP_Coal_Lignite_CCS') = yes;
FossilPower('CHP_Gas_CCGT_Natural_CCS') = yes;
FossilPower('CHP_Oil') = yes;

set CHPs(t);
CHPs(t) = no;
*CHPs('HLR_Gas_CHP') = yes;
*CHPs('HLR_Biomass_CHP') = yes;
*CHPs('HLR_Hardcoal_CHP') = yes;
*CHPs('HLR_Lignite_CHP') = yes;
*CHPs('HLI_Gas_CHP') = yes;
*CHPs('HLI_Biomass_CHP') = yes;
*CHPs('HLI_Hardcoal_CHP') = yes;
*CHPs('HLI_Lignite_CHP') = yes;
*CHPs('HLI_Fuelcell') = yes;
*CHPs('HLI_Oil_CHP') = yes;
CHPs('CHP_Biomass_Solid') = yes;
CHPs('CHP_Coal_Hardcoal') = yes;
CHPs('CHP_Coal_Lignite') = yes;
CHPs('CHP_Gas_CCGT_Natural') = yes;
CHPs('CHP_Gas_CCGT_Biogas') = yes;
CHPs('CHP_Gas_CCGT_SynGas') = yes;
CHPs('CHP_Biomass_Solid_CCS') = yes;
CHPs('CHP_Coal_Hardcoal_CCS') = yes;
CHPs('CHP_Coal_Lignite_CCS') = yes;
CHPs('CHP_Gas_CCGT_Natural_CCS') = yes;
CHPs('CHP_Gas_CCGT_Biogas_CCS') = yes;
CHPs('CHP_Hydrogen_FuelCell') = yes;
CHPs('CHP_Oil') = yes;
CHPs('HLI_Convert_DH') = yes;
CHPs('HLR_Convert_DH') = yes;

set RenewableTransport(t);
RenewableTransport(t) = no;
RenewableTransport('FRT_Rail_Electric') = yes;
RenewableTransport('FRT_Road_BEV') = yes;
RenewableTransport('FRT_Road_H2') = yes;
RenewableTransport('FRT_Road_PHEV') = yes;
RenewableTransport('FRT_Road_OH') = yes;
RenewableTransport('FRT_Ship_Bio') = yes;
RenewableTransport('PSNG_Air_Bio') = yes;
RenewableTransport('PSNG_Air_H2') = yes;
RenewableTransport('PSNG_Rail_Electric') = yes;
RenewableTransport('PSNG_Road_BEV') = yes;
RenewableTransport('PSNG_Road_H2') = yes;
RenewableTransport('PSNG_Road_PHEV') = yes;
RenewableTransport('PSNG_Ship_EL') = yes;


set Transport(t);
Transport(t) = no;
Transport('FRT_Rail_Conv') = yes;
Transport('FRT_Rail_Electric') = yes;
Transport('FRT_Road_BEV') = yes;
Transport('FRT_Road_H2') = yes;
Transport('FRT_Road_ICE') = yes;
Transport('FRT_Road_PHEV') = yes;
Transport('FRT_Road_OH') = yes;
Transport('FRT_Ship_Bio') = yes;
Transport('FRT_Ship_Conv') = yes;
Transport('PSNG_Air_Bio') = yes;
Transport('PSNG_Air_Conv') = yes;
Transport('PSNG_Air_H2') = yes;
Transport('PSNG_Rail_Conv') = yes;
Transport('PSNG_Rail_Electric') = yes;
Transport('PSNG_Road_BEV') = yes;
Transport('PSNG_Road_H2') = yes;
Transport('PSNG_Road_ICE') = yes;
Transport('PSNG_Road_PHEV') = yes;
Transport('PSNG_Ship_Bio') = yes;
Transport('PSNG_Ship_Conv') = yes;
Transport('PSNG_Ship_Bio') = yes;
Transport('PSNG_Ship_EL') = yes;


set Passenger(t);
Passenger(t) = no;
Passenger('PSNG_Air_Bio') = yes;
Passenger('PSNG_Air_Conv') = yes;
Passenger('PSNG_Air_H2') = yes;
Passenger('PSNG_Rail_Conv') = yes;
Passenger('PSNG_Rail_Electric') = yes;
Passenger('PSNG_Road_BEV') = yes;
Passenger('PSNG_Road_H2') = yes;
Passenger('PSNG_Road_ICE') = yes;
Transport('PSNG_Ship_Conv') = yes;
Transport('PSNG_Ship_Bio') = yes;
Transport('PSNG_Ship_EL') = yes;

set Freight(t);
Freight(t) = no;
Freight('FRT_Rail_Conv') = yes;
Freight('FRT_Rail_Electric') = yes;
Freight('FRT_Road_BEV') = yes;
Freight('FRT_Road_H2') = yes;
Freight('FRT_Road_ICE') = yes;
Freight('FRT_Road_PHEV') = yes;
Freight('FRT_Road_OH') = yes;
Freight('FRT_Ship_Bio') = yes;
Freight('FRT_Ship_Conv') = yes;

set TransportFuels(f);
TransportFuels(f) = no;
TransportFuels('Mobility_Passenger') = yes;
TransportFuels('Mobility_Freight') = yes;

set ImportTechnology(t);
ImportTechnology(t) = no;
ImportTechnology('Z_Import_Hardcoal') = yes;
ImportTechnology('Z_Import_Oil') = yes;
ImportTechnology('Z_Import_Gas') = yes;
ImportTechnology('Z_Import_LNG') = yes;
ImportTechnology('Z_Import_H2') = yes;

set Heat(t);
Heat(t) = no;
Heat('HLR_Gas_Boiler') = yes;
*Heat('HLR_Gas_CHP') = yes;
Heat('HLR_Biomass') = yes;
*Heat('HLR_Biomass_CHP') = yes;
Heat('HLR_Hardcoal') = yes;
Heat('HLR_Lignite') = yes;
*Heat('HLR_Hardcoal_CHP') = yes;
*Heat('HLR_Lignite_CHP') = yes;
Heat('HLR_Direct_Electric') = yes;
Heat('HLR_Solar_Thermal') = yes;
Heat('HLR_Heatpump_Aerial') = yes;
Heat('HLR_Heatpump_Ground') = yes;
Heat('HLR_Geothermal') = yes;
Heat('HLR_Oil_Boiler') = yes;
Heat('HLI_Gas_Boiler') = yes;
*Heat('HLI_Gas_CHP') = yes;
Heat('HLI_Biomass') = yes;
*Heat('HLI_Biomass_CHP') = yes;
Heat('HLI_Hardcoal') = yes;
Heat('HLI_Lignite') = yes;
*Heat('HLI_Hardcoal_CHP') = yes;
*Heat('HLI_Lignite_CHP') = yes;
Heat('HLI_Direct_Electric') = yes;
Heat('HLI_Solar_Thermal') = yes;
Heat('HLI_Fuelcell') = yes;
Heat('HLI_Geothermal') = yes;
Heat('HLI_Oil_Boiler') = yes;
*Heat('HLI_Oil_CHP') = yes;
Heat('HMI_Gas') = yes;
Heat('HMI_Biomass') = yes;
Heat('HMI_HardCoal') = yes;
Heat('HMI_Steam_Electric') = yes;
Heat('HMI_Oil') = yes;
Heat('HHI_BF_BOF') = yes;
Heat('HHI_DRI_EAF') = yes;
Heat('HHI_Scrap_EAF') = yes;
Heat('HHI_H2DRI_EAF') = yes;
Heat('HHI_Molten_Electrolysis') = yes;
Heat('HHI_Bio_BF_BOF') = yes;
Heat('HHI_BF_BOF_CCS') = yes;
Heat('HHI_DRI_EAF_CCS') = yes;
*Heat('HLI_Biomass_CHP') = yes;
*Heat('HLI_Hardcoal_CHP_CCS') = yes;
*Heat('HLI_Lignite_CHP_CCS') = yes;
*Heat('HLR_Biomass_CHP') = yes;
*Heat('HLR_Hardcoal_CHP_CCS') = yes;
*Heat('HLR_Lignite_CHP_CCS') = yes;
Heat('HMI_Gas_CCS') = yes;
Heat('HMI_HardCoal_CCS') = yes;
Heat('HLR_H2_Boiler') = yes;
Heat('HLI_H2_Boiler') = yes;
Heat('CHP_Biomass_Solid') = yes;
Heat('CHP_Coal_Hardcoal') = yes;
Heat('CHP_Coal_Lignite') = yes;
Heat('CHP_Gas_CCGT_Natural') = yes;
Heat('CHP_Gas_CCGT_Biogas') = yes;
Heat('CHP_Gas_CCGT_SynGas') = yes;
Heat('CHP_Biomass_Solid_CCS') = yes;
Heat('CHP_Coal_Hardcoal_CCS') = yes;
Heat('CHP_Coal_Lignite_CCS') = yes;
Heat('CHP_Gas_CCGT_Natural_CCS') = yes;
Heat('CHP_Gas_CCGT_Biogas_CCS') = yes;
Heat('CHP_Hydrogen_FuelCell') = yes;
Heat('CHP_Oil') = yes;
Heat('HLI_Convert_DH') = yes;
Heat('HLR_Convert_DH') = yes;

set PowerSupply(t);
PowerSupply(t) = no;
PowerSupply('Res_Wind_Offshore_Deep') = yes;
PowerSupply('Res_Wind_Offshore_Shallow') = yes;
PowerSupply('Res_Wind_Offshore_Transitional') = yes;
PowerSupply('Res_Wind_Onshore_opt') = yes;
PowerSupply('Res_Wind_Onshore_avg') = yes;
PowerSupply('Res_Wind_Onshore_inf') = yes;
PowerSupply('Res_PV_Rooftop_Residential') = yes;
PowerSupply('Res_PV_Rooftop_commercial') = yes;
PowerSupply('Res_PV_utility_opt') = yes;
PowerSupply('Res_PV_utility_avg') = yes;
PowerSupply('Res_PV_utility_inf') = yes;
PowerSupply('RES_PV_Utility_Tracking') = yes;
PowerSupply('Res_CSP') = yes;
PowerSupply('Res_Geothermal') = yes;
PowerSupply('Res_Hydro_Small') = yes;
PowerSupply('Res_Hydro_Large') = yes;
PowerSupply('Res_Ocean') = yes;
PowerSupply('P_Coal_Hardcoal') = yes;
PowerSupply('P_Coal_Lignite') = yes;
*PowerSupply('P_Gas') = yes;
PowerSupply('P_Nuclear') = yes;
PowerSupply('P_Oil') = yes;
PowerSupply('P_Biomass') = yes;
PowerSupply('P_Biomass_CCS') = yes;
*PowerSupply('HLR_Gas_CHP') = yes;
*PowerSupply('HLR_Biomass_CHP') = yes;
*PowerSupply('HLR_Hardcoal_CHP') = yes;
*PowerSupply('HLR_Lignite_CHP') = yes;
*PowerSupply('HLI_Gas_CHP') = yes;
*PowerSupply('HLI_Biomass_CHP') = yes;
*PowerSupply('HLI_Hardcoal_CHP') = yes;
*PowerSupply('HLI_Lignite_CHP') = yes;
*PowerSupply('HLI_Oil_CHP') = yes;
PowerSupply('P_Coal_Lignite_CCS') = yes;
PowerSupply('P_Coal_Hardcoal_CCS') = yes;
PowerSupply('P_Gas_CCS') = yes;
PowerSupply('P_H2_OCGT') = yes;
PowerSupply('P_Gas_CCGT') = yes;
PowerSupply('P_Gas_OCGT') = yes;
PowerSupply('P_Gas_Engines') = yes;

set PowerBiomass(t);
PowerBiomass(t) = no;
PowerBiomass('P_Biomass') = yes;
PowerBiomass('P_Biomass_CCS') = yes;
*PowerBiomass('HLR_Biomass_CHP') = yes;
*PowerBiomass('HLI_Biomass_CHP') = yes;
PowerBiomass('CHP_Biomass_Solid') = yes;
PowerBiomass('CHP_Biomass_Solid_CCS') = yes;

set Coal(t);
Coal(t) = no;
Coal('P_Coal_Hardcoal') = yes;
Coal('P_Coal_Lignite') = yes;
Coal('HLR_Hardcoal') = yes;
Coal('HLR_Lignite') = yes;
*Coal('HLR_Hardcoal_CHP') = yes;
*Coal('HLR_Lignite_CHP') = yes;
Coal('HLI_Hardcoal') = yes;
Coal('HLI_Lignite') = yes;
*Coal('HLI_Hardcoal_CHP') = yes;
*Coal('HLI_Lignite_CHP') = yes;
Coal('HMI_HardCoal') = yes;
Coal('HHI_BF_BOF') = yes;
Coal('HHI_BF_BOF_CCS') = yes;
*Coal('HLI_Hardcoal_CHP_CCS') = yes;
*Coal('HLI_Lignite_CHP_CCS') = yes;
*Coal('HLR_Hardcoal_CHP_CCS') = yes;
*Coal('HLR_Lignite_CHP_CCS') = yes;
Coal('HMI_HardCoal_CCS') = yes;
Coal('P_Coal_Hardcoal_CCS') = yes;
Coal('P_Coal_Lignite_CCS') = yes;
Coal('CHP_Coal_Hardcoal') = yes;
Coal('CHP_Coal_Lignite') = yes;
Coal('CHP_Coal_Hardcoal_CCS') = yes;
Coal('CHP_Coal_Lignite_CCS') = yes;

set Lignite(t);
Lignite(t) = no;
Lignite('P_Coal_Lignite') = yes;
Lignite('HLR_Lignite') = yes;
*Lignite('HLR_Lignite_CHP') = yes;
Lignite('HLI_Lignite') = yes;
*Lignite('HLI_Lignite_CHP') = yes;
Lignite('P_Coal_Lignite_CCS') = yes;
*Lignite('HLR_Lignite_CHP_CCS') = yes;
*Lignite('HLI_Lignite_CHP_CCS') = yes;
Coal('CHP_Coal_Lignite') = yes;
Coal('CHP_Coal_Lignite_CCS') = yes;


set Gas(t);
Gas(t) = no;
*Gas('P_Gas') = yes;
Gas('HLR_Gas_Boiler') = yes;
*Gas('HLR_Gas_CHP') = yes;
Gas('HLI_Gas_Boiler') = yes;
*Gas('HLI_Gas_CHP') = yes;
Gas('HMI_Gas') = yes;
Gas('HHI_DRI_EAF') = yes;
Gas('HHI_DRI_EAF_CCS') = yes;
Gas('HMI_Gas_CCS') = yes;
Gas('P_Gas_CCS') = yes;
Gas('P_Gas_CCGT') = yes;
Gas('P_Gas_OCGT') = yes;
Gas('P_Gas_Engines') = yes;
Gas('CHP_Gas_CCGT_Natural') = yes;
Gas('CHP_Gas_CCGT_Biogas') = yes;
Gas('CHP_Gas_CCGT_SynGas') = yes;
Gas('CHP_Gas_CCGT_Natural_CCS') = yes;
Gas('CHP_Gas_CCGT_Biogas_CCS') = yes;

set StorageDummies(t);
StorageDummies(t) = no;
StorageDummies('D_Battery_Li-Ion') = yes;
StorageDummies('D_Battery_Redox') = yes;
StorageDummies('D_Gas_Methane') = yes;
StorageDummies('D_Gas_H2') = yes;
StorageDummies('D_Heat_HLI') = yes;
StorageDummies('D_Heat_HLR') = yes;
StorageDummies('D_PHS') = yes;
StorageDummies('D_PHS_Residual') = yes;
StorageDummies('D_CAES') = yes;

set SectorCoupling(t);
SectorCoupling(t) = no;
SectorCoupling('X_FUEL_CELL') = yes;
SectorCoupling('X_Electrolysis') = yes;
SectorCoupling('X_Methanation') = yes;
SectorCoupling('HLI_Fuelcell') = yes;
SectorCoupling('X_SMR') = yes;
SectorCoupling('X_SMR_CCS') = yes;
SectorCoupling('X_Biofuel') = yes;
SectorCoupling('X_Powerfuel') = yes;
SectorCoupling('P_H2_OCGT') = yes;

set HeatFuels(f);
HeatFuels(f) = no;
HeatFuels('Heat_Low_Industrial') = yes;
HeatFuels('Heat_Medium_Industrial') = yes;
HeatFuels('Heat_High_Industrial') = yes;
HeatFuels('Heat_Low_Residential')  = yes;

set ModalGroups(mt);
ModalGroups(mt) = no;
ModalGroups('MT_PSNG_ROAD') = yes;
ModalGroups('MT_PSNG_RAIL') = yes;
ModalGroups('MT_PSNG_AIR') = yes;
ModalGroups('MT_FRT_ROAD') = yes;
ModalGroups('MT_FRT_RAIL') = yes;
ModalGroups('MT_PSNG_SHIP') = yes;

set PhaseInSet(t);
PhaseInSet(t) = no;
*PhaseInSet('X_FUEL_CELL') = yes;
PhaseInSet('X_Electrolysis') = yes;
PhaseInSet('X_Biofuel') = yes;
*PhaseInSet('X_Methanation') = yes;
PhaseInSet('D_Battery_Li-Ion') = yes;
PhaseInSet('D_Battery_Redox') = yes;
PhaseInSet('D_Gas_Methane') = yes;
PhaseInSet('D_Gas_H2') = yes;
PhaseInSet('D_CAES') = yes;
PhaseInSet('D_Heat_HLR') = yes;
PhaseInSet('D_Heat_HLI') = yes;
PhaseInSet('D_PHS') = yes;
PhaseInSet('HLR_Biomass') = yes;
*PhaseInSet('HLR_Biomass_CHP') = yes;
PhaseInSet('HLR_Direct_Electric') = yes;
PhaseInSet('HLR_Solar_Thermal') = yes;
PhaseInSet('HLR_Heatpump_Aerial') = yes;
PhaseInSet('HLR_Heatpump_Ground') = yes;
PhaseInSet('HLR_Geothermal') = yes;
PhaseInSet('HLI_Biomass') = yes;
*PhaseInSet('HLI_Biomass_CHP') = yes;
PhaseInSet('HLI_Direct_Electric') = yes;
PhaseInSet('HLI_Solar_Thermal') = yes;
PhaseInSet('HLI_Fuelcell') = yes;
PhaseInSet('HLI_Geothermal') = yes;
PhaseInSet('HMI_Biomass') = yes;
PhaseInSet('HMI_Steam_Electric') = yes;
PhaseInSet('HHI_H2DRI_EAF') = yes;
PhaseInSet('HHI_Scrap_EAF') = yes;
PhaseInSet('HHI_Molten_Electrolysis') = yes;
PhaseInSet('HHI_Bio_BF_BOF') = yes;
PhaseInSet('Res_Wind_Offshore_Deep') = yes;
PhaseInSet('Res_Wind_Offshore_Shallow') = yes;
PhaseInSet('Res_Wind_Offshore_Transitional') = yes;
PhaseInSet('Res_Wind_Onshore_opt') = yes;
PhaseInSet('Res_Wind_Onshore_avg') = yes;
PhaseInSet('Res_Wind_Onshore_inf') = yes;
PhaseInSet('Res_PV_Rooftop_Residential') = yes;
PhaseInSet('Res_PV_Rooftop_commercial') = yes;
PhaseInSet('Res_PV_utility_opt') = yes;
PhaseInSet('Res_PV_utility_avg') = yes;
PhaseInSet('Res_PV_utility_inf') = yes;
PhaseInSet('RES_PV_Utility_Tracking') = yes;
PhaseInSet('Res_CSP') = yes;
PhaseInSet('Res_Geothermal') = yes;
PhaseInSet('Res_Hydro_Small') = yes;
PhaseInSet('Res_Hydro_Large') = yes;
PhaseInSet('Res_Ocean') = yes;
*PhaseInSet('Res_BioMass') = yes;
PhaseInSet('P_Biomass') = yes;
PhaseInSet('P_Biomass_CCS') = yes;
*PhaseInSet('P_Biomass_CCS') = yes;
*PhaseInSet('HHI_BF_BOF_CCS') = yes;
*PhaseInSet('HHI_DRI_EAF_CCS') = yes;
*PhaseInSet('HLI_Biomass_CHP_CCS') = yes;
*PhaseInSet('HLI_Hardcoal_CHP_CCS') = yes;
*PhaseInSet('HLI_Lignite_CHP_CCS') = yes;
*PhaseInSet('HLR_Biomass_CHP_CCS') = yes;
*PhaseInSet('HLR_Hardcoal_CHP_CCS') = yes;
*PhaseInSet('HLR_Lignite_CHP_CCS') = yes;
*PhaseInSet('HMI_Gas_CCS') = yes;
*PhaseInSet('HMI_HardCoal_CCS') = yes;
*PhaseInSet('P_Coal_Hardcoal_CCS') = yes;
*PhaseInSet('P_Coal_Lignite_CCS') = yes;
*PhaseInSet('P_Gas_CCS') = yes;
PhaseInSet('X_SMR_CCS') = yes;
PhaseInSet('X_DAC_LT') = yes;
PhaseInSet('X_DAC_HT') = yes;
PhaseInSet('HLR_H2_Boiler') = yes;
PhaseInSet('HLI_H2_Boiler') = yes;
PhaseInSet('FRT_Road_BEV') = yes;
PhaseInSet('FRT_Road_H2') = yes;
PhaseInSet('FRT_Road_PHEV') = yes;
PhaseInSet('FRT_Road_OH') = yes;
PhaseInSet('FRT_Ship_Bio') = yes;
PhaseInSet('PSNG_Air_Bio') = yes;
PhaseInSet('PSNG_Air_H2') = yes;
PhaseInSet('PSNG_Road_BEV') = yes;
PhaseInSet('PSNG_Road_H2') = yes;
PhaseInSet('PSNG_Road_PHEV') = yes;
PhaseInSet('P_H2_OCGT') = yes;
PhaseInSet('CHP_Biomass_Solid') = yes;
PhaseInSet('CHP_Gas_CCGT_Biogas') = yes;
PhaseInSet('CHP_Gas_CCGT_SynGas') = yes;
PhaseInSet('CHP_Biomass_Solid_CCS') = yes;
PhaseInSet('CHP_Coal_Hardcoal_CCS') = yes;
PhaseInSet('CHP_Coal_Lignite_CCS') = yes;
PhaseInSet('CHP_Gas_CCGT_Natural_CCS') = yes;
PhaseInSet('CHP_Gas_CCGT_Biogas_CCS') = yes;
PhaseInSet('CHP_Hydrogen_FuelCell') = yes;
PhaseInSet(CCS) = yes;


Set PhaseOutSet(t);
PhaseOutSet(t) = no;
PhaseOutSet('P_Coal_Hardcoal') = yes;
PhaseOutSet('P_Coal_Lignite') = yes;
*PhaseOutSet('P_Gas') = yes;
*PhaseOutSet('P_Nuclear') = yes;
PhaseOutSet('P_Oil') = yes;
PhaseOutSet('HLR_Gas_Boiler') = yes;
*PhaseOutSet('HLR_Gas_CHP') = yes;
PhaseOutSet('HLR_Hardcoal') = yes;
PhaseOutSet('HLR_Lignite') = yes;
*PhaseOutSet('HLR_Hardcoal_CHP') = yes;
*PhaseOutSet('HLR_Lignite_CHP') = yes;
PhaseOutSet('HLR_Oil_Boiler') = yes;
PhaseOutSet('HLI_Gas_Boiler') = yes;
*PhaseOutSet('HLI_Gas_CHP') = yes;
PhaseOutSet('HLI_Hardcoal') = yes;
PhaseOutSet('HLI_Lignite') = yes;
*PhaseOutSet('HLI_Hardcoal_CHP') = yes;
*PhaseOutSet('HLI_Lignite_CHP') = yes;
PhaseOutSet('HLI_Oil_Boiler') = yes;
*PhaseOutSet('HLI_Oil_CHP') = yes;
PhaseOutSet('HMI_Gas') = yes;
PhaseOutSet('HMI_HardCoal') = yes;
PhaseOutSet('HMI_Oil') = yes;
PhaseOutSet('HHI_BF_BOF') = yes;
PhaseOutSet('CHP_Coal_Hardcoal') = yes;
PhaseOutSet('CHP_Coal_Lignite') = yes;
PhaseOutSet('CHP_Oil') = yes;

Set HeatSlowRamper(t);
HeatSlowRamper(t) = no;
*HeatSlowRamper('HLR_Hardcoal_CHP') = yes;
*HeatSlowRamper('HLR_Lignite_CHP') = yes;
*HeatSlowRamper('HLR_Biomass_CHP') = yes;
HeatSlowRamper('HLR_Oil_Boiler') = yes;

*HeatSlowRamper('HLI_Hardcoal_CHP') = yes;
*HeatSlowRamper('HLI_Lignite_CHP') = yes;
HeatSlowRamper('HLI_Oil_Boiler') = yes;
*HeatSlowRamper('HLI_Oil_CHP') = yes;
*HeatSlowRamper('HLI_Biomass_CHP') = yes;

HeatSlowRamper('HHI_BF_BOF') = yes;
HeatSlowRamper('HHI_DRI_EAF') = yes;
HeatSlowRamper('HHI_Scrap_EAF') = yes;
HeatSlowRamper('HHI_H2DRI_EAF') = yes;
HeatSlowRamper('HHI_Molten_Electrolysis') = yes;
HeatSlowRamper('HHI_Bio_BF_BOF') = yes;

HeatSlowRamper('HHI_BF_BOF_CCS') = yes;
HeatSlowRamper('HHI_DRI_EAF_CCS') = yes;
*HeatSlowRamper('HLI_Biomass_CHP') = yes;
*HeatSlowRamper('HLI_Hardcoal_CHP_CCS') = yes;
*HeatSlowRamper('HLI_Lignite_CHP_CCS') = yes;
*HeatSlowRamper('HLR_Biomass_CHP') = yes;
*HeatSlowRamper('HLR_Hardcoal_CHP_CCS') = yes;
*HeatSlowRamper('HLR_Lignite_CHP_CCS') = yes;


Set HeatQuickRamper(t);
HeatQuickRamper(t) = no;
HeatQuickRamper('HLR_Hardcoal') = yes;
HeatQuickRamper('HLR_Lignite') = yes;
HeatQuickRamper('HLR_Biomass') = yes;

HeatQuickRamper('HLR_Gas_Boiler') = yes;
*HeatQuickRamper('HLR_Gas_CHP') = yes;
HeatQuickRamper('HLR_Direct_Electric') = yes;
HeatQuickRamper('HLR_H2_Boiler') = yes;
HeatQuickRamper('HLI_Hardcoal') = yes;
HeatQuickRamper('HLI_Lignite') = yes;

HeatQuickRamper('HLI_Biomass') = yes;
HeatQuickRamper('HLI_Gas_Boiler') = yes;
*HeatQuickRamper('HLI_Gas_CHP') = yes;
HeatQuickRamper('HLI_Direct_Electric') = yes;
HeatQuickRamper('HLI_H2_Boiler') = yes;

HeatQuickRamper('HMI_Gas') = yes;
HeatQuickRamper('HMI_Steam_Electric') = yes;
HeatQuickRamper('HMI_Gas_CCS') = yes;
HeatQuickRamper('HMI_Biomass') = yes;
HeatQuickRamper('HMI_HardCoal') = yes;
HeatQuickRamper('HMI_Oil') = yes;
HeatQuickRamper('HMI_HardCoal_CCS') = yes;

set Hydro(t);
Hydro(t) = no;
Hydro('Res_Hydro_large') = yes;
Hydro('Res_Hydro_small') = yes;

set Geothermal(t);
Geothermal(t) = no;
Geothermal('Res_Geothermal') = yes;
Geothermal('HLR_Geothermal') = yes;
Geothermal('HLI_Geothermal') = yes;

set Onshore(t);
Onshore(t) = no;
Onshore('Res_Wind_Onshore_opt') = yes;
Onshore('Res_Wind_Onshore_avg') = yes;
Onshore('Res_Wind_Onshore_inf') = yes;

set Offshore(t);
Offshore(t) = no;
Offshore('Res_Wind_Offshore_Deep') = yes;
Offshore('Res_Wind_Offshore_Shallow') = yes;
Offshore('Res_Wind_Offshore_Transitional') = yes;

set SolarUtility(t);
SolarUtility(t) = no;
SolarUtility('Res_pv_utility_opt') = yes ;
SolarUtility('Res_pv_utility_avg') = yes ;
SolarUtility('Res_pv_utility_inf') = yes ;

set Oil(t);
Oil(t) = no;
Oil('P_Oil') = yes;
Oil('HMI_Oil') = yes;
Oil('HLI_Oil_Boiler') = yes;
*Oil('HLI_Oil_CHP') = yes;
Oil('HLR_Oil_Boiler') = yes;
Oil('CHP_Oil') = yes;

set HeatLowRes(t);
HeatLowRes(t) = no;
HeatLowRes('HLR_Gas_Boiler') = yes;
*HeatLowRes('HLR_Gas_CHP') = yes;
HeatLowRes('HLR_Biomass') = yes;
*HeatLowRes('HLR_Biomass_CHP') = yes;
HeatLowRes('HLR_Hardcoal') = yes;
HeatLowRes('HLR_Lignite') = yes;
*HeatLowRes('HLR_Hardcoal_CHP') = yes;
*HeatLowRes('HLR_Lignite_CHP') = yes;
HeatLowRes('HLR_Direct_Electric') = yes;
HeatLowRes('HLR_Solar_Thermal') = yes;
HeatLowRes('HLR_Heatpump_Aerial') = yes;
HeatLowRes('HLR_Heatpump_Ground') = yes;
HeatLowRes('HLR_Geothermal') = yes;
HeatLowRes('HLR_Oil_Boiler') = yes;
HeatLowRes('HLR_Convert_DH') = yes;

set HeatLowInd(t);
HeatLowInd(t) = no;
HeatLowInd('HLI_Gas_Boiler') = yes;
*HeatLowInd('HLI_Gas_CHP') = yes;
HeatLowInd('HLI_Biomass') = yes;
*HeatLowInd('HLI_Biomass_CHP') = yes;
HeatLowInd('HLI_Hardcoal') = yes;
HeatLowInd('HLI_Lignite') = yes;
*HeatLowInd('HLI_Hardcoal_CHP') = yes;
*HeatLowInd('HLI_Lignite_CHP') = yes;
HeatLowInd('HLI_Direct_Electric') = yes;
HeatLowInd('HLI_Solar_Thermal') = yes;
HeatLowInd('HLI_Fuelcell') = yes;
HeatLowInd('HLI_Geothermal') = yes;
HeatLowInd('HLI_Oil_Boiler') = yes;
*HeatLowInd('HLI_Oil_CHP') = yes;
HeatLowInd('HLI_Convert_DH') = yes;

set HeatMedInd(t);
HeatMedInd(t) = no;
HeatMedInd('HMI_Gas') = yes;
HeatMedInd('HMI_Biomass') = yes;
HeatMedInd('HMI_HardCoal') = yes;
HeatMedInd('HMI_Steam_Electric') = yes;
HeatMedInd('HMI_Oil') = yes;

set HeatHighInd(t);
HeatHighInd(t) = no;
HeatHighInd('HHI_BF_BOF') = yes;
HeatHighInd('HHI_DRI_EAF') = yes;
HeatHighInd('HHI_Scrap_EAF') = yes;
HeatHighInd('HHI_H2DRI_EAF') = yes;
HeatHighInd('HHI_Molten_Electrolysis') = yes;
HeatHighInd('HHI_Bio_BF_BOF') = yes;

Set Biomass(t);
Biomass(t) = no;
Biomass('RES_Grass') = yes;
Biomass('RES_Wood') = yes;
Biomass('RES_Residues') = yes;
Biomass('RES_Paper_Cardboard') = yes;
Biomass('RES_Roundwood') = yes;
Biomass('RES_Biogas') = yes;

$ontext


*
* OLD SUBSETS BELOW: not used for China branch
*

*
* ####### Solar #############

* ####### Coal #############
set CoalResource(t);
CoalResource(t) = no;
CoalResource('Z_Import_Hardcoal') = yes;
CoalResource('R_Coal_Hardcoal') = yes;
CoalResource('R_Coal_Lignite') = yes;



set
Solar(t)
Night(l_full)
;
Solar(t) = no;
Solar('Res_pv_Rooftop_Residential') = yes ;
Solar('Res_pv_Rooftop_commercial') = yes ;
Solar('Res_pv_utility_opt') = yes ;
Solar('Res_pv_utility_avg') = yes ;
Solar('Res_pv_utility_inf') = yes ;
Solar('Res_csp') = yes ;
*Solar('Res_CSP_Storage') = yes ;
Solar('HLR_Solar_Thermal') = yes;
Solar('HLI_Solar_Thermal') = yes;

*$ifthen %timeseries% == elmod
*$else
Night(l_full) = no ;
Night('Q1N') = yes;
Night('Q2N') = yes;
Night('Q3N') = yes;
Night('Q4N') = yes;
*$endif



set PowerBiomass(t);
PowerBiomass(t) = no;
PowerBiomass('P_Biomass') = yes;
PowerBiomass('P_Biomass_CCS') = yes;
PowerBiomass('HLR_Biomass_CHP') = yes;
PowerBiomass('HLI_Biomass_CHP') = yes;






* ####### Transport #############


* ####### Passenger Transport #############


* ####### Renewables #############
set RenewablesPower(t);
alias (RenewablesPower,RES_P);
RenewablesPower(t) = no;
RenewablesPower('Res_Wind_Offshore_Deep') = yes;
RenewablesPower('Res_Wind_Offshore_Shallow') = yes;
RenewablesPower('Res_Wind_Offshore_Transitional') = yes;
RenewablesPower('Res_Wind_Onshore_opt') = yes;
RenewablesPower('Res_Wind_Onshore_avg') = yes;
RenewablesPower('Res_Wind_Onshore_inf') = yes;
RenewablesPower('Res_PV_Rooftop_Residential') = yes;
RenewablesPower('Res_PV_Rooftop_commercial') = yes;
RenewablesPower('Res_PV_utility_opt') = yes;
RenewablesPower('Res_PV_utility_avg') = yes;
RenewablesPower('Res_PV_utility_inf') = yes;
*Renewables('Res_CSP_Storage') = yes;
RenewablesPower('Res_CSP') = yes;
RenewablesPower('Res_Geothermal') = yes;
RenewablesPower('Res_Hydro_Small') = yes;
RenewablesPower('Res_Hydro_Large') = yes;
RenewablesPower('Res_Ocean') = yes;
*RenewablesPower('Res_BioMass') = yes;
RenewablesPower('P_Biomass') = yes;
RenewablesPower('P_Biomass_CCS') = yes;

* ####### Geothermal #############


* ####### Renewables #############
set Renewables(t);
alias (Renewables,RES);
Renewables(t) = no;
Renewables('Res_Wind_Offshore_Deep') = yes;
Renewables('Res_Wind_Offshore_Shallow') = yes;
Renewables('Res_Wind_Offshore_Transitional') = yes;
Renewables('Res_Wind_Onshore_opt') = yes;
Renewables('Res_Wind_Onshore_avg') = yes;
Renewables('Res_Wind_Onshore_inf') = yes;
Renewables('Res_PV_Rooftop_Residential') = yes;
Renewables('Res_PV_Rooftop_commercial') = yes;
Renewables('Res_PV_utility_opt') = yes;
Renewables('Res_PV_utility_avg') = yes;
Renewables('Res_PV_utility_inf') = yes;
*Renewables('Res_CSP_Storage') = yes;
Renewables('Res_CSP') = yes;
Renewables('Res_Geothermal') = yes;
Renewables('Res_Hydro_Small') = yes;
Renewables('Res_Hydro_Large') = yes;
Renewables('Res_Ocean') = yes;
Renewables('Res_BioMass') = yes;
Renewables('P_Biomass') = yes;
Renewables('P_Biomass_CCS') = yes;
* Heat Renewables
Renewables('HLR_Biomass') = yes;
Renewables('HLR_Biomass_CHP') = yes;
Renewables('HLR_Direct_Electric') = yes;
Renewables('HLR_Solar_Thermal') = yes;
Renewables('HLR_Heatpump_Aerial') = yes;
Renewables('HLR_Heatpump_Ground') = yes;
Renewables('HLR_Geothermal') = yes;

Renewables('HLI_Biomass') = yes;
Renewables('HLI_Biomass_CHP') = yes;
Renewables('HLI_Direct_Electric') = yes;
Renewables('HLI_Solar_Thermal') = yes;
Renewables('HLI_Fuelcell') = yes;
Renewables('HLI_Geothermal') = yes;

Renewables('HMI_Biomass') = yes;
Renewables('HMI_Steam_Electric') = yes;

Renewables('HHI_Scrap_EAF') = yes;
Renewables('HHI_H2DRI_EAF') = yes;
Renewables('HHI_Molten_Electrolysis') = yes;
Renewables('HHI_Bio_BF_BOF') = yes;

Renewables('HLR_H2_Boiler') = yes;
Renewables('HLI_H2_Boiler') = yes;

*Renewables('P_Gas') = yes;
*Renewables('HHT_Gas') = yes;
*Renewables('HLT_Gas') = yes;
*Renewables('CHP_Gas') = yes;

*
* ####### Sets for Fossil Energy Carriers #############
*
set Coal(t);
Coal(t) = no;
Coal('P_Coal_Hardcoal') = yes;
Coal('P_Coal_Lignite') = yes;

Coal('HLR_Hardcoal') = yes;
Coal('HLR_Lignite') = yes;
Coal('HLR_Hardcoal_CHP') = yes;
Coal('HLR_Lignite_CHP') = yes;

Coal('HLI_Hardcoal') = yes;
Coal('HLI_Lignite') = yes;
Coal('HLI_Hardcoal_CHP') = yes;
Coal('HLI_Lignite_CHP') = yes;

Coal('HMI_HardCoal') = yes;
Coal('HHI_BF_BOF') = yes;

Coal('HHI_BF_BOF_CCS') = yes;
Coal('HLI_Hardcoal_CHP_CCS') = yes;
Coal('HLI_Lignite_CHP_CCS') = yes;
Coal('HLR_Hardcoal_CHP_CCS') = yes;
Coal('HLR_Lignite_CHP_CCS') = yes;
Coal('HMI_HardCoal_CCS') = yes;
Coal('P_Coal_Hardcoal_CCS') = yes;
Coal('P_Coal_Lignite_CCS') = yes;



set Lignite(t);
Lignite(t) = no;
Lignite('P_Coal_Lignite') = yes;
Lignite('HLR_Lignite') = yes;
Lignite('HLR_Lignite_CHP') = yes;
Lignite('HLI_Lignite') = yes;
Lignite('HLI_Lignite_CHP') = yes;

Lignite('P_Coal_Lignite_CCS') = yes;
Lignite('HLR_Lignite_CHP_CCS') = yes;
Lignite('HLI_Lignite_CHP_CCS') = yes;

set Gas(t);
Gas(t) = no;
Gas('P_Gas') = yes;
Gas('HLR_Gas_Boiler') = yes;
Gas('HLR_Gas_CHP') = yes;
Gas('HLI_Gas_Boiler') = yes;
Gas('HLI_Gas_CHP') = yes;
Gas('HMI_Gas') = yes;
Gas('HHI_DRI_EAF') = yes;

Gas('HHI_DRI_EAF_CCS') = yes;
Gas('HMI_Gas_CCS') = yes;
Gas('P_Gas_CCS') = yes;

set Oil(t);
Oil(t) = no;
Oil('P_Oil') = yes;
Oil('HMI_Oil') = yes;
Oil('HLI_Oil_Boiler') = yes;
Oil('HLI_Oil_CHP') = yes;
Oil('HLR_Oil_Boiler') = yes;

set Nuclear(t);
Nuclear(t) = no;
Nuclear('P_Nuclear') = yes;


set Power(t);
Power(t) = no;

Power('HLR_Heatpump_Aerial') = yes;
Power('HLR_Heatpump_Ground') = yes;
Power('HLI_Direct_Electric') = yes;
Power('HLI_Fuelcell') = yes;
Power('HMI_Steam_Electric') = yes;
Power('HHI_Scrap_EAF') = yes;
Power('HHI_H2DRI_EAF') = yes;
Power('HHI_Molten_Electrolysis') = yes;


set CHPs(t);
CHPs(t) = no;

CHPs('HLR_Gas_CHP') = yes;
CHPs('HLR_Biomass_CHP') = yes;
CHPs('HLR_Hardcoal_CHP') = yes;
CHPs('HLR_Lignite_CHP') = yes;
CHPs('HLI_Gas_CHP') = yes;
CHPs('HLI_Biomass_CHP') = yes;
CHPs('HLI_Hardcoal_CHP') = yes;
CHPs('HLI_Lignite_CHP') = yes;
CHPs('HLI_Fuelcell') = yes;
CHPs('HLI_Oil_CHP') = yes;

*
* ####### Renewable Fuels #############
*
set REFuels(f);
REFuels(f) = no;
REFuels('Power') = yes;
REFuels('Heat_Low_Residual') = yes;
REFuels('Heat_Low_Industrial') = yes;
REFuels('Heat_Medium_Industrial') = yes;
REFuels('Heat_High_Industrial') = yes;

set HeatFuels(f);
HeatFuels(f) = no;
HeatFuels('Heat_Low_Residual') = yes;
HeatFuels('Heat_Low_Industrial') = yes;
HeatFuels('Heat_Medium_Industrial') = yes;
HeatFuels('Heat_High_Industrial') = yes;




*
* ####### Storage Dummies #############
*
set ST(t);
ST(t) = no;
ST('D_Battery_Li-Ion') = yes;
ST('D_Battery_Redox') = yes;
ST('D_Gas_Methane') = yes;
ST('D_Gas_H2') = yes;
ST('D_Heat_HLI') = yes;
ST('D_Heat_HLR') = yes;
ST('D_PHS') = yes;
ST('D_CAES') = yes;

*
* ####### Fossil Power Production #############
*
set FP(t);
FP(t) = no;
FP('P_Coal_Hardcoal') = yes;
FP('P_Coal_Lignite') = yes;
FP('P_Gas') = yes;
FP('P_Nuclear') = yes;
FP('P_Oil') = yes;
FP('P_Coal_Hardcoal_CCS') = yes;
FP('P_Coal_Lignite_CCS') = yes;
FP('P_Gas_CCS') = yes;

set FP_C(t);
FP_C(t) = no;
FP_C('P_Coal_Hardcoal') = yes;
FP_C('P_Coal_Lignite') = yes;
FP_C('HLR_Hardcoal_CHP') = yes;
FP_C('HLR_Lignite_CHP') = yes;
FP_C('HLI_Hardcoal_CHP') = yes;
FP_C('HLI_Lignite_CHP') = yes;

*
* ####### Fossil Heat Production #############
*
set FH(t);
FH(t) = no;
FH('HLR_Gas_Boiler') = yes;
FH('HLR_Gas_CHP') = yes;
FH('HLR_Hardcoal') = yes;
FH('HLR_Lignite') = yes;
FH('HLR_Hardcoal_CHP') = yes;
FH('HLR_Lignite_CHP') = yes;
FH('HLR_Oil_Boiler') = yes;
FH('HLI_Gas_Boiler') = yes;
FH('HLI_Gas_CHP') = yes;
FH('HLI_Hardcoal') = yes;
FH('HLI_Lignite') = yes;
FH('HLI_Hardcoal_CHP') = yes;
FH('HLI_Lignite_CHP') = yes;
FH('HLI_Oil_Boiler') = yes;
FH('HLI_Oil_CHP') = yes;
FH('HMI_Gas') = yes;
FH('HMI_HardCoal') = yes;
FH('HMI_Oil') = yes;
FH('HHI_BF_BOF') = yes;
FH('HHI_DRI_EAF') = yes;


*
* ####### Fossil Fuel Technologies #############
*
set FF(t);
FF(t) = no;
FF('R_Coal_Hardcoal') = yes;
FF('R_Coal_Lignite') = yes;
FF('R_Oil') = yes;
FF('R_Nuclear') = yes;
FF('R_Gas') = yes;
FF('Z_Import_Gas') = yes;
FF('Z_Import_Oil') = yes;
FF('Z_Import_Hardcoal') = yes;


* ####### Wind #############
set Wind(t);
Wind(t) = no;
Wind('Res_Wind_Offshore_Deep') = yes;
Wind('Res_Wind_Offshore_Shallow') = yes;
Wind('Res_Wind_Offshore_Transitional') = yes;
Wind('Res_Wind_Onshore_opt') = yes;
Wind('Res_Wind_Onshore_avg') = yes;
Wind('Res_Wind_Onshore_inf') = yes;


* ####### Wind #############
set Onshore(t);
Onshore(t) = no;
Onshore('Res_Wind_Onshore_opt') = yes;
Onshore('Res_Wind_Onshore_avg') = yes;
Onshore('Res_Wind_Onshore_inf') = yes;


* ####### Wind #############
set Offshore(t);
Offshore(t) = no;
Offshore('Res_Wind_Offshore_Deep') = yes;
Offshore('Res_Wind_Offshore_Shallow') = yes;
Offshore('Res_Wind_Offshore_Transitional') = yes;

* ####### Solar Utility #############
set SolarUtility(t);
SolarUtility(t) = no;
SolarUtility('Res_pv_utility_opt') = yes ;
SolarUtility('Res_pv_utility_avg') = yes ;
SolarUtility('Res_pv_utility_inf') = yes ;


* ####### Hydro #############



* ####### Heat #############
set Heat(t);
Heat(t) = no;
Heat('HLR_Gas_Boiler') = yes;
Heat('HLR_Gas_CHP') = yes;
Heat('HLR_Biomass') = yes;
Heat('HLR_Biomass_CHP') = yes;
Heat('HLR_Hardcoal') = yes;
Heat('HLR_Lignite') = yes;
Heat('HLR_Hardcoal_CHP') = yes;
Heat('HLR_Lignite_CHP') = yes;
Heat('HLR_Direct_Electric') = yes;
Heat('HLR_Solar_Thermal') = yes;
Heat('HLR_Heatpump_Aerial') = yes;
Heat('HLR_Heatpump_Ground') = yes;
Heat('HLR_Geothermal') = yes;
Heat('HLR_Oil_Boiler') = yes;
Heat('HLI_Gas_Boiler') = yes;
Heat('HLI_Gas_CHP') = yes;
Heat('HLI_Biomass') = yes;
Heat('HLI_Biomass_CHP') = yes;
Heat('HLI_Hardcoal') = yes;
Heat('HLI_Lignite') = yes;
Heat('HLI_Hardcoal_CHP') = yes;
Heat('HLI_Lignite_CHP') = yes;
Heat('HLI_Direct_Electric') = yes;
Heat('HLI_Solar_Thermal') = yes;
Heat('HLI_Fuelcell') = yes;
Heat('HLI_Geothermal') = yes;
Heat('HLI_Oil_Boiler') = yes;
Heat('HLI_Oil_CHP') = yes;
Heat('HMI_Gas') = yes;
Heat('HMI_Biomass') = yes;
Heat('HMI_HardCoal') = yes;
Heat('HMI_Steam_Electric') = yes;
Heat('HMI_Oil') = yes;
Heat('HHI_BF_BOF') = yes;
Heat('HHI_DRI_EAF') = yes;
Heat('HHI_Scrap_EAF') = yes;
Heat('HHI_H2DRI_EAF') = yes;
Heat('HHI_Molten_Electrolysis') = yes;
Heat('HHI_Bio_BF_BOF') = yes;

Heat('HHI_BF_BOF_CCS') = yes;
Heat('HHI_DRI_EAF_CCS') = yes;
Heat('HLI_Biomass_CHP') = yes;
Heat('HLI_Hardcoal_CHP_CCS') = yes;
Heat('HLI_Lignite_CHP_CCS') = yes;
Heat('HLR_Biomass_CHP') = yes;
Heat('HLR_Hardcoal_CHP_CCS') = yes;
Heat('HLR_Lignite_CHP_CCS') = yes;
Heat('HMI_Gas_CCS') = yes;
Heat('HMI_HardCoal_CCS') = yes;

Heat('HLR_H2_Boiler') = yes;
Heat('HLI_H2_Boiler') = yes;


*$ontext

set HeatHighRenewable(t);
HeatHighRenewable(t) = no;
HeatHighRenewable('HHT_Biomass') = Yes;
HeatHighRenewable('HHT_Electric_Furnace') = yes;
HeatHighRenewable('HHT_Geothermal') = yes;
HeatHighRenewable('HHT_H2') = yes;

set HeatLowRenewable(t);
HeatLowRenewable(t) = no;
*HeatLowRenewable('CHP_Biomass') = yes;
*HeatLowRenewable('CHP_Gas') = yes;
HeatLowRenewable('HLT_Biomass') = Yes;
HeatLowRenewable('HLT_Electric_Furnace') = yes;
HeatLowRenewable('HLT_Geothermal') = yes;
HeatLowRenewable('HLT_Heatpump') = yes;

set HeatFossil(t);
HeatFossil(t) = no;
HeatFossil('CHP_Coal_Hardcoal') = yes;
HeatFossil('CHP_Coal_Lignite') = yes;
HeatFossil('CHP_Nuclear') = yes;
HeatFossil('HHT_Biomass') = Yes;
HeatFossil('HHT_Coal_Hardcoal') = yes;
HeatFossil('HHT_Coal_Lignite') = yes;
HeatFossil('HHT_Oil') = yes;
HeatFossil('HLT_Coal_Hardcoal') = yes;
HeatFossil('HLT_Coal_Lignite') = yes;

*$offtext






$offtext


set Households(t);
Households(t) = no;
Households('RES_PV_Rooftop_Residential') = yes;
Households('HLR_Gas_Boiler') = yes;
Households('HLR_Biomass') = yes;
Households('HLR_Hardcoal') = yes;
Households('HLR_Direct_Electric') = yes;
Households('HLR_Solar_Thermal') = yes;
Households('HLR_Heatpump_Aerial') = yes;
Households('HLR_Heatpump_Ground') = yes;
Households('HLR_Oil_Boiler') = yes;


set Companies(t);
Companies(t) = yes;
Companies('RES_PV_Rooftop_Residential') = no;
Companies('HLR_Gas_Boiler') = no;
Companies('HLR_Biomass') = no;
Companies('HLR_Hardcoal') = no;
Companies('HLR_Direct_Electric') = no;
Companies('HLR_Solar_Thermal') = no;
Companies('HLR_Heatpump_Aerial') = no;
Companies('HLR_Heatpump_Ground') = no;
Companies('HLR_Oil_Boiler') = no;


set HydrogenTechnologies(t);
HydrogenTechnologies(t) = no;
HydrogenTechnologies('HLI_H2_Boiler') = yes;
HydrogenTechnologies('HMI_H2') = yes;
HydrogenTechnologies('P_H2_OCGT') = yes;
