# README

<h1 align="center">Coreplan Eventos</h1>

## Descrição do Projeto

<p align="center"> O projeto tem o intuito do desenvolvimento de uma api ao qual o usuário pode criar um evento e registrar um usuário e vincular a algum evento criado</p>

## Baixar o projeto

```
  git clone https://github.com/jonatasvenancio167/coreplan_evento.git
```

## Pré-requisitos

* Ruby 3.2.1
* Rails 7.0.8.4
* SQlite

# Feature

- [x] Cadastro de Evento
- [x] Atualizar Evento
- [x] Visualizar Evento
- [x] Cadastro de Inscrições
- [x] Deletar Inscrição
- [x] Atualizar Inscrição

# Instalação

```
  git clone https://github.com/jonatasvenancio167/coreplan_evento.git
  cd coreplan_evento
  bundle
  rails db:create
  rails db:migrate
  rails s
```

# Como usar

<h3>Métodos Eventos</h3>
<p>Method POST: /events</p>
<p>data e hora de início deve ser anterior à data e hora de
término e não podem existir eventos com horários conflitantes no mesmo local</p>

```
{
  "title": string,
  "description": string,
  "start_datetime": datetime,
  "end_datetime": datetime,
  "location": string,
  "capacity": number
}
```

<p>Method GET: /events/1</p>

```
{
	"title": "Evento teste",
	"description": "Este é um evento teste",
	"start_datetime": "12/01/2025 00:00",
	"end_datetime": "13/01/2025 00:00",
	"location": "Teste",
	"registered_count": 1,
	"vacancies_available": true
}
```

<p>Method PUT: /events/:id</p>

```
{
  "title": "Evento teste",
  "description": "Este é um evento para o teste 4",
  "start_datetime": "2025-01-02T10:00:00Z",
  "end_datetime": "2025-01-02T12:00:00Z",
  "location": "Fortaleza",
  "capacity": 100
}
```
<h3>Métodos Registros</h3>
<p>Method POST: /registrations</p>

```
{
  "participant_name": string,
  "participant_email": string,
  "event_id": number
}
```

<p>Method GET: /registrations/1</p>

```
{
  "participant_name": "nome_teste_2",
  "participant_email": "teste@email.com",
  "event_id": 1
}
```

<p>Method PUT: /registrations/:id</p>

```
{
  "participant_name": "nome_teste_3",
  "participant_email": "teste@email.com",
  "event_id": 1
}
```

<p>Method DELETE: /registrations/:id</p>
<p>O usuário deve poder cancelar sua inscrição, desde que o evento ainda não tenha começado.</p>

# Rodando os teste

```
  rspec
```
