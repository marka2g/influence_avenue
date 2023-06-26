defmodule InfluenceAvenue.Donations do
  @moduledoc """
  The Donations context
  """
  import Ecto.Query, warn: false

  alias InfluenceAvenue.Repo
  alias InfluenceAvenue.Donations.Donation

  def total_count(), do: Repo.aggregate(Donation, :count)
  def total_query_count(query), do: Repo.aggregate(query, :count)

  def queryable(opts \\ %{}) do
    from(d in Donation)
    |> infinity_scroll(opts)
    |> filter(opts)
    |> sort(opts)
  end

  def fetch_records(query), do: query |> Repo.all()

  defp infinity_scroll(query, %{limit: limit, offset: offset, count: count}) do
    query
    |> limit(^limit)
    |> offset(^offset)
  end

  defp infinity_scroll(query, _), do: query

  defp sort(query, %{sort_by: sort_by, sort_dir: sort_dir})
       when sort_by in [
              :id,
              :amount,
              :cycle,
              :corpname,
              :recipient_name,
              :recipient_party,
              :contributor_name,
              :contributor_occupation
            ] and
              sort_dir in [:asc, :desc] do
    order_by(query, {^sort_dir, ^sort_by})
  end

  defp sort(query, _), do: query

  defp filter(query, opts) do
    query
    |> filter_by_cycle(opts)
    |> filter_by_corpname(opts)
    |> filter_by_recipient_name(opts)
    |> filter_by_contributor_name(opts)
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

  defp filter_by_contributor_name(query, %{contributor_name: contributor_name})
       when is_binary(contributor_name) and contributor_name != "" do
    query_string = "%#{contributor_name}%"
    where(query, [d], ilike(d.contributor_name, ^query_string))
  end

  defp filter_by_contributor_name(query, _opts), do: query

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
