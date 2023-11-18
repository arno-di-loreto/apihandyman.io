SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR=$SCRIPT_DIR/..

git push
gh pr create --fill
gh pr merge --merge --delete-branch