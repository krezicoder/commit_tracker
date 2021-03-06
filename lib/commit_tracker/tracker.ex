defmodule CommitTracker.Tracker do
  @moduledoc """
  The Tracker context.
  """

  import Ecto.Query, warn: false
  alias CommitTracker.Repo

  alias CommitTracker.Tracker.Repository

  @doc """
  Returns the list of repositories.

  ## Examples

      iex> list_repositories()
      [%Repository{}, ...]

  """
  def list_repositories do
    Repo.all(Repository)
  end

  @doc """
  Gets a single repository.

  Raises `Ecto.NoResultsError` if the Repository does not exist.

  ## Examples

      iex> get_repository!(123)
      %Repository{}

      iex> get_repository!(456)
      ** (Ecto.NoResultsError)

  """
  def get_repository!(id), do: Repo.get!(Repository, id)

  @doc """
  Creates a repository.

  ## Examples

      iex> create_repository(%{field: value})
      {:ok, %Repository{}}

      iex> create_repository(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_repository(attrs \\ %{}) do
    %Repository{}
    |> Repository.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a repository.

  ## Examples

      iex> update_repository(repository, %{field: new_value})
      {:ok, %Repository{}}

      iex> update_repository(repository, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_repository(%Repository{} = repository, attrs) do
    repository
    |> Repository.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a repository.

  ## Examples

      iex> delete_repository(repository)
      {:ok, %Repository{}}

      iex> delete_repository(repository)
      {:error, %Ecto.Changeset{}}

  """
  def delete_repository(%Repository{} = repository) do
    Repo.delete(repository)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking repository changes.

  ## Examples

      iex> change_repository(repository)
      %Ecto.Changeset{data: %Repository{}}

  """
  def change_repository(%Repository{} = repository, attrs \\ %{}) do
    Repository.changeset(repository, attrs)
  end

  alias CommitTracker.Tracker.Push

  @doc """
  Returns the list of pushes.

  ## Examples

      iex> list_pushes()
      [%Push{}, ...]

  """
  def list_pushes do
    Repo.all(Push)
  end

  @doc """
  Gets a single push.

  Raises `Ecto.NoResultsError` if the Push does not exist.

  ## Examples

      iex> get_push!(123)
      %Push{}

      iex> get_push!(456)
      ** (Ecto.NoResultsError)

  """
  def get_push!(id), do: Repo.get!(Push, id)

  @doc """
  Creates a push.

  ## Examples

      iex> create_push(%{field: value})
      {:ok, %Push{}}

      iex> create_push(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_push(attrs \\ %{}) do
    %Push{}
    |> Push.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a push.

  ## Examples

      iex> update_push(push, %{field: new_value})
      {:ok, %Push{}}

      iex> update_push(push, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_push(%Push{} = push, attrs) do
    push
    |> Push.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a push.

  ## Examples

      iex> delete_push(push)
      {:ok, %Push{}}

      iex> delete_push(push)
      {:error, %Ecto.Changeset{}}

  """
  def delete_push(%Push{} = push) do
    Repo.delete(push)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking push changes.

  ## Examples

      iex> change_push(push)
      %Ecto.Changeset{data: %Push{}}

  """
  def change_push(%Push{} = push, attrs \\ %{}) do
    Push.changeset(push, attrs)
  end

  alias CommitTracker.Tracker.Author

  @doc """
  Returns the list of authors.

  ## Examples

      iex> list_authors()
      [%Author{}, ...]

  """
  def list_authors do
    Repo.all(Author)
  end

  @doc """
  Gets a single author.

  Raises `Ecto.NoResultsError` if the Author does not exist.

  ## Examples

      iex> get_author!(123)
      %Author{}

      iex> get_author!(456)
      ** (Ecto.NoResultsError)

  """
  def get_author!(id), do: Repo.get!(Author, id)

  @doc """
  Creates a author.

  ## Examples

      iex> create_author(%{field: value})
      {:ok, %Author{}}

      iex> create_author(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_author(attrs \\ %{}) do
    %Author{}
    |> Author.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a author.

  ## Examples

      iex> update_author(author, %{field: new_value})
      {:ok, %Author{}}

      iex> update_author(author, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_author(%Author{} = author, attrs) do
    author
    |> Author.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a author.

  ## Examples

      iex> delete_author(author)
      {:ok, %Author{}}

      iex> delete_author(author)
      {:error, %Ecto.Changeset{}}

  """
  def delete_author(%Author{} = author) do
    Repo.delete(author)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking author changes.

  ## Examples

      iex> change_author(author)
      %Ecto.Changeset{data: %Author{}}

  """
  def change_author(%Author{} = author, attrs \\ %{}) do
    Author.changeset(author, attrs)
  end

  alias CommitTracker.Tracker.Commit

  @doc """
  Returns the list of commits.

  ## Examples

      iex> list_commits()
      [%Commit{}, ...]

  """
  def list_commits do
    Repo.all(Commit)
  end

  @doc """
  Gets a single commit.

  Raises `Ecto.NoResultsError` if the Commit does not exist.

  ## Examples

      iex> get_commit!(123)
      %Commit{}

      iex> get_commit!(456)
      ** (Ecto.NoResultsError)

  """
  def get_commit!(id), do: Repo.get!(Commit, id)

  @doc """
  Gets a single commit by sha.

  Raises `Ecto.NoResultsError` if the Commit does not exist.

  ## Examples

      iex> get_commit_by_sha!("fbea31d5a04cd9e238fd45f3f27f314ebf707479")
      %Commit{}

      iex> get_commit_by_sha!("fbea31d5a04cd9e238fd45f3f27f314ebf707479")
      ** (Ecto.NoResultsError)

  """
  def get_commit_by_sha(sha), do: Repo.get_by(Commit, sha: sha)

  @doc """
  Creates a commit.

  ## Examples

      iex> create_commit(%{field: value})
      {:ok, %Commit{}}

      iex> create_commit(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_commit(attrs \\ %{}) do
    %Commit{}
    |> Commit.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a commit.

  ## Examples

      iex> update_commit(commit, %{field: new_value})
      {:ok, %Commit{}}

      iex> update_commit(commit, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_commit(%Commit{} = commit, attrs) do
    commit
    |> Commit.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a commit.

  ## Examples

      iex> delete_commit(commit)
      {:ok, %Commit{}}

      iex> delete_commit(commit)
      {:error, %Ecto.Changeset{}}

  """
  def delete_commit(%Commit{} = commit) do
    Repo.delete(commit)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking commit changes.

  ## Examples

      iex> change_commit(commit)
      %Ecto.Changeset{data: %Commit{}}

  """
  def change_commit(%Commit{} = commit, attrs \\ %{}) do
    Commit.changeset(commit, attrs)
  end

  alias CommitTracker.Tracker.Ticket

  @doc """
  Returns the list of tickets.

  ## Examples

      iex> list_tickets()
      [%Ticket{}, ...]

  """
  def list_tickets do
    Repo.all(Ticket)
  end

  @doc """
  Gets a single ticket.

  Raises `Ecto.NoResultsError` if the Ticket does not exist.

  ## Examples

      iex> get_ticket!(123)
      %Ticket{}

      iex> get_ticket!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ticket!(id), do: Repo.get!(Ticket, id)

  @doc """
  Creates a ticket.

  ## Examples

      iex> create_ticket(%{field: value})
      {:ok, %Ticket{}}

      iex> create_ticket(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ticket(attrs \\ %{}) do
    %Ticket{}
    |> Ticket.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ticket.

  ## Examples

      iex> update_ticket(ticket, %{field: new_value})
      {:ok, %Ticket{}}

      iex> update_ticket(ticket, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ticket(%Ticket{} = ticket, attrs) do
    ticket
    |> Ticket.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ticket.

  ## Examples

      iex> delete_ticket(ticket)
      {:ok, %Ticket{}}

      iex> delete_ticket(ticket)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ticket(%Ticket{} = ticket) do
    Repo.delete(ticket)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ticket changes.

  ## Examples

      iex> change_ticket(ticket)
      %Ecto.Changeset{data: %Ticket{}}

  """
  def change_ticket(%Ticket{} = ticket, attrs \\ %{}) do
    Ticket.changeset(ticket, attrs)
  end

  alias CommitTracker.Tracker.Release

  @doc """
  Returns the list of releases.

  ## Examples

      iex> list_releases()
      [%Release{}, ...]

  """
  def list_releases do
    Repo.all(Release)
  end

  @doc """
  Gets a single release.

  Raises `Ecto.NoResultsError` if the Release does not exist.

  ## Examples

      iex> get_release!(123)
      %Release{}

      iex> get_release!(456)
      ** (Ecto.NoResultsError)

  """
  def get_release!(id), do: Repo.get!(Release, id)

  def get_release(id), do: Repo.get(Release, id)

  @doc """
  Creates a release.

  ## Examples

      iex> create_release(%{field: value})
      {:ok, %Release{}}

      iex> create_release(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_release(attrs \\ %{}) do
    %Release{}
    |> Release.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a release.

  ## Examples

      iex> update_release(release, %{field: new_value})
      {:ok, %Release{}}

      iex> update_release(release, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_release(%Release{} = release, attrs) do
    release
    |> Release.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a release.

  ## Examples

      iex> delete_release(release)
      {:ok, %Release{}}

      iex> delete_release(release)
      {:error, %Ecto.Changeset{}}

  """
  def delete_release(%Release{} = release) do
    Repo.delete(release)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking release changes.

  ## Examples

      iex> change_release(release)
      %Ecto.Changeset{data: %Release{}}

  """
  def change_release(%Release{} = release, attrs \\ %{}) do
    Release.changeset(release, attrs)
  end

  alias CommitTracker.Tracker.PullRequest

  @doc """
  Returns the list of pull_requests.

  ## Examples

      iex> list_pull_requests()
      [%PullRequest{}, ...]

  """
  def list_pull_requests do
    Repo.all(PullRequest)
  end

  @doc """
  Gets a single pull_request.

  Raises `Ecto.NoResultsError` if the Pull request does not exist.

  ## Examples

      iex> get_pull_request!(123)
      %PullRequest{}

      iex> get_pull_request!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pull_request!(id), do: Repo.get!(PullRequest, id)
  def get_pull_request(id), do: Repo.get(PullRequest, id)

  @doc """
  Creates a pull_request.

  ## Examples

      iex> create_pull_request(%{field: value})
      {:ok, %PullRequest{}}

      iex> create_pull_request(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pull_request(attrs \\ %{}) do
    %PullRequest{}
    |> PullRequest.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pull_request.

  ## Examples

      iex> update_pull_request(pull_request, %{field: new_value})
      {:ok, %PullRequest{}}

      iex> update_pull_request(pull_request, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pull_request(%PullRequest{} = pull_request, attrs) do
    pull_request
    |> PullRequest.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pull_request.

  ## Examples

      iex> delete_pull_request(pull_request)
      {:ok, %PullRequest{}}

      iex> delete_pull_request(pull_request)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pull_request(%PullRequest{} = pull_request) do
    Repo.delete(pull_request)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pull_request changes.

  ## Examples

      iex> change_pull_request(pull_request)
      %Ecto.Changeset{data: %PullRequest{}}

  """
  def change_pull_request(%PullRequest{} = pull_request, attrs \\ %{}) do
    PullRequest.changeset(pull_request, attrs)
  end
end
