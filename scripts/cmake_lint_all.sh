#!/bin/bash
cd "$1"
find . -type f -print0 -name "$2" |
while read -d '' file
do
    echo "$file"
    polysquare-cmake-linter "$file" --indent 2 --blacklist style/space_before_func style/set_var_case style/uppercase_args style/lowercase_func style/argument_align unused/var_in_func
done
