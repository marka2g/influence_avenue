defmodule InfluenceAvenueWeb.Forms.SortingForm do
  import Ecto.Changeset

  alias InfluenceAvenue.EctoHelper

  @fields %{
    sort_by:
      EctoHelper.enum([
        :id,
        :amount,
        :cycle,
        :corpname,
        :recipient_party,
        :recipient_name,
        :contributor_name,
        :contributor_occupation
      ]),
    sort_dir: EctoHelper.enum([:asc, :desc])
  }

  @default_values %{
    sort_by: :id,
    sort_dir: :asc
  }

  def parse(params) do
    {@default_values, @fields}
    |> cast(params, Map.keys(@fields))
    |> apply_action(:insert)
  end

  def default_values(), do: @default_values
end
