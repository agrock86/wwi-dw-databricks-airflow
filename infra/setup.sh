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

sudo ./setup_docker.sh
sudo ./setup_airflow.sh --airflow_dir=$airflow_dir
sudo ./setup_git.sh --airflow_dir=$airflow_dir