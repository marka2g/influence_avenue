defmodule InfluenceAvenueWeb.Forms.FilterForm do
  import Ecto.Changeset

  alias InfluenceAvenue.EctoHelper

  @fields %{
    cycle: :integer,
    corpname: :string,
    contributor_name: :string,
    recipient_name: :string,
    recipient_party: :string
  }

  @default_values %{
    cycle: nil,
    corpname: nil,
    contributor_name: nil,
    recipient_name: nil,
    recipient_party: nil
  }

  def default_values(overrides \\ %{}) do
    Map.merge(@default_values, overrides)
  end

  def parse(params) do
    {@default_values, @fields}
    |> cast(params, Map.keys(@fields))
    |> apply_action(:insert)
  end

  def change_values(values \\ @default_values) do
    {values, @fields}
    |> cast(%{}, Map.keys(@fields))
  end
end
