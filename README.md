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

  Ao executar o comando de seed, serão criados os seguintes registros no banco de dados:

- 2 usuários administradores.
- 2 usuários comuns.
- 15 produtos.
- 2 lotes de leilão ativos que ainda não iniciaram.
- 2 lotes ativos que já iniciaram.
- 2 lotes ativos que estão prestes a ser encerrados e tiveram lance.
- 2 lotes que podem ser cancelados por não terem nenhum lance.
- 2 lotes aguardando aprovação.
- 3 produtos que não foram associados a nenhum lote.

Esses registros fornecem uma base inicial para o funcionamento do sistema, permitindo testar diferentes funcionalidades, como a criação de leilões, lances, cancelamento de lotes e associação de produtos.

É importante observar que essas informações são fictícias e foram criadas exclusivamente para fins de desenvolvimento e teste do projeto.
</p>

## Funcionalidades

:heavy_check_mark: Cadastro de produtos disponíveis para venda

:heavy_check_mark: Configuração de lotes, datas e lances mínimos para leilões

:heavy_check_mark: Acompanhamento de lances recebidos nos lotes

:heavy_check_mark: Criação de conta para usuários regulares/visitantes

:heavy_check_mark: Busca por produtos em lotes existentes

:heavy_check_mark: Detalhes de produtos

:heavy_check_mark: Fazer uma oferta (se ainda possível)

:heavy_check_mark: Marcar Lote como favorito

:heavy_check_mark: Bloquear um CPF

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

Para executar os testes automatizados da aplicação entre no diretorio da aplicação e execute os comandos abaixo:

Testes de Sistema:

```
$ rails spec:system
```

Testes de Request:

```
$ rails spec:requests
```

Testes de Models:

```
$ rails spec:models
```

Para rodar todos os testes juntos:

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