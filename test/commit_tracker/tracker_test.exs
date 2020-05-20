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

  describe "commits" do
    alias CommitTracker.Tracker.Commit

    @valid_attrs %{date: "2010-04-17T14:00:00Z", message: "some message", sha: "some sha", type: "some type"}
    @update_attrs %{date: "2011-05-18T15:01:01Z", message: "some updated message", sha: "some updated sha", type: "some updated type"}
    @invalid_attrs %{date: nil, message: nil, sha: nil, type: nil}

    def commit_fixture(attrs \\ %{}) do
      {:ok, commit} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracker.create_commit()

      commit
    end

    test "list_commits/0 returns all commits" do
      commit = commit_fixture()
      assert Tracker.list_commits() == [commit]
    end

    test "get_commit!/1 returns the commit with given id" do
      commit = commit_fixture()
      assert Tracker.get_commit!(commit.id) == commit
    end

    test "create_commit/1 with valid data creates a commit" do
      assert {:ok, %Commit{} = commit} = Tracker.create_commit(@valid_attrs)
      assert commit.date == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert commit.message == "some message"
      assert commit.sha == "some sha"
      assert commit.type == "some type"
    end

    test "create_commit/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_commit(@invalid_attrs)
    end

    test "update_commit/2 with valid data updates the commit" do
      commit = commit_fixture()
      assert {:ok, %Commit{} = commit} = Tracker.update_commit(commit, @update_attrs)
      assert commit.date == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert commit.message == "some updated message"
      assert commit.sha == "some updated sha"
      assert commit.type == "some updated type"
    end

    test "update_commit/2 with invalid data returns error changeset" do
      commit = commit_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_commit(commit, @invalid_attrs)
      assert commit == Tracker.get_commit!(commit.id)
    end

    test "delete_commit/1 deletes the commit" do
      commit = commit_fixture()
      assert {:ok, %Commit{}} = Tracker.delete_commit(commit)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_commit!(commit.id) end
    end

    test "change_commit/1 returns a commit changeset" do
      commit = commit_fixture()
      assert %Ecto.Changeset{} = Tracker.change_commit(commit)
    end
  end

  describe "tickets" do
    alias CommitTracker.Tracker.Ticket

    @valid_attrs %{ticket_id: "some ticket_id", type: "some type"}
    @update_attrs %{ticket_id: "some updated ticket_id", type: "some updated type"}
    @invalid_attrs %{ticket_id: nil, type: nil}

    def ticket_fixture(attrs \\ %{}) do
      {:ok, ticket} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracker.create_ticket()

      ticket
    end

    test "list_tickets/0 returns all tickets" do
      ticket = ticket_fixture()
      assert Tracker.list_tickets() == [ticket]
    end

    test "get_ticket!/1 returns the ticket with given id" do
      ticket = ticket_fixture()
      assert Tracker.get_ticket!(ticket.id) == ticket
    end

    test "create_ticket/1 with valid data creates a ticket" do
      assert {:ok, %Ticket{} = ticket} = Tracker.create_ticket(@valid_attrs)
      assert ticket.ticket_id == "some ticket_id"
      assert ticket.type == "some type"
    end

    test "create_ticket/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_ticket(@invalid_attrs)
    end

    test "update_ticket/2 with valid data updates the ticket" do
      ticket = ticket_fixture()
      assert {:ok, %Ticket{} = ticket} = Tracker.update_ticket(ticket, @update_attrs)
      assert ticket.ticket_id == "some updated ticket_id"
      assert ticket.type == "some updated type"
    end

    test "update_ticket/2 with invalid data returns error changeset" do
      ticket = ticket_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_ticket(ticket, @invalid_attrs)
      assert ticket == Tracker.get_ticket!(ticket.id)
    end

    test "delete_ticket/1 deletes the ticket" do
      ticket = ticket_fixture()
      assert {:ok, %Ticket{}} = Tracker.delete_ticket(ticket)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_ticket!(ticket.id) end
    end

    test "change_ticket/1 returns a ticket changeset" do
      ticket = ticket_fixture()
      assert %Ecto.Changeset{} = Tracker.change_ticket(ticket)
    end
  end

  describe "releases" do
    alias CommitTracker.Tracker.Release

    @valid_attrs %{released_at: "2010-04-17T14:00:00Z", status: "some status", tag_name: "some tag_name"}
    @update_attrs %{released_at: "2011-05-18T15:01:01Z", status: "some updated status", tag_name: "some updated tag_name"}
    @invalid_attrs %{released_at: nil, status: nil, tag_name: nil}

    def release_fixture(attrs \\ %{}) do
      {:ok, release} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracker.create_release()

      release
    end

    test "list_releases/0 returns all releases" do
      release = release_fixture()
      assert Tracker.list_releases() == [release]
    end

    test "get_release!/1 returns the release with given id" do
      release = release_fixture()
      assert Tracker.get_release!(release.id) == release
    end

    test "create_release/1 with valid data creates a release" do
      assert {:ok, %Release{} = release} = Tracker.create_release(@valid_attrs)
      assert release.released_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert release.status == "some status"
      assert release.tag_name == "some tag_name"
    end

    test "create_release/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_release(@invalid_attrs)
    end

    test "update_release/2 with valid data updates the release" do
      release = release_fixture()
      assert {:ok, %Release{} = release} = Tracker.update_release(release, @update_attrs)
      assert release.released_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert release.status == "some updated status"
      assert release.tag_name == "some updated tag_name"
    end

    test "update_release/2 with invalid data returns error changeset" do
      release = release_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_release(release, @invalid_attrs)
      assert release == Tracker.get_release!(release.id)
    end

    test "delete_release/1 deletes the release" do
      release = release_fixture()
      assert {:ok, %Release{}} = Tracker.delete_release(release)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_release!(release.id) end
    end

    test "change_release/1 returns a release changeset" do
      release = release_fixture()
      assert %Ecto.Changeset{} = Tracker.change_release(release)
    end
  end

  describe "pull_requests" do
    alias CommitTracker.Tracker.PullRequest

    @valid_attrs %{action: "some action", body: "some body", closed_at: "2010-04-17T14:00:00Z", created_at: "2010-04-17T14:00:00Z", head_sha: "some head_sha", merge_commit_sha: "some merge_commit_sha", number: 42, request_number: 42, state: "some state", title: "some title", updated_at: "2010-04-17T14:00:00Z"}
    @update_attrs %{action: "some updated action", body: "some updated body", closed_at: "2011-05-18T15:01:01Z", created_at: "2011-05-18T15:01:01Z", head_sha: "some updated head_sha", merge_commit_sha: "some updated merge_commit_sha", number: 43, request_number: 43, state: "some updated state", title: "some updated title", updated_at: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{action: nil, body: nil, closed_at: nil, created_at: nil, head_sha: nil, merge_commit_sha: nil, number: nil, request_number: nil, state: nil, title: nil, updated_at: nil}

    def pull_request_fixture(attrs \\ %{}) do
      {:ok, pull_request} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tracker.create_pull_request()

      pull_request
    end

    test "list_pull_requests/0 returns all pull_requests" do
      pull_request = pull_request_fixture()
      assert Tracker.list_pull_requests() == [pull_request]
    end

    test "get_pull_request!/1 returns the pull_request with given id" do
      pull_request = pull_request_fixture()
      assert Tracker.get_pull_request!(pull_request.id) == pull_request
    end

    test "create_pull_request/1 with valid data creates a pull_request" do
      assert {:ok, %PullRequest{} = pull_request} = Tracker.create_pull_request(@valid_attrs)
      assert pull_request.action == "some action"
      assert pull_request.body == "some body"
      assert pull_request.closed_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert pull_request.created_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert pull_request.head_sha == "some head_sha"
      assert pull_request.merge_commit_sha == "some merge_commit_sha"
      assert pull_request.number == 42
      assert pull_request.request_number == 42
      assert pull_request.state == "some state"
      assert pull_request.title == "some title"
      assert pull_request.updated_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_pull_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_pull_request(@invalid_attrs)
    end

    test "update_pull_request/2 with valid data updates the pull_request" do
      pull_request = pull_request_fixture()
      assert {:ok, %PullRequest{} = pull_request} = Tracker.update_pull_request(pull_request, @update_attrs)
      assert pull_request.action == "some updated action"
      assert pull_request.body == "some updated body"
      assert pull_request.closed_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert pull_request.created_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert pull_request.head_sha == "some updated head_sha"
      assert pull_request.merge_commit_sha == "some updated merge_commit_sha"
      assert pull_request.number == 43
      assert pull_request.request_number == 43
      assert pull_request.state == "some updated state"
      assert pull_request.title == "some updated title"
      assert pull_request.updated_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_pull_request/2 with invalid data returns error changeset" do
      pull_request = pull_request_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_pull_request(pull_request, @invalid_attrs)
      assert pull_request == Tracker.get_pull_request!(pull_request.id)
    end

    test "delete_pull_request/1 deletes the pull_request" do
      pull_request = pull_request_fixture()
      assert {:ok, %PullRequest{}} = Tracker.delete_pull_request(pull_request)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_pull_request!(pull_request.id) end
    end

    test "change_pull_request/1 returns a pull_request changeset" do
      pull_request = pull_request_fixture()
      assert %Ecto.Changeset{} = Tracker.change_pull_request(pull_request)
    end
  end
end
