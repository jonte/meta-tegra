DEPENDS_append_tegra124 = " tegra-libraries"
DEPENDS_append_tegra186 = " tegra-libraries"
DEPENDS_append_tegra210 = " tegra-libraries"

python () {
    overrides = d.getVar("OVERRIDES").split(":")
    if "tegra210" not in overrides and "tegra124" not in overrides and "tegra186" not in overrides:
        return

    x11flag = d.getVarFlag("PACKAGECONFIG", "x11", False)
    d.setVarFlag("PACKAGECONFIG", "x11", x11flag.replace("--enable-glx-tls", "--enable-glx"))
}

move_libraries() {
    install -d ${D}${libdir}/mesa
    mv ${D}${libdir}/libGL.* ${D}${libdir}/mesa/
    mv ${D}${libdir}/libGLES* ${D}${libdir}/mesa/
    mv ${D}${libdir}/libEGL.* ${D}${libdir}/mesa/
}
do_install_append_tegra210() {
    move_libraries
}

do_install_append_tegra124() {
    move_libraries
}

do_install_append_tegra186() {
    move_libraries
}

PACKAGE_ARCH_tegra210 = "${SOC_FAMILY_PKGARCH}"
PACKAGE_ARCH_tegra124 = "${SOC_FAMILY_PKGARCH}"
PACKAGE_ARCH_tegra186 = "${SOC_FAMILY_PKGARCH}"

PACKAGES =+ "${PN}-stubs-dev"
FILES_${PN}-stubs-dev = "${libdir}/mesa"
ALLOW_EMPTY_${PN}-stubs-dev = "1"
PRIVATE_LIBS_${PN}-stubs-dev = "\
    libEGL.so.1 \
    libGLESv1_CM.so.1 \
    libGLESv2.so.2 \
    libGL.so.1 \
"
