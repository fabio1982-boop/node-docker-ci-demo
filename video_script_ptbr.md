# Roteiro do Vídeo (passo a passo)

> Objetivo: provar os requisitos com uma demonstração simples, clara e objetiva.

## Cena 1 — Introdução (10–20s)
- Diga rapidamente: "Vamos ver um app com frontend + backend. O backend em Node roda em Docker. O código está no GitHub com branches dev, staging e master. O deploy para a AWS EC2 é automático via GitHub Actions."

## Cena 2 — Rodando localmente (30–60s)
1. Abra o terminal na pasta do projeto.
2. Rode: `docker compose up -d --build`.
3. Abra `http://localhost:8080` e clique em **Chamar API**. Mostre a resposta com `version: "v1"`.

## Cena 3 — Git & Branches (20–40s)
- Mostre o repositório no GitHub com as branches `dev`, `staging`, `master`.

## Cena 4 — Deploy automático (1–2 min)
1. Abra `http://IP_PUBLICO_DA_EC2:8080` e clique em **Chamar API** (versão `v1`).
2. No editor, altere `backend/server.js` para retornar `"v2"`.
3. `git add`, `git commit`, `git push` na **branch `master`**.
4. Abra a aba **Actions** e mostre a execução do workflow.
5. Ao finalizar, atualize a página da EC2: agora a resposta mostra `version: "v2"`.

## Cena 5 — Encerramento (10–20s)
- Faça um resumo curto e finalize.
