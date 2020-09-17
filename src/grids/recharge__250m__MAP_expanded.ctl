GRID 3188 3956 47955.0 673285.0 250
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
FLOW_ROUTING_METHOD              D8
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

FLOW_DIRECTION ARC_GRID D8_FLOW_DIRECTION__250m__MAP_expanded.asc
FLOW_DIRECTION_PROJECTION_DEFINITION  +proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23.0 +lon_0=-96.0 +x_0=0.0 +y_0=0.0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs

HYDROLOGIC_SOILS_GROUP ARC_GRID HYDROLOGIC_SOIL_GROUP__250m__MAP_expanded.asc
HYDROLOGIC_SOILS_GROUP_PROJECTION_DEFINITION +proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23.0 +lon_0=-96.0 +x_0=0.0 +y_0=0.0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs

LAND_USE ARC_GRID cropland_data_layer__250m__%Y__MAP_expanded.asc
LANDUSE_PROJECTION_DEFINITION +proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23.0 +lon_0=-96.0 +x_0=0.0 +y_0=0.0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs

AVAILABLE_WATER_CONTENT ARC_GRID AWC_IN_FT__250m__MAP_expanded.asc
AVAILABLE_WATER_CONTENT_PROJECTION_DEFINITION +proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23.0 +lon_0=-96.0 +x_0=0.0 +y_0=0.0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs

IRRIGATION_MASK ARC_GRID IRRIGATION_MASK__250m__MAP_expanded.asc
IRRIGATION_MASK_PROJECTION_DEFINITION +proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23.0 +lon_0=-96.0 +x_0=0.0 +y_0=0.0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs


%% specify location and names for all lookup tables
---------------------------------------------------

LAND_USE_LOOKUP_TABLE Landuse_lookup_CDL_2016.txt
IRRIGATION_LOOKUP_TABLE Irrigation_lookup_CDL_2016.txt

START_DATE 01/01/2008
END_DATE 12/31/2018


