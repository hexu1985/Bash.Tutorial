
cat test.txt | \
while read line
do
    echo "<<" '"'"    $line: "'"' "<<" "$line" "<<" '"\n"'
done
