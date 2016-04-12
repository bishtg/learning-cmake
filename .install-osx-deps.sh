# Install required software
brew update
brew install openmpi git 
brew install netcdf --enable-fortran

git clone https://bitbucket.org/petsc/petsc.git

cd petsc

export PETSC_DIR=$PWD
export PETSC_ARCH=osx-gnu
./configure PETSC_ARCH=osx-gnu --with-mpi=1 --with-debug=$DEBUG --with-shared-libraries=1
make 
