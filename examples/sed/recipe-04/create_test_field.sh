#!/usr/bin/env bash

ptr_name="local_pose_ptr"
infile="test.txt"
tmpfile=.${infile}.tmp
outfile="output.txt"

cp ${infile} ${tmpfile}

sed -i 's/^ *ptr_out->.*ptr_in->//g' ${tmpfile}
sed -i "s/\(.*\);/    ${ptr_name}->\1 = 1;/g" ${tmpfile}

mv ${tmpfile} ${outfile}


