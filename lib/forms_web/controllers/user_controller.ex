defmodule FormsWeb.UserController do
  use FormsWeb, :controller
  alias Forms.User
  def create(conn, params) when is_list(params)do
    #Enum.each(params, fn(user) ->
    #  chg = User.changeset(%User{}, user)
    #  IO.inspect(chg)
    #  User.save(chg)
    #end)
    #Nos sirve para esperar un tiempo determinado
    #Process.sleep(1000)
    list = Enum.reduce(params, [], fn user,acc ->
      chg = User.changeset(%User{}, user)
      IO.inspect(chg)
      case chg.valid? do
        true ->
            User.save(chg)
            acc
        false ->
          ## acc ++ [chg] va insertando en la lista  de mi reduce el chg que sea invalido
          acc ++ [chg]
      end
    end)
    if length(list) == 0 do
      conn
      |> put_status(201)
      |> json(%{msg: "Exito"})
    else
      conn
      |> put_status(206)
      |> json(%{error: "Error al crear #{length(list)} usuarios"})
    end
  end
  def create(conn, params) do
    chg = User.changeset(%User{}, params)
    IO.inspect(chg)
    case chg.valid? do
      true ->
        {:ok, user} = User.save(chg)
        conn
          |> put_status(201)
          |> json(%{user: %{name: user.name, age: user.age, email: user.email}})
      false ->
        conn
          |> put_status(400)
          |> json(%{error: "Error al crear al usuario"})
    end
  end
  def create_second_form(conn, params) do
    IO.inspect(params)
    string = Map.get(params, "users")
    insert_in_to_file(string)
    #%{"users" => string} = params
    new_users = Regex.split(~r/\n/,string)
    create(conn, convert_new_users(new_users))
  end
  def convert_new_users(list) do
    Enum.map(list, fn(x) ->
        new_list = String.split(x, ",")
        %{
          name: Enum.at(new_list, 0) |> String.split(" ") |> Enum.at(0) ,
          first_last_name: Enum.at(new_list, 0) |> String.split(" ") |> Enum.at(1),
          last_name: Enum.at(new_list, 0) |> String.split(" ") |> Enum.at(2),
          age: Enum.at(new_list, 1),
          email: Enum.at(new_list, 2),
          gender: Enum.at(new_list, 3)
        }
    end)
    |> IO.inspect()
  end
  def insert_in_to_file(string)do
    date_time = Timex.local |> Timex.format!("{YYYY}-{M}-{D} {h24}:{m}:{s}")
    File.open("./bd/"<>date_time<>".txt", [:read, :write], fn file ->
      #all_text = IO.read(file, :all)
      IO.write(file, string)
    end)
  end
end
