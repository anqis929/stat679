#code used to grep information from each file.
echo analysis, h, CPUtime, Nruns, Nfail, fabs, frel, xabs, xrel, seed, under3460, under3450, under3440 > summarization.csv

for filename in log/*.log
do
  analysis=`grep rootname $filename | cut -f 2 -d ':'`
  basenames="${filename%.*}" #extract roots
  basename="${basename##*/}"  #get rid of "log/" in the front of roots
  outname="${basename}.out" #set roots name for *.out files
  #grep hmax time
  h=`grep hmax $filename | head -n 1 | cut -f 2 -d '=' `
#grep CPU time
  CPUtime=`grep -E "Elapsed time. \d+\.\d+" -o out/${outname} | cut -f 2 -d ':'`
#grep number of runs
  Nruns=`grep runs $filename | cut -f 2 -d ':'|sed -E "s/([0-9]+) run.*/\1/"`
  Nruns=${Nruns%% runs*} #extract only numbers
#grep number of masimum failures
  Nfail=`grep "max number of failed proposals" $filename | sed -E 's/.*=([0-9]+),.*/\1/'`

#grep ftolAbs parameter in the files
  fabs=`grep ftolAbs $filename | sed -E "s/.*Abs=([0-9]\.[0-9]+.*),/\1/"`

#grep "ftolRel" parameter in the files
  frel=`grep ftolRel $filename | sed -E "s/.*Rel=([0-9]\.[0-9]+.*),ftol.*/\1/"`
#grep "xtolAbs" paramter in the files
  xabs=`grep xtolAbs $filename | sed -E "s/.*Abs=([0-9]\.[0-9]+),.*/\1/"`
#grep "xtolRel" parameter in the files
  xrel=`grep xtolRel $filename | sed -E "s/.*Rel=([0-9]\.[0-9]+)./\1/"`
#grep seed for the first run
  seed=`grep seed $filename | sed -E "s/.*seed=([0-9]+)/\1/"`
#grep -loglike value of the best run
  loglik=`grep "loglik of best" $filename | sed -E "s/.*best ([0-9]+).*/\1/"`
  i1=0
  i2=0
  i3=0
    for lglik in $loglik
    do
	if [ $lglik -le 3460 ] #number of runs that returned a network with a score (-loglik value) better than (below) 3460
	then
	    i1=$((i1+1))
	fi

	if [ $lglik -le 3450 ] #number of runs with a network score under 3450
	then
	    i2=$((i2+1))
	fi

	if [ $lglik -le 3440 ] #number of runs with a network score under 3440
	then
	    i3=$((i3+1))
	fi

    done

    echo $analysis, $h $CPUtime, $Nruns, $Nfail, $fabs,$frel$xabs, $xrel, $seed, $i1, $i2, $i3>> summarization.csv
done
