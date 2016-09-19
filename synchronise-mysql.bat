@echo off

rem Import MySQL based database schema and data from origin to destination.
rem Usage for single import:
rem   synchronize-mysql.bat

rem set current path to return back then
set current_path=%CD%
rem MySQL Server local installation path
rem example: "%PROGRAMFILES%\MySQL\MySQL Server 5.7\bin"
set mysql_path=

set mysql_origin_user=
set mysql_origin_password=
set mysql_origin_database=
set mysql_origin_host=
set mysql_origin_port=3306

set mysql_destination_user=
set mysql_destination_password=
set mysql_destination_database=
set mysql_destination_host=
set mysql_destination_port=3306

set temporal_dump_file_name=%TEMP%\dump.sql

rem change to MySQL installation path
cd %mysql_path%

rem set credentials
mysql_config_editor.exe set --user=%mysql_origin_user% --password

rem import a dump from the origin database
echo "Importing a dump from %mysql_origin_database% database from host %mysql_origin_database%..."
mysqldump.exe -h %mysql_origin_host% -P %mysql_origin_port% %mysql_origin_database% > %temporal_dump_file_name%

rem delete current destination database
echo "Deleting database %mysql_origin_database% in host %mysql_destination_host%..."
mysqladmin.exe -h %mysql_destination_host% -P %mysql_destination_port% drop -f %mysql_destination_database%

rem create an empty destination database
echo "Creating an empty database %mysql_destination_database% in host %mysql_destination_host%..."
mysqladmin.exe -h %mysql_destination_host% -P %mysql_destination_port% create %mysql_destination_database%

rem import the dump into the destination database
echo "Importing dump into %mysql_destination_host%..."
mysql.exe -h %mysql_destination_host% -P %mysql_destination_port% %mysql_origin_database% < %temporal_dump_file_name%

rem delete the temporal dump file
echo "Deleting temporal dump file..."
del /q %temporal_dump_file_name%

echo "Done"

rem let the previous path
cd %current_path%
