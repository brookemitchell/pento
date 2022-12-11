defmodule Pento.Promo do
  alias Ecto.Changeset
  alias Pento.Promo.Recipient

  def change_recipient(%Recipient{} = recipient, attrs \\ %{}) do
    Recipient.changeset(recipient, attrs)
  end

  def send_promo(recipient, attrs) do
    # create and validate changeset

    # If changeset valid, send to service to send email
    with %Changeset{valid?: true} <- Recipient.changeset(recipient, attrs) do
      # step 2. send email to promo recipient
      {:ok}
    else
      %Changeset{valid?: false} = changeset ->
        {:error, changeset}

      other_err ->
        IO.inspect(other_err)
        {:error}
    end
  end
end
