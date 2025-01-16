#!/usr/bin/env bash

machine_type_iterator=$1
max_iterator=$2

while [ $machine_type_iterator -le $max_iterator ]; do
  terragrunt plan -out tf.plan -var="machine_type_iterator=$machine_type_iterator"

  read -t 60 -p "Do you want to continue? (y/n): " choice
  choice=${choice:-y}  # Default to 'y' if no input is provided within 60 seconds
  case "$choice" in
    y|Y ) echo "Continuing...";;
    n|N ) echo "Exiting..."; exit 1;;
    * ) echo "Invalid input"; exit 1;;
  esac

  terragrunt apply tf.plan

  machine_type_iterator=$((machine_type_iterator + 1))
done

terragrunt plan -destroy --target azurerm_linux_virtual_machine.benchmark -out tf.plan -var="machine_type_iterator=$machine_type_iterator"
# terragrunt apply tf.plan