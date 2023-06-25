defmodule InfluenceAvenue.Donations.Donation do
  @moduledoc """
  Donation Schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "donations" do
    field(:corpname, :string)
    field(:cycle, :integer)
    field(:amount, :integer)
    field(:date, :string)
    field(:recipient_name, :string)
    field(:recipient_party, :string)
    field(:contributor_name, :string)
    field(:contributor_occupation, :string)
    field(:more, :map)
    timestamps()
  end

  def changeset(donation, params) do
    donation
    |> cast(params, [
      :corpname,
      :cycle,
      :recipient_name,
      :recipient_party,
      :contributor_name,
      :contributor_occupation,
      :amount,
      :more
    ])
    |> validate_required([
      :corpname,
      :cycle,
      :recipient_name,
      :recipient_party,
      :amount,
      :contributor_name,
      :contributor_occupation
    ])
  end
end
