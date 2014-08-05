#! /bin/bash
 
FILETYPES=( "*.html" "*.css" "*.js" "*.xml" "*.svg" )
DIRECTORIES="/var/www/"
MIN_SIZE=512


for currentDir in $DIRECTORIES; do
   for f in "${FILETYPES[@]}"; do
   do
      find $currentdir -iname "$i" -exec bash -c 'PLAINFILE={};GZIPPEDFILE={}.gz; \
         if [ -e $GZIPPEDFILE ]; \
         then if [ `stat --printf=%Y $PLAINFILE` -gt `stat --printf=%Y $GZIPPEDFILE` ]; \
                then    gzip -1 -f -c $PLAINFILE > $GZIPPEDFILE; \
                 fi; \
         elif [ `stat --printf=%s $PLAINFILE` -gt $MIN_SIZE ]; \
            then gzip -1 -c $PLAINFILE > $GZIPPEDFILE; \
         fi' \;
  done
done

