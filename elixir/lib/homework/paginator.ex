defmodule Homework.Paginator do
  import Ecto.Query, warn: false

  def paginate(query, page, size) do
    if page > 0 do
      page = (page - 1) * size
    end
    query
    |> offset(^page)
    |> limit(^size)
    |> select_merge([m], %{total_rows: over(count())})
  end

  def pagination_fields do

  end
end
