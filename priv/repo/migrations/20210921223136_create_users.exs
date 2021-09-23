defmodule Forms.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :first_last_name, :string
      add :last_name, :string
      add :age, :integer
      add :email, :string
      add :gender, :integer

      timestamps()
    end

  end
end
