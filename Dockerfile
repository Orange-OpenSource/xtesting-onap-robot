FROM opnfv/xtesting:iruya

ARG OPENSTACK_TAG=master
ARG OPNFV_TAG=master
ARG ONAP_TAG=master
ARG PIP_TAG=18.0

ENV PYTHONPATH $PYTHONPATH:/src/testing-utils/robotframework-onap/eteutils
ENV TAG all

COPY thirdparty-requirements.txt thirdparty-requirements.txt
RUN apk --no-cache add --virtual .build-deps --update \
        python-dev build-base linux-headers libffi-dev \
        openssl-dev libjpeg-turbo-dev && \
    git clone --depth 1 https://git.onap.org/testsuite -b $ONAP_TAG /var/opt/OpenECOMP_ETE && \
    git clone --depth 1 https://git.onap.org/testsuite/properties -b $ONAP_TAG /share/config && \
    git clone --depth 1 https://git.onap.org/testsuite/python-testing-utils -b $ONAP_TAG /src/testing-utils && \
    git clone --depth 1 https://git.onap.org/demo -b $ONAP_TAG /src/demo && \
    pip install \
        -chttps://git.openstack.org/cgit/openstack/requirements/plain/upper-constraints.txt?h=$OPENSTACK_TAG \
        pip==$PIP_TAG && \
    pip install \
        -chttps://git.opnfv.org/functest/plain/upper-constraints.txt?h=$OPNFV_TAG \
        -rthirdparty-requirements.txt \
        -e /src/testing-utils/robotframework-onap && \
    mkdir -p /var/opt/OpenECOMP_ETE/demo/heat && cp -Rf /src/demo/heat/vFW /var/opt/OpenECOMP_ETE/demo/heat/ && \
    rm -r thirdparty-requirements.txt /src/testing-utils/.git /share/config/.git \
        /var/opt/OpenECOMP_ETE/.git /src/demo && \
    cd / && ln -s /var/opt/OpenECOMP_ETE/robot/ /robot && \
    apk del .build-deps

COPY testcases.yaml /usr/lib/python2.7/site-packages/xtesting/ci/testcases.yaml
COPY cmd.sh /
CMD ["/cmd.sh"]
