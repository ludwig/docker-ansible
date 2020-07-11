#!/bin/bash
# We can source this file, or a similar one, before running the helper
# script `docker-ansible`.

# Location of vault password.
export ANSIBLE_VAULT_PASSWORD_FILE="${HOME}/.ansible_vault_password"

# Location of log file.
export ANSIBLE_LOG_PATH="/tmp/ansible.log"

# Uncomment to set the `playbook_dir` config to "~/ansible/playbooks/".
# If this variable is not set, the helper script will mount ${PWD}.
#export ANSIBLE_PLAYBOOK_DIR="${HOME}/ansible/playbooks/"
