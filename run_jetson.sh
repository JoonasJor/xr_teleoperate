#!/usr/bin/env bash
set -euo pipefail

ENV_NAME="tv"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONDA_SH="/home/unitree/miniconda3/etc/profile.d/conda.sh"
export OMP_NUM_THREADS=1

DEFAULT_ARGS=(
	--xr-mode=hand
	--arm=G1_29
	--ee=inspire1
	--network-interface=eth0
	--motion
	--disable-img-passthrough
	--headless
	--affinity
)

if [[ ! -f "${CONDA_SH}" ]]; then
	echo "Error: conda.sh not found at ${CONDA_SH}" >&2
	exit 1
fi

# shellcheck source=/dev/null
source "${CONDA_SH}"
conda activate "${ENV_NAME}"

jetson_clocks

cd "${SCRIPT_DIR}/teleop/"
exec python teleop_hand_and_arm.py "${DEFAULT_ARGS[@]}" "$@"
