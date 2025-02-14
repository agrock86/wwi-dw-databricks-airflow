airflow_dir=""

# parse arguments manually
while [[ $# -gt 0 ]]; do
    case "$1" in
        -airflow_dir)
            airflow_dir="$2"
            shift 2 # Shift past argument and its value
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

sudo ./setup_docker.sh
sudo ./setup_airflow.sh -airflow_dir $airflow_dir