#!/bin/env bash

# Variables
database_name=""
backup_file=""

# Function to display help text
display_help() {
    echo "Usage: $0 [-b|--backup] [-r|--restore] [-d|--database] [-h|--help] database_name"
    echo "  -b or --backup: backup the specified database"
    echo "  -r or --restore: restore the specified database"
    echo "  -d or --database: specify the name of the database"
    echo "  -h or --help: display this help text"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -b|--backup)
            option="backup"
            ;;
        -r|--restore)
            option="restore"
            ;;
        -d|--database)
            database_name="$2"
            shift # past argument
            ;;
        -h|--help)
            display_help
            exit 0
            ;;
        *)
            echo "Invalid option: $1"
            display_help
            exit 1
            ;;
    esac
    shift # past argument or value
done

# Validate input
if [[ -z $database_name ]]; then
    echo "Error: missing database name"
    display_help
    exit 1
fi
if [[ -z $option ]]; then
    echo "Error: missing option"
    display_help
    exit 1
fi

# Backup or restore the database
if [[ $option == "backup" ]]; then
    timestamp=$(date +%Y-%m-%d-%H-%M-%S)
    backup_file="$database_name-$timestamp.sql"
    echo "Backing up $database_name to $backup_file..."
    pg_dump $database_name > $backup_file
    echo "Backup complete."
elif [[ $option == "restore" ]]; then
    backup_file="$database_name.sql"
    echo "Deleting $database_name..."
    dropdb $database_name
    echo "Creating $database_name..."
    createdb $database_name
    echo "Restoring $database_name from $backup_file..."
    psql $database_name < $backup_file
    echo "Restore complete."
else
    echo "Error: invalid option"
    display_help
    exit 1
fi

