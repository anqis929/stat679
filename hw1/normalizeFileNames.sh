#Code used to change filenames for hw1 exercise1

for i in {1..9}
do
  #echo " i = $i"
  # mv $i ${i/timetest$i_snaq/timetest0$i_snaq}
  #fn is the input filenames taht need changing
  fn=log/timetest${i}_snaq.log
  #echo "fn=$fn"
  fn2=log/timetest0${i}_snaq.log
  #echo "fn2=$fn2"
  mv $fn $fn2
done
