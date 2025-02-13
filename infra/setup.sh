while getopts airflow_dir: flag
do
    case "${flag}" in
        airflow_dir) airflow_dir=${OPTARG};;
    esac
done

sudo sh setup_docker.sh
sudo sh setup_airflow.sh -airflow_dir $airflow_dir