#!/bin/bash -ex

# 変数の存在チェック
: "${FSCHAT_WORKER_MODEL_NAMES:?}"  # TODO: 必須にするかどうか検討
: "${FSCHAT_WORKER_MODEL_PATHS:?}"  # TODO: 必須にするかどうか検討
: "${FSCHAT_WORKER_HOST:?}"
: "${FSCHAT_WORKER_PORT:?}"
: "${FSCHAT_CONTROLLER_PORT:?}"
: "${FSCHAT_WORKER_NUM_GPUS:?}"

# 最初のモデルのみを使う
# カンマ区切りの最初だけ
model_args="--model-path $(echo "$FSCHAT_WORKER_MODEL_PATHS" | cut -d, -f1) --model-names $(echo "$FSCHAT_WORKER_MODEL_NAMES" | cut -d, -f1)"

python3.9 -m fastchat.serve.model_worker \
  --host "$FSCHAT_WORKER_HOST" \
  --port "$FSCHAT_WORKER_PORT" \
  "$model_args" \
  --worker-address "http://fastchat-model-worker:$FSCHAT_WORKER_PORT" \
  --controller-address "http://fastchat-controller:$FSCHAT_CONTROLLER_PORT" \
  --num-gpus "$FSCHAT_WORKER_NUM_GPUS" \
  --debug DEBUG
