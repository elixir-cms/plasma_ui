{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  name = "elixirShell";
  buildInputs = [
    erlangR23
    pkgs.beam.packages.erlangR23.elixir
    inotify-tools
    postgresql
    nodejs-12_x
    rebar3
    yarn
  ];
  shellHook = ''
    if [ ! -d $PGHOST ]; then
      mkdir -p $PGHOST
    fi
    if [ ! -d $PGDATA ]; then
      echo 'Initializing postgresql database...'
      initdb $PGDATA --auth=trust >/dev/null
    fi
    pg_ctl start -l $LOG_PATH -o "-c listen_addresses= -c unix_socket_directories=$PGHOST"
  '';
}
