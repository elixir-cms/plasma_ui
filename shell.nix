{ pkgs ? import (fetchTarball https://github.com/nixos/nixpkgs/archive/nixos-22.05-small.tar.gz) {} }:

with pkgs;

mkShell {
  buildInputs = [
    chromium
    chromedriver
    erlangR25
    elixir
    inotify-tools
    nodejs-16_x
    postgresql
    rebar3
    yarn
  ];
}
