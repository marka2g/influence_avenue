defmodule InfluenceAvenueWeb.FilterComponent do
  use InfluenceAvenueWeb, :live_component

  alias InfluenceAvenueWeb.Forms.FilterForm

  def render(assigns) do
    ~H"""
    <div id="table-filter">
      <.form :let={f} for={@changeset} as="filter" phx-submit="search" phx-target={@myself}>
        <div class="flex flex-row gap-6">
          <span class="isolate inline-flex rounded-md shadow-sm">
            <.button
              phx-click="set-party"
              type="button"
              class="relative inline-flex mr-2 items-center rounded-l-md bg-red-500 text-sm font-semibold text-red-900 ring-2 ring-inset ring-red-600 hover:bg-red-400 focus:z-10"
              value={200}
            >
              Republican
            </.button>
            <.button
              phx-click="set-party"
              type="button"
              class="relative -ml-px inline-flex mr-2 items-center bg-sky-500 text-sm font-semibold text-sky-900 ring-2 ring-inset ring-sky-600 hover:bg-sky-400 focus:z-10"
              value={100}
            >
              Democrat
            </.button>
            <.button
              phx-click="set-party"
              type="button"
              class="relative -ml-px inline-flex mr-2 items-center rounded-r-md bg-purple-500 text-sm font-semibold text-purple-900 ring-2 ring-inset ring-purple-600 hover:bg-purple-400 focus:z-10"
              value="I"
            >
              Independent
            </.button>
          </span>
          <div>
            <label for="recipient_party" class="sr-only">Political Party Text Search</label>
            <.input
              field={f[:recipient_party]}
              placeholder="Other"
              type="text"
              class="block w-full rounded-md border-0 py-1.5 text-zinc-900 shadow-sm ring-1 ring-inset ring-zinc-300 placeholder:text-zinc-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
            />
          </div>
        </div>

        <div class="flex flex-row gap-6">
          <.input field={f[:corpname]} placeholder="Company Name" type="text" />
          <.input field={f[:cycle]} type="number" placeholder="Election Year" />
          <.input field={f[:contributor_name]} placeholder="Donor Name" type="text" />
          <.input field={f[:recipient_name]} placeholder="Candidate Name" type="text" />
          <div class="mt-2">
            <.button>Search</.button>
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
