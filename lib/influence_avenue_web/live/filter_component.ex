defmodule InfluenceAvenueWeb.FilterComponent do
  use InfluenceAvenueWeb, :live_component

  alias InfluenceAvenueWeb.Forms.FilterForm

  def render(assigns) do
    ~H"""
    <div id="table-filter">
      <.form :let={f} for={@changeset} as="filter" phx-submit="search" phx-target={@myself}>
        <div class="flex flex-col">
          <div class="flex flex-row gap-4">
            <div class="flex-none w-36 h-14">
              <.input field={f[:cycle]} type="number" placeholder="Election Year" />
            </div>
            <div class="flex-initial w-72">
              <.input field={f[:corpname]} placeholder="Company Name" type="text" />
            </div>
            <div class="flex-initial w-64">
              <.input field={f[:contributor_name]} placeholder="Donor Name" type="text" />
            </div>
          </div>

          <div class="flex gap-4">
            <div class="basis-1/3">
              <.input
                field={f[:recipient_party]}
                placeholder="Party - 200 for 🐘, 100 for 🫏"
                type="text"
              />
            </div>
            <div class="basis-2/3">
              <div class="flex flex-row gap-4">
                <div class="flex-initial w-72">
                  <.input field={f[:recipient_name]} placeholder="Candidate Name" type="text" />
                </div>
                <div class="flex-none mt-2">
                  <.button>Search</.button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </.form>
    </div>
    """
  end

  def update(assigns, socket) do
    {:ok, assign_changeset(assigns, socket)}
  end

  defp assign_changeset(%{filter: filter}, socket) do
    assign(socket, :changeset, FilterForm.change_values(filter))
  end

  def handle_event("search", %{"filter" => filter}, socket) do
    case FilterForm.parse(filter) do
      {:ok, opts} ->
        send(self(), {:update, opts})

      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end

    {:noreply, socket}
  end
end
