# rd-vllm-bench

> vLLM Benchmark Docker Image Builder

## 專案簡介

本專案用於建置 vLLM 效能基準測試（Benchmark）所需的 Docker 映像。映像基於 `vllm/vllm-openai-cpu` 官方映像，預先安裝 `vllm[bench]` 套件並內建 ShareGPT 資料集，可直接用於 vLLM 推論效能測試。

## 專案結構

```
.
├── Dockerfile                             # Docker 映像建置檔
├── .github/workflows/docker-publish.yml   # GitHub Actions CI/CD 工作流
├── LICENSE                                # Apache License 2.0
└── README.md                              # 本文件
```

## Docker 映像內容

映像以 `vllm/vllm-openai-cpu` 為基底，包含以下額外元件：

| 元件 | 說明 |
|------|------|
| `vllm[bench]` | vLLM 官方基準測試工具，版本與基底映像的 vLLM 版本一致 |
| `ShareGPT_V3_unfiltered_cleaned_split.json` | ShareGPT V3 對話資料集（清理版），存放於 `/workspace/` |

> **資料集來源：** [anon8231489123/ShareGPT_Vicuna_unfiltered](https://huggingface.co/datasets/anon8231489123/ShareGPT_Vicuna_unfiltered)

## 支援的 vLLM 版本

目前透過 CI/CD 矩陣策略自動建置以下版本：

- `0.18.1`
- `0.19.0`

如需新增版本，請修改 `.github/workflows/docker-publish.yml` 中的 `matrix.vllm_version` 陣列。

## 映像倉庫

映像發布至 **GitHub Container Registry (GHCR)**：

```
ghcr.io/ap-mic-inc/rd-vllm-bench:<vllm_version>
```

例如：

```
ghcr.io/ap-mic-inc/rd-vllm-bench:0.19.0
ghcr.io/ap-mic-inc/rd-vllm-bench:0.18.1
```

## 使用方式

### 1. 拉取映像

```bash
docker pull ghcr.io/ap-mic-inc/rd-vllm-bench:0.19.0
```

### 2. 執行基準測試

```bash
docker run --rm -it ghcr.io/ap-mic-inc/rd-vllm-bench:0.19.0
```

進入容器後即可使用 `vllm bench` 指令進行效能測試。

### 3. 本地建置

若需自訂 vLLM 版本，可於本地建置：

```bash
docker build --build-arg VLLM_VERSION=0.19.0 -t vllm-bench:0.19.0 .
```

## CI/CD 工作流

專案使用 GitHub Actions 自動建置並推送 Docker 映像。

**觸發條件：**

- 推送至 `main` 分支
- 手動觸發（`workflow_dispatch`）

**工作流程：**

1. Checkout 程式碼
2. 設定 Docker Buildx
3. 登入 GitHub Container Registry
4. 依照版本矩陣建置並推送映像
5. 使用 GitHub Actions Cache 加速建置

## 授權條款

本專案採用 [Apache License 2.0](LICENSE) 授權。
