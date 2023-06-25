defmodule InfluenceAvenue.Donations do
  @moduledoc """
  The Donations context
  """
  import Ecto.Query, warn: false

  alias InfluenceAvenue.Repo
  alias InfluenceAvenue.Donations.Donation

  def queryable(opts \\ %{}) do
    from(d in Donation)
    |> with_limit(opts)
    |> filter(opts)
    |> sort(opts)
  end

  def total_count(), do: Repo.aggregate(Donation, :count)
  def total_query_count(query), do: Repo.aggregate(query, :count)

  def fetch_records(query) do
    query
    |> Repo.all()
  end

  defp with_limit(query, %{limit: limit}), do: limit(query, ^limit)
  defp with_limit(query, _), do: limit(query, 10)

  defp sort(query, %{sort_by: sort_by, sort_dir: sort_dir})
       when sort_by in [:amount, :cycle, :corpname, :recipient_name, :recipient_party] and
              sort_dir in [:asc, :desc] do
    order_by(query, {^sort_dir, ^sort_by})
  end

  defp sort(query, _), do: query

  defp filter(query, opts) do
    query
    |> filter_by_cycle(opts)
    |> filter_by_corpname(opts)
    |> filter_by_recipient_name(opts)
    |> filter_by_recipient_party(opts)
  end

  defp filter_by_cycle(query, %{cycle: cycle}) when is_integer(cycle) do
    where(query, cycle: ^cycle)
  end

  defp filter_by_cycle(query, _opts), do: query

  # fuzzy filters
  defp filter_by_corpname(query, %{corpname: corpname})
       when is_binary(corpname) and corpname != "" do
    query_string = "%#{corpname}%"
    where(query, [d], ilike(d.corpname, ^query_string))
  end

  defp filter_by_corpname(query, _opts), do: query

  defp filter_by_recipient_name(query, %{recipient_name: recipient_name})
       when is_binary(recipient_name) and recipient_name != "" do
    query_string = "%#{recipient_name}%"
    where(query, [d], ilike(d.recipient_name, ^query_string))
  end

  defp filter_by_recipient_name(query, _opts), do: query

  defp filter_by_recipient_party(query, %{recipient_party: recipient_party})
       when is_binary(recipient_party) and recipient_party != "" do
    query_string = "%#{recipient_party}%"
    where(query, [d], ilike(d.recipient_party, ^query_string))
  end

  defp filter_by_recipient_party(query, _opts), do: query
end
