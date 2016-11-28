defmodule CodeCorps.StripeService.StripePlatformCustomerService do
  alias CodeCorps.Repo
  alias CodeCorps.StripeService.Adapters.StripePlatformCustomerAdapter
  alias CodeCorps.StripePlatformCustomer
  alias CodeCorps.User

  @api Application.get_env(:code_corps, :stripe)

  def create(attributes) do
    with stripe_attributes <- build_stripe_attributes(attributes),
         {:ok, customer} <- @api.Customer.create(stripe_attributes),
         {:ok, params} <- StripePlatformCustomerAdapter.to_params(customer, attributes)
    do
      %StripePlatformCustomer{}
      |> StripePlatformCustomer.create_changeset(params)
      |> Repo.insert
    end
  end

  def update(%StripePlatformCustomer{id_from_stripe: id_from_stripe} = customer, attributes) do
    with {:ok, stripe_customer} <- @api.Customer.update(id_from_stripe, attributes),
         {:ok, params} <- Adapters.StripePlatformCustomer.to_params(stripe_customer, attributes)
    do
      customer
      |> StripePlatformCustomer.update_changeset(params)
      |> Repo.update
    end
  end

  defp build_stripe_attributes(%{"user_id" => user_id}) do
    %User{email: email} = Repo.get(User, user_id)
    %{email: email}
  end
end
