defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  def mount(_params, _session, socket) do
    :timer.send_interval(10000, self(), :get_time)

    {:ok,
     assign(
       socket,
       score: 0,
       correct_number: "#{:rand.uniform(10)}",
       message: "Make a guess: "
     )}
  end

  def handle_event(
        "guess",
        %{"numbers" => guess},
        %{assigns: %{correct_number: cor_num}} = socket
      )
      when guess == cor_num do
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
      Correct <%= @correct_number %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
        <a href="#" phx-click="guess" phx-value-numbers={n} ><%= n %> </a>
      <% end %>
    </h2>
    """
  end
end
