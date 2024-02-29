ARG PYTHON_MAJOR_MINOR=3.11

FROM python:${PYTHON_MAJOR_MINOR}-alpine as build

# needed to build netifaces
RUN apk add --no-cache build-base python3-dev linux-headers

RUN pip install --no-cache-dir python-swiftclient==4.5.0 python-keystoneclient>=2.0.0

FROM python:${PYTHON_MAJOR_MINOR}-alpine

ARG PYTHON_MAJOR_MINOR

COPY --from=build /usr/local/lib/python${PYTHON_MAJOR_MINOR}/site-packages /usr/local/lib/python${PYTHON_MAJOR_MINOR}/site-packages
COPY --from=build /usr/local/bin /usr/local/bin

ENTRYPOINT ["swift"]
CMD ["-h"]
