defmodule Forms.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :age, :integer
    field :email, :string
    field :first_last_name, :string
    field :gender, :integer
    field :last_name, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :first_last_name, :last_name, :age, :email, :gender])
    |> validate_required([:name, :first_last_name, :last_name, :age, :email, :gender])
  end

  def save(chg) do
    Forms.Repo.insert(chg)
  end
end
