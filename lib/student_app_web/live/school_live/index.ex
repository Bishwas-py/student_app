defmodule StudentAppWeb.SchoolLive.Index do
  use StudentAppWeb, :live_view

  alias StudentApp.Schools
  alias StudentApp.Schools.School

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :school_collection, Schools.list_school())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit School")
    |> assign(:school, Schools.get_school!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New School")
    |> assign(:school, %School{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing School")
    |> assign(:school, nil)
  end

  @impl true
  def handle_info({StudentAppWeb.SchoolLive.FormComponent, {:saved, school}}, socket) do
    {:noreply, stream_insert(socket, :school_collection, school)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    school = Schools.get_school!(id)
    {:ok, _} = Schools.delete_school(school)

    {:noreply, stream_delete(socket, :school_collection, school)}
  end
end
