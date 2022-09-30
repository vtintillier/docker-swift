FROM python:3-alpine

RUN pip install --no-cache-dir python-swiftclient==4.1.0

ENTRYPOINT ["swift"]
CMD ["-h"]
