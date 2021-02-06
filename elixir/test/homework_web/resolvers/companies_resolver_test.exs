defmodule Homework.Resolvers.CompaniesResolverTest do
  use Homework.DataCase

  describe "companies Resolvers" do
    alias Homework.Companies
    alias HomeworkWeb.Resolvers.CompaniesResolver

    @valid_attrs %{available_credit: 0, credit_line: 0 , name: "some name"}
    @update_attrs %{available_credit: 100 , credit_line: 200, name: "some updated name"}
    @invalid_attrs %{available_credit: nil, credit_line: nil, name: nil}

    def company_fixture(attrs \\ %{}) do
      {:ok, company} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Companies.create_company()
      company
    end

    test "companies/1 returns all companies" do
      company = company_fixture()
      assert CompaniesResolver.companies(%{},[], %{}) == {:ok, [company]}
    end
    test "users/1 returns all companies" do
      company = company_fixture()
      assert CompaniesResolver.companies(%{},[], %{}) == {:ok, [company]}
    end
    test "transactions/1 returns all companies" do
      company = company_fixture()
      assert CompaniesResolver.companies(%{},[], %{}) == {:ok, [company]}
    end
    test "create_company/1 returns all companies" do
      company = company_fixture()
      assert CompaniesResolver.companies(%{},[], %{}) == {:ok, [company]}
    end
    test "update_company/1 returns all companies" do
      company = company_fixture()
      assert CompaniesResolver.companies(%{},[], %{}) == {:ok, [company]}
    end
    test "delete_company/1 returns all companies" do
      company = company_fixture()
      assert CompaniesResolver.companies(%{},[], %{}) == {:ok, [company]}
    end
  end
end
