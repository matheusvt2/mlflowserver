FROM python:3.7.9-slim

LABEL maintainer="Matheus Torres <matheusvt@gmail.com>"

ARG MLFLOW_VERSION=1.11.0

RUN mkdir -p /mlflow/ \
  && apt-get update && apt-get -y install --no-install-recommends default-libmysqlclient-dev libpq-dev build-essential 

RUN useradd -m -d /mlflow mlflow
RUN chown -R mlflow:mlflow /mlflow
WORKDIR /mlflow/

USER mlflow

ENV PATH="/mlflow/.local/bin:$PATH"
ENV BACKEND_URI /mlflow/store
ENV ARTIFACT_ROOT /mlflow/mlflow-artifacts
ENV MLFLOW_PORT 5000

RUN pip install --user\
    mlflow==$MLFLOW_VERSION \
    sqlalchemy \
    boto3 \
    google-cloud-storage \
    psycopg2 \
    mysql \
    PyMySQL

EXPOSE 5000

CMD echo "Artifact Root is ${ARTIFACT_ROOT}" && \
  mlflow server \
  --backend-store-uri ${BACKEND_URI} \
  --default-artifact-root ${ARTIFACT_ROOT} \
  --host 0.0.0.0 \
  --port ${MLFLOW_PORT}