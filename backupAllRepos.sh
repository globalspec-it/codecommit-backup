#!/bin/bash
# Variables
ccurl="git-codecommit.us-east-1.amazonaws.com"
backuppath="/mnt/share01"

# Compute destination file names for current date
date_daily=`date +"%d-%m-%Y"`
month_day=`date +"%d"`
week_day=`date +"%u"`

# Set destination folder name
# On first month day do
if [ "$month_day" -eq 1 ] ; then
  datefolder=monthly/$date_daily
else
  # On saturdays do
  if [ "$week_day" -eq 6 ] ; then
    datefolder=weekly/$date_daily
  else
    # On any regular day do
    datefolder=daily/$date_daily
  fi
fi

# Perform backup of all repos into  appropriate folder name based on date
while read repositoryName ; do
    git clone https://$ccurl/v1/repos/$repositoryName $backuppath/$datefolder/$repositoryName
    reposToBackup[$repositoryName]=$id

done < <(aws codecommit list-repositories | jq -r '.repositories[]|"\(.repositoryName)"')

# Cleanup Old Backups
# daily - keep for 14 days
find $storage/daily/ -maxdepth 1 -mtime +14 -type d -exec rm -rv {} \;
# weekly - keep for 60 days
find $storage/weekly/ -maxdepth 1 -mtime +60 -type d -exec rm -rv {} \;
# monthly - keep for 300 days
find $storage/monthly/ -maxdepth 1 -mtime +300 -type d -exec rm -rv {} \;
