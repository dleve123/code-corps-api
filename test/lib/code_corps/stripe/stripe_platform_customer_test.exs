defmodule CodeCorps.StripeService.StripePlatformCustomerTest do
  use CodeCorps.ModelCase

  alias CodeCorps.StripeService.StripePlatformCustomer

  describe "update/2" do
    test "performs update" do
      customer = insert(:stripe_platform_customer)
      {:ok, customer} = StripePlatformCustomer.update(customer, %{email: "mail@mail.com"})
      assert customer.email == "mail@mail.com"

       # TODO: Figure out testing if stripe API request was made
    end

    test "returns changeset with validation errors if there is an issue" do
      customer = insert(:stripe_platform_customer)
      {:error, changeset} = StripePlatformCustomer.update(customer, %{email: nil})
      refute changeset.valid?
    end
  end
end
