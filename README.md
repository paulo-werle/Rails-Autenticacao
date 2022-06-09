# Doorkeeper

Documentação: https://github.com/doorkeeper-gem/doorkeeper

Projeto de implementação: ‣

[Doorkeeper Guides](https://doorkeeper.gitbook.io/guides/)

- Passos para implementar a autenticação com o doorkeeper:
    1. Utilizar a `gem 'doorkeeper'`
    2. Adicionar as dependências no projeto com `bundle add doorkeeper`
    3. Gerar arquivos com `bundle exec rails generate doorkeeper:install`
        - Com isso teremos os seguintes arquivos
            - Foi criado um arquivo **initializer** em `config/initializers/doorkeeper.rb`
            - Foi criado um arquivo de **idioma em** `config/locales/doorkeeper.en.yml`
            - Foi adicionado as **routes** do doorkeeper em `config/routes.rb`
    4. Gerar as tabelas apropriadas com `bundle exec rails generate doorkeeper:migration`
        - Com isso teremos a seguinte migração
            - `create db/migrate/20190324080634_create_doorkeeper_tables.rb`
        - Antes de executar a migração, podemos informar qual é a nossa tabela de usuarios para podermos vincular as informações
            - Com isso podemos ajustar como o código abaixo

            ```ruby
            add_foreign_key :oauth_access_grants, :users, column: :resource_owner_id
            add_foreign_key :oauth_access_tokens, :users, column: :resource_owner_id
            ```

    5. Ajustar relacionamentos na model de usuários

        ```ruby
        class User < ApplicationRecord
          has_many :access_grants,
                   class_name: 'Doorkeeper::AccessGrant',
                   foreign_key: :resource_owner_id,
                   dependent: :delete_all # or :destroy if you need callbacks

          has_many :access_tokens,
                   class_name: 'Doorkeeper::AccessToken',
                   foreign_key: :resource_owner_id,
                   dependent: :delete_all # or :destroy if you need callbacks
        end
        ```

    6. Informar o proprietário da autenticação em `config/initializers/doorkeeper.rb`

        ```ruby
        resource_owner_authenticator do
            current_user || warden.authenticate!(scope: :user)
          end
        ```

    7. Para proteger nossos controllers basta colocar `before_action :doorkeeper_authorize!`
    8. Para informar qual usuário está autenticado, podemos usar um código similar com

        ```ruby
        class Api::V1::CredentialsController < Api::V1::ApiController
          before_action :doorkeeper_authorize!
          respond_to    :json

          # GET /me.json
          def me
            respond_with current_resource_owner
          end

          private

          # Find the user that owns the access token
          def current_resource_owner
            User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
          end
        end
        ```

- Arquivo do insomnia

    [doorkeeper.json](Doorkeeper%206c818291647647e1828bae4bcc0ba569/doorkeeper.json)

- Repositórios de exemplos (Consta na documentação do doorkeeper)

    Provider: https://github.com/doorkeeper-gem/doorkeeper-provider-app

    Client: https://github.com/doorkeeper-gem/doorkeeper-devise-client

- Links auxiliares

    A segui temos alguns links auxiliares de como implementar a autenticação com o doorkeeper, aparentemente todos são apenas de clientes

    [Rails API authentication with Devise and Doorkeeper](https://medium.com/@khokhanijignesh29/rails-api-doorkeeper-devise-4212115c9f0d)

    [How to implement Rails API authentication with Devise and Doorkeeper](https://rubyyagi.com/rails-api-authentication-devise-doorkeeper/)

    [Autenticação Rails usando OAuth 2.0](https://medium.com/jaguaribetech/autentica%C3%A7%C3%A3o-rails-usando-oauth-2-0-d97a0a7d7f9f)

    [Understanding and Implementing OAuth2 in Ruby](https://www.honeybadger.io/blog/oauth2-ruby/)