/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/charles/Documents/FPGA/CharlesProc/RAMController.vhd";
extern char *IEEE_P_1242562249;
extern char *IEEE_P_2592010699;

int ieee_p_1242562249_sub_17802405650254020620_1035706684(char *, char *, char *);
unsigned char ieee_p_2592010699_sub_2763492388968962707_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_2138627450_3212880686_p_0(char *t0)
{
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    char *t6;
    unsigned char t7;
    unsigned char t8;
    char *t9;
    char *t10;
    int t11;
    int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;

LAB0:    xsi_set_current_line(28, ng0);
    t2 = (t0 + 1672U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB3;

LAB4:
LAB8:    t22 = xsi_get_transient_memory(16U);
    memset(t22, 0, 16U);
    t23 = t22;
    memset(t23, (unsigned char)4, 16U);
    t24 = (t0 + 4352);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    t27 = (t26 + 56U);
    t28 = *((char **)t27);
    memcpy(t28, t22, 16U);
    xsi_driver_first_trans_fast_port(t24);

LAB2:    t29 = (t0 + 4240);
    *((int *)t29) = 1;

LAB1:    return;
LAB3:    t2 = (t0 + 1992U);
    t9 = *((char **)t2);
    t2 = (t0 + 1512U);
    t10 = *((char **)t2);
    t2 = (t0 + 7008U);
    t11 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t10, t2);
    t12 = (t11 - 0);
    t13 = (t12 * 1);
    xsi_vhdl_check_range_of_index(0, 3, 1, t11);
    t14 = (16U * t13);
    t15 = (0 + t14);
    t16 = (t9 + t15);
    t17 = (t0 + 4352);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t16, 16U);
    xsi_driver_first_trans_fast_port(t17);
    goto LAB2;

LAB5:    t2 = (t0 + 1832U);
    t6 = *((char **)t2);
    t7 = *((unsigned char *)t6);
    t8 = (t7 == (unsigned char)2);
    t1 = t8;
    goto LAB7;

LAB9:    goto LAB2;

}

static void work_a_2138627450_3212880686_p_1(char *t0)
{
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    char *t6;
    unsigned char t7;
    unsigned char t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    int t17;
    int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;

LAB0:    xsi_set_current_line(29, ng0);
    t2 = (t0 + 1672U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)2);
    if (t5 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB3;

LAB4:
LAB8:    t14 = (t0 + 1992U);
    t15 = *((char **)t14);
    t14 = (t0 + 1512U);
    t16 = *((char **)t14);
    t14 = (t0 + 7008U);
    t17 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t16, t14);
    t18 = (t17 - 0);
    t19 = (t18 * 1);
    xsi_vhdl_check_range_of_index(0, 3, 1, t17);
    t20 = (16U * t19);
    t21 = (0 + t20);
    t22 = (t15 + t21);
    t23 = (t0 + 4416);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    t26 = (t25 + 56U);
    t27 = *((char **)t26);
    memcpy(t27, t22, 16U);
    xsi_driver_first_trans_fast(t23);

LAB2:    t28 = (t0 + 4256);
    *((int *)t28) = 1;

LAB1:    return;
LAB3:    t2 = (t0 + 1352U);
    t9 = *((char **)t2);
    t2 = (t0 + 4416);
    t10 = (t2 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t9, 16U);
    xsi_driver_first_trans_fast(t2);
    goto LAB2;

LAB5:    t2 = (t0 + 1832U);
    t6 = *((char **)t2);
    t7 = *((unsigned char *)t6);
    t8 = (t7 == (unsigned char)3);
    t1 = t8;
    goto LAB7;

LAB9:    goto LAB2;

}

static void work_a_2138627450_3212880686_p_2(char *t0)
{
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    char *t5;
    int t6;
    int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;

LAB0:    xsi_set_current_line(30, ng0);
    t1 = (t0 + 992U);
    t2 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB3;

LAB4:
LAB2:    t16 = (t0 + 4272);
    *((int *)t16) = 1;

LAB1:    return;
LAB3:    t3 = (t0 + 2152U);
    t4 = *((char **)t3);
    t3 = (t0 + 1512U);
    t5 = *((char **)t3);
    t3 = (t0 + 7008U);
    t6 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t5, t3);
    t7 = (t6 - 0);
    t8 = (t7 * 1);
    t9 = (16U * t8);
    t10 = (0U + t9);
    t11 = (t0 + 4480);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t4, 16U);
    xsi_driver_first_trans_delta(t11, t10, 16U, 0LL);
    goto LAB2;

}


extern void work_a_2138627450_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2138627450_3212880686_p_0,(void *)work_a_2138627450_3212880686_p_1,(void *)work_a_2138627450_3212880686_p_2};
	xsi_register_didat("work_a_2138627450_3212880686", "isim/Computer_isim_beh.exe.sim/work/a_2138627450_3212880686.didat");
	xsi_register_executes(pe);
}
