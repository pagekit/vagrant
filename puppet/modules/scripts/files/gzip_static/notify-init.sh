#! /bin/bash
 
FILETYPES=( "*.css" "*.js" "*.svg" "*.ttf" "*.otf" "*.eot" )
DIRECTORIES="/var/www/"
MIN_SIZE=512

for currentDir in $DIRECTORIES; do
    for f in "${FILETYPES[@]}"; do
    files="$(find $currentDir -iname "$f")";
        echo "$files" | while read file; do
            PLAINFILE=$file;
            GZIPPEDFILE=$file.gz;
            if [[ -e "$GZIPPEDFILE" ]]; then
                if [[ `stat --printf=%Y "$PLAINFILE"` -gt `stat --printf=%Y "$GZIPPEDFILE"` ]]; then
                    echo .gz is older, updating "$GZIPPEDFILE";
                    gzip -9 -f -c "$PLAINFILE" > "$GZIPPEDFILE";
                fi;
                
                if [[ `stat --printf=%s "$PLAINFILE"` -le $MIN_SIZE ]]; then
                    echo Uncompressed size is less than minimum "("$(stat –printf=%s "$PLAINFILE")")", removing "$GZIPPEDFILE";
                    rm -f "$GZIPPEDFILE";
                fi;
            elif [[ `stat --printf=%s "$PLAINFILE"` -gt $MIN_SIZE ]]; then
                echo Creating .gz "for" "$PLAINFILE";
                gzip -9 -c "$PLAINFILE" > "$GZIPPEDFILE";
            fi;
        done
    done
done

exit