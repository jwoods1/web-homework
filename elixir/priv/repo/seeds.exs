# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Homework.Repo.insert!(%Homework.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Homework.{Users, Merchants, Transactions}

users = [
  %{
    first_name: "Jason",
    last_name: "Road",
    dob: "Jun 20, 1985"
  },
  %{
    first_name: "Kelly",
    last_name: "Woods",
    dob: "Jan 20, 1955"
  },
  %{
    first_name: "Tanner",
    last_name: "Dancer",
    dob: "Nov 1, 1990"
  },
]

Enum.each(users, fn(data) ->
    Users.create_user(data)
end)

merchants = [
  %{
    description: "Developer help site",
    name: "Stackoverflow",
  },
  %{
    description: "Elixir Docs - package repo",
    name: "Hex",
  },
]

Enum.each(merchants, fn(data) ->
  Merchants.create_merchant(data)
end)
