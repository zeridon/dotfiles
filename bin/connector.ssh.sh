#!/bin/bash -i
#set -xe
#
# $Id$
#
# Simple connector wrapper
# connector.ssh:<jump host>:<remote host>:<session title>:<local port>:<remote port>:<tgt username>:<nologin>:<env type>:<ssh port>

VERSION="1.1-20121211"
CONNECTOR_DIR=${CONNECTOR_DIR:-$HOME/connector}
if [ ! -d ${CONNECTOR_DIR} ] ; then
	mkdir -p ${CONNECTOR_DIR}
fi
LOGDIR=${CONNECTOR_LOGDIR:-$CONNECTOR_DIR/logs}
if [ ! -d ${LOGDIR} ] ; then
	mkdir -p ${LOGDIR}
fi
TITLE1=${CONNECTOR_TITLE1:-''}
TITLE2=${CONNECTOR_TITLE2:-''}
CONNECTOR_SFTP_DELAY=${CONNECTOR_SFTP_DELAY:-10}
SFTP_DIR=${CONNECTOR_SFTP_DIR:-$CONNECTOR_DIR/sftp}
if [ ! -d ${SFTP_DIR} ] ; then
	mkdir -p ${SFTP_DIR}
fi

## Env Setup
function setup_environment {
	if [ "x${CONNECTOR_USER}" = "x" ] ; then
		echo 'Target Username is not set'
		echo -n 'Please enter target Username: '
		read CONNECTOR_USER
		# now write it down
		USER_SHELL=`echo $SHELL | rev | cut -d\/ -f1 | rev`
		case ${USER_SHELL} in
			'bash')
				grep -v 'CONNECTOR_USER' ${HOME}/.bashrc > /tmp/connector.tmp.$$
				echo "## CONNECTOR_USER Target username
export CONNECTOR_USER=$CONNECTOR_USER" >> /tmp/connector.tmp.$$
				mv /tmp/connector.tmp.$$ ${HOME}/.bashrc
				echo 'You will have to Login/Logout to make this permanent.'
				read
				;;
			'ksh')
				grep -v 'CONNECTOR_USER' ${HOME}/.kshrc > /tmp/connector.tmp.$$
				echo "## CONNECTOR_USER Target username
export CONNECTOR_USER=$CONNECTOR_USER" >> /tmp/connector.tmp.$$
				mv /tmp/connector.tmp.$$ ${HOME}/.kshrc
				echo 'You will have to Login/Logout to make this permanent.'
				read
				;;
			'csh')
				grep -v 'CONNECTOR_USER' ${HOME}/.cshrc > /tmp/connector.tmp.$$
				echo "## CONNECTOR_USER Target username
setenv CONNECTOR_USER=$CONNECTOR_USER" >> /tmp/connector.tmp.$$
				mv /tmp/connector.tmp.$$ ${HOME}/.cshrc
				echo 'You will have to Login/Logout to make this permanent.'
				read
				;;
			*)
				echo "Your shell {USER_SHELL} is currently not supported"
				echo "Press enter to exit"
				read
				exit 9
				;;
		esac
	fi
}

## Build command line
function build_cmd {
	CMD_TO_RUN='ssh -q -2 -t -A -X -Y -o PreferredAuthentications=publickey -o StrictHostKeyChecking=no -o CheckHostIP=no -o UserKnownHostsFile=/dev/null '
	if [ "x${RELAY}x" == "xnorelayx" ] ; then
		# direct connection
		REMOTE_CMD=''
		REMOTE_USER=${TARGET_USER}
		CMD_TO_RUN="${CMD_TO_RUN} -p ${SSH_PORT} -l ${REMOTE_USER} ${TARGET}"
		echo ${CMD_TO_RUN}
		return 0
	fi

	if [ ${RELAY} == ${TARGET} ] ; then
		# direct connection
		REMOTE_CMD=''
		REMOTE_USER=${TARGET_USER}
		CMD_TO_RUN="${CMD_TO_RUN} -p ${SSH_PORT} -l ${REMOTE_USER} ${TARGET}"
		echo ${CMD_TO_RUN}
		return 0
	fi

	REMOTE_CMD="${CMD_TO_RUN} -p ${SSH_PORT} -l ${TARGET_USER} ${TARGET}"
	CMD_TO_RUN="${CMD_TO_RUN} -p 22 -l ${CONNECTOR_USER} ${RELAY} ${REMOTE_CMD}"

	echo ${CMD_TO_RUN}
	return 0
}

## Call the shit
function connect_it {
	TITLE="${TITLE1} ${TITLE2} ${TITLE}"
	case ${ENVIRONMENT} in 
		0)
			TITLE="${TITLE} UNDEFINED System"
			;;
		1)
			TITLE="${TITLE} PRODUCTION System"
			;;
		2)
			TITLE="${TITLE} STAGING System"
			;;
		3)
			TITLE="${TITLE} TEST System"
			;;
		4)
			TITLE="${TITLE} DEVELOPMENT System"
			;;
		5)
			TITLE="${TITLE} DISASTER RECOVERY System"
			;;
		6)
			TITLE="${TITLE} QA System"
			;;
		*)
			TITLE="${TITLE} UNDEFINED System"
			;;
	esac

	gnome-terminal --working-directory="${CONNECTOR_DIR}" -t "${TITLE}" -e "$(build_cmd)"
}

## Main
# Verify we have the necessary stuff
setup_environment

# parse input
CONNECTOR_STRING=$1
RELAY=`echo ${CONNECTOR_STRING} | cut -d\: -f2`
TARGET=`echo ${CONNECTOR_STRING} | cut -d\: -f3`
TITLE=`echo ${CONNECTOR_STRING} | cut -d\: -f4`
LOCAL_PORT=`echo ${CONNECTOR_STRING} | cut -d\: -f5`
REMOTE_PORT=`echo ${CONNECTOR_STRING} | cut -d\: -f6`
TARGET_USER=`echo ${CONNECTOR_STRING} | cut -d\: -f7`
NOLOGIN=`echo ${CONNECTOR_STRING} | cut -d\: -f8`
ENVIRONMENT=`echo ${CONNECTOR_STRING} | cut -d\: -f9`
SSH_PORT=`echo ${CONNECTOR_STRING} | cut -d\: -f10`

if [ -z ${ENVIRONMENT} ] ; then
	ENVIRONMENT='0'
fi

if [ "${TARGET_USER}" == "x" ] ; then
	TARGET_USER=${CONNECTOR_USER}
fi

eval connect_it
