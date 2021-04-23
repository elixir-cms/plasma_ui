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
    ./postgres-local.sh start
    trap "./postgres-local.sh stop" EXIT
  '';
}
