defmodule LiveCommerce.Orders do
  @moduledoc """
  The Orders context.
  """

  import Ecto.Query, warn: false
  alias LiveCommerce.Repo

  alias LiveCommerce.Orders.Order
  alias LiveCommerce.Payments.Payment
  alias LiveCommerce.Accounts.User

  @doc """
  Returns the list of orders.

  ## Examples

      iex> list_orders()
      [%Order{}, ...]

  """
  def list_orders do
    Repo.all(Order)
  end

  def list_paid_orders_for_branch(branch_id) do
    from(o in Order,
      join: p in Payment,
      on: o.payment_id == p.id,
      join: u in User,
      on: o.user_id == u.id,
      where: not is_nil(o.payment_id) and u.branch_id == ^branch_id,
      select: o
    )
    |> Repo.all()
  end

  def count_orders_for_branch(branch_id) do
    from(o in Order,
      join: u in User,
      on: o.user_id == u.id,
      where: u.branch_id == ^branch_id,
      select: count(o.id)
    )
    |> Repo.one()
  end

  def count_paid_orders_for_branch(branch_id) do
    from(o in Order,
      join: p in Payment,
      on: o.payment_id == p.id,
      join: u in User,
      on: o.user_id == u.id,
      where: not is_nil(o.payment_id) and u.branch_id == ^branch_id,
      select: count(o.id)
    )
    |> Repo.one()
  end

  def from_date_count_paid_orders_for_branch(date, branch_id) do
    from(o in Order,
      join: p in Payment,
      on: o.payment_id == p.id,
      join: u in User,
      on: o.user_id == u.id,
      where:
        not is_nil(o.payment_id) and
          u.branch_id == ^branch_id and
          fragment("DATE(?) >= ?", o.inserted_at, ^date),
      select: count(o.id)
    )
    |> Repo.one()
  end

  def from_date_count_orders_for_branch(date, branch_id) do
    from(o in Order,
      join: u in User,
      on: o.user_id == u.id,
      where: u.branch_id == ^branch_id,
      where:
          u.branch_id == ^branch_id and
          fragment("DATE(?) >= ?", o.inserted_at, ^date),
      select: count(o.id)
    )
    |> Repo.one()
  end

  @doc """
  Gets a single order.

  Raises `Ecto.NoResultsError` if the Order does not exist.

  ## Examples

      iex> get_order!(123)
      %Order{}

      iex> get_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order!(id), do: Repo.get!(Order, id)

  @doc """
  Creates a order.

  ## Examples

      iex> create_order(%{field: value})
      {:ok, %Order{}}

      iex> create_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order(attrs \\ %{}) do
    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a order.

  ## Examples

      iex> update_order(order, %{field: new_value})
      {:ok, %Order{}}

      iex> update_order(order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order(%Order{} = order, attrs) do
    order
    |> Order.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order.

  ## Examples

      iex> delete_order(order)
      {:ok, %Order{}}

      iex> delete_order(order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order(%Order{} = order) do
    Repo.delete(order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order changes.

  ## Examples

      iex> change_order(order)
      %Ecto.Changeset{data: %Order{}}

  """
  def change_order(%Order{} = order, attrs \\ %{}) do
    Order.changeset(order, attrs)
  end

  alias LiveCommerce.Orders.OrderItem

  @doc """
  Returns the list of order_items.

  ## Examples

      iex> list_order_items()
      [%OrderItem{}, ...]

  """
  def list_order_items do
    Repo.all(OrderItem)
  end

  @doc """
  Gets a single order_item.

  Raises `Ecto.NoResultsError` if the Order item does not exist.

  ## Examples

      iex> get_order_item!(123)
      %OrderItem{}

      iex> get_order_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order_item!(id), do: Repo.get!(OrderItem, id)

  @doc """
  Creates a order_item.

  ## Examples

      iex> create_order_item(%{field: value})
      {:ok, %OrderItem{}}

      iex> create_order_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order_item(attrs \\ %{}) do
    %OrderItem{}
    |> OrderItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a order_item.

  ## Examples

      iex> update_order_item(order_item, %{field: new_value})
      {:ok, %OrderItem{}}

      iex> update_order_item(order_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order_item(%OrderItem{} = order_item, attrs) do
    order_item
    |> OrderItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order_item.

  ## Examples

      iex> delete_order_item(order_item)
      {:ok, %OrderItem{}}

      iex> delete_order_item(order_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order_item(%OrderItem{} = order_item) do
    Repo.delete(order_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order_item changes.

  ## Examples

      iex> change_order_item(order_item)
      %Ecto.Changeset{data: %OrderItem{}}

  """
  def change_order_item(%OrderItem{} = order_item, attrs \\ %{}) do
    OrderItem.changeset(order_item, attrs)
  end
end
