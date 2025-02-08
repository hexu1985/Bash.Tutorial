#!/usr/bin/env bash

word1="ptr_in"
word2="ptr_out"
word_tmp="aaabbb"

infile="test.txt"
tmpfile=.${infile}.tmp
outfile="output.txt"

cp ${infile} ${tmpfile}

sed -i "s/${word1}/${word_tmp}/g" ${tmpfile}
sed -i "s/${word2}/${word1}/g" ${tmpfile}
sed -i "s/${word_tmp}/${word2}/g" ${tmpfile}

mv ${tmpfile} ${outfile}

