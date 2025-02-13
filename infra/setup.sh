while getopts a: flag
do
    case "${flag}" in
        a) airflow_dir=${OPTARG};;
    esac
done

sudo sh setup_docker.sh
sudo sh setup_airflow.sh -a $airflow_dir