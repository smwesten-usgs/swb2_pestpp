GRID 661 989 150955.0 673285.0 1000
BASE_PROJECTION_DEFINITION +proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23.0 +lon_0=-96.0 +x_0=0.0 +y_0=0.0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs
%% Define methods
-----------------

DYNAMIC_LANDUSE
INTERCEPTION_METHOD              BUCKET
EVAPOTRANSPIRATION_METHOD        HARGREAVES
RUNOFF_METHOD                    CURVE_NUMBER
SOIL_MOISTURE_METHOD             FAO-56_TWO_STAGE
PRECIPITATION_METHOD             GRIDDED
GROWING_DEGREE_DAY_METHOD        BASKERVILLE_EMIN
FOG_METHOD                       NONE
FLOW_ROUTING_METHOD              NONE
IRRIGATION_METHOD                FAO-56
ROOTING_DEPTH_METHOD             DYNAMIC
CROP_COEFFICIENT_METHOD          FAO-56
DIRECT_RECHARGE_METHOD           NONE
SOIL_STORAGE_MAX_METHOD          CALCULATED
AVAILABLE_WATER_CONTENT_METHOD   GRIDDED

%% define location, projection, and conversions for weather data
----------------------------------------------------------------

PRECIPITATION NETCDF daymet_v3_prcp_%y_na.nc4
PRECIPITATION_GRID_PROJECTION_DEFINITION +proj=lcc +lat_1=25.0 +lat_2=60.0 +lat_0=42.5 +lon_0=-100.0 +x_0=0.0 +y_0=0.0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs
PRECIPITATION_NETCDF_Z_VAR                prcp
PRECIPITATION_SCALE_FACTOR          0.03937008
PRECIPITATION_MISSING_VALUES_CODE      -9999.0
PRECIPITATION_MISSING_VALUES_OPERATOR      <=
PRECIPITATION_MISSING_VALUES_ACTION       zero

TMAX NETCDF daymet_v3_tmax_%y_na.nc4
TMAX_GRID_PROJECTION_DEFINITION +proj=lcc +lat_1=25.0 +lat_2=60.0 +lat_0=42.5 +lon_0=-100.0 +x_0=0.0 +y_0=0.0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs
TMAX_SCALE_FACTOR                 1.8
TMAX_ADD_OFFSET                  32.0
TMAX_MISSING_VALUES_CODE      -9999.0
TMAX_MISSING_VALUES_OPERATOR      <=
TMAX_MISSING_VALUES_ACTION       mean

TMIN NETCDF daymet_v3_tmin_%y_na.nc4
TMIN_GRID_PROJECTION_DEFINITION +proj=lcc +lat_1=25.0 +lat_2=60.0 +lat_0=42.5 +lon_0=-100.0 +x_0=0.0 +y_0=0.0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs
TMIN_SCALE_FACTOR                 1.8
TMIN_ADD_OFFSET                  32.0
TMIN_MISSING_VALUES_CODE      -9999.0
TMIN_MISSING_VALUES_OPERATOR      <=
TMIN_MISSING_VALUES_ACTION       mean

INITIAL_CONTINUOUS_FROZEN_GROUND_INDEX   CONSTANT  100.0
UPPER_LIMIT_CFGI 83.
LOWER_LIMIT_CFGI 55.

INITIAL_PERCENT_SOIL_MOISTURE            CONSTANT  70.0
INITIAL_SNOW_COVER_STORAGE               CONSTANT   0.0

%% specify location and projection for input GIS grids
------------------------------------------------------
%% *** This version has gNATSGO grids for HSG and AWC

#FLOW_DIRECTION ARC_GRID D8_FLOW_DIRECTION__1000m__MAP_expanded.asc
#FLOW_DIRECTION_PROJECTION_DEFINITION  +proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23.0 +lon_0=-96.0 +x_0=0.0 +y_0=0.0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs

HYDROLOGIC_SOILS_GROUP ARC_GRID hsg_corrected_0to150cm_1000m_mapv2.asc
HYDROLOGIC_SOILS_GROUP_PROJECTION_DEFINITION +proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23.0 +lon_0=-96.0 +x_0=0.0 +y_0=0.0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs

LAND_USE ARC_GRID cropland_data_layer__1000m__2016__MAP_expanded.asc
LANDUSE_PROJECTION_DEFINITION +proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23.0 +lon_0=-96.0 +x_0=0.0 +y_0=0.0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs

AVAILABLE_WATER_CONTENT ARC_GRID gnatsgo_awc_in_ft_0to150cm_1000m_map_expv2.asc
AVAILABLE_WATER_CONTENT_PROJECTION_DEFINITION +proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23.0 +lon_0=-96.0 +x_0=0.0 +y_0=0.0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs

IRRIGATION_MASK ARC_GRID irrigation_combined_mask_1000m.asc
IRRIGATION_MASK_PROJECTION_DEFINITION +proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23.0 +lon_0=-96.0 +x_0=0.0 +y_0=0.0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs

#IRRIGATION_MASK CONSTANT 1

%% specify location and names for all lookup tables
---------------------------------------------------

LAND_USE_LOOKUP_TABLE YETI_Landuse_lookup_table_V4.txt
IRRIGATION_LOOKUP_TABLE YETI_Irrigation_lookup_table_V2.txt


%% OUTPUT CONTROL SECTION:
--------------------------------------------------
OUTPUT DISABLE snowmelt snow_storage soil_storage
OUTPUT DISABLE snowfall reference_ET0 runon rainfall 
OUTPUT DISABLE interception tmax tmin runoff_outside
OUTPUT DISABLE rejected_net_infiltration gross_precipitation

%% SIMULATION TIME:
--------------------------------------------------
START_DATE 01/01/1999
END_DATE 12/31/2018


