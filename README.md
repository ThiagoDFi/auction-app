<h1>Leilão de Estoque</h1> 

<p align="center">
  <img src="http://img.shields.io/static/v1?label=Ruby&message=3.1.1&color=red&style=for-the-badge&logo=ruby"/>
  <img src="http://img.shields.io/static/v1?label=Ruby%20On%20Rails%20&message=7.0.4.3&color=red&style=for-the-badge&logo=ruby"/>

  <img src="http://img.shields.io/static/v1?label=TESTES&message=%3E100&color=GREEN&style=for-the-badge"/>
   <img src="http://img.shields.io/static/v1?label=STATUS&message=EM%20DESENVOLVIMENTO&color=RED&style=for-the-badge"/>
</p>

### Tópicos 

:small_blue_diamond: [Descrição do projeto](#descrição-do-projeto)

:small_blue_diamond: [Funcionalidades](#funcionalidades)

:small_blue_diamond: [Pré-requisitos](#pré-requisitos)

:small_blue_diamond: [Como rodar a aplicação](#como-rodar-a-aplicação-arrow_forward)

## Descrição do projeto 

<p align="justify">
  O projeto é uma aplicação web com Ruby on Rails que serve para conectar o público com itens que são abandonados, permitindo que esses itens sejam comercializados novamente. O formato escolhido foi o de leilão de itens. Este projeto faz parte da primeira etapa de treinamento do TreinaDev.
</p>

## Funcionalidades

:heavy_check_mark: Cadastro de produtos disponíveis para venda

:heavy_check_mark: Configuração de lotes, datas e lances mínimos para leilões

:heavy_check_mark: Acompanhamento de lances recebidos nos lotes

:heavy_check_mark: Criação de conta para usuários regulares/visitantes

:heavy_check_mark: Busca por produtos

:heavy_check_mark: Detalhes de produtos

:heavy_check_mark: Fazer uma oferta (se ainda possível)

## Layout :dash:

![Layout](https://github.com/ThiagoDFi/auction-app/blob/main/app/assets/images/site_leilao.png)

## Pré-requisitos


:warning: [Ruby: versão 3.1.1](https://www.ruby-lang.org/en/news/2022/02/18/ruby-3-1-1-released/)

:warning: [Ruby on Rails: versão 7.0.4.3](https://rubygems.org/gems/rails/versions/7.0.4.3)

:warning: [Node](https://nodejs.org/en/download/)

:warning: [Bundler](https://rubygems.org/gems/bundler)

:warning: [SQLite](https://www.sqlite.org/download.html)

## Como rodar a aplicação :arrow_forward:

No terminal, clone o projeto: 

```
git clone https://github.com/ThiagoDFi/auction-app.git
```

Entre na pasta do projeto:

```
cd auction-app
```

Execute o comando bundle, para instalar todas as dependências do projeto.

```
bundle install
```

Execute o comando migrate, para realizar as migrações do banco de dados.

```
rails db:migrate
```
Execute o comando seed, para popular a aplicação com dados de exemplo.

```
rails db:seed
```

Por fim, execute o comando server, para iniciar o servidor de desenvolvimento.

```
rails server
```

Acesse a aplicação em seu navegador através do endereço http://localhost:3000.

## Como rodar os testes

Para executar os testes automatizados da aplicação entre no diretorio da aplicação e execute o comando abaixo

```
$ rspec
```

## Casos de Uso

A aplicação contém dois tipos de usuários, o administrador e o cliente. Cada perfil possui visualizações e ações diferentes. O administrador é responsável por gerenciar o site, sendo assim, apenas usuários administradores são capazes de cadastrar produtos, lotes, adicionar item, aprovar e finalizar um lote. Por ser um perfil de gerenciamento ele não pode realizar lances em lotes disponíveis, todo usuário que se cadastrar na plataforma com o domínio @leilaodogalpao.com.br são automaticamente adicionados ao perfil de administrador.

O cliente por sua vez possui suas ações limitadas a realizar lances em lotes disponiveis, realizar buscas por produtos ou IDs de lotes e consulta se ganhou um lote que tenha participado.

## Tarefas em aberto

:memo: Dúvidas sobre um lote


## Autor

Este projeto foi desenvolvido por Thiago Firmino.

GitHub: [ThiagoDFI](https://github.com/ThiagoDFi)