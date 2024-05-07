#!/bin/bash -ex

# 変数の存在チェック
: "${FSCHAT_WORKER_MODEL_NAMES:?}"  # TODO: 必須にするかどうか検討
: "${FSCHAT_WORKER_MODEL_PATHS:?}"  # TODO: 必須にするかどうか検討
: "${FSCHAT_WORKER_HOST:?}"
: "${FSCHAT_WORKER_PORT:?}"
: "${FSCHAT_CONTROLLER_PORT:?}"
: "${FSCHAT_WORKER_NUM_GPUS:?}"

model_path_args=()
for model_path in $(echo "$FSCHAT_WORKER_MODEL_PATHS" | tr ',' ' '); do
  model_path_args+=(--model-path "$model_path")
  break # 1つ目モデルだけ使う
done

python3.9 -m fastchat.serve.model_worker \
  --host "$FSCHAT_WORKER_HOST" \
  --port "$FSCHAT_WORKER_PORT" \
  "${model_path_args[@]}" \
  --model-names "$FSCHAT_WORKER_MODEL_NAMES" \
  --worker-address "http://fastchat-model-worker:$FSCHAT_WORKER_PORT" \
  --controller-address "http://fastchat-controller:$FSCHAT_CONTROLLER_PORT" \
  --num-gpus "$FSCHAT_WORKER_NUM_GPUS" \
  --debug
