#!/bin/sh
sudo sh setup_docker.sh

curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.10.4/docker-compose.yaml'

mkdir -p ./dags ./logs ./plugins ./config
echo -e "AIRFLOW_UID=$(id -u)" > .env.docker

docker compose --env-file .env.docker config up airflow-init