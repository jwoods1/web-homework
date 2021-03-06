defmodule Homework.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset
  alias Homework.Users.User
  alias Homework.Transactions.Transaction

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "companies" do
    field(:available_credit, :integer)
    field(:credit_line, :integer)
    field(:name, :string)
    has_many(:users, User)
    has_many(:transactions, Transaction)

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :credit_line, :available_credit, :credit_line])
    |> validate_required([:name, :credit_line, :available_credit, :credit_line])
  end
end
