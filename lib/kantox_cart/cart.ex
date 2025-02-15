defmodule KantoxCart.Cart do
  alias KantoxCart.Product

  @products Product.products()

  def total(products) do
    products
    |> Enum.frequencies()
    |> apply_discounts()
    |> calculate_total()
  end

  defp apply_discounts(items) do
    items
    |> Enum.map(fn {code, quantity} ->
      {code, do_apply_discount(Enum.find(@products, &(&1.code == code)), quantity)}
    end)
  end

  defp do_apply_discount(%Product{code: code, price: price}, quantity) do
    # for generalizing the rule functions, the conditions are checked here so that future change could be handled easily
    cond do
      code == "GR1" -> buy_one_get_one(price, quantity)
      code == "SR1" && quantity >= 3 -> ten_percent_off(price, quantity)
      code == "CF1" && quantity >= 3 -> two_third_off(price, quantity)
      # default case
      true -> %{price: price, quantity: quantity}
    end
  end

  defp calculate_total(items) do
    items
    |> Enum.reduce(0, fn {_code, %{price: price, quantity: quantity}}, acc ->
      acc + price * quantity
    end)
    # rounding off to two digits
    |> Float.round(2)
  end

  defp buy_one_get_one(price, quantity),
    # for handling odd numbers of products correctly
    do: %{price: price, quantity: div(quantity, 2) + rem(quantity, 2)}

  defp ten_percent_off(price, quantity) do
    # 10% discount amount
    discount = price * 0.10
    %{price: price - discount, quantity: quantity}
  end

  defp two_third_off(price, quantity) do
    %{price: price * 2 / 3, quantity: quantity}
  end
end
