#!/bin/bash

function error() {
  echo $(date)" ${1} failed"
  exit 1
}

NAME="$1"
TPROC="$2"
GCC_VERSION="$3"
CDIR="$PWD"
WDIR="${CDIR}/buildloop.d/${NAME}/"
for ((I=0;1;I++)); do
  cd "${CDIR}" || error "leave workdir"
  echo $(date)" start ${I}"
  [ -e "${WDIR}" ] && rm -rf "${WDIR}"
  mkdir -p "${WDIR}" || error "create workdir"
  cd "${WDIR}" || error "change to workdir"
  ${CDIR}/gcc-${GCC_VERSION}/configure --disable-multilib &> configure.log || error "configure"
  make -j "$TPROC" &> build.log || error "build"
done
