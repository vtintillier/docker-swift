ARG PYTHON_VERSION=3.10

FROM python:${PYTHON_VERSION}-alpine as build

# needed to build netifaces
RUN apk add --no-cache build-base python3-dev linux-headers

RUN pip install --no-cache-dir python-swiftclient==4.1.0 python-keystoneclient>=2.0.0

FROM python:${PYTHON_VERSION}-alpine

# without this, we have a three digits PYTHON_VERSION defined as environment variable in the parent docker image itself
ARG PYTHON_VERSION

COPY --from=build /usr/local/lib/python${PYTHON_VERSION}/site-packages /usr/local/lib/python${PYTHON_VERSION}/site-packages
COPY --from=build /usr/local/bin /usr/local/bin

ENTRYPOINT ["swift"]
CMD ["-h"]
