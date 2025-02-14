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

# define variables
REPO_URL="https://github.com/agrock86/wwi-dw-databricks-airflow.git"
BRANCH="main"
DAGS_DIR="$airflow_dir/dags"
TEMP_DIR="$airflow_dir/temp"

# check if the temp directory exists
if [ ! -d "$TEMP_DIR" ]; then
  # clone the repository if not already cloned
  git clone --branch "$BRANCH" "$REPO_URL" "$TEMP_DIR"
else
  # pull the latest changes
  cd "$TEMP_DIR" || exit
  git reset --hard  # ensure no local changes interfere
  git clean -fd     # remove untracked files
  git pull origin "$BRANCH"
fi

# sync only Python files from the 'dag' folder in the repository to the Airflow DAGs folder
rsync -av --include="*.py" --exclude="*" "$TEMP_DIR/dag/" "$DAGS_DIR/"