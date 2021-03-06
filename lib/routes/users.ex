defmodule Routes.Users do
  use Routes.Base

  require Logger

  @database [%{"id" => 1, "title" => "Hello"}, %{"id" => 2, "title" => "world!"}]

  get "/" do
    Logger.debug("Sending a debug message!")
    Logger.info("Sending info!")
    Logger.warn("Sending a warning!")
    Logger.error("Sending an error!")

    send(conn, :ok, @database)
  end

  post "/" do
    send(conn, :not_found, %{"id" => 3, "title" => "just been added"})
  end

  put "/:id" do
    send(conn, :updated, %{"id" => id, "title" => "Just been updated"})
  end

  delete "/:id" do
    send(conn, :ok, %{"id" => id, "title" => "Just been deleted"})
  end
end
