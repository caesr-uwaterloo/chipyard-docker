Docker for Chipyard
====================

[Chipyard](https://chipyard.readthedocs.io/en/latest/) does not support a Docker image anymore. This is an attempt to create a Docker container with the latest Chipyard.

Build the docker image.

```bash
docker build -t rseac/chipyard-docker . 
```

After a long time, the docker image will have been created.

Run the docker image.
```bash
docker run -it rseac/chipyard-docker 
```

## Test a simple example

Once you're in the container, source the `env.sh` file. More documentation is available [here](https://chipyard.readthedocs.io/en/stable/Simulation/Software-RTL-Simulation.html#simulating-the-default-example).

```bash
source env.sh
```

Build the tests.
```bash
cd tests 
make
```

Build the simulator.
```bash
cd sims/verilator
make run-binary BINARY=../../tests/hello.riscv
```

You should see the following.
```bash
(/chipyard/.conda-env) root@b8794a54d3e9:/chipyard/sims/verilator# make run-binary BINARY=../../tests/hello.riscv
Running with RISCV=/chipyard/.conda-env/riscv-tools
mkdir -p /chipyard/sims/verilator/output/chipyard.harness.TestHarness.RocketConfig
if [ "../../tests/hello.riscv" != "none" ] && [ ! -f "../../tests/hello.riscv" ]; then printf "\n\nBinary ../../tests/hello.riscv not found\n\n"; exit 1; fi
(set -o pipefail &&  /chipyard/sims/verilator/simulator-chipyard.harness-RocketConfig \
        +permissive \
        +dramsim +dramsim_ini_dir=/chipyard/generators/testchipip/src/main/resources/dramsim2_ini +max-cycles=10000000     \
        +verbose \
        +permissive-off \
        ../../tests/hello.riscv \
         \
        </dev/null 2> >(spike-dasm > /chipyard/sims/verilator/output/chipyard.harness.TestHarness.RocketConfig/hello.out) | tee /chipyard/sims/verilator/output/chipyard.harness.TestHarness.RocketConfig/hello.log)
[UART] UART0 is here (stdin/stdout).
Hello world from core 0, a rocket
- /chipyard/sims/verilator/generated-src/chipyard.harness.TestHarness.RocketConfig/gen-collateral/TestDriver.v:158: Verilog $finish
```

