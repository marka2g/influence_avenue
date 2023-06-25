defmodule InfluenceAvenue.Donations do
  @moduledoc """
  The Donations context
  """
  import Ecto.Query, warn: false

  alias InfluenceAvenue.Repo
  alias InfluenceAvenue.Donations.Donation

  def count(), do: Repo.aggregate(Donation, :count)

  def sorted_list(opts) do
    from(d in Donation)
    |> with_limit(opts)
    |> sort(opts)
    |> Repo.all()
  end

  def list(opts \\ %{}) do
    from(d in Donation)
    |> with_limit(opts)
    |> Repo.all()
  end

  defp sort(query, %{sort_by: sort_by, sort_dir: sort_dir})
       when sort_by in [:amount, :cycle, :corpname, :recipient_name, :recipient_party] and
              sort_dir in [:asc, :desc] do
    order_by(query, {^sort_dir, ^sort_by})
  end

  defp with_limit(query, %{limit: limit}), do: limit(query, ^limit)
  defp with_limit(query, _), do: limit(query, 10)
end

# def list_meerkats(opts) do
#   from(m in Meerkat)
#   |> filter(opts)
#   |> sort(opts)
#   |> Repo.all()
# end
#
# defp filter(query, opts) do
#   query
#   |> filter_by_id(opts)
#   |> filter_by_name(opts)
# end

# defp filter_by_id(query, %{id: id}) when is_integer(id) do
#   where(query, id: ^id)
# end

# defp filter_by_id(query, _opts), do: query

# # fuzzy filter example
# defp filter_by_name(query, %{name: name})
#       when is_binary(name) and name != "" do
#   query_string = "%#{name}%"
#   where(query, [m], ilike(m.name, ^query_string))
# end

# defp filter_by_name(query, _opts), do: query

# defp sort(query, %{sort_by: sort_by, sort_dir: sort_dir})
#       when sort_by in [:id, :name] and
#             sort_dir in [:asc, :desc] do
#   order_by(query, {^sort_dir, ^sort_by})
# end
