# Azure Benchmarks
With the azure benchmarks module you can evaluate the real performance of azure virtual machines.
## Run the benchmarks
To run the benchmarks you need to have the following tools installed:
- [Terraform](https://www.terraform.io/downloads.html)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [tsp](https://manpages.ubuntu.com/manpages/trusty/man1/tsp.1.html)

### Run the benchmarks for a list of instance types
Create a file with the list of instance types you want to benchmark. For example:
**list.txt**
```txt
Standard_B1ls
Standard_B1s
Standard_B1ms
```
Then run the following command:
```bash
bash ./run_benchmark_for_instance_type_list.sh < list.txt
```
Check the results in tsp. Run for example:
```bash
ts -l
```
to list the jobs.

### Run the benchmarks for all available instance types
Run the following command:
```bash
FROM_POSITION=0
TO_POSITION=10
bash ./run_benchmark_for_all_instance_types.sh $FROM_POSITION $TO_POSITION
```
With the above command you will run the benchmarks for the first 10 instance types. You can change the values of `FROM_POSITION` and `TO_POSITION` to run the benchmarks for a different range of instance types.