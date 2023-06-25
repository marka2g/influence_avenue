defmodule InfluenceAvenueWeb.Live.DonationsLive do
  use InfluenceAvenueWeb, :live_view

  alias InfluenceAvenue.Donations
  # alias InfluenceAvenueWeb.{SortingForm, FilterForm, PaginationForm}

  @impl true
  def mount(_params, _session, socket), do: {:ok, socket}

  @impl true
  def handle_params(_params, _uri, socket) do
    {:noreply, assign_donations(socket)}
  end

  defp assign_donations(socket) do
    assign(socket, :donations, Donations.queryable() |> Donations.fetch_records())
  end

  # defp parse_params(socket, params)
  # defp assign_donations(socket)
  # defp assign_sorting(socket, overrides \\ %{})
  # defp assign_filter(socket, overrides \\ %{})
  # defp assign_pagination(socket, overrides \\ %{})
  # defp assign_total_count(socket, total_count)
  # defp maybe_reset_pagaination(overrides)
  # defp merge_and_sanitize_params(socket, overrides \\ %{})

  defp party("100"), do: "🫏"
  defp party("200"), do: "🐘"
  defp party(""), do: "NA"
  defp party(party), do: party

  defp occupation(""), do: "Not listed"
  defp occupation(occ), do: String.capitalize(occ)
end
