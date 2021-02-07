defmodule HomeworkWeb.Resolvers.TransactionsResolver do
  alias Homework.{Companies, Users, Transactions, Merchants}

  alias Absinthe.Resolution.Helpers

  @doc """
  Get a list of transcations
  """

  def transactions(_root, %{min: min, max: max}, _info) do
    {:ok, Transactions.list_transactions_min_max(min, max)}
  end
  def transactions(_root, %{min: _min} = args, _info) do
    {:ok, Transactions.list_transactions(args)}
  end
  def transactions(_root, %{max: _max} = args, _info) do
    {:ok, Transactions.list_transactions(args)}
  end
  def transactions(_root, args, _info) do
    {:ok, Transactions.list_transactions(args)}
  end

  @doc """
  Get the user associated with a transaction
  Updated to use a batch query to Avoid N+1 Queries
  """
  def user(transaction, _args, _source) do
    Helpers.batch({HomeworkWeb.ResolverHelpers, :by_id, Users.User}, transaction.user_id, fn batch_results ->
      {:ok, Map.get(batch_results, transaction.user_id)}
    end)
  end
 @doc """
  Get the company associated with a transaction
  Updated to use a batch query to Avoid N+1 Queries
  """
  def company(transaction, _args, _source) do
    Helpers.batch({HomeworkWeb.ResolverHelpers, :by_id, Companies.Company}, transaction.company_id, fn batch_results ->
      {:ok, Map.get(batch_results, transaction.company_id)}
    end)
  end
  @doc """
  Get the merchant associated with a transaction
  Updated to use a batch query to Avoid N+1 Queries
  """
  def merchant(transaction, _args, _source) do
    Helpers.batch({HomeworkWeb.ResolverHelpers, :by_id, Merchants.Merchant}, transaction.merchant_id, fn batch_results ->
      {:ok, Map.get(batch_results, transaction.merchant_id)}
    end)
  end

  @doc """
  Create a new transaction
  """
  def create_transaction(_root, args, _info) do
    case Transactions.create_transaction(args) do
      {:ok, transaction} ->
        {:ok, transaction}
      error ->
        {:error, "could not create transaction: #{inspect(error)}"}
    end
  end

  @doc """
  Updates a transaction for an id with args specified.
  """
  def update_transaction(_root, %{id: id} = args, _info) do
    transaction = Transactions.get_transaction!(id)

    case Transactions.update_transaction(transaction, args) do
      {:ok, transaction} ->
        {:ok, transaction}
      error ->
        {:error, "could not update transaction: #{inspect(error)}"}
    end
  end

  @doc """
  Deletes a transaction for an id
  """
  def delete_transaction(_root, %{id: id}, _info) do
    transaction = Transactions.get_transaction!(id)

    case Transactions.delete_transaction(transaction) do
      {:ok, transaction} ->
        {:ok, transaction}

      error ->
        {:error, "could not update transaction: #{inspect(error)}"}
    end
  end
end
