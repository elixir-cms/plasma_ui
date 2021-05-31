{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  name = "elixirShell";
  buildInputs = [
    erlangR24
    pkgs.beam.packages.erlangR24.elixir
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
