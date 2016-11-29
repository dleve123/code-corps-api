defmodule CodeCorps.Services.UserServiceTest do
  use ExUnit.Case, async: true

  use CodeCorps.ModelCase

  alias CodeCorps.StripePlatformCustomer
  alias CodeCorps.Services.UserService

  describe "update/1" do
    test "it just updates the user if there is nothing associated to update" do
      user = insert(:user, email: "mail@mail.com", first_name: "Joe")
      {:ok, user} = UserService.update(user, %{email: "changed@mail.com"})

      assert user.email == "changed@mail.com"
      assert user.first_name == "Joe"
    end

    test "it returns an {:error, changeset} if there are validation errors with the user" do
      user = insert(:user, email: "mail@mail.com")
      {:error, changeset} = UserService.update(user, %{email: ""})

      refute changeset.valid?
    end

    test "it just updates the user if the changeset does not contain an email" do
      user = insert(:user, email: "mail@mail.com")
      stripe_platform_customer = insert(:stripe_platform_customer, email: "mail@mail.com", user: user)

      {:ok, user} = UserService.update(user, %{first_name: "Mark"})

      assert user.first_name == "Mark"
      assert user.email == "mail@mail.com"

      stripe_platform_customer = Repo.get(StripePlatformCustomer, stripe_platform_customer.id)

      assert stripe_platform_customer.email == "mail@mail.com"
    end

    test "it also updates the associated platform customer if there is one" do
      user = insert(:user, email: "mail@mail.com")
      stripe_platform_customer = insert(:stripe_platform_customer, user: user)

      {:ok, user} = UserService.update(user, %{email: "changed@mail.com"})

      assert user.email == "changed@mail.com"

      stripe_platform_customer = Repo.get(StripePlatformCustomer, stripe_platform_customer.id)

      assert stripe_platform_customer.email == "changed@mail.com"
    end
  end
end
