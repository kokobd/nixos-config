#!/usr/bin/env bash

find . -name "*.nix" -type f -exec nixfmt '{}' '+'
