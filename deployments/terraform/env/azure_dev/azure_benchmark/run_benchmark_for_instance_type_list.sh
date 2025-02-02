#!/usr/bin/env bash

# this script uses task spooler to run benchmark jobs one after the other
# you can configure the number of parallel jobs in task spooler
# through task spooler we can easily keep track of the jobs and their status (error, success) and its logs

while IFS= read -r machine_name || [[ -n "$machine_name" ]]; do
  echo "Running benchmarks for machine type: $machine_name"
  ts terragrunt plan -out tf.plan -var="machine_type_name=$machine_name"

  ts sleep 180
  ts terragrunt apply tf.plan

  ts terragrunt plan -destroy --target azurerm_linux_virtual_machine.benchmark -out tf.plan -var="machine_type_name=$machine_name"
  ts sleep 180
  ts terragrunt apply tf.plan
done