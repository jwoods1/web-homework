defmodule HomeworkWeb.ResolverHelpers do

  alias Homework.Repo

  # from absinthe docs https://hexdocs.pm/absinthe/1.4.16/ecto.html#avoiding-n-1-queries
  def by_id(model, ids) do
    import Ecto.Query
    ids = ids |> Enum.uniq
    model
    |> where([m], m.id in ^ids)
    |> Repo.all
    |> Map.new(&{&1.id, &1})
  end

  def by_assoc_id(model, ids) do
    import Ecto.Query
    ids = ids |> Enum.uniq
    model
    |> where([m], m.user_id in ^ids)
    |> Repo.all
    |> Map.new(&{&1.id, &1})
  end
end
