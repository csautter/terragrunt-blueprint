# Test suites
- pts/aarch64
- pts/memory - runtime 1h30m
- pts/server-memory
- pts/java
- pts/database
- pts/cpu-massive
- pts/golang
- pts/go

# Test cases
- pts/pgbench
- ``phoronix-test-suite benchmark nginx``
- ``phoronix-test-suite benchmark node-express-loadtest``
- ``phoronix-test-suite benchmark node-web-tooling``

# Test batch
- ``phoronix-test-suite batch-benchmark nginx apache node-web-tooling mysqlslap hammerdb-postgresql redis``

# Performance per euro calculation
```bash
export COST_PERF_PER_UNIT="euro/hour"
export COST_PERF_PER_DOLLAR=1
```

# Run result viewer
First build the docker file:
https://github.com/phoronix-test-suite/phoronix-test-suite/blob/master/deploy/docker/ubuntu-pts-docker-build.sh
```bash
TEST_RESULT_PATH=~/.phoronix-test-suite/test-results
docker run -it -p 8080:80 -v $(pwd)/phoronix-test-suite.xml:/etc/phoronix-test-suite.xml -v $TEST_RESULT_PATH:/var/lib/phoronix-test-suite/test-results  phoronix-pts-docker /phoronix-test-suite/phoronix-test-suite start-result-viewer
```