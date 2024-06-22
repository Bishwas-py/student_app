defmodule StudentAppWeb.SchoolLive.FormComponent do
  use StudentAppWeb, :live_component

  alias StudentApp.Schools

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage school records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="school-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:doe]} type="datetime-local" label="Doe" />
        <.input field={@form[:addr]} type="text" label="Addr" />
        <.input field={@form[:street_addr]} type="text" label="Street addr" />
        <:actions>
          <.button phx-disable-with="Saving...">Save School</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{school: school} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Schools.change_school(school))
     end)}
  end

  @impl true
  def handle_event("validate", %{"school" => school_params}, socket) do
    changeset = Schools.change_school(socket.assigns.school, school_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"school" => school_params}, socket) do
    save_school(socket, socket.assigns.action, school_params)
  end

  defp save_school(socket, :edit, school_params) do
    case Schools.update_school(socket.assigns.school, school_params) do
      {:ok, school} ->
        notify_parent({:saved, school})

        {:noreply,
         socket
         |> put_flash(:info, "School updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_school(socket, :new, school_params) do
    case Schools.create_school(school_params) do
      {:ok, school} ->
        notify_parent({:saved, school})

        {:noreply,
         socket
         |> put_flash(:info, "School created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
