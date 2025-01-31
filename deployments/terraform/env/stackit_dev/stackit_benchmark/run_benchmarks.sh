#!/usr/bin/env bash

set -xe

machine_type_prefix=$1

function continue_feedback() {
    read -t 60 -p "Do you want to continue? (y/n): " choice
    choice=${choice:-y}  # Default to 'y' if no input is provided within 60 seconds
    case "$choice" in
      y|Y ) echo "Continuing...";;
      n|N ) echo "Exiting..."; exit 1;;
      * ) echo "Invalid input"; exit 1;;
    esac
}

terragrunt plan -out tf.plan -var="machine_type_prefix=$machine_type_prefix"
continue_feedback
terragrunt apply tf.plan

terragrunt plan -destroy --target stackit_server.bench -out tf.plan -var="machine_type_prefix=$machine_type_prefix"
continue_feedback
terragrunt apply tf.plan