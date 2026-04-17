ARG VLLM_VERSION=0.19.0
FROM vllm/vllm-openai-cpu:v${VLLM_VERSION}

ARG VLLM_VERSION

RUN pip install --no-cache-dir vllm[bench]==${VLLM_VERSION} && \
    curl -L -o /workspace/ShareGPT_V3_unfiltered_cleaned_split.json \
    https://huggingface.co/datasets/anon8231489123/ShareGPT_Vicuna_unfiltered/resolve/main/ShareGPT_V3_unfiltered_cleaned_split.json

ENTRYPOINT ["/bin/bash"]