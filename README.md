# swb2_pestpp
WIP: swb2 parameter uncertainty analysis with pest++

Another attempt to standardize the approach to parameter estimation and uncertainty analysis using
Pest++ version 5. The files included here make use of the updated control file format available
in the latest (September 2020) version of Pest++. In particular, extensive use is made of *.csv files
as a means to containerize sections of the control file entries.

The directories are created in order to separate active working files from analysis and model setup files. The
structure is:

| Directory name    | Description                                                             |
|-------------------|----------------------------------------------------------------------------------|
| /jupyter          | jupyter notebooks aimed at pre and post processing files for use with pest       |
| /master           | contains just the files needed to run a pest iteration; programmatically created |
| /src              | template, instruction, and control files needed to run a pest optimization       |
| /src/grids        | gridfiles needed to make a forward run of SWB, or zonefile grids needed for postprocessing |

Ideally, version control plus good commit messages will largely eliminate the need to create a host of similar files of varying provenance (e.g. lu_table_v1.txt, lu_table_v2.txt, etc.).

## File naming conventions

In order to help keep the workspace tidy and the contents understandable, the following filename conventions are suggested:

| File type | Naming pattern  |
|-----------|-----------------|
| simulated values | `simulated_xxxx.txt` or `simulated_xxxx.csv`, where 'xxxx' can be the parameter name and possibly other useful metadata, such as original resolution. *These files are to contain model-generated values or derivatives from the modeled values obtained via postprocessing.* |
| observed values | `observed_xxxx.txt` or `observed_xxx.csv`, where 'xxxx' can be the parameter name and possibly other metadata such as resolution or applicable date range. |
| lookup tables | `lookup_table__xxxx.txt`, where 'xxxx' is one of 'irrigation' or 'landuse'. |
| control file (swb2 or ppest) | `control_file__swb_xxxx.ctl` for a swb control file, and `control_file__ppest_xxxx.pst` for a pest++ control file; xxxx can be added to supply limited additional information. |
|swbstats2 'zone period' file | `zone_period_file__xxxx.csv`, where 'xxxx' can be the parameter name and possibly some other useful metadata. |