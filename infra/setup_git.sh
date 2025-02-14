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

# define variables
repo_url="https://github.com/agrock86/wwi-dw-databricks-airflow.git"
branch="main"
dags_dir="$airflow_dir/dags"
temp_dir="$airflow_dir/temp"

# check if the temp directory exists
if [ ! -d "$temp_dir" ]; then
  # clone the repository if not already cloned
  git clone --branch "$branch" "$repo_url" "$temp_dir"
else
  # pull the latest changes
  cd "$temp_dir" || exit
  git reset --hard  # ensure no local changes interfere
  git clean -fd     # remove untracked files
  git pull origin "$branch"
fi

# sync only Python files from the 'dag' folder in the repository to the Airflow DAGs folder
rsync -av --include="*.py" --exclude="*" "$temp_dir/dag/" "$dags_dir/"