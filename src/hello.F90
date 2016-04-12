program main
#include "finclude/petscsys.h"
#include "finclude/petscvec.h"
#include "finclude/petscvec.h90"

  Vec                 :: x
  PetscInt, parameter :: n = 2
  PetscInt            :: rank, size,i
  PetscReal, pointer  :: x_p(:)
  PetscErrorCode      :: ierr

  call PetscInitialize(PETSC_NULL_CHARACTER,ierr)

  PETSC_COMM_WORLD = MPI_COMM_WORLD

  call MPI_Comm_rank(PETSC_COMM_WORLD, rank, ierr);CHKERRQ(ierr)
  call MPI_Comm_size(PETSC_COMM_WORLD, size, ierr);CHKERRQ(ierr)

  if (rank==0) write(*,*), 'Hello world! Why is everything in color?'

  call VecCreate(PETSC_COMM_WORLD, x, ierr);CHKERRQ(ierr)
  call VecSetSizes(x, n, PETSC_DECIDE, ierr);CHKERRQ(ierr)
  call VecSetFromOptions(x);

  call VecGetArrayF90(x, x_p, ierr);CHKERRQ(ierr)
  do i = 1,n
     x_p(i) = i + 10.d0*rank
  enddo
  call VecRestoreArrayF90(x, x_p, ierr);CHKERRQ(ierr)

  call VecView(x, PETSC_VIEWER_STDOUT_WORLD, ierr);CHKERRQ(ierr)

  call VecDestroy(x, ierr); CHKERRQ(ierr)

  call PetscFinalize(ierr)

end program main

