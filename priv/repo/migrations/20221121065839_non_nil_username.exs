defmodule Pento.Repo.Migrations.NonNilUsername do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :username, :string, null: false, from: :string
    end
  end
end
