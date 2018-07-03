#!/bin/ash
set -e

# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_DB_PASSWORD' 'example'
# (will allow for "$XYZ_DB_PASSWORD_FILE" to fill in the value of
#  "$XYZ_DB_PASSWORD" from a file, especially for Docker's secrets feature)
file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local varValue=$(eval "echo \"\$$var\"")
	local fileVarValue=$(eval "echo \"\$$fileVar\"")
	local def="${2:-}"
    # Check if only one of the variables is set, either env or file
	if [ ! -z "$varValue" ] && [ ! -z "$fileVarValue" ]; then
		echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
		exit 1
	fi
	local val="$def"
	if [ ! -z "$varValue" ]; then
		val="${varValue}"
	elif [ ! -z "$fileVarValue" ]; then
		val="$(cat "${fileVarValue}")"
	fi
	export "$var"="$val"
	unset "$fileVar"
	unset "$varValue"
	unset "$fileVarValue"
}


file_env "DATABASE_NAME"

if [ -z "$DATABASE_NAME" ]; then
	echo "No name for database was passed..."
	echo "Database set to 'default'"
	echo "If you want to use another db use docker run with '-e \"DATABASE_NAME=<my_database_name>\"'"
	DATABASE_NAME="default.db"
fi

echo
echo "Starting SQLite..."
echo

exec sqlite3 "/db/${DATABASE_NAME}"
