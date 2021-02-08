defmodule HomeworkWeb.Schemas.Types do
  @moduledoc """
  Defines the types for the Schema to use.
  """
  use Absinthe.Schema.Notation

  import_types(Absinthe.Type.Custom)
  import_types(HomeworkWeb.Schemas.MerchantsSchema)
  import_types(HomeworkWeb.Schemas.TransactionsSchema)
  import_types(HomeworkWeb.Schemas.UsersSchema)
  import_types(HomeworkWeb.Schemas.CompaniesSchema)

  @desc """
  The `Cents` scalar type represents a cents integer into a currency format. The Cents appears in a JSON response as an 00.00 format.
  """
  scalar :cents, name: "Cents" do
    serialize(&encode/1)
    parse(&decode/1)
  end

  defp decode(%Absinthe.Blueprint.Input.Integer{value: value}) do
    cents = trunc(value * 100)
    {:ok, cents}
  end

  defp decode(%Absinthe.Blueprint.Input.Null{}) do
    {:ok, nil}
  end

  defp decode(_) do
    :error
  end

  defp encode(value) do
    value / 100
  end
end
