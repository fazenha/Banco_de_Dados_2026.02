# Manual de Sobrevivência: Git & GitHub

Guia prático e rápido para uso do Git e GitHub no dia a dia e em trabalhos em equipe.

*Prof. Flávio Copola Azenha*
---

## Sumário

- [1. O que é Git e GitHub?](#1-o-que-é-git-e-github)
- [2. Configuração Inicial (Primeiros Passos)](#2-configuração-inicial-primeiros-passos)
  - [2.1 Identidade (Nome e E-mail)](#21-configure-seu-nome-e-e-mail-use-os-mesmos-do-github)
  - [2.2 Configurações extras recomendadas](#22-configurações-extras-recomendadas)
- [3. Comandos Essenciais](#3-comandos-essenciais)
  - [3.1 Criar e Clonar Repositórios](#31-criar-e-clonar-repositórios)
  - [3.2 O Ciclo Básico](#32-o-ciclo-básico-você-vai-usar-isso-o-tempo-todo)
  - [3.3 Trabalhando com o Remoto (GitHub)](#33-trabalhando-com-o-remoto-github)
  - [3.4 Navegando no Histórico](#34-navegando-no-histórico)
- [4. Trabalho em Equipe (Branches e Colaboração)](#4-trabalho-em-equipe-branches-e-colaboração)
  - [4.1 Criando e usando branches](#41-criando-e-usando-branches)
  - [4.2 Mesclando mudanças](#42-mesclando-mudanças)
- [5. Gerenciando Pull Requests (PR) — Web e CLI (`gh`)](#5-gerenciando-pull-requests-pr--web-e-cli-gh)
  - [5.1 Passo a Passo pela Web (Interface Gráfica)](#51-passo-a-passo-pela-web-interface-gráfica--recomendado-para-iniciantes)
  - [5.2 Ciclo Completo com GitHub CLI (`gh`): Criar, Testar, Aprovar e Mergear](#52-ciclo-completo-com-github-cli-gh-criar-testar-aprovar-e-mergear)
  - [5.3 Boas práticas na hora de abrir e revisar um PR](#53-boas-práticas-na-hora-de-abrir-e-revisar-um-pr)
- [6. Boas Práticas para Trabalho em Equipe](#6-boas-práticas-para-trabalho-em-equipe)
  - [Fluxo de Trabalho Recomendado (GitHub Flow)](#fluxo-de-trabalho-recomendado-github-flow)
  - [Mensagens de Commit — Como escrever bem](#mensagens-de-commit--como-escrever-bem)
  - [Nomeação de Branches](#nomeação-de-branches)
  - [Limpeza e Organização](#limpeza-e-organização)
- [7. Comandos de Emergência (Quando tudo der errado)](#7-comandos-de-emergência-quando-tudo-der-errado)
- [8. Dicas Extras](#8-dicas-extras)

---

## 1. O que é Git e GitHub?

* **Git:** É um sistema de controle de versão que registra cada alteração nos seus arquivos ao longo do tempo.
* **GitHub:** É uma plataforma online onde você hospeda repositórios Git e colabora com outras pessoas.

---

## 2. Configuração Inicial (Primeiros Passos)

Antes de qualquer coisa, configure sua identidade. Essas informações vão aparecer em todos os seus commits:

### 2.1 Configure seu nome e e-mail (use os mesmos do GitHub!)

```bash
git config --global user.name "Seu Nome Completo"
git config --global user.email "seuemail@example.com"
```

### 2.2 Configurações extras recomendadas

* **Defina "main" como branch padrão (em vez de "master"):**
  ```bash
  git config --global init.defaultBranch main
  ```

* **Evita que o Git converta quebras de linha automaticamente:**
  ```bash
  git config --global core.autocrlf false
  ```

* **Evita mensagens confusas ao dar pull:**
  ```bash
  git config --global pull.rebase false
  ```

* **Verifique se está tudo certo:**
  ```bash
  git config --list
  ```

---

## 3. Comandos Essenciais

Comandos fundamentais para o dia a dia.

### 3.1 Criar e Clonar Repositórios

* **Transforma a pasta atual em um repositório Git:**
  ```bash
  git init
  ```

* **Baixa uma cópia local de um repositório remoto:**
  ```bash
  git clone <url>
  ```

### 3.2 O Ciclo Básico (você vai usar isso o tempo todo)

O Git funciona em três zonas: **diretório de trabalho** (onde você edita), **staging area** (onde prepara o que vai salvar) e **repositório local** (histórico salvo).

* **Vê o que mudou e o que está pronto para commit:**
  ```bash
  git status
  ```

* **Adiciona um arquivo específico à staging:**
  ```bash
  git add <arquivo>
  ```

* **Adiciona TODAS as alterações à staging:**
  ```bash
  git add .
  ```

* **Salva um snapshot das alterações:**
  ```bash
  git commit -m "mensagem"
  ```

> [!TIP]
> Faça commits pequenos e frequentes. Cada commit deve representar uma mudança lógica.

### 3.3 Trabalhando com o Remoto (GitHub)

* **Conecta seu repositório local ao GitHub:**
  ```bash
  git remote add origin <url>
  ```

* **Envia seus commits para o GitHub (primeira vez):**
  ```bash
  git push -u origin main
  ```

* **Envia commits (depois que já configurou o upstream):**
  ```bash
  git push
  ```

* **Baixa e integra mudanças do repositório remoto:**
  ```bash
  git pull
  ```

### 3.4 Navegando no Histórico

* **Mostra o histórico de commits:**
  ```bash
  git log
  ```

* **Histórico bonitinho com gráfico:**
  ```bash
  git log --oneline --graph --all
  ```

* **Mostra o que você mudou mas ainda não adicionou:**
  ```bash
  git diff
  ```

---

## 4. Trabalho em Equipe (Branches e Colaboração)

Comandos fundamentais para o trabalho em equipes.

### 4.1 Criando e usando branches

Uma branch é uma linha de desenvolvimento independente. Use branches para cada nova funcionalidade ou correção.

* **Lista todas as branches locais:**
  ```bash
  git branch
  ```

* **Cria uma nova branch:**
  ```bash
  git branch <nome>
  ```

* **Muda para uma branch existente:**
  ```bash
  git checkout <nome>
  ```

* **Cria E já muda para a nova branch:**
  ```bash
  git checkout -b <nome>
  # ou sintaxe mais nova:
  git switch -c <nome>
  ```

### 4.2 Mesclando mudanças

* **Volta para a branch principal:**
  ```bash
  git checkout main
  ```

* **Mescla a branch `<nome-branch>` na branch atual:**
  ```bash
  git merge <nome-branch>
  ```

* **Enviando uma branch nova para o GitHub (e configurando o rastreamento):**
  ```bash
  git push -u origin <nome-branch>
  ```

---

## 5. Gerenciando Pull Requests (PR) — Web e CLI (`gh`)

O Pull Request (PR) é o coração da colaboração no GitHub. É onde você pede que suas alterações sejam revisadas e mescladas à branch principal (geralmente a `main`).

---

### 5.1 Passo a Passo pela Web (Interface Gráfica) — Recomendado para iniciantes

1. **Envie sua branch para o GitHub (se ainda não fez):**
   ```bash
   git push -u origin nome-da-sua-branch
   ```
2. **Acesse o repositório no GitHub** no seu navegador.
3. Clique na aba **"Pull requests"** (geralmente ao lado de "Issues").
4. Clique no botão verde **"New pull request"**.
5. **Escolha as branches corretas:**
   * **Base:** `main` (ou a branch para onde você quer mesclar)
   * **Compare:** `nome-da-sua-branch` (a branch com suas alterações)
6. **Preencha os detalhes do PR:**
   * **Título:** Seja claro e direto (ex: `"Adiciona função de login com JWT"`).
   * **Descrição:** Explique o que foi feito, por que e como testar. Se o PR resolve uma Issue, escreva `Closes #23` para fechá-la automaticamente.
   * **Marque revisores** (à direita, em *"Reviewers"*) — geralmente seus colegas de equipe ou o professor.
7. Clique em **"Create pull request"** e aguarde a revisão.

---

### 5.2 Ciclo Completo com GitHub CLI (`gh`): Criar, Testar, Aprovar e Mergear

O GitHub CLI (`gh`) permite executar todo o ciclo de vida de um PR direto do terminal, sem abrir o navegador.

> [!NOTE]
> Se ainda não conectou sua conta, execute uma única vez:
> ```bash
> gh auth login
> ```

#### Etapa 1: Criar o Pull Request (`gh pr create`)

* **Modo Interativo (Guiado e mais fácil):**
  Pergunta título, descrição, branch de destino e revisores dinamicamente:
  ```bash
  gh pr create
  ```

* **Modo Direto via parâmetros:**
  ```bash
  gh pr create --title "feat: adiciona login com JWT" --body "Implementa autenticação JWT. Closes #23" --base main
  ```

* **Criar e abrir o rascunho na Web (se preferir preencher visualmente):**
  ```bash
  gh pr create --web
  ```

* **Criar indicando revisores:**
  ```bash
  gh pr create --title "feat: adiciona tela de perfil" --body "Detalhes..." --reviewer colega1,colega2
  ```

---

#### Etapa 2: Acompanhar, Baixar e Testar o PR (`gh pr checkout`)

* **Listar PRs abertos no projeto:**
  ```bash
  gh pr list
  ```

* **Ver detalhes e status do PR no terminal:**
  ```bash
  gh pr view 42
  ```

* **Inspecionar as diferenças de código (*diff*):**
  ```bash
  gh pr diff 42
  ```

* **Baixar a branch do colega e testar localmente (Comando essencial! ✨):**
  Cria a branch local e faz o checkout automático do código do PR para que você possa rodar os testes antes de aprovar:
  ```bash
  gh pr checkout 42
  ```

---

#### Etapa 3: Revisar e Aprovar (`gh pr review`)

* **Aprovar o PR com comentário:**
  ```bash
  gh pr review 42 --approve -b "Código testado e funcionando perfeitamente! LGTM 🚀"
  ```

* **Solicitar alterações (Request Changes):**
  ```bash
  gh pr review 42 --request-changes -b "Por favor, adicione validação para o campo de email."
  ```

* **Deixar apenas um comentário geral:**
  ```bash
  gh pr review 42 --comment -b "Dúvida: por que escolhemos a biblioteca X em vez da Y?"
  ```

* **Revisão interativa:**
  ```bash
  gh pr review 42
  ```

---

#### Etapa 4: Mesclar e Limpar a Branch (`gh pr merge`)

* **Modo Interativo (Pergunta a estratégia de merge e se quer deletar a branch):**
  ```bash
  gh pr merge
  ```

* **Squash and Merge (Recomendado — compacta todos os commits em um e apaga a branch remota e local):**
  ```bash
  gh pr merge 42 --squash --delete-branch
  ```

* **Merge Commit padrão (mantém todo o histórico e deleta a branch):**
  ```bash
  gh pr merge 42 --merge --delete-branch
  ```

* **Auto-Merge (agenda o merge automático assim que os testes passarem e houver aprovação):**
  ```bash
  gh pr merge 42 --auto --squash
  ```

---

#### 📌 Cola Rápida de Sobrevivência do `gh`

| Ação | Comando CLI |
| :--- | :--- |
| **Criar PR interativo** | `gh pr create` |
| **Criar PR com título e corpo** | `gh pr create -t "Título" -b "Descrição"` |
| **Listar PRs abertos** | `gh pr list` |
| **Puxar e testar PR localmente** | `gh pr checkout <número>` |
| **Ver diferenças de código (*diff*)** | `gh pr diff <número>` |
| **Aprovar PR** | `gh pr review <número> --approve -b "Aprovado!"` |
| **Solicitar ajustes** | `gh pr review <número> --request-changes -b "Motivo"` |
| **Fazer merge e deletar branch** | `gh pr merge <número> --squash --delete-branch` |
| **Ver status dos seus PRs** | `gh pr status` |

---

### 5.3 Boas práticas na hora de abrir e revisar um PR

* **Mantenha PRs pequenos** (máximo 300–400 linhas alteradas) — fica muito mais fácil de revisar.
* **Associe a uma Issue** sempre que possível (ex: `Closes #12`).
* **Adicione screenshots/gifs** se for uma mudança visual.
* **Verifique se o código está funcionando** antes de abrir o PR (teste localmente).
* **Não mescle seu próprio PR sem aprovação** — espere a revisão dos colegas de equipe.

---

## 6. Boas Práticas para Trabalho em Equipe

### Fluxo de Trabalho Recomendado (GitHub Flow)

O GitHub Flow é simples e eficaz para a maioria das equipes:

1. Crie uma Issue descrevendo a tarefa ou bug no GitHub.
2. Crie uma branch a partir da `main` para desenvolver a solução:
   ```bash
   git checkout main
   git pull origin main
   git checkout -b feature/nome-da-funcionalidade
   ```
3. Desenvolva fazendo commits pequenos e frequentes.
4. Abra um Pull Request (PR) seguindo o passo a passo acima.
5. Revise o código com colegas antes de mesclar.
6. Mescle o PR (geralmente pelo botão "Merge pull request" no GitHub).
7. Limpe as branches que não são mais necessárias (local e remotamente).

### Mensagens de Commit — Como escrever bem

* **Use o imperativo:** *"Adiciona"*, *"Corrige"*, *"Atualiza"* (não *"Adicionado"*, *"Corrigido"*).
* **Mantenha o assunto com menos de 50 caracteres.**
* **Seja descritivo:** diga o que mudou e por quê.
* **Exemplo:**
  ```bash
  git commit -m "Corrige bug no cálculo de média"
  ```

### Nomeação de Branches

Use nomes descritivos e padronizados:

* `feature/login-autenticacao` — nova funcionalidade
* `bugfix/corrige-loop-infinito` — correção de bug
* `hotfix/seguranca-urgente` — correção crítica em produção

### Limpeza e Organização

* **Mantenha branches curtas** — mescle em 1 a 3 dias.
* **Nunca force push (`git push --force`)** em branches compartilhadas.
* **Commits atômicos:** cada commit = uma mudança lógica.
* **Atualize sua branch com frequência:** `git pull` antes de começar a trabalhar.

---

## 7. Comandos de Emergência (Quando tudo der errado)

| Situação | Comando / Solução |
| :--- | :--- |
| **Esqueci de adicionar um arquivo no último commit** | `git commit --amend -m "Nova mensagem"` |
| **Adicionei arquivo errado na staging area** | `git reset <arquivo>` |
| **Quero descartar mudanças locais** | `git reset --hard` *(cuidado — perde alterações!)* |
| **Quero desfazer um commit já enviado** | `git revert <hash-do-commit>` |
| **Preciso salvar mudanças temporariamente** | `git stash` e depois `git stash pop` |
| **Conflito no merge?** | Resolva os conflitos manualmente, depois `git add .` e `git commit` |

> [!CAUTION]
> **Regra de ouro:** se não tiver certeza do que está fazendo, **não use `--force`** e peça ajuda!

---

## 8. Dicas Extras

* **`.gitignore`:** Crie este arquivo para ignorar arquivos desnecessários (como `node_modules/`, `.env`, arquivos de compilação).
* **Autenticação:** Use chaves SSH ou GitHub CLI (`gh auth login`) para evitar digitar senha toda hora.
* **2FA:** Ative a autenticação de dois fatores (2FA) no GitHub para proteger sua conta.
* **Issues:** Use Issues para organizar tarefas e discutir abordagens.
* **Documentação:** Documente o fluxo de trabalho da sua equipe em um arquivo `CONTRIBUTING.md`.
