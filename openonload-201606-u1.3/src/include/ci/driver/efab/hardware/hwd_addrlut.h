/*
** Copyright 2005-2017  Solarflare Communications Inc.
**                      7505 Irvine Center Drive, Irvine, CA 92618, USA
** Copyright 2002-2005  Level 5 Networks Inc.
**
** This program is free software; you can redistribute it and/or modify it
** under the terms of version 2 of the GNU General Public License as
** published by the Free Software Foundation.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
*/

/* this file is autogenerated; use '.../scripts/genheader --type=hwdef'
 * to regenerate */
#ifndef _HWD_ADDRLUT_H
#define _HWD_ADDRLUT_H

extern hwd_ifmapstblentry_t hwd_ifmaps[];

typedef enum {
   HWD_IFMAP_IOBAR,
   HWD_IFMAP_MCPU,
   HWD_IFMAP_MCPUCSRIND,
   HWD_IFMAP_MCPUPORTIND,
   HWD_IFMAP_MEMBAR,
   HWD_IFMAP_MEMBAR_VF,
   HWD_IFMAP_MSIXMEMBAR,
   HWD_IFMAP_MSIXMEMBAR_VF,
   HWD_IFMAP_PCICONFIG,
   HWD_IFMAP_PCICOREMGMT,
   HWD_IFMAP_PCIPFMGMT,
   HWD_IFMAP_PCIVFCONFIG,
   HWD_IFMAP_PCIVFMGMT,
   HWD_IFMAP_LASTP1,
} hw_ifmap_e;


#endif

