STEPS (from Lab0 Git Repo top):

cd lab1-4/examples
source setupX.bash              //to initialize Xcelium simulation environment

cd sim
./CLEAN                         //to clean up sim directory before/after simulation

xrun -f xrun.f                  //to run a simulation
exit                            //to exit Xcelium simulator  

more xrun.log                   //to look for errors in simulation log file

simvision -waves waves.shm &    //to look at waveforms from simulation

./gen_cov_html_report.bash      //to merge coverage from multiple simulations
imc -load cov_work/scope/ALL &  //to look at merged coverage 

./CLEAN                         //to clean up sim directory before/after simulation
