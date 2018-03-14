# xtesting-onap-robot
Xtesting used for ONAP robot tests

To launch xtesting robot you need 2 files
* env
* onap.properties: list of ONAP endpoints (can be found on the robot VM)

## env file

 INSTALLER_TYPE=heat
 EXTERNAL_NETWORK=ext-network
 DEPLOY_SCENARIO=os-nosdn-nofeature-ha
 NODE_NAME=pod4-orange-heat1
 TEST_DB_URL=http://10.0.2.5:8021/api/v1/results
 BUILD_TAG=jenkins-functest-kolla-baremetal-daily-amsterdam-222

* NODE_NAME, TEST_DB_URL are used to publish results to OPNFV Test DB through the Test API
* BUILD_TAG is used to retrieve the version (amsterdam in the example)

all the parameters are detailed in Functest user guide.

## onap.properties

this file includes all the onap end points. It is built at ONAP installation and can be found on the ONAM Robot VM

#launch xtesting-onap-robot

You can run the test with the following command:

sudo docker run --env-file <your env> -v <your onap properties>:/share/config/integration_vm_properties.py colvert22/functest-onap:latest bash -c "run_tests -t all -r"

# References

* Xtesting page: https://wiki.opnfv.org/display/functest/Xtesting
* Onap robot repo: https://git.onap.org/testsuite/
* Functest User Guide: http://docs.opnfv.org/en/stable-euphrates/submodules/functest/docs/testing/user/userguide/index.html
