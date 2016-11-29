defmodule CodeCorps.Services.UserService do
  @moduledoc """
  Handles CRUD operations for users.

  When operations happen on `CodeCorps.User`, we need to make sure changes
  are propagated to related records, ex., `CodeCorps.StripePlatformCustomer`

  """

  alias CodeCorps.{Repo, StripePlatformCustomer, User}
  alias CodeCorps.StripeService
  alias Ecto.Changeset
  alias Ecto.Multi

  @doc """
  Updates a `CodeCorps.User` record and, if necessary, associated
  `CodeCorps.StripePlatformCustomer` and `CodeCorps.StripeConnectCustomer` records.

  These 2 sets of related records inherit the email field from the user,
  so they need to be kept in sync, bot locally, and on the Stripe platform.

  """
  def update(%User{} = user, attributes) do
    changeset = user |> User.update_changeset(attributes)
    do_update(changeset)
  end

  defp do_update(%Changeset{changes: %{email: _email}} = changeset) do
    multi =
      Multi.new
      |> Multi.update(:update_user, changeset)
      |> Multi.run(:update_platform_customer, &update_platform_customer/1)

    case Repo.transaction(multi) do
      {:ok, %{update_user: user, update_platform_customer: _}} ->
        {:ok, user}
      {:error, :update_user, %Ecto.Changeset{} = changeset, %{}} ->
        {:error, changeset}
      {:error, _failed_operation, _failed_value, _changes_so_far} ->
        {:error, :unhandled}
    end
  end
  defp do_update(%Changeset{} = changeset), do: Repo.update(changeset)

  defp update_platform_customer(%{update_user: %User{id: user_id, email: email}}) do
    StripePlatformCustomer
    |> Repo.get_by(user_id: user_id)
    |> do_update_platform_customer(%{email: email})
  end

  defp do_update_platform_customer(nil, _), do: {:ok, :nothing_to_update}
  defp do_update_platform_customer(%StripePlatformCustomer{} = stripe_platform_customer, attributes) do
    StripeService.StripePlatformCustomer.update(stripe_platform_customer, attributes)
  end
end
