#!/usr/bin/env bash

infile="test.txt"
tmpfile=.${infile}.tmp
outfile="output.txt"

cp ${infile} ${tmpfile}

sed -i 's/ptr_out->//g' ${tmpfile}
sed -i 's/ =.*$//g' ${tmpfile}
sed -i 's/^ *//g' ${tmpfile}
sed -i '/^$/d' ${tmpfile}

rm -f ${outfile}
cat ${tmpfile} | \
while read line
do
    echo "    <<" '"'"    $line: "'"' "<<" "std::to_string(data.$line)" "<<" '"\n"' >> ${outfile}
done


