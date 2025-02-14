# default value
airflow_dir=""

# parse argument
while [ "$#" -gt 0 ]; do
  case "$1" in
    --airflow_dir=*) airflow_dir="${1#*=}";;
    *) echo "Unknown parameter: $1"; exit 1;;
  esac
  shift
done

# validate input
if [ -z "$airflow_dir" ]; then
  echo "Error: --airflow_dir parameter is required."
  exit 1
fi

mkdir -p $airflow_dir
cd $airflow_dir

curl -LfO "https://airflow.apache.org/docs/apache-airflow/2.10.4/docker-compose.yaml"

mkdir -p ./dags ./logs ./plugins ./config
echo -e "AIRFLOW_UID=$(id -u)" > .env.docker

docker compose --env-file .env.docker config
docker compose up airflow-init
docker compose up -d