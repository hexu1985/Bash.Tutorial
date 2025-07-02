
filter_case_array=("-*ShouldAdd1*"
"*ShouldBeEmptyOnStartup*"
)

function gen_filter_str {
    local array
	array=(`echo "$@"`)

    separator=":"

    # 临时修改IFS，然后使用"$*"展开数组
    oldIFS=$IFS
    IFS=$separator
    joined="${array[*]}"
    IFS=$oldIFS
    
    echo "$joined"
}

filter_str=$(gen_filter_str "${filter_case_array[*]}")
echo "$filter_str"

