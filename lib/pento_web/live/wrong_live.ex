defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  def mount(_params, session, socket) do
    {:ok,
     assign(
       socket,
       score: 0,
       message: "Guess a number.",
       session_id: session["live_socket_id"],
       correct_number: "#{:rand.uniform(10)}"
     )}
  end

  def handle_event(
        "guess",
        %{"numbers" => guess},
        %{assigns: %{correct_number: correct_number}} = socket
      )
      when guess == correct_number do
    {message, score} = {
      "Great guess: #{guess}. Correct!",
      socket.assigns.score + 1
    }

    {:noreply,
     assign(
       socket,
       message: message,
       score: score
     )}
  end

  def handle_event(
        "guess",
        %{"numbers" => guess},
        socket
      ) do
    {message, score} = {
      "Your guess: #{guess}. Wrong. Guess again.",
      socket.assigns.score - 1
    }

    {:noreply,
     assign(
       socket,
       message: message,
       score: score
     )}
  end

  def render(assigns) do
    ~H"""
    <h1> Your Score: <%= @score %> </h1>
    <h2>
      <%= @message %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-numbers={n} ><%= n %> </a>
      <% end %>
      <pre>
        <%= @current_user.email %>
        <%= @session_id %>
      </pre>
    </h2>
    """
  end
end
