# Demo: Frontend + Backend (Docker) com CI/CD no GitHub Actions → EC2

Este projeto **pronto para uso** atende aos requisitos:
- Aplicação com **frontend** (Nginx + HTML/JS) e **backend** (Node/Express) se comunicando por **API**.
- O **NodeJS** (backend) roda dentro de um **contêiner Docker**.
- Gerenciamento de código com **Git/GitHub** usando 3 branches: `dev`, `staging` e `master`.
- **GitHub Actions** realiza o **deploy na AWS (EC2)**. Você poderá gravar um **vídeo** mostrando a aplicação **antes e depois** da atualização.

> Dica: se quiser uma mudança visual clara no vídeo, altere o texto retornado pela rota `GET /api/hello` de `"v1"` para `"v2"` no arquivo `backend/server.js`.

---

## 0) Pré-requisitos (Windows)

1. **Windows 10/11** com usuário administrador.
2. **Docker Desktop** (Habilite o **WSL 2** durante a instalação).
3. **Git for Windows** (instale com o Git Bash).
4. **Node.js LTS** (apenas se quiser rodar sem Docker, não é obrigatório).
5. **Conta no GitHub** e **conta na AWS**.
6. (Opcional) **OBS Studio** para gravar o vídeo.

---

## 1) Rodar localmente (Docker)

1. Extraia o zip em uma pasta. Abra um terminal (PowerShell ou Git Bash) dentro da pasta do projeto.
2. Execute:
   ```bash
   docker compose up -d --build
   ```
3. Acesse o frontend em **http://localhost:8080**. Clique em **"Chamar API"** e veja a resposta da rota `GET /api/hello`.
4. Para parar:
   ```bash
   docker compose down
   ```

---

## 2) Criar repositório no GitHub e branches

1. Crie um repositório vazio no GitHub (nome sugerido: `node-docker-ci-demo`).   No GitHub, deixe temporariamente com a branch padrão `main` mesmo.
2. No seu computador, dentro da pasta do projeto, rode:
   ```bash
   git init
   git add .
   git commit -m "Projeto inicial"
   git branch -M master          # renomeia branch atual para 'master'
   git remote add origin https://github.com/SEU_USUARIO/node-docker-ci-demo.git
   git push -u origin master
   git checkout -b staging
   git push -u origin staging
   git checkout -b dev
   git push -u origin dev
   ```
3. No GitHub (Settings → Branches), defina **`master`** como branch padrão se desejar (opcional).

---

## 3) Criar uma instância EC2 (Ubuntu) e preparar o servidor

1. No console da AWS, crie uma **EC2 Ubuntu 22.04 LTS** (t2.micro).   **Security Group**: libere **porta 22 (SSH)** e **porta 8080 (TCP)** a partir do seu IP/Internet.
2. Conecte via SSH usando a sua **.pem** (chave criada na AWS):
   ```bash
   ssh -i /caminho/sua-chave.pem ubuntu@IP_PUBLICO_DA_EC2
   ```
3. No servidor, rode o script para instalar Docker e Compose:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/docker/docker-install/master/install.sh | sh
   sudo usermod -aG docker ubuntu
   newgrp docker
   sudo apt-get update -y && sudo apt-get install -y docker-compose-plugin git
   mkdir -p ~/app
   ```
   > Se preferir, use o arquivo `script_ec2_setup.sh` deste projeto (copie e cole o conteúdo no servidor).

---

## 4) Configurar *Secrets* no GitHub

No repositório → **Settings → Secrets and variables → Actions → New repository secret**:

- `EC2_HOST` = IP público da sua instância (ex.: `54.123.45.67`)- `EC2_USER` = `ubuntu` (para Ubuntu)- `EC2_KEY`  = **conteúdo da sua chave privada** (abra o `.pem` com um editor e cole o conteúdo inteiro)

> Segurança: nunca faça commit da chave. Guarde apenas nos **Secrets**.

---

## 5) Pipeline de Deploy (GitHub Actions)

O workflow em `.github/workflows/deploy.yml`:
- É acionado em *push* nas branches `master`, `staging` e `dev`.
- Copia os arquivos do repositório para `~/app` na EC2 (via **SCP**).
- Executa `docker compose up -d --build` na EC2, atualizando os contêineres.

Verifique os *logs* do Actions na aba **Actions** do repositório.

---

## 6) Mostrar "antes e depois" no vídeo

1. Abra no navegador: `http://IP_PUBLICO_DA_EC2:8080` e clique em **"Chamar API"**: verá `version: "v1"`.
2. Edite `backend/server.js` trocando `"v1"` por `"v2"` e faça *commit* na **branch `master`**:
   ```bash
   git checkout master
   git pull
   git add backend/server.js
   git commit -m "Atualiza API para v2"
   git push
   ```
3. Acompanhe a *pipeline* rodar no GitHub (Actions). Quando terminar, recarregue a página: verá `version: "v2"`.
4. Pronto: demonstre no vídeo o **antes (v1)** e **depois (v2)**.

---

## 7) Comandos úteis

```bash
# Status e logs
docker compose ps
docker compose logs -f backend
docker compose logs -f frontend

# Reiniciar serviços após mudanças
docker compose up -d --build

# Parar e remover
docker compose down
```

---

## 8) Problemas comuns

- **Site não abre na EC2**: confira se a porta **8080** está aberta no Security Group.
- **Permissão Docker na EC2**: rode `sudo usermod -aG docker ubuntu && newgrp docker`.
- **Actions falha por SSH**: verifique `EC2_HOST`, `EC2_USER` e o conteúdo de `EC2_KEY`.
- **Portas em uso**: altere o mapeamento em `docker-compose.yml` (ex.: `- "8081:80"` no frontend).

---

Boa gravação! ✨
