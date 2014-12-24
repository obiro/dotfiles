#!/bin/bash

### update-alternatives
# /etc/alternatives/
# /var/lib/alternatives/

SETTING_FILE="/tmp/setting.tmp"

BIN_DIR="/usr/local/bin"
INSTALL_PATH="/usr/local"

INSTALL_PROGRAMS_PATH=( `find ${INSTALL_PATH}/* -type d -prune | egrep -r "-" | sort -r` )

for string in ${INSTALL_PROGRAMS_PATH[@]}; do
  INSTALL_PROGRAMS_VERSION+=( `echo "${string}" | awk -F / '{print $4}'` )
  unset string
done

for string in ${INSTALL_PROGRAMS_VERSION[@]}; do
  INSTALL_PROGRAMS_NAME+=( `echo "${string}" | sed -e "s/-.*//"` )
  unset string
done

echo ${INSTALL_PROGRAMS_PATH[@]}
echo ""
echo ${INSTALL_PROGRAMS_VERSION[@]}
echo ""
echo ${INSTALL_PROGRAMS_NAME[@]}




### yuusendo iretai
### version change wrap sitai


for INSTALL_PROGRAM_PATH in ${INSTALL_PROGRAMS_PATH[@]}; do

  INSTALL_PROGRAM_PATH_ARRAY=( `echo ${INSTALL_PROGRAM_PATH} | tr -s "/" " "` )
  INSTALL_PROGRAM_FULLNAME=${INSTALL_PROGRAM_PATH_ARRAY[((${#INSTALL_PROGRAM_PATH_ARRAY[@]}-1))]}
  INSTALL_PROGRAM_VERSION=`echo ${INSTALL_PROGRAM_FULLNAME} | sed -e "s/.*-//"`
  INSTALL_PROGRAM_NAME=`echo ${INSTALL_PROGRAM_FULLNAME} | sed -e "s/-.*//"`

  rm -f ${SETTING_FILE}
  touch ${SETTING_FILE}

  # clear
  update-alternatives --remove ${INSTALL_PROGRAM_NAME} "${INSTALL_PROGRAM_PATH}/bin/${INSTALL_PROGRAM_NAME}"

  echo "#!/bin/bash" >> ${SETTING_FILE}
  echo "update-alternatives --install "${BIN_DIR}/${INSTALL_PROGRAM_NAME}" "${INSTALL_PROGRAM_NAME} ${INSTALL_PROGRAM_PATH}/bin/${INSTALL_PROGRAM_NAME}" 10 \\" >> ${SETTING_FILE}

  for BIN_PATH in $(find ${INSTALL_PROGRAM_PATH}/bin -type f); do

    BIN_PATH_ARRAY=( `echo ${BIN_PATH} | tr -s "/" " "` )
    BIN_NAME=${BIN_PATH_ARRAY[((${#BIN_PATH_ARRAY[@]}-1))]}
    
    if [ ${BIN_NAME} = "${INSTALL_PROGRAM_NAME}" -o ! -f "${BIN_PATH}" ]; then
      continue;
    fi

    echo "--slave ${BIN_DIR}/${BIN_NAME} ${BIN_NAME} ${BIN_PATH} \\" >> ${SETTING_FILE}

  done

  echo "" >> ${SETTING_FILE}

  sh ${SETTING_FILE}

  rm -f ${SETTING_FILE}

done

