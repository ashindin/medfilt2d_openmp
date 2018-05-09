# medfilt2d_openmp
Median filter for 2D array of doubles with openmp parallel optimizations

## Dependencies:
1. python3 with requests and json modules.
2. wget.
3. gfortran or ifort.

## Command to download test.bin file:
```bash
python download_test_bin.py
```
## Build command for gfortran:
```bash
gfortran medfilt2d_omp_test.f90 -fopenmp -O3 -o medfilt2d_omp_test.out
```
## Build command for ifort:
```bash
ifort medfilt2d_omp_test.f90 -fopenmp -O3 -o medfilt2d_omp_test.out
```
## Run command:
```bash
./medfilt2d_omp_test.out
```