# Docker sqlite3

## What is this?

This is a simple docker container hosting sqlite3. It can be used to easily spin up a sqlite database or debug an existing one.
Say you are developing an app based on sqlite and want to check your database state but also want to keep your system environment as clean as possible, or want a container for better organization, or any other reason.
Just fire the container up with an interactive shell and pass your database in...et voila, easylife.

## Running the container default mode

If no other options are passed, a database called 'default' is created and the sqlite-cli starts from there.

```bash
docker run -it --name sqlite3 abecodes/sqlite3
```

## Running the container with persitent data

The container can be started with a volume linked to it to persist data:

```bash
docker run \
        --rm \
        -it \
        -v "/path/to/persistent/data:/db" \
        --name sqlite \
        abecodes/sqlite
```

Mount works fine as well:

```bash
docker run \
        --rm \
        -it \
        --mount type=bind,source=/path/to/persistent/data,destination=/db \
        --name sqlite \
        abecodes/sqlite
```

## Running container with an already existing database

To debug an existing database, you can link the folder containing the database and pass the database name as environment variable:

```bash
docker run \
        --rm \
        -it \
        -e "DATABASE_NAME=databasename" \
        --mount type=bind,source=/path/to/persistent/data,destination=/db \
        --name sqlite \
        abecodes/sqlite
```

The database name can also be passed as a file with the name in a single line like so:

```bash
docker run \
        --rm \
        -it \
        -e "DATABASE_NAME_FILE=/db/databasename/file" \
        --mount type=bind,source=/path/to/persistent/data,destination=/db \
        --name sqlite \
        abecodes/sqlite
```

## Environment Variables

| Env                | Usage                                                                                                     |
| ------------------ | --------------------------------------------------------------------------------------------------------- |
| DATABASE_NAME      | Specifies the database file sqlite should use or create if it not exists in /db. Defaults to "default.db" |
| DATABASE_NAME_FILE | Specifies a file containing a single line with the database name                                          |

## Troubleshoots

- make sure you have the correct access rights on the persistent folder
