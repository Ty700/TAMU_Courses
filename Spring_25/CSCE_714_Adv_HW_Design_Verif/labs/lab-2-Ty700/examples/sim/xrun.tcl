#database -open tr_db -into tr_db -event -default
#probe -create -shm top -all -depth all
database -open waves -into waves.shm -event -default
probe -create top -all -memories -depth all -tasks -functions -all -database waves -waveform
run 1000 ns
assertion -summary
#exit
