# Synchronise MySQL #
Import MySQL based database schema and data from origin to destination.

## Prerequisites ##
- [mysql (MySQL command-line tool)](http://dev.mysql.com/doc/refman/5.7/en/mysql.html)
- [mysqladmin] (https://dev.mysql.com/doc/refman/5.7/en/mysqladmin.html)
- [mysqldump] (https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html)

## Linux/OS X usage ##
OS X will need to install *watch* command. You can find it in (procps package) [https://gitlab.com/procps-ng/procps/]

### Single import ###
```
$ sh synchronize-mysql.sh
```

### Auto-import  ###
```
$ watch -n 600 'sh synchronise-mysql.sh'
```
Where 600 is the number of miliseconds between each import.

## Windows usage  ##
Auto-import is not develop for Windows but you can try it installing the (procps package) [https://cygwin.com/packages/procps/] for Cygwin.

### Single import ###
```
synchronize-mysql.bat
```

