while getopts airflow_dir: flag
do
    case "${flag}" in
        airflow_dir) airflow_dir=${OPTARG};;
    esac
done

# Define variables
REPO_URL="https://github.com/agrock86/wwi-dw-databricks-airflow.git"
BRANCH="main"
DAGS_DIR="$airflow_dir/dags"
TEMP_DIR="$airflow_dir/temp"

# Check if the temp directory exists
if [ ! -d "$TEMP_DIR" ]; then
  # Clone the repository if not already cloned
  git clone --branch "$BRANCH" "$REPO_URL" "$TEMP_DIR"
else
  # Pull the latest changes
  cd "$TEMP_DIR" || exit
  git reset --hard  # Ensure no local changes interfere
  git clean -fd     # Remove untracked files
  git pull origin "$BRANCH"
fi

# Sync only Python files from the 'dag' folder in the repository to the Airflow DAGs folder
rsync -av --include="*.py" --exclude="*" "$TEMP_DIR/dag/" "$DAGS_DIR/"