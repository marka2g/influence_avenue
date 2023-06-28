defmodule InfluenceAvenueWeb.FilterComponent do
  use InfluenceAvenueWeb, :live_component

  alias InfluenceAvenueWeb.Forms.FilterForm

  def render(assigns) do
    ~H"""
    <div id="table-filter">
      <.form :let={f} for={@changeset} as={:filter} phx-submit="search" phx-target={@myself}>
        <div class="flex flex-row gap-6 my-3">
          <span class="inline-flex rounded-md shadow-sm isolate">
            <.button
              phx-click="set-party"
              type="button"
              class="relative inline-flex items-center mr-6 -ml-px text-neutral-100 hover:text-neutral-50 bg-neutral-600 hover:bg-neutral-600/90 text-sm rounded-r-md font-semibold focus:z-10 ring-1 ring-inset ring-red-600 hover:shadow-[0_0_10px_red]"
              value={200}
            >
              Republican
            </.button>
            <.button
              phx-click="set-party"
              type="button"
              class="relative inline-flex items-center mr-6 -ml-px text-neutral-100 hover:text-neutral-50 bg-neutral-600 hover:bg-neutral-600/90 text-sm rounded-r-md font-semibold focus:z-10 ring-2 ring-inset ring-blue-600 hover:shadow-[0_0_10px_blue]"
              value={100}
            >
              Democrat
            </.button>
            <.button
              phx-click="set-party"
              type="button"
              class="relative inline-flex items-center mr-6 -ml-px text-neutral-100 hover:text-neutral-50 hover:bg-neutral-600/90 text-sm rounded-r-md font-semibold focus:z-10 ring-2 ring-inset ring-violet-600 hover:shadow-[0_0_10px_violet]"
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
