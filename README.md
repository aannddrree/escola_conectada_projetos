# Escola Conectada

Projeto composto por dois módulos principais:

1. `api-escola-conectada` - backend em Java Spring Boot.
2. `app_escola_conectadaon` - frontend mobile em Flutter.

## Visão geral

Escola Conectada é uma solução didática para comunicação entre professores e responsáveis de alunos do 1º ao 4º ano. O backend expõe uma API REST para gerenciar dados de responsáveis, alunos, professores, comunicados e respostas. O app Flutter consome essa API para permitir cadastro e troca de mensagens de forma simples.

## Estrutura do repositório

- `api-escola-conectada/` - serviço backend Java Spring Boot.
- `app_escola_conectadaon/` - aplicativo Flutter.

## Backend - `api-escola-conectada`

O backend fornece endpoints para:

- cadastro de responsáveis
- cadastro de alunos
- cadastro de professores
- criação de comunicados
- listagem de comunicados
- listagem de comunicados por aluno
- envio de respostas a comunicados

### Como executar

No diretório `api-escola-conectada`:

```bash
mvn spring-boot:run
```

### URLs úteis

- API: `http://localhost:8080`
- Swagger UI: `http://localhost:8080/swagger-ui.html`
- H2 Console: `http://localhost:8080/h2-console`

Configuração do H2:

- JDBC URL: `jdbc:h2:mem:escoladb`
- Usuário: `sa`
- Senha: deixar em branco

## Frontend - `app_escola_conectadaon`

O app Flutter serve como interface móvel para pais e professores interagirem com a API.

### Pré-requisitos

- Flutter instalado
- API rodando localmente

### Como executar

No diretório `app_escola_conectadaon`:

```bash
flutter pub get
flutter run
```

### Configuração da API

No arquivo `lib/services/api_config.dart`, ajuste `baseUrl` de acordo com o ambiente.

- Para execução local no computador: `http://localhost:8080`
- Para emulador Android: `http://10.0.2.2:8080`

## Funcionalidades

- cadastro de responsáveis
- cadastro de alunos
- cadastro de professores
- envio e listagem de comunicados
- resposta a comunicados

## Observações

Este projeto é ideal para estudos de integração entre um backend Spring Boot e um app Flutter, mostrando o funcionamento de uma aplicação completa de comunicação escolar.
