defmodule KantoxCartWeb.CartLive do
  use Phoenix.LiveView

  alias KantoxCart.{Cart, Product}

  def mount(_params, _session, socket) do
    {:ok, assign(socket, products: Product.products(), cart: [], total: 0.0)}
  end

  def handle_event(
        "add_to_cart",
        %{"code" => code},
        %{assigns: %{cart: cart, products: products}} = socket
      ) do
    product = Enum.find(products, &(&1.code == code))
    cart = [product | cart]
    total = Cart.total(Enum.map(cart, & &1.code))
    {:noreply, assign(socket, cart: cart, total: total)}
  end

  def render(assigns) do
    ~H"""
    <div class="max-w-lg mx-auto p-6 bg-white shadow-lg rounded-lg">
      <h1 class="text-2xl font-bold text-center mb-4">Kantox Checkout</h1>

      <h2 class="text-xl font-semibold mb-2">Products</h2>
      <ul class="space-y-2">
        <%= for product <- @products do %>
          <li class="flex justify-between bg-gray-100 p-3 rounded">
            <span>{product.name} - £{product.price}</span>
            <button
              phx-click="add_to_cart"
              phx-value-code={product.code}
              class="bg-blue-500 text-white px-4 py-1 rounded hover:bg-blue-700"
            >
              Add to Cart
            </button>
          </li>
        <% end %>
      </ul>

      <h2 class="text-xl font-semibold mt-6 mb-2">Cart</h2>
      <ul class="bg-gray-100 p-3 rounded mb-4">
        <%= for item <- @cart do %>
          <li class="border-b py-1">{item.name}</li>
        <% end %>
      </ul>

      <h3 class="text-lg font-bold">Total: £{@total}</h3>
    </div>
    """
  end
end
