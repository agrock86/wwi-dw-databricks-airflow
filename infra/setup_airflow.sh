#!/bin/sh
sudo sh setup_docker.sh

sudo curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.10.4/docker-compose.yaml'

sudo mkdir -p ./dags ./logs ./plugins ./config
sudo echo -e "AIRFLOW_UID=$(id -u)" > .env.docker

sudo docker compose --env-file .env.docker config
sudo docker compose up airflow-init