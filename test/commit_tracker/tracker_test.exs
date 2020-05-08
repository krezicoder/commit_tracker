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

  describe "pushes" do
    alias CommitTracker.Tracker.Push

    @valid_attrs %{pushed_at: ~N[2010-04-17 14:00:00]}
    @update_attrs %{pushed_at: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{pushed_at: nil}

    def push_fixture(attrs \\ %{}) do
      {:ok, push} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracker.create_push()

      push
    end

    test "list_pushes/0 returns all pushes" do
      push = push_fixture()
      assert Tracker.list_pushes() == [push]
    end

    test "get_push!/1 returns the push with given id" do
      push = push_fixture()
      assert Tracker.get_push!(push.id) == push
    end

    test "create_push/1 with valid data creates a push" do
      assert {:ok, %Push{} = push} = Tracker.create_push(@valid_attrs)
      assert push.pushed_at == ~N[2010-04-17 14:00:00]
    end

    test "create_push/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_push(@invalid_attrs)
    end

    test "update_push/2 with valid data updates the push" do
      push = push_fixture()
      assert {:ok, %Push{} = push} = Tracker.update_push(push, @update_attrs)
      assert push.pushed_at == ~N[2011-05-18 15:01:01]
    end

    test "update_push/2 with invalid data returns error changeset" do
      push = push_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_push(push, @invalid_attrs)
      assert push == Tracker.get_push!(push.id)
    end

    test "delete_push/1 deletes the push" do
      push = push_fixture()
      assert {:ok, %Push{}} = Tracker.delete_push(push)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_push!(push.id) end
    end

    test "change_push/1 returns a push changeset" do
      push = push_fixture()
      assert %Ecto.Changeset{} = Tracker.change_push(push)
    end
  end

  describe "authors" do
    alias CommitTracker.Tracker.Author

    @valid_attrs %{email: "some email", name: "some name"}
    @update_attrs %{email: "some updated email", name: "some updated name"}
    @invalid_attrs %{email: nil, name: nil}

    def author_fixture(attrs \\ %{}) do
      {:ok, author} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracker.create_author()

      author
    end

    test "list_authors/0 returns all authors" do
      author = author_fixture()
      assert Tracker.list_authors() == [author]
    end

    test "get_author!/1 returns the author with given id" do
      author = author_fixture()
      assert Tracker.get_author!(author.id) == author
    end

    test "create_author/1 with valid data creates a author" do
      assert {:ok, %Author{} = author} = Tracker.create_author(@valid_attrs)
      assert author.email == "some email"
      assert author.name == "some name"
    end

    test "create_author/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_author(@invalid_attrs)
    end

    test "update_author/2 with valid data updates the author" do
      author = author_fixture()
      assert {:ok, %Author{} = author} = Tracker.update_author(author, @update_attrs)
      assert author.email == "some updated email"
      assert author.name == "some updated name"
    end

    test "update_author/2 with invalid data returns error changeset" do
      author = author_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_author(author, @invalid_attrs)
      assert author == Tracker.get_author!(author.id)
    end

    test "delete_author/1 deletes the author" do
      author = author_fixture()
      assert {:ok, %Author{}} = Tracker.delete_author(author)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_author!(author.id) end
    end

    test "change_author/1 returns a author changeset" do
      author = author_fixture()
      assert %Ecto.Changeset{} = Tracker.change_author(author)
    end
  end
end
