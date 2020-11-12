echo "${{ inputs.module_name }}"
ls -al
export PYTHONPATH=$(pwd)
python -m pip install --upgrade pip
pip install pytest pytest-cov pylint
if [ -f requirements.txt ]; then pip install -r requirements.txt; fi
if [ -f requirements_test.txt ]; then pip install -r requirements_test.txt; fi
pylint --rcfile=.pylintrc ${{ inputs.module_name }} || exit 0
if [ -d tests -o -d test  ]; then pytest --cov=${{ inputs.module_name }} -v; else echo "tests not found" && exit 0; fi
