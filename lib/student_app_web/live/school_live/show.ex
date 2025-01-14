defmodule StudentAppWeb.SchoolLive.Show do
  use StudentAppWeb, :live_view

  alias StudentApp.Schools

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:school, Schools.get_school!(id))}
  end

  defp page_title(:show), do: "Show School"
  defp page_title(:edit), do: "Edit School"
end
