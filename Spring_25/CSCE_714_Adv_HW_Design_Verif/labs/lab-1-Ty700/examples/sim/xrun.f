// To run XRUN with GUI, type: "xrun -f xrun.f +gui"
// To run XRUN with no GUI, type: "xrun -f xrun.f"

// include directories
// tells the tool where to looks for files specified
// using the `include directive
//-incdir ${ABVIP_INST_DIR}/apb3/rtl
-incdir ${example_dir}/sim/rtl
-define ABVIP_SIM

// RTL design files:
// No command line option is required. Just list the path to the files.
${example_dir}/sim/rtl/apb_master.v
${example_dir}/sim/rtl/apb3_monitor.sv
${example_dir}/sim/top.v

// Dynamic ABV Performance Options
// The three options below have been made default in 12.1
// Uncomment the options below, if using XCELIUM 12.1 before releases
// -abvoptrange
// -abvsvfopt
// -abvnovarchange

// Tcl command files:
// Specify the path to the tcl file called *.tcl in this directory
-input ${example_dir}/sim/xrun.tcl
-sv

// Top
-top top

-access rwc
-assert

-coverage A                   // record "all" coverage
-covoverwrite                 // overwrite existing coverage db
-covfile ./cov_conf.ccf     // feed in coverage configuration file
