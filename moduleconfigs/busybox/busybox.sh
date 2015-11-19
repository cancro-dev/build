BB_ARGS="ARCH=arm CROSS_COMPILE=$GCC_LINUX_GNUEABIHF O=$MODULE_OUT"

EnableConfig() {
    sed -i "s/# $1 is not set/$1=y/g" "$MODULE_OUT/.config"
}

Compile() {
    "$MAKEFORWARD" "$EFIDROID_MAKE" -C "$MODULE_DIR" $BB_ARGS allnoconfig
    EnableConfig CONFIG_STATIC
    EnableConfig CONFIG_SED
    EnableConfig CONFIG_LOSETUP
    "$MAKEFORWARD" "$EFIDROID_MAKE" -C "$MODULE_DIR" $BB_ARGS silentoldconfig
    "$MAKEFORWARD" "$EFIDROID_MAKE" -C "$MODULE_DIR" $BB_ARGS all
}

Clean() {
    "$MAKEFORWARD" "$EFIDROID_MAKE" -C "$MODULE_DIR" $BB_ARGS clean
}

DistClean() {
    "$MAKEFORWARD" "$EFIDROID_MAKE" -C "$MODULE_DIR" $BB_ARGS distclean
}
