defmodule CommitTracker.TrackerTest do
  use CommitTracker.DataCase

  alias CommitTracker.Tracker

  describe "repositories" do
    alias CommitTracker.Tracker.Repository

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def repository_fixture(attrs \\ %{}) do
      {:ok, repository} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracker.create_repository()

      repository
    end

    test "list_repositories/0 returns all repositories" do
      repository = repository_fixture()
      assert Tracker.list_repositories() == [repository]
    end

    test "get_repository!/1 returns the repository with given id" do
      repository = repository_fixture()
      assert Tracker.get_repository!(repository.id) == repository
    end

    test "create_repository/1 with valid data creates a repository" do
      assert {:ok, %Repository{} = repository} = Tracker.create_repository(@valid_attrs)
      assert repository.name == "some name"
    end

    test "create_repository/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_repository(@invalid_attrs)
    end

    test "update_repository/2 with valid data updates the repository" do
      repository = repository_fixture()
      assert {:ok, %Repository{} = repository} = Tracker.update_repository(repository, @update_attrs)
      assert repository.name == "some updated name"
    end

    test "update_repository/2 with invalid data returns error changeset" do
      repository = repository_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_repository(repository, @invalid_attrs)
      assert repository == Tracker.get_repository!(repository.id)
    end

    test "delete_repository/1 deletes the repository" do
      repository = repository_fixture()
      assert {:ok, %Repository{}} = Tracker.delete_repository(repository)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_repository!(repository.id) end
    end

    test "change_repository/1 returns a repository changeset" do
      repository = repository_fixture()
      assert %Ecto.Changeset{} = Tracker.change_repository(repository)
    end
  end
end
