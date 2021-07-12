# Direct radiative effects of airborne microplastics

**Authors:** Laura E. Revell<sup>1</sup>, Peter Kuma<sup>1,*</sup>,
Eric C. Le Ru<sup>2</sup>, Walter R. C. Somerville<sup>2</sup>,
Sally K. Gaw<sup>1</sup>

<sup>1</sup>School of Physical and Chemical Sciences, University of Canterbury,
Christchurch 8140, New Zealand.\
<sup>2</sup>The MacDiarmid Institute for Advanced Materials and Nanotechnology,
School of Chemical and Physical Sciences, Victoria University of Wellington,
Wellington 6140, New Zealand.\
<sup>*</sup>Now at: Department of Meteorology, Stockholm University, Stockholm
SE-106 91, Sweden.

This repository contains programs and data accompanying the paper by
Revell et al. (2021), "Direct radiative effects of airborne microplastics".

## Requirements

The programs contained in this repository can be run on a Linux distribution.
They have been tested on the Devuan GNU/Linux 3 (beowulf) Linux distribution
with Python 3.7.3. The original versions of Python packages
used to run the Python scripts are available from the
[Python Package Index (PyPI)](https://pypi.org/):

- numpy 1.20.1
- scipy 1.6.1
- matplotlib 3.3.4
- basemap 1.2.2
- cartopy 0.18.0
- aquarius-time 0.1.0
- pst-format 1.1.1
- ds-format 1.1.0

It is possible to install these packages inside a Python Virtual Environment
(venv) with the command `pip3 install -r requirements.txt`. See Python
documentation on how to set up a virtual environment.

Equivalent Linux distributions such as Ubuntu or Fedora may work equally well.
On Windows, the Windows Subsystem for Linux (WSL) with the Ubuntu distribution
(available from the Microsoft Store), is recommended for running the programs.

The `run_cscatter` and `run_cscatter_average` programs depend on the SOCRATES
radiative transfer code, which is only available to the Unified Model (UM)
Partnership members.

To calculate the optical properties of fibres, R is required (tested on 4.0.2),
as well as MATLAB or octave. The R package provided in
`fibre_optical_property_scripts/Rpathlength_1.1.1.tar.gz` should be installed.

## CIRC cases

Continual Intercomparison of Radiation Codes (CIRC) cases are located
in `data/circ`. Each case contains files extracted from the original input and
output archives of the CIRC case. To process case data and run SOCRATES, use
the following sequence of programs:

- `convert_circ_levels`: Convert levels txt file to NetCDF.
- `prepare_socrates`: Prepare SOCRATES profiles of MP mixing ratio
and get MP aerosol blocks to be inserted into sp_sw_ga7 and sp_lw_ga7.
- `run_socrates`: Run the single column model.
- `plot_profile_all`: Plot the resulting flux and heating rate profiles.

See examples in each program documentation below on how to run it.

## Programs (`bin`)

Below is a list of programs contained in this repository with a brief
description of how to use them. The programs can be executed from the UNIX
command line from the main directory as `bin/<program> <arg>...`, where
`<program>` is the name of the program and `<arg>` are command-line arguments
of the program, documented below.

### calc_rad_eff

Calculate radiative effect.

Usage: `calc_rad_eff <input1> <input2> <output> <plot>`

Arguments:

- `input1`: HadGEM output 1 (directory with NetCDF files).
- `input2`: HadGEM output 2 (directory with NetCDF files).
- `output`: Output file (NetCDF)
- `plot`: Output plot file prefix.

### confidence_intervals

Calculate and print confidence intervals from yearly HadGEM3 model output
files.

Usage: `confidence_intervals <input>`

Arguments:

- `input`: Input yearly files (NetCDF). The files should contain rsut_cs2,
  rlut_cs2, lat and lon variables.

### convert_circ_levels

Convert CIRC `level_input_case<i>.txt` file to NetCDF.

Usage: `convert_circ_levels <input> <output>`

Arguments:

- `input`: Input file (txt). This should be the `level_input_case<n>.txt` file.
- `output`: Output file (NetCDF).

Examples:

Convert CIRC case levels to NetCDF.

```sh
for i in {1..7}; do bin/convert_circ_levels data/circ/case"$i"/level_input_case"$i".txt data/circ/case"$i"/level_input_case"$i".nc; done
```

### convert_size_dist

Convert size distribution CSV file to NetCDF.

Usage: `convert_size_dist <input> <output>`

Arguments:

- `input`: Input file (CSV).
- `output`: Output file (NetCDF).

Examples:

Convert size distribution in `allen2019_fibers.csv` to `allen2019_fibers.nc`.

```sh
bin/convert_size_dist data/size_dist/allen2019_fibers.{csv,nc}
```

### create_size_dist

Create theoretical size distribution.

Usage: `create_size_dist <type> <p1> <p2> <output>`

Arguments:

- `type`: Distribution type ("gamma").
- `p1`: Parameter 1 (shape).
- `p2`: Parameter 2 (scale in um).
- `output`: Output file (NetCDF).

Examples:

Create size distribution for fibers, films and fragments.

```sh
bin/create_size_dist gamma 2.5 250 plot/size_dist_theor/gamma_fibers.nc
bin/create_size_dist gamma 1.5 20 plot/size_dist_theor/gamma_films.nc
bin/create_size_dist gamma 2 15 plot/size_dist_theor/gamma_fragments.nc
```

### gen_refractive_index

Generate theoretical refractive index for use with Cscatter.

Usage: `gen_refractive_index <A> <B> <c0> ... <cn>`

Arguments:

- `A`, `B`: Coefficients of the real part.
- `c0`, ..., `cn`: Coefficients of the imaginary part (n-th order polynomial).

Examples:

Generate refractive index with coefficients as in the paper.

```sh
bin/gen_refractive_index 1.41 1.06e-7 552.717 458.983 140.513 18.8141 0.926965 \
> data/cscatter/refract
```

### plot_abs_sca [Figure 2]

Plot absorption and scattering of microplastics.

Usage: `plot_abs_sca <input> <output>`

Arguments:

- `input`: Input directory with input files (txt).
- `output`: Output plot (PDF).

Example:

Plot absorption and scattering based on txt files in `data/opt_prop`.

```sh
bin/plot_abs_sca data/opt_prop 'plot/Microplastics optical properties.pdf'
```

### plot_color [Extended Data Figure 6]

Plot microplastics color.

Usage: `plot_color <input>... <output>`

Arguments:

- `input`: Input file (CSV).
- `output`: Output plot file (PDF).

Examples:

Plot microplastics color from source files in `data/color`.

```sh
bin/plot_color data/color/*.csv 'plot/Microplastics colour.pdf'
```

### plot_composition [Extended Data Figure 1]

Plot microplastics composition.

Usage: `plot_composition <input> <output> <title>`

Arguments:

- `input`: Input file (CSV).
- `output`: Output plot file (PDF).
- `title`: Plot title.

Examples:

Plot composition of fibers and fragments from source files in `data/composition`.

```sh
bin/plot_composition data/composition/fibers.csv 'plot/Microplastics composition fibers.pdf' fibers
bin/plot_composition data/composition/fragments.csv 'plot/Microplastics composition fragments.pdf' fragments
```

### plot_concentration

Plot microplastics concentration.

Usage: `plot_concentration <input> <output>`

Arguments:

- `input`: Input file (CSV).
- `output`: Output plot file (PDF).

Examples:

Plot microplastics concentration from a source CSV file
`data/concentration/concentration.csv`.

```sh
bin/plot_concentration data/concentration/concentration.csv \
'plot/Microplastics concentration.pdf'
```

### plot_fibers [Extended Data Figure 7]

Plot fiber diameter-to-length ratio.

Usage: `plot_fibers <input> <output>`

Arguments:

- `input`: Input file (CSV).
- `output`: Output plot file (PDF).

Examples:

```sh
bin/plot_fibers data/fibers/bergmann2019.csv 'plot/Fibers aspect ratio.pdf'
```

### plot_fibers_regime

Plot scattering regime of fibers.

Usage: `plot_fiber_regime <output>`

Arguments:

- `output`: Output filename (PDF).

Examples:

Plot scattering regime of fibers.

```sh
bin/plot_fiber_regime 'plot/Scattering regime of fibers.pdf'
```

### plot_map [Figure 1]

Plot MP concentration map.

Usage: `plot_map <output>`

Arguments:

- `output`: Output plot (PDF).

Examples:

Plot MP concentration map in "plot/Microplastics concentration map.pdf".

```sh
bin/plot_map 'plot/Microplastics concentration map.pdf'
```

### plot_morphotype [Extended Data Figure 4]

Plot microplastics shape distribution.

Usage: `plot_morphotype <input> <output>`

Arguments:

- `input`: Input file (CSV).
- `output`: Output plot file (PDF).

Examples:

Plot microplastics shape from a source CSV file `data/morphotype/morphotype.csv`.

```sh
bin/plot_morphotype data/morphotype/morphotype.csv 'plot/Microplastics morphotype.pdf'
```


### plot_mp_rf [Figure 3]

Plot microplastics radiative forcing.

Usage: `plot_mp_rf <output>`

Arguments:

- `output`: Output plot (PDF).

Examples:

```sh
bin/plot_mp_rf 'plot/Microplastics RF.pdf'
```

### plot_opt_prop

Plot optical properties (absorption and scattering cross section) from
Cscatter data.

Usage: `plot_opt_prop <input> <output>`

Arguments:

- `input`: Input file (output of Cscatter).
- `output`: Output plot (PDF).

Examples:

Plot optical properties of fragments.

```sh
bin/plot_opt_prop data/cscatter/opt_prop_fragments \
'plot/Optical properties fragments.pdf'
```

### plot_profile_all

Plot flux profiles of multiple CIRC cases.

Usage: `plot_profile_all <input>... <type> <output> <title>`

Arguments:

- `input`: Input directory.
- `type`: Profile type.
- `output`: Output plot file (PDF).
- `title`: Plot title.

Examples:

Plot profiles of CIRC cases for fragments.

```sh
bin/plot_profile_all data/circ/case* fragments 'plot/CIRC fragments.pdf' 'Microplastic fragments: 100 MP m-3' > 'csv/CIRC fragments.csv'
bin/plot_profile_all data/circ/case* fibers 'plot/CIRC fibers.pdf' 'Microplastic fibers: 100 MP m-3' > 'csv/CIRC fibers.csv'
bin/plot_profile_all data/circ/case* fibers_and_fragments 'plot/CIRC fibers and fragments.pdf' 'Microplastics combined: 100 MP m-3' > 'csv/CIRC fibers and fragments.csv'
bin/plot_profile_all data/circ/case* fibers_and_fragments_2km 'plot/CIRC fibers and fragments (2 km).pdf' 'Microplastics boundary layer: 100 MP m-3' > 'csv/CIRC fibers and fragments (2 km).csv'
```

### plot_refractive_index [Extended Data Figure 5]

Plot refractive index of polymers.

Usage: `plot_refractive_index <input>... <output>`

Arguments:

- `input`: Input file (CSV).
- `output`: Output plot file (PDF).

Examples:

```sh
bin/plot_refractive_index data/refractive_index/*.csv \
'plot/Refractive index.pdf'
```

### plot_size_dist [Extended Data Figure 2 and 3]

Plot particle size distribution.

Usage: `plot_size_dist <input>... <output> <title> <max_x>`

Arguments:

- `input`: Input file (NetCDF).
- `output`: Output file (PDF).
- `title`: Plot title.
- `max_x`: Upper size limit (um).

Examples:

Plot size distribution of fibers and fragments from source files in
`data/size_dist.`

```sh
bin/plot_size_dist data/size_dist/fibers/*.nc 'plot/Microplastics size distribution fibers.pdf' fibers 4000
bin/plot_size_dist data/size_dist/fragments/*.nc 'plot/Microplastics size distribution fragments.pdf' fragments 400
```

### prepare_cscatter

Prepare input for Cscatter_average from a CSV file. The output is printed
to the standard output.

Usage: `prepare_cscatter <input>`

Arguments:

- `input`: Input file with absorption and scattering coefficients and asymmetry
  factor per wavelength (CSV). The CSV file should contain a header line and
  the following columns:

  1. wavelength (m)
  2. absorption coefficient (m<sup>-1</sup>)
  3. scattering coefficient (m<sup>-1</sup>)
  4. asymmetry factor (1)

Examples:

Prepare Cscatter_average input for fibers.

```sh
bin/prepare_cscatter data/opt_prop_fibers/fibers.csv > data/cscatter/opt_prop_fibers
```

### prepare_ea

Prepare EasyAerosol input files (NetCDF). The files are saved in the current
directory.

Usage: `prepare_ea <orog> <opt>`

Arguments:

- `orog`: HadGEM orography file (NetCDF).
- `opt`: Optical properties (py).

Examples:

Prepare EasyAerosol input files for fibers.

```sh
bin/prepare_ea data/orography/qrparm.orog.nc data/ea/fibers.py
```

Prepare EasyAerosol input files for fibers and fragments.

```sh
bin/prepare_ea data/orography/qrparm.orog.nc data/ea/fibers_and_fragments.py
```

Prepare EasyAerosol input files for fibers with peaks in refractive index.

```sh
bin/prepare_ea data/orography/qrparm.orog.nc data/ea/fibers_peak.py
```

Prepare EasyAerosol input files for fragments.

```sh
bin/prepare_ea data/orography/qrparm.orog.nc data/ea/fragments.py
```

### prepare_socrates

Prepare SOCRATES aerosol file. Spectra blocks for shortwave and longwave
and printed to the standard output.

Usage: `prepare_socrates <opt> <levels> <output>`

Arguments:

- `opt`: Optical properties file (py).
- `levels`: Atmosphere levels file (NetCDF). This file should contain variables
    zhalf, phalf and ta.
- `output`: Output file - common for shortwave and longwave (NetCDF).

Examples:

Prepare SOCRATES profiles for CIRC cases. The standard output blocks should be
inserted in the `data/circ/common/sp_{sw,lw}_ga7_<type>` spectral files. These
should be otherwise the same as the original `sp_{sw,lw}_ga7` files.

```sh
for i in {1..7}; do bin/prepare_socrates data/ea/fragments.py data/circ/case"$i"/level_input_case"$i".nc data/circ/case"$i"/case"$i".fragments.nc; done
for i in {1..7}; do bin/prepare_socrates data/ea/fibers.py data/circ/case"$i"/level_input_case"$i".nc data/circ/case"$i"/case"$i".fibers.nc; done
for i in {1..7}; do bin/prepare_socrates data/ea/fibers_and_fragments.py data/circ/case"$i"/level_input_case"$i".nc data/circ/case"$i"/case"$i".fibers_and_fragments.nc; done
for i in {1..7}; do bin/prepare_socrates data/ea/fibers_and_fragments_2km.py data/circ/case"$i"/level_input_case"$i".nc data/circ/case"$i"/case"$i".fibers_and_fragments_2km.nc; done
```

### run_cscatter

Run Cscatter to calculate optical properties of a given constituent.
The output is saved in `data/cscatter/opt_prop_<type>`.

Usage: `run_cscatter <type>`

Arguments:

- `type`: Type of constituent (one of: "fragments", "fragments_fit")

Examples:

Calculate optical properties of fragments.

```sh
bin/run_cscatter fragments
```

Calculate optical properties of fragments (fit).

```sh
bin/run_cscatter fragments_fit
```

### run_cscatter_average

Run Cscatter_average to calculate optical properties of a given constituent
averaged on model spectral bands. The output is saved in
`data/cscatter/avg_sw_<type>` and `data/cscatter/avg_lw_<type>`.

Usage: `run_cscatter <type>`

Arguments:

- `type`: Type of constituent (one of: "fibers", "fragments", "fragments_fit").

Examples:

Calculate averaged optical properties of fibers.

```sh
bin/run_cscatter_average fibers
```

Calculate averaged optical properties of fragments.

```sh
bin/run_cscatter_average fragments
```

Calculate averaged optical properties of fragments (fit).

```sh
bin/run_cscatter_average fragments_fit
```

### run_socrates

Run SOCRATES on CIRC case.

Usage: `bin/run_socrates <dir> <n>`

Arguments:

- `dir`: Directory with the CIRC case.
- `n`: Case number.

Examples:

Run SOCRATES for the 7 CIRC cases.

```sh
for i in {1..7}; do echo "$i"; bin/run_socrates data/circ/case"$i" "$i"; done
```

## Data (`data`)

Below is a list of data files contained in the `data` directory with a brief
description of their meaning.

- `circ`: CIRC cases for running a single column model.
- `color`: Microplastics color distributions sourced from past studies.
- `composition`: Microplastics composition sourced from past studies.
- `morphotype`: Microplastics morphotype sourced from past studies.
- `cscatter`: SOCRATES Cscatter and Cscatter_average input and output files.
- `ea`: EasyAerosol optical properties for use with `prepare_ea`.
- `fibers`: Microplastic fibers length-diameter size distribution sourced from
    past studies.
- `opt_prop`: Optical properties of fragments and fibers.
- `opt_prop_fibers`: Optical properties of fibers.
- `orography`: HadGEM3 orography.
- `refractive_index`: Refractive index of polymers sourced from past studies.
- `size_dist`: Microplastic size distributions sourced from past studies.

## Plots (`plot`)

The directory `plot` contains plots generated with the programs contained
in this repository. Plots which appear in the paper Revell et al. (2021)
are not included in the directory for licensing reasons, but they can be
generated with the programs described above (annotated with the figure number).

## Fibre optical properties (`fibre_optical_property_scripts`)

As provided the scripts are configured for octave,
`fibre_optical_property_scripts/RunLSA.sh` should have octave lines commented
and matlab lines uncommented to use MATLAB.  The script
`fibre_optical_property_scripts/RunLSA.sh` will perform all of the necessary
calculations. A brief outline of the files included follows.

- `calculate_single_wavelength_size_fibre.m`: MATLAB/octave script that
  calculates the optical properties for a fibre in the large size
  approximation.
- `combine_csv.sh`: Shell script to combine many output files into a single
  file.
- `create_input_parameters.m`: MATLAB/octave script to write parameters of
  interest into a file.
- `create_lsa_script.r`: R script that creates a MATLAB/octave script to run
  `calculate_single_wavelength_size_fibre.m` with appropriate parameters.
- `epsPETfit.m`: Dielectric function of PET for calculations.
- `generate_values_for_interpolation.r`: R script that runs ray tracing
  simulations to obtain values needed in fibre calculations. This script takes
  significant time to run.
- `interpolate_ray_tracing_quantities.m`: MATLAB/octave script that
  interpolates output of `generate_values_for_interpolation.r`.
- `Rpathlength_1.1.1.tar.gz`: R package for running ray tracing simulations.
- `RunLSA.sh`: Shell script that runs all other scripts as needed, and outputs
  into `LSA_all_results.csv`.
- `save_lsa_script.r`: R script that is used to save the output of
  `create_lsa_script.r` to a file, and print the filename.

## License

The programs distributed in this repository are available under
the terms of an MIT License.

Copyright (c) 2020, 2021 Peter Kuma, Laura Revell, Eric Le Ru,
Walter Somerville, Sally Gaw

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
