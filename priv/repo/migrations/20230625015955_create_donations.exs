defmodule InfluenceAvenue.Repo.Migrations.CreateDonations do
  use Ecto.Migration

  def change do
    create table(:donations) do
      add(:corpname, :string)
      add(:cycle, :integer)
      add(:amount, :integer)
      add(:date, :string)
      add(:recipient_name, :string)
      add(:recipient_party, :string)
      add(:contributor_name, :string)
      add(:contributor_occupation, :string)
      add(:more, :map)

      timestamps()
    end

    create(index(:donations, :corpname))
    create(index(:donations, :cycle))
    create(index(:donations, :date))
    create(index(:donations, :recipient_name))
    create(index(:donations, :recipient_party))
    create(index(:donations, :contributor_name))
    create(index(:donations, :contributor_occupation))
  end
end
