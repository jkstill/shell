
If in a shell, use $BASH_VERSION

echo "${BASH_VERSION%%\(*}"


If in something else:

bash --version | head -n1 | sed -r -e 's/^(.)+([0-9]+\.[0-9]+\.[0-9]+)(.)+$/\2/'

Or use the BASH_VERSINFO builtin variable:

MAJOR_INDEX=0
MINOR_INDEX=1
PATCH_INDEX=2

BASH_MAJOR=${BASH_VERSINFO[MAJOR_INDEX]}
BASH_MINOR=${BASH_VERSINFO[MINOR_INDEX]}
BASH_PATCH=${BASH_VERSINFO[PATCH_INDEX]}

