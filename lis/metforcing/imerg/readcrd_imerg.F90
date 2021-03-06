!-----------------------BEGIN NOTICE -- DO NOT EDIT-----------------------
! NASA Goddard Space Flight Center Land Information System (LIS) v7.2
!
! Copyright (c) 2015 United States Government as represented by the
! Administrator of the National Aeronautics and Space Administration.
! All Rights Reserved.
!-------------------------END NOTICE -- DO NOT EDIT-----------------------
!BOP
!
! !ROUTINE: readcrd_imerg
! \label{readcrd_imerg}
!
! !REVISION HISTORY:
! 11 Dec 2003; Sujay Kumar, Initial Code
! 05 Mar 2015; Jonathan Case, adapted for IMERG
!
! !INTERFACE:    
subroutine readcrd_imerg()
! !USES:
  use ESMF 
  use LIS_coreMod, only : LIS_config, LIS_rc
  use LIS_logMod,  only : LIS_logunit
  use imerg_forcingMod, only : imerg_struc
!
! !DESCRIPTION:
!
!  This routine reads the options specific to IMERG forcing from 
!  the LIS configuration file. 
!  
!EOP
  implicit none
  integer :: n, rc

  call ESMF_ConfigFindLabel(LIS_config,"IMERG forcing directory:",rc=rc)
  do n=1, LIS_rc%nnest
     call ESMF_ConfigGetAttribute(LIS_config,imerg_struc(n)%imergdir,rc=rc)
  enddo

!  call ESMF_ConfigFindLabel(LIS_config,"IMERG domain x-dimension size:",rc=rc)
!  do n=1, LIS_rc%nnest
!     call ESMF_ConfigGetAttribute(LIS_config,imerg_struc(n)%ncold,rc=rc)
!  enddo
!  call ESMF_ConfigFindLabel(LIS_config,"IMERG domain y-dimension size:",rc=rc)
!  do n=1, LIS_rc%nnest
!     call ESMF_ConfigGetAttribute(LIS_config,imerg_struc(n)%nrold,rc=rc)
!  enddo

  do n=1, LIS_rc%nnest
     write(LIS_logunit,*)'Using IMERG forcing'
     write(LIS_logunit,*)'IMERG forcing directory : ',trim(imerg_struc(n)%IMERGDIR)
!------------------------------------------------------------------------
! Setting global observed precip times to zero to ensure 
! data is read in during first time step
!------------------------------------------------------------------------
     imerg_struc(n)%imergtime = 0.0
  enddo

end subroutine readcrd_imerg
