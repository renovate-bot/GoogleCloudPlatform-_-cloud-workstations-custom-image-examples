# syntax=docker/dockerfile:1

# Copyright 2024 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Builder container for Cuttlefish
FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/base AS cuttlefish-builder

RUN apt-get update && apt-get install -y \
    git \
    devscripts \
    equivs \
    config-package-dev \
    debhelper-compat \
    golang \
    curl && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  git clone https://github.com/google/android-cuttlefish && \
  /android-cuttlefish/tools/buildutils/build_packages.sh && \
  mkdir out && \
  cp /android-cuttlefish/cuttlefish-base_*_*64.deb /out && \
  cp /android-cuttlefish/cuttlefish-user_*_*64.deb /out && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Main container
FROM us-central1-docker.pkg.dev/cloud-workstations-images/predefined/base

# Install repo and rsync
RUN apt-get update && apt-get install -y \
  repo \
  rsync && \
  #smoke tests
  repo version && \
  rsync --version && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Install Cuttlefish from builder
COPY --from=cuttlefish-builder /out /cuttlefish
RUN cd /cuttlefish && \
  apt-get update && \
  apt install -y ./cuttlefish-base_*.deb ./cuttlefish-user_*.deb && \
  cd / && \
  rm -rf /cuttlefish && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Install recommended tooling: https://source.android.com/docs/setup/start
RUN apt-get update && apt-get install -y \
    git-core \
    gnupg \
    flex \
    bison \
    build-essential \
    zip \
    curl \
    zlib1g-dev \
    libc6-dev-i386 \
    x11proto-core-dev \
    libx11-dev \
    lib32z1-dev \
    libgl1-mesa-dev \
    libxml2-utils \
    xsltproc \
    unzip \
    fontconfig && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Merge assets into the container.
COPY ./assets/. /

ENTRYPOINT ["/google/scripts/entrypoint.sh"]
