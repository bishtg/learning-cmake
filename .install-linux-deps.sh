sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y
sudo apt-get update -qq
sudo apt-get install -y cmake gcc-5 libopenmpi-dev openmpi-bin liblapack-dev gfortran-5 mercurial git netcdf-bin libnetcdf-dev 

which gcc-5
which gcc

git clone https://bitbucket.org/petsc/petsc.git

cd petsc

git checkout v3.5.4

export PETSC_DIR=$PWD
export PETSC_ARCH=linux-gnu
./configure PETSC_ARCH=linux-gnu --with-mpi=1 --with-debug=$DEBUG --with-shared-libraries=1
make 


