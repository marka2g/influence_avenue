defmodule InfluenceAvenueWeb.Live.DonationsLive do
  use InfluenceAvenueWeb, :live_view

  alias InfluenceAvenue.Donations
  alias InfluenceAvenueWeb.Forms.SortingForm
  # alias InfluenceAvenueWeb.Forms.{SortingForm, FilterForm, PaginationForm}

  @impl true
  def mount(_params, _session, socket), do: {:ok, socket}

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

  defp parse_params(socket, params) do
    with {:ok, sorting_opts} <- SortingForm.parse(params) do
      assign_sorting(socket, sorting_opts)
    else
      _error ->
        assign_sorting(socket)
    end
  end

  defp assign_sorting(socket, overrides \\ %{}) do
    opts = Map.merge(SortingForm.default_values(), overrides)
    assign(socket, :sorting, opts)
  end

  defp assign_donations(socket) do
    %{sorting: sorting} = socket.assigns
    assign(socket, :donations, Donations.queryable(sorting) |> Donations.fetch_records())
  end

  defp party("100"), do: "🫏"
  defp party("200"), do: "🐘"
  defp party(""), do: "NA"
  defp party(party), do: party

  defp occupation(""), do: "Not listed"
  defp occupation(occ), do: String.capitalize(occ)
end
