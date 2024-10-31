defmodule LiveCommerce.BranchesTest do
  use LiveCommerce.DataCase

  alias LiveCommerce.Branches

  describe "branches" do
    alias LiveCommerce.Branches.Branch

    import LiveCommerce.BranchesFixtures

    @invalid_attrs %{name: nil, subdomain: nil, parent_branch_id: nil, deleted_at: nil}

    test "list_branches/0 returns all branches" do
      branch = branch_fixture()
      assert Branches.list_branches() == [branch]
    end

    test "get_branch!/1 returns the branch with given id" do
      branch = branch_fixture()
      assert Branches.get_branch!(branch.id) == branch
    end

    test "create_branch/1 with valid data creates a branch" do
      valid_attrs = %{name: "some name", subdomain: "some subdomain", parent_branch_id: 42, deleted_at: ~U[2024-10-30 04:38:00Z]}

      assert {:ok, %Branch{} = branch} = Branches.create_branch(valid_attrs)
      assert branch.name == "some name"
      assert branch.subdomain == "some subdomain"
      assert branch.parent_branch_id == 42
      assert branch.deleted_at == ~U[2024-10-30 04:38:00Z]
    end

    test "create_branch/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Branches.create_branch(@invalid_attrs)
    end

    test "update_branch/2 with valid data updates the branch" do
      branch = branch_fixture()
      update_attrs = %{name: "some updated name", subdomain: "some updated subdomain", parent_branch_id: 43, deleted_at: ~U[2024-10-31 04:38:00Z]}

      assert {:ok, %Branch{} = branch} = Branches.update_branch(branch, update_attrs)
      assert branch.name == "some updated name"
      assert branch.subdomain == "some updated subdomain"
      assert branch.parent_branch_id == 43
      assert branch.deleted_at == ~U[2024-10-31 04:38:00Z]
    end

    test "update_branch/2 with invalid data returns error changeset" do
      branch = branch_fixture()
      assert {:error, %Ecto.Changeset{}} = Branches.update_branch(branch, @invalid_attrs)
      assert branch == Branches.get_branch!(branch.id)
    end

    test "delete_branch/1 deletes the branch" do
      branch = branch_fixture()
      assert {:ok, %Branch{}} = Branches.delete_branch(branch)
      assert_raise Ecto.NoResultsError, fn -> Branches.get_branch!(branch.id) end
    end

    test "change_branch/1 returns a branch changeset" do
      branch = branch_fixture()
      assert %Ecto.Changeset{} = Branches.change_branch(branch)
    end
  end
end
