#!/usr/bin/env bash

############################################################################
# 2022-06-30 tanzhongqiang


############################################################################
CUR_DIR=${PWD}

function push_gitlab2()
{
	echo "======================================"
	echo $1
	echo $2
	echo "======================================"
	pushd ../$1
	git checkout -b master
	git remote rm origin
	git remote add origin git@rocktan001:Ysemi-SW/$2
	git push -u origin --all
	git push -u origin --tags
	popd
}
function main()
{
	push_gitlab2  "docs" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/docs.git"
	push_gitlab2  "manifests" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/manifests.git"
	push_gitlab2  "software" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/software.git"
	push_gitlab2  "build-scripts" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/build-scripts.git"
	push_gitlab2  "scp" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/scp.git"
	push_gitlab2  "scp/contrib/cmsis/git" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/contrib/cmsis/git.git"
	push_gitlab2  "scp/contrib/run-clang-format/git" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/contrib/run-clang-format/git.git"
	push_gitlab2  "busybox" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/busybox.git"
	push_gitlab2  "mbedtls" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/mbedtls.git"
	push_gitlab2  "model-scripts" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/model-scripts.git"
	push_gitlab2  "grub" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/grub.git"
	push_gitlab2  "kvmtool" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/kvmtool.git"
	push_gitlab2  "arm-tf" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/arm-tf.git"
	push_gitlab2  "tools/efitools" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/tools/efitools.git"
	push_gitlab2  "tools/acpica" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/tools/acpica.git"
	push_gitlab2  "linux" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/linux.git"
	push_gitlab2  "buildroot" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/buildroot.git"
	push_gitlab2  "kvm-unit-tests" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/kvm-unit-tests.git"
	push_gitlab2  "uefi/edk2" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/uefi/edk2.git"
	push_gitlab2  "uefi/edk2/edk2-platforms" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/uefi/edk2-platforms.git"
	push_gitlab2  "uefi/edk2/edk2-platforms/Silicon/RISC-V/ProcessorPkg/Library/RiscVOpensbiLib/opensbi" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/uefi/Silicon/RISC-V/ProcessorPkg/Library/RiscVOpensbiLib/opensbi.git"
	push_gitlab2  "uefi/edk2/ArmPkg/Library/ArmSoftFloatLib/berkeley-softfloat-3" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/uefi/ArmPkg/Library/ArmSoftFloatLib/berkeley-softfloat-3.git"
	push_gitlab2  "uefi/edk2/UnitTestFrameworkPkg/Library/CmockaLib/cmocka" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/uefi/UnitTestFrameworkPkg/Library/CmockaLib/cmocka.git"
	push_gitlab2  "uefi/edk2/RedfishPkg/Library/JsonLib/jansson" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/uefi/RedfishPkg/Library/JsonLib/jansson.git"
	push_gitlab2  "uefi/edk2/CryptoPkg/Library/OpensslLib/openssl" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/uefi/CryptoPkg/Library/OpensslLib/openssl.git"
	push_gitlab2  "uefi/edk2/CryptoPkg/Library/OpensslLib/openssl/krb5" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/uefi/CryptoPkg/Library/OpensslLib/krb5.git"
	push_gitlab2  "uefi/edk2/CryptoPkg/Library/OpensslLib/openssl/boringssl" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/uefi/CryptoPkg/Library/OpensslLib/boringssl.git"
	push_gitlab2  "uefi/edk2/CryptoPkg/Library/OpensslLib/openssl/pyca-cryptography" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/uefi/CryptoPkg/Library/OpensslLib/pyca-cryptography.git"
	push_gitlab2  "uefi/edk2/MdeModulePkg/Universal/RegularExpressionDxe/oniguruma" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/uefi/MdeModulePkg/Universal/RegularExpressionDxe/oniguruma.git"
	push_gitlab2  "uefi/edk2/MdeModulePkg/Library/BrotliCustomDecompressLib/brotli" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/uefi/MdeModulePkg/Library/BrotliCustomDecompressLib/brotli.git"
	push_gitlab2  "uefi/edk2/BaseTools/Source/C/BrotliCompress/brotli" "FVP_RD_N2_CFG1_RD-INFRA-2022_04_04/uefi/BaseTools/Source/BrotliCompress/brotli.git"

}

main