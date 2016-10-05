#code used to grep information from each file.
pwd
cd /Users/Macpro/Desktop/stat679HW/stat679/hw1
#in order to use same root later, we change the filenames in lut so it's
#consitent with the file name in log

for i in {1..9}
do
  fn=out/timetest${i}_snaq.out
  fn2=out/timetest0${i}_snaq.out
  mv $fn $fn2
done

#create a loop that extract the root and use this root to grep hmax and CPU time
#from each file
cd /Users/Macpro/Desktop/stat679HW/stat679/hw1/log

for vn in *.log
do
  roots=${vn%.log}
  logname="${roots}.log"
  outname="${roots}.out"
  hmax=`grep hmax ${logname} | head -n 1 | cut -f 2 -d '=' `
  elapsedt=`grep -E "Elapsed time. \d+\.\d+" -o ../out/${outname} | cut -f 2 -d ':'`
 echo $roots, $hmax $elapsedt >> ../hw1EX2.csv
done
