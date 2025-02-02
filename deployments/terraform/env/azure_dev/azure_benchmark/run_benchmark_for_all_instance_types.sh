#!/usr/bin/env bash

# this script uses task spooler to run benchmark jobs one after the other
# you can configure the number of parallel jobs in task spooler
# through task spooler we can easily keep track of the jobs and their status (error, success) and its logs

machine_type_iterator=$1
max_iterator=$2

while [ $machine_type_iterator -le $max_iterator ]; do
  ts terragrunt plan -out tf.plan -var="machine_type_iterator=$machine_type_iterator"

  ts sleep 180
  ts terragrunt apply tf.plan

  machine_type_iterator=$((machine_type_iterator + 1))
done

ts terragrunt plan -destroy --target azurerm_linux_virtual_machine.benchmark -out tf.plan -var="machine_type_iterator=$machine_type_iterator"
ts sleep 180
ts terragrunt apply tf.plan