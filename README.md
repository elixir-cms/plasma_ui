# Plasma UI

**WARNING:** This is a work in progress that is still in very early stages.

Plasma UI is a Phoenix based user interface for manipulating entity types with the ecto_entity library.


# Usage

Before you get started, you'll want to create a `.env` or `.envrc` (if using [`direnv`](https://direnv.net/docs/installation.html)) file that contains something similar to the following:

```
PGDATA=$PWD/pg_data
PGHOST=$PWD/pg-localhost
LOG_PATH=$PWD/postgres/LOG
PGDATABASE=postgres
DATABASE_URL="postgresql:///postgres?host=$PGHOST"
```

Or for `.envrc`:
```
export PGDATA=$PWD/pg_data
export PGHOST=$PWD/pg-localhost
export LOG_PATH=$PWD/postgres/LOG
export PGDATABASE=postgres
export DATABASE_URL="postgresql:///postgres?host=$PGHOST"
```

and make sure that these variables are loaded into your environment with `echo $PGHOST` etc.

This project uses the [`nix package manager`](https://nixos.org/guides/install-nix.html) along with a script, `run`, that can setup, host, and release the project with the following commands:

```
# Project setup
./run setup

# Local development
./run dev

# Release builds
./run release
```

The local development server runs on [`localhost:4001`](https://localhost:4001).
