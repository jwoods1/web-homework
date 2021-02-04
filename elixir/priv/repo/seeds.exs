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


## NEED TO CLEAN THIS UP
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
merchants = [
  %{
    description: "Quick Stop Food service",
    name: "Qstop",
  },
  %{
    description: "Git source host",
    name: "Github",
  },
]
transactions = [
  %{

    amount: 200,
    credit: true,
    debit: false,
    description: "Dinner"
  },
  %{

    amount: 20,
    credit: true,
    debit: false,
    description: "Gas"
  },
   %{

    amount: 40,
    credit: false,
    debit: true,
    description: "Lunch"
  },
   %{
    amount: 3000,
    credit: false,
    debit: true,
    description: "Entiprise app"
  }
]

Enum.each(users, fn(data) ->
  Users.create_user(data)
end)
Enum.each(merchants, fn(data) ->
  Merchants.create_merchant(data)
end)
Enum.each(transactions, fn(data) ->
  %{:id => merch } = Merchants.list_merchants([])
    |> Enum.random
  %{:id => user} = Users.list_users([])
    |> Enum.random
    data = Map.put_new(data, :user_id, user)
    data = Map.put_new(data, :merchant_id, merch)
  Transactions.create_transaction(data)
end)
