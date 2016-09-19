#!/bin/bash

# Import MySQL based database schema and data from origin to destination.
#
# Usage for single import:
#   $ sh synchronize-mysql.sh
#
# Usage for auto-import:
#   $ watch -n 600 'sh synchronise-mysql.sh'
# where 600 is the number of miliseconds between each import

mysql_origin_user=
mysql_origin_password=
mysql_origin_database=
mysql_origin_host=
mysql_origin_port=3306

mysql_destination_user=
mysql_destination_password=
mysql_destination_database=
mysql_destination_host=
mysql_destination_port=3306

temporal_dump_file_name=/tmp/dump.sql

# import a dump from the origin database
echo "Importing a dump from ${mysql_origin_database} database from host ${mysql_origin_database}..."
mysqldump -u$mysql_origin_user -p$mysql_origin_password -h $mysql_origin_host -P $mysql_origin_port $mysql_origin_database > $temporal_dump_file_name

# delete current destination database
echo "Deleting database ${mysql_origin_database} in host ${mysql_destination_host}..."
mysqladmin -u$mysql_destination_user -p$mysql_destination_password -h $mysql_destination_host -P $mysql_destination_port drop -f $mysql_destination_database

# create an empty destination database
echo "Creating an empty database ${mysql_destination_database} in host ${mysql_destination_host}..."
mysqladmin -u$mysql_destination_user -p$mysql_destination_password -h $mysql_destination_host -P $mysql_destination_port create $mysql_destination_database

# import the dump into the destination database
echo "Importing dump into ${mysql_destination_host}..."
mysql -u$mysql_destination_user -p$mysql_destination_password -h $mysql_destination_host -P $mysql_destination_port $mysql_origin_database < $temporal_dump_file_name

# delete the temporal dump file
echo "Deleting dump file..."
rm -f $temporal_dump_file_name

echo "Done"
