# Xtesting-onap-robot
Xtesting can be used for ONAP robot tests

To launch xtesting robot you need 2 files
* env
* onap.properties: list of ONAP endpoints (can be found on the robot VM)

## env file
```
INSTALLER_TYPE=heat
EXTERNAL_NETWORK=ext-network
DEPLOY_SCENARIO=os-nosdn-nofeature-ha
NODE_NAME=pod4-orange-heat1
TEST_DB_URL=http://10.0.2.5:8021/api/v1/results
BUILD_TAG=jenkins-functest-kolla-baremetal-daily-amsterdam-222
```

with 
* NODE_NAME, TEST_DB_URL are used to publish results to OPNFV Test DB through the Test API
* BUILD_TAG is used to retrieve the version (amsterdam in the example)

all the other parameters are detailed in Functest user guide.

## onap.properties

This file includes all the ONAP end points. It is built at ONAP installation and can be found on the ONAP Robot VM.

# Launch xtesting-onap-robot

You can run the test with the following command:

sudo docker run --env-file <your env> -v <your onap properties>:/share/config/integration_vm_properties.py colvert22/functest-onap:latest

By default it will execute all the tests corresponding to the command bash -c 'run_tests -t all'
If you want to execute only a subset of the tests you may precise the test cases using -t: bash -c 'run_tests -t dcae'
If you want to push the results to the database, you can use the -r option:  bash -c 'run_tests -t all -r'

# References

* Xtesting page: https://wiki.opnfv.org/display/functest/Xtesting
* Onap robot repo: https://git.onap.org/testsuite/
* Functest User Guide: http://docs.opnfv.org/en/stable-euphrates/submodules/functest/docs/testing/user/userguide/index.html
