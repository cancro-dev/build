#
# Copyright (C) 2016 The EFIDroid Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

UBOOT_DIR="$TOP/bootloader/uboot/common/master"
UBOOT_OUT="$MODULE_OUT"
UBOOT_ARGS="ARCH=arm CROSS_COMPILE=$GCC_NONE_TARGET_PREFIX O=$UBOOT_OUT"

if [ ! -z "$UBOOT_SOURCE" ];then
    UBOOT_DIR="$TOP/bootloader/$UBOOT_SOURCE"
fi

Check() {
    if [ -z "$UBOOT_TARGET" ];then
        pr_fatal "UBOOT_TARGET is not set"
    fi
    if [ ! -d "$UBOOT_DIR" ];then
        pr_fatal "U-Boot wasn't found at $UBOOT_DIR"
    fi
}

Compile() {
    Check
    "$MAKEFORWARD" "$EFIDROID_MAKE" -C "$UBOOT_DIR" $UBOOT_ARGS "$UBOOT_TARGET"
    "$MAKEFORWARD" "$EFIDROID_MAKE" -C "$UBOOT_DIR" $UBOOT_ARGS all
}

Clean() {
    if [ ! -z "$UBOOT_TARGET" ];then
        Check
        "$MAKEFORWARD" "$EFIDROID_MAKE" -C "$UBOOT_DIR" $UBOOT_ARGS clean
    fi
}

DistClean() {
    if [ ! -z "$UBOOT_TARGET" ];then
        Check
        "$MAKEFORWARD" "$EFIDROID_MAKE" -C "$UBOOT_DIR" $UBOOT_ARGS distclean
    fi
}
