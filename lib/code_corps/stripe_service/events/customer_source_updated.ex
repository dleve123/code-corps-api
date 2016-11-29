defmodule CodeCorps.StripeService.Events.CustomerSubscriptionUpdated do
  import Ecto.Query

  alias CodeCorps.Repo
  alias CodeCorps.StripePlatformCard
  alias CodeCorps.StripeConnectCard
  alias CodeCorps.StripeService.Adapters.StripePlatformCardAdapter

  alias Ecto.Multi

  @api Application.get_env(:code_corps, :stripe)

  def handle(%{"data" => %{"object" => %{"id" => card_id, "object" => card}}}) do
    with %StripePlatformCard{} = record <- get_card(card_id),
         {:ok, stripe_card} <- @api.Cards.retrieve(card_id)
         {:ok, params} <- StripePlatformCardAdapter.to_params(stripe_card)
    do
      perform_update(record, params)
    else

    end
  end

  def handle(%{"data" => %{"object" => %{"id" => card_id, "object" => _}}}), do: {:error, :unsupported_object}


  defp get_card(id_from_stripe) do: StripePlatformCard |> Repo.get_by(id_from_stripe: id_from_stripe)

  defp perform_update(record, params)
    changeset = record |> StripePlatformCard.update_changeset(params)

    multi =
      Multi.new
      |> Multi.update(:update_platform_card, changeset)
      |> Multi.run(:update_connect_cards, &update_connect_cards/1)

    case Repo.transaction(multi) do
      {:ok, %{update_platform_card: platform_card, update_connect_cards: _}} ->
        {:ok, platform_card}
      {:error, :platform_card, %Ecto.Changeset{} = changeset, %{}} ->
        {:error, changeset}
      {:error, _failed_operation, _failed_value, _changes_so_far} ->
        {:error, :unhandled}
    end
  end

  defp update_connect_cards(%{update_platform_card: platform_card}) do
    results =
      platform_card
      |> get_connect_cards
      |> update_connect_card(platform_card)

    {:ok, results}
  end

  defp update_connect_card(Stripe.Card{} = stripe_card, StripePlatformCard{} = platform_card) do
    # TODO:
  end
end
