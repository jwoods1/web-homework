defmodule Homework.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Homework.Repo

  alias Homework.Users.User

  alias Homework.Transactions.Transaction
  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users([])
      [%User{}, ...]

  """
  def list_users(_args) do
    Repo.all(User)
  end
  @doc """
  Returns the list of users for a company.

  ## Examples
      iex> list_users(id)

  """
  def list_users_by_company(id) do
    query = from u in User, preload: [:transactions]
    query = from [u] in query, where: u.company_id == ^id
    query = from [u] in query, join: t in Transaction, on: t.user_id == u.id
   Repo.all(query)
  end

  @doc """
  Returns the list of users by first or last name

  ## Examples
      iex> search_users(string)

  """
  def search_users(search) do
    start_character = String.slice(search, 0..1)
    from(
      u in User,
      where: ilike(u.last_name, ^"#{start_character}%") or ilike(u.first_name, ^"#{start_character}%"),
      where: fragment("SIMILARITY(?, ?) > 0",  u.last_name, ^search) or fragment("SIMILARITY(?, ?) > 0",  u.first_name, ^search),
      order_by: fragment("LEVENSHTEIN(?, ?)", u.last_name, ^search)
    )
    |> Repo.all()
  end
  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
