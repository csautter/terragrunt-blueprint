#!/usr/bin/env bash

set -xe

# prefix list
# FULL_PREFIX_LIST=("s1" "c1" "g1" "m1" "b1" "c2i" "g2i" "m2i" "s1a" "c1a" "g1a" "m1a" "b1a" "g1r" "b2i")
PREFIX_LIST=("m1a" "b1a" "g1r" "b2i")

for prefix in "${PREFIX_LIST[@]}"
do
    echo "Running benchmarks for prefix: $prefix"
    bash run_benchmarks.sh $prefix
done