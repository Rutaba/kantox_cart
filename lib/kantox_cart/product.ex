defmodule KantoxCart.Product do
  defstruct code: "", name: "", price: 0.0

  def products do
    [
      %__MODULE__{code: "GR1", name: "Green tea", price: 3.11},
      %__MODULE__{code: "SR1", name: "Strawberries", price: 5.00},
      %__MODULE__{code: "CF1", name: "Coffee", price: 11.23}
    ]
  end
end
