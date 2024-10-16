FROM condaforge/miniforge3 as base
# Install Chipyard and run ubuntu-req.sh to install necessary dependencies
RUN git clone https://github.com/ucb-bar/chipyard.git && \
        cd chipyard && \
        git checkout HEAD

FROM base  as chipyard-setup 
SHELL ["/bin/bash", "-cl"]

# Initialize repo
RUN cd chipyard && \
      /bin/bash build-setup.sh riscv-tools -v --skip-marshal
#
FROM chipyard-setup as dev-env
WORKDIR /chipyard/
#ENTRYPOINT ["/bin/bash", "-c", "source /chipyard/env.sh"]


