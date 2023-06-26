defmodule InfluenceAvenueWeb.Live.DonationsLive do
  use InfluenceAvenueWeb, :live_view

  alias InfluenceAvenue.Donations
  alias InfluenceAvenueWeb.Forms.{SortingForm, FilterForm}

  @impl true
  def mount(_params, _session, socket) do
    count = Donations.total_count()

    socket =
      socket
      |> assign(
        offset: 0,
        limit: 25,
        count: count
      )

    {:ok, socket}
  end

  @imp true
  def handle_event("load-more", _, socket) do
    %{offset: offset, limit: limit, count: count} = socket.assigns

    socket =
      if offset < count do
        socket
        |> assign(offset: offset + limit)
        |> assign_donations()
      else
        socket
      end

    {:noreply, socket}
  end

  @impl true
  def handle_info({:update, opts}, socket) do
    {:noreply, push_patch(socket, to: ~p"/?#{opts}", replace: true)}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    socket =
      socket
      |> parse_params(params)
      |> assign_donations()

    {:noreply, socket}
  end

  defp assign_donations(socket) do
    params = merge_and_sanitize_params(socket)
    assign(socket, :donations, Donations.queryable(params) |> Donations.fetch_records())
  end

  defp parse_params(socket, params) do
    with {:ok, sorting_opts} <- SortingForm.parse(params),
         {:ok, filter_opts} <- FilterForm.parse(params) do
      socket
      |> assign_sorting(sorting_opts)
      |> assign_filter(filter_opts)
    else
      _error ->
        socket
        |> assign_sorting()
        |> assign_filter()
    end
  end

  defp assign_sorting(socket, overrides \\ %{}) do
    opts = Map.merge(SortingForm.default_values(), overrides)
    assign(socket, :sorting, opts)
  end

  defp assign_filter(socket, overrides \\ %{}) do
    assign(socket, :filter, FilterForm.default_values(overrides))
  end

  defp merge_and_sanitize_params(socket, overrides \\ %{}) do
    %{
      sorting: sorting,
      filter: filter,
      limit: limit,
      offset: offset,
      count: count
    } = socket.assigns

    %{}
    |> Map.merge(sorting)
    |> Map.merge(filter)
    |> Map.merge(%{limit: limit, offset: offset, count: count})
    |> Map.merge(overrides)
    |> Enum.reject(fn {_key, value} -> is_nil(value) end)
    |> Map.new()
  end

  defp party("100"), do: "🫏"
  defp party("200"), do: "🐘"
  defp party("I"), do: "Independent"
  defp party(""), do: "NA"
  defp party(party), do: party

  defp occupation(""), do: "Not listed"
  defp occupation(occ), do: String.capitalize(occ)
end
