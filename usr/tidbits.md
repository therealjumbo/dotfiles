# Tidbits

This is a collection of useful shell tidbits that haven't justified their own script

## comparing two debians/tarballs
this assumes both debians are unpacked under the `new` and `old` dirs
1. compare only the directory structure
```
diff --brief -r ./old ./new
```

2. compare the elf headers of dynamic libraries
```
for i in old new; do 
    readelf -W -d $i/path/to/lib/libfoo.so | awk '{print $5}' | LANG= sort -u | tee $i.d.log; 
done
diff -u old.log new.log
```

3. compare the permissions and sizes on the files
```
for i in old new; do
    ls -AlR $i | awk '{print $1, $5, $9}' > $i-perm.log
done
diff new-perm.log old-perm.log
```

4. compare the file types for all files in the dirs (useful if line endings changed)
```
for i in old new; do
    cd $i
    find . -type f -name "*" -print0 |
    while read -rd '' file
        file $file >> ../$i-file.log
    done
    cd ..
done
diff old-file.log new-file.log
```

5. compare the contents
compare only files of type blah
```
TODO
```
