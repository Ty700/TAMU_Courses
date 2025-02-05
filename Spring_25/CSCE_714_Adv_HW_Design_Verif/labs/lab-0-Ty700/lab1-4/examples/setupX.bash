#!/bin/bash
export UVMHOME="/opt/coe/cadence/XCELIUM/tools/methodology/UVM/CDNS-1.1d/sv"
source /opt/coe/cadence/XCELIUM/setup.XCELIUM.linux.bash
export CDN_VIP_ROOT="/opt/coe/cadence/VIPCAT"
export DENALI="$CDN_VIP_ROOT/tools.lnx86/denali"
export ABVIP_INST_DIR="$CDN_VIP_ROOT/tools.lnx86/abvip"
export example_dir=`pwd`
alias imc="/opt/coe/cadence/VMANAGER/bin/imc"
echo Success
