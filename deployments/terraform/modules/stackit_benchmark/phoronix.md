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