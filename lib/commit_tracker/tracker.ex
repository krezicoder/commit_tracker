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
end
