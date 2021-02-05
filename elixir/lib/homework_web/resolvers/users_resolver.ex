defmodule HomeworkWeb.Resolvers.UsersResolver do
  alias Homework.{Users, Companies, Transactions}
  alias Absinthe.Resolution.Helpers

  @doc """
  Get a list of users
  """
  def users(_root, %{search: search}, _info) do
    {:ok, Users.search_users(search)}
  end
  def users(_root, args, _info) do
    {:ok, Users.list_users(args)}
  end
  @doc """
  Get a single user
  """
  def user(_root, %{id: id}, _info) do
    {:ok, Users.get_user!(id)}
  end
 @doc """
  Get the company associated with a user
  """
  def company(user, _args, _source) do
    Helpers.batch({HomeworkWeb.ResolverHelpers, :by_id, Companies.Company}, user.company_id, fn batch_results ->
      {:ok, Map.get(batch_results, user.company_id)}
    end)
  end
   @doc """
  Get a list of transactions for User
  """
  def transactions(user, _args, _source) do
    Helpers.batch({HomeworkWeb.ResolverHelpers, :by_assoc_id, Transactions.Transaction}, user.id, fn batch_results ->
      {:ok, Enum.map(batch_results, fn {_, v} -> v end)}
    end)
  end
  @doc """
  Creates a user
  """
  def create_user(_root, args, _info) do
    case Users.create_user(args) do
      {:ok, user} ->
        {:ok, user}

      error ->
        {:error, "could not create user: #{inspect(error)}"}
    end
  end

  @doc """
  Updates a user for an id with args specified.
  """
  def update_user(_root, %{id: id} = args, _info) do
    user = Users.get_user!(id)

    case Users.update_user(user, args) do
      {:ok, user} ->
        {:ok, user}

      error ->
        {:error, "could not update user: #{inspect(error)}"}
    end
  end

  @doc """
  Deletes a user for an id
  """
  def delete_user(_root, %{id: id}, _info) do
    user = Users.get_user!(id)

    case Users.delete_user(user) do
      {:ok, user} ->
        {:ok, user}

      error ->
        {:error, "could not update user: #{inspect(error)}"}
    end
  end
end
