# CoTeRAG-S: Hybrid Knowledge Graph Retrieval for Scientific Question Answering

**Author**: Chaiwat Plongkaew  
**Advisor**: Prof. Deng Juan  
**Affiliation**: School of Computer Science, Wuhan University

## 🌐 Project Overview

CoTeRAG-S is a **hybrid Retrieval-Augmented Generation (RAG)** system designed to enhance scientific question answering, especially in high-stakes domains like **biomedicine**. It combines **knowledge graph-based community structuring**, **semantic vector retrieval**, and **term coverage validation** to improve answer completeness, interpretability, and factual grounding.

## 🎯 Key Features

- Graph-based retrieval using Neo4j with community detection via the Leiden algorithm
- LLM-powered community summarization using DeepSeek-V3 (671B, 32k tokens)
- Hybrid retrieval pipeline combining dense vector search with multi-hop graph traversal
- Term coverage filtering to ensure all critical query terms are retrieved
- Fallback mechanism using unfiltered node expansion for sparse queries
- Evaluation using RAGAS metrics: Answer Relevancy, Faithfulness, Contextual Recall, Contextual Precision

## 📊 Experimental Results (CORD-19 Dataset)

| Metric               | CoTeRAG-S | ChatGPT-4o |
|----------------------|-----------|------------|
| Answer Relevancy     | 0.93      | 0.94       |
| Faithfulness         | 0.60      | 0.89       |
| Contextual Recall    | 0.66      | 0.32       |
| Contextual Precision | 0.77      | 0.67       |

CoTeRAG-S excels at **retrieving more complete and well-aligned evidence**, even if slightly less fluent than ChatGPT-4o.

## 🧠 Architecture

### Full pipeline
<img src="architecture/Full Diagram.drawio.png">

### Knowledge Graph Construction
<img src="architecture/Data preprocessing pipepline.drawio.png">
<img src="architecture/enity embedding.drawio.png">

### Community Detection
<img src="architecture/Community Detection.drawio.png">
<img src="architecture/Community Summary Embedding.drawio.png">



## 📦 Tech Stack

- **Language Models**: LLaMA 3.1 / 3.2 for answer generation, LLaMA 3.3 for evaluation, DeepSeek-V3 for summarization
- **NER & RE Models**: GLiNER (entity recognition), REBEL (relation extraction)
- **Database**: Neo4j (graph storage & Cypher queries)
- **Embedding**: nomic-embed-text-v1.5
- **Evaluation**: RAGAS framework

## 🧪 Components

- `knowledge_graph`: Entity and relation extraction pipeline using GLiNER + REBEL
- `summarization`: Summarization of community subgraphs with DeepSeek-V3
- `retrieval`: Graph traversal, vector search, and term coverage filtering
- `fallback`: Expansion strategy for low-coverage queries
- `evaluation`: Scripts to compute RAGAS metrics

## 📂 Dataset

- **CORD-19**: COVID-19 scientific literature dataset used to construct the biomedical KG and evaluate QA performance.


## 📌 Future Work
- Support for dynamic and overlapping **communities**
- Integrating entity-aware summarization
- Evaluation with human experts and larger test sets
- Real-time graph updates and temporal reasoning