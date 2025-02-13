while getopts airflow_dir: flag
do
    case "${flag}" in
        airflow_dir) airflow_dir=${OPTARG};;
    esac
done

mkdir -p $airflow_dir
cd $airflow_dir

curl -LfO "https://airflow.apache.org/docs/apache-airflow/2.10.4/docker-compose.yaml"

mkdir -p ./dags ./logs ./plugins ./config
echo -e "AIRFLOW_UID=$(id -u)" > .env.docker

docker compose --env-file .env.docker config
docker compose up airflow-init
docker compose up -d