defmodule LiveCommerce.BranchesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveCommerce.Branches` context.
  """

  @doc """
  Generate a branch.
  """
  def branch_fixture(attrs \\ %{}) do
    {:ok, branch} =
      attrs
      |> Enum.into(%{
        deleted_at: ~U[2024-10-30 04:38:00Z],
        name: "some name",
        parent_branch_id: 42,
        subdomain: "some subdomain"
      })
      |> LiveCommerce.Branches.create_branch()

    branch
  end
end
