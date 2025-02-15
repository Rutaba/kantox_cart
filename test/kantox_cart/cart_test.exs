defmodule KantoxCart.CartTest do
  use ExUnit.Case

  alias KantoxCart.Cart

  test "total price calculation" do
    assert Cart.total(["GR1", "SR1", "GR1", "GR1", "CF1"]) == 22.45
    assert Cart.total(["GR1", "GR1"]) == 3.11
    assert Cart.total(["SR1", "SR1", "GR1", "SR1"]) == 16.61
    assert Cart.total(["GR1", "CF1", "SR1", "CF1", "CF1"]) == 30.57
  end

  test "buy one get one free on green tea" do
    assert Cart.total(["GR1"]) == 3.11
    assert Cart.total(["GR1", "GR1"]) == 3.11
    assert Cart.total(["GR1", "GR1", "GR1"]) == 6.22
  end

  test "strawberry bulk discount" do
    assert Cart.total(["SR1", "SR1"]) == 10.00
    assert Cart.total(["SR1", "SR1", "SR1"]) == 13.50
    assert Cart.total(["SR1", "SR1", "SR1", "SR1"]) == 18.00
  end

  test "coffee bulk discount" do
    assert Cart.total(["CF1"]) == 11.23
    assert Cart.total(["CF1", "CF1"]) == 22.46
    assert Cart.total(["CF1", "CF1", "CF1"]) == 22.46
    assert Cart.total(["CF1", "CF1", "CF1", "CF1"]) == 29.95
  end
end
