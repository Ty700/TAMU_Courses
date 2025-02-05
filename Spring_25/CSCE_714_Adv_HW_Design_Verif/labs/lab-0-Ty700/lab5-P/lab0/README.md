STEPS (from Lab0 Git Repo top):

cd lab5-P/lab0
source setupX.bash              //to initialize Xcelium simulation environment

cd project
ls                              //list directories
                                //  design/ - contains DUT
                                //  uvm/    - contains TESTBENCH
                                //  sim/    - contains simulation files

cd sim
./ALL_CLEAR                     //to clean up sim directory before/after simulation

xrun -f xrun.f                  //to run a simulation

more xrun.log                   //to look for errors in simulation log file

simvision -waves waves.shm &    //to look at waveforms from simulation

./gen_cov_html_report.bash      //to merge coverage from multiple simulations
imc -load cov_work/scope/ALL &  //to look at merged coverage 

./ALL_CLEAR                     //to clean up sim directory before/after simulation
