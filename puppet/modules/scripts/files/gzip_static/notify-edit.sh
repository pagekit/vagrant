#!/bin/bash
inotifywait -m -q -e CREATE -e MODIFY -e MOVED_TO -r "/var/www/" --format "%w%f" --excludei '\.(jpg|png|gif|ico|log|sql|zip|gz|pdf|php|swf|woff|)$' |
	while read file
	do
		if [[ $file =~ \.(js|css|svg|ttf|otf|eot)$ ]];
		then
			gzip -f -c -9 $file > $file.gz
		fi
	done