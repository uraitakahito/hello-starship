#!/bin/bash -e
# https://create-it-myself.com/know-how/set-host-userid-groupid-to-docker-container/
SHELL_NAME='setUserGroup.sh'
GROUP_ID=$1
USER_ID=$2
USER_NAME=$3

echo "[$SHELL_NAME] START"

# グループID、グループ名の設定
if getent group "$GROUP_ID" > /dev/null 2>&1; then
    echo "[$SHELL_NAME] GROUP_ID '$GROUP_ID' already exists."
else
    echo "[$SHELL_NAME] GROUP_ID '$GROUP_ID' does NOT exist. So execute [groupadd -g \$GROUP_ID \$GROUP_NAME]."
    groupadd -g $GROUP_ID $GROUP_NAME
fi

# ユーザID、ユーザ名の設定
if getent passwd "$USER_ID" > /dev/null 2>&1; then
    echo "[$SHELL_NAME] USER_ID '$USER_ID' already exists."
else
    echo "[$SHELL_NAME] USER_ID '$USER_ID' does NOT exist. So execute [useradd -m -s /bin/bash -u \$USER_ID -g \$GROUP_ID \$USER_NAME]."
    useradd -m -s /bin/zsh -u $USER_ID -g $GROUP_ID $USER_NAME
fi

echo "[$SHELL_NAME] FINISH"
# exec $@
