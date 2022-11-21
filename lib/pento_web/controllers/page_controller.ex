defmodule PentoWeb.PageController do
  use PentoWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: Routes.wrong_path(conn, :show))
  end
end
