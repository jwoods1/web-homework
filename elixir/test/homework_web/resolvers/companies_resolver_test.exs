defmodule Homework.Resolvers.CompaniesResolverTest do
  use Homework.DataCase

  describe "companies Resolvers" do
    alias Homework.{Companies,Users,Merchants,Transactions}
    alias HomeworkWeb.Resolvers.CompaniesResolver

    setup do

      {:ok, company} =
        Companies.create_company(%{available_credit: 0, credit_line: 1_000_000 , name: "some name"})

      {:ok, merchant1} =
        Merchants.create_merchant(%{description: "some description", name: "some name"})

      {:ok, merchant2} =
        Merchants.create_merchant(%{
          description: "some updated description",
          name: "some updated name"
        })

      {:ok, user1} =
        Users.create_user(%{
          dob: "some dob",
          first_name: "some first_name",
          last_name: "some last_name",
          company_id: company.id
        })

      {:ok, user2} =
        Users.create_user(%{
          dob: "some updated dob",
          first_name: "some updated first_name",
          last_name: "some updated last_name",
          company_id: company.id
        })

      valid_attrs = %{
        available_credit: 1_000_000,
        credit_line: 1_000_000 ,
        name: "some name"
      }

      update_attrs = %{
        available_credit: 500_000,
        credit_line: 1_500_000 ,
        name: "some name updated"
      }

      invalid_attrs = %{
        available_credit: nil,
        credit_line: nil ,
        name: nil
      }

      {:ok,
       %{
         valid_attrs: valid_attrs,
         update_attrs: update_attrs,
         invalid_attrs: invalid_attrs,
         company: company
       }}
    end

    def companies_fixture() do
      companies = Companies.list_companies([])
      {:ok, companies}
    end
    def company_users_fixture(company) do
      users = Users.list_users_by_company(company.id)
      {:ok, users}
    end
    def company_transactions_fixture(company)do
      transactions = Transactions.list_transactions_by_company(company.id)
      {:ok, transactions}
    end
    test "companies/1 returns all companies" do
      assert CompaniesResolver.companies(%{}, [], %{}) == companies_fixture()
    end

    test "create_company/1 returns created company" , %{valid_attrs: valid_attrs} do
      assert {:ok, %Companies.Company{} = company} = CompaniesResolver.create_company(%{},valid_attrs, %{})
      assert company.name == valid_attrs.name
    end
    test "update_company/1 returns updated company", %{update_attrs: update_attrs} do
      {:ok, companies} = companies_fixture()
      company = List.first(companies)
      update_attrs = Map.put(update_attrs, :id, company.id)
      assert {:ok, %Companies.Company{} = company} = CompaniesResolver.update_company(%{}, update_attrs, %{})
      assert company.name == update_attrs.name
      assert company.available_credit == update_attrs.available_credit
      assert company.credit_line == update_attrs.credit_line
    end

    test "delete_company/1 returns deleted company if no users or transactions exist" do
      {:ok, company} =
        Companies.create_company(%{available_credit: 0, credit_line: 1_000_000 , name: "some name"})
      assert {:ok, %Companies.Company{} = company} = CompaniesResolver.delete_company(%{}, company, %{})

    end

    test "users/1 returns all company users", %{company: company} do
      assert CompaniesResolver.users(company, [], %{}) == company_users_fixture(company)
    end

    test "transactions/1 returns all company transactions",  %{company: company} do
      assert CompaniesResolver.transactions(company, [], %{}) == company_transactions_fixture(company)
    end

  end
end
