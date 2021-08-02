# ApiGit

This simple Phoenix REST API application exposes a route ("/api/<github_username>") to get the list repositories of the passed username on GitHub.

New users can be created through "/api/users", passing a password as body parameter ({senha: "my_password"}).

To authenticate, call "/api/login", passing your user id and password. This will return a JWT token you can use to call the API's main resource.

This covers [challenge #2](https://www.notion.so/Desafio-02-Testando-requisi-es-com-bypass-e67ba498dee64089ac32e872812d20f6) of Rocketseat's Ignite Elixir module 6 and [challenge #1](https://www.notion.so/Desafio-01-Autentica-o-JWT-5c2fd6b53afb41b8b9f053deedecdf2f) of Rocketseat's Ignite Elixir module 7.

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser ou REST Client.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Tests with Bypass

You can also run the tests script in the terminal (outside `iex`):

```shell
$ mix test
```

## Learn more about Phoenix

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

