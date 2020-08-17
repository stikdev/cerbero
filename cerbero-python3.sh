#!/bin/sh
# Ensure that the virtual environment is activated
[ -z "$VIRTUAL_ENV" ] && echo "You must activate the 'cerbero-venv' virtual environment (i.e. \`source /path/to/cerbero-venv/bin/activate\`)" && exit 1;

echo "WARNING: This script will temporarily replace /usr/bin/python and /usr/bin/python3 with symlinks to the virtual environment python3 path."

sudo mv /usr/bin/python /usr/bin/pythonbak || { echo 'Cannot move /usr/bin/python'; exit 1; }
sudo ln $(which python) /usr/bin/python || { echo "Cannot link $(which python) to /usr/bin/python"; exit 1; }

if [ -f '/usr/bin/python3' ]; then
  sudo mv /usr/bin/python3 /usr/bin/python3bak || { echo 'Cannot move /usr/bin/python3'; exit 1; }
fi

sudo ln $(which python) /usr/bin/python3 || { echo "Cannot link $(which python) to /usr/bin/python3"; exit 1; }

./cerbero-uninstalled "$@"

sudo rm /usr/bin/python

sudo mv /usr/bin/pythonbak /usr/bin/python

sudo rm /usr/bin/python3

if [ -f '/usr/bin/python3bak' ]; then
  sudo mv /usr/bin/python3bak /usr/bin/python3
fi
