recursive subroutine quicksort(a, first, last)
  implicit none
  real*8  a(*), x, t
  integer first, last
  integer i, j

  x = a( (first+last) / 2 )
  i = first
  j = last
  do
     do while (a(i) < x)
        i=i+1
     end do
     do while (x < a(j))
        j=j-1
     end do
     if (i >= j) exit
     t = a(i);  a(i) = a(j);  a(j) = t
     i=i+1
     j=j-1
  end do
  if (first < i-1) call quicksort(a, first, i-1)
  if (j+1 < last)  call quicksort(a, j+1, last)
end subroutine quicksort

program prog
implicit none

include "omp_lib.h"

integer, parameter :: width=1117, height=844
integer, parameter :: aw=55
integer :: awp
integer :: ii, jj 
integer :: numProc

real*8 st, et
real*8, dimension(:, :), allocatable :: aa
real*8, dimension(:, :), allocatable :: b
real*8, dimension(:, :), allocatable :: c 

allocate (aa(width,height))
allocate (b(width,height))

awp=(aw-1)/2

open(unit = 8, file = 'test.bin', access = "STREAM", form = "unformatted")
read(8) aa
write(*,*) "Shape of the INPUT:",SHAPE(aa)
close(8)

st = omp_get_wtime()
b=0.0d0

allocate (c(aw, aw)) 
numProc = omp_get_num_procs()
write(*,'(A32,I4)')"Available number of processors: ",numProc
!$omp parallel
!$omp do collapse(2) private(ii,jj,c)
do ii=awp+1, width-awp, 1
    do jj=awp+1, height-awp, 1
        c=aa(ii-awp:ii+awp,jj-awp:jj+awp)
        call quicksort(c,1,aw**2)
        b(ii,jj)=c(awp+1,awp+1)
    enddo
enddo
!$omp end parallel

et = omp_get_wtime()

open(unit = 9, file = 'out.bin', access = "STREAM", form = "unformatted")
write(9) b
close(9)

write(6,"(A,f10.5)") 'Elapsed time - ',et-st

end
