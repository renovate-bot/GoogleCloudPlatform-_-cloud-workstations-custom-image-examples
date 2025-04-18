#!/bin/bash

# Copyright 2025 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# This script launches an Android Automotive OS (AAOS) 15 virtual device
# using Cuttlefish.

CODEBASE_DIR="${HOME}/aaos/vcar"

cd ${CODEBASE_DIR} && \
    source build/envsetup.sh && \
    lunch aosp_cf_x86_64_auto-ap4a-userdebug && \
    launch_cvd --start_webrtc=true &
