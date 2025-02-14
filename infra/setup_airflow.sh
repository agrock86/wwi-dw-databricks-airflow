airflow_dir=""

# parse arguments manually
while [[ $# -gt 0 ]]; do
    case "$1" in
        -airflow_dir)
            airflow_dir="$2"
            shift 2 # shift past argument and its value
            ;;
        *)
            echo "Usage: $0 -airflow_dir <path>"
            exit 1
            ;;
    esac
done

# check if airflow_dir is set
if [ -z "$airflow_dir" ]; then
    echo "Error: Missing required argument -airflow_dir <path>"
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