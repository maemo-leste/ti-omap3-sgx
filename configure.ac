AC_INIT([ti-omap3-sgx], [1.4.268], [spinal.by@gmail.com])
AM_INIT_AUTOMAKE([foreign])

AC_PROG_LN_S

AC_ARG_WITH([r125],
    AS_HELP_STRING([--with-r125], [select SGX core revision 1.2.5 (default is 1.2.1)]))
AS_IF([test "x$with_r125" != "xyes"], [AC_SUBST(SGX, [r121])], [AC_SUBST(SGX, [r125]]))

AC_CONFIG_FILES([Makefile data/glesv2.pc data/powervr])
AC_OUTPUT
