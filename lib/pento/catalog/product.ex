defmodule Pento.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :description, :string
    field :name, :string
    field :sku, :integer
    field :unit_price, :float
    field :image_upload, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :unit_price, :sku, :image_upload])
    |> validate_required([:name, :description, :unit_price, :sku])
    |> validate_number(:unit_price, greater_than: 0)
    |> unique_constraint(:sku)
  end

  def changeset_unit_price_decrease(product, new_unit_price) do
    product
    |> cast(%{unit_price: new_unit_price}, [:unit_price])
    |> validate_required([:unit_price])
    |> validate_number(:unit_price, less_than: product.unit_price)
  end
end
