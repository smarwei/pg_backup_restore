# Postgres Backup and Restore Script

This is a bash script that allows you to backup and restore a specified PostgreSQL database with a timestamp in the backup file's name.

## Usage
```
./script.sh [-b|--backup] [-r|--restore] [-d|--database] [-h|--help] database_name
```
- **-b** or **--backup**: backup the specified database
- **-r** or **--restore**: restore the specified database
- **-d** or **--database**: specify the name of the database
- **-h** or **--help**: display the usage help text

## Example
```
./script.sh -b -d mydatabase
```

This will backup the database `mydatabase`
```
./script.sh -r -d mydatabase
```

This will restore the database `mydatabase` from the latest backup file.

## Deployment
This script can be deployed using nix package manager, you can find an example of a `flake.nix` file in the repository that you can use to deploy the script and its dependencies.

Please make sure you don't overwrite any important files by creating a new backup file with the same name.
