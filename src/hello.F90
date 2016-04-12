program main
  !
  use netcdf
  !
  implicit none
  !
#include "finclude/petscsys.h"
#include "finclude/petscvec.h"
#include "finclude/petscvec.h90"
  !
  Vec                 :: v
  PetscInt, parameter :: n = 2
  PetscInt            :: rank, size,i
  PetscReal, pointer  :: v_p(:)
  PetscErrorCode      :: ierr

  ! Code from http://people.sc.fsu.edu/~jburkardt/f_src/netcdf/simple_xy_wr.f90
  character (len = *), parameter :: FILE_NAME = "simple_xy.nc"
  integer, parameter :: NDIMS = 2
  integer, parameter :: NX = 6, NY = 12
  integer :: ncid, varid, dimids(NDIMS)
  integer :: x_dimid, y_dimid
  integer :: data_out(NY, NX)
  integer :: x, y

  call PetscInitialize(PETSC_NULL_CHARACTER,ierr)

  PETSC_COMM_WORLD = MPI_COMM_WORLD

  call MPI_Comm_rank(PETSC_COMM_WORLD, rank, ierr);CHKERRQ(ierr)
  call MPI_Comm_size(PETSC_COMM_WORLD, size, ierr);CHKERRQ(ierr)

  if (rank==0) write(*,*), 'Hello world! Why is everything in color?'

  call VecCreate(PETSC_COMM_WORLD, v, ierr);CHKERRQ(ierr)
  call VecSetSizes(v, n, PETSC_DECIDE, ierr);CHKERRQ(ierr)
  call VecSetFromOptions(v, ierr);

  call VecGetArrayF90(v, v_p, ierr);CHKERRQ(ierr)
  do i = 1,n
     v_p(i) = i + 10.d0*rank
  enddo
  call VecRestoreArrayF90(v, v_p, ierr);CHKERRQ(ierr)

  call VecView(v, PETSC_VIEWER_STDOUT_WORLD, ierr);CHKERRQ(ierr)

  call VecDestroy(v, ierr); CHKERRQ(ierr)

  if (rank == 0) then

     do x = 1, NX
        do y = 1, NY
           data_out(y, x) = (x - 1) * NY + (y - 1)
        end do
     end do

     call check( nf90_create(FILE_NAME, NF90_CLOBBER, ncid) )
     call check( nf90_def_dim(ncid, "x", NX, x_dimid) )
     call check( nf90_def_dim(ncid, "y", NY, y_dimid) )
     dimids =  (/ y_dimid, x_dimid /)
     call check( nf90_def_var(ncid, "data", NF90_INT, dimids, varid) )
     call check( nf90_enddef(ncid) )
     call check( nf90_put_var(ncid, varid, data_out) )
     call check( nf90_close(ncid) )

  endif

  call PetscFinalize(ierr)

  contains

    subroutine check(status)
    integer, intent ( in) :: status

    if(status /= nf90_noerr) then
      print *, trim(nf90_strerror(status))
      stop "Stopped"
    end if
  end subroutine check

end program main

