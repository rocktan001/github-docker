#!/bin/bash
echo -e "
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<manifest>
  <remote  name=\"aosp\"
           fetch=\"..\"/>
  <default revision=\"master\"
           remote=\"aosp\"
           sync-j=\"4\" />" >>$1
 
while read line; do
  echo "  <project path=\"$line\" name=\"$line\" />" >>$1
done
echo -e "\n</manifest>" >>$1