defmodule VinciDropbox do
  use Application

  def start() do
    start(nil, nil)
  end

  def start(_type, _args) do
    HTTPoison.start
    dropbox_config = %{
      endpoint: "https://api.dropboxapi.com",
      routes: %{
        get_account: %{
          method: :post,
          path: "/2/users/get_account",
          result: VinciDropbox.BasicAccount
        },
        get_current_account: %{
          method: :post,
          path: "/2/users/get_current_account",
          result: VinciDropbox.FullAccount
        },
        get_space_usage: %{
          method: :post,
          path: "/2/users/get_space_usage",
          result: VinciDropbox.SpaceUsage
        },
        get_metadata: %{
          method: :post,
          path: "/2/files/get_metadata",
          result: VinciDropbox.Metadata
        },
        list_folder: %{
          method: :post,
          path: "/2/files/list_folder",
          result: VinciDropbox.ListFolderResult
        },
        list_folder_continue: %{
          method: :post,
          path: "/2/files/list_folder/continue",
          result: VinciDropbox.ListFolderResult,
        },
        list_folder_get_latest_cursor: %{
          method: :post,
          path: "/2/files/list_folder/get_latest_cursor",
          result: VinciDropbox.ListFolderResult,
        },
        download: %{
          method: :post,
          path: "/2/files/download",
          result: VinciDropbox.Metadata,
        },
        upload_session_start: %{
          method: :post,
          path: "/2/files/upload_session/start",
          result: VinciDropbox.Session,
        },
        upload_session_finish: %{
          method: :post,
          path: "/2/files/upload_session/finish",
          result: VinciDropbox.Metadata,
        },
        upload: %{
          method: :post,
          path: "/2/files/upload",
          # TODO: file upload
        },
        search: %{
          method: :post,
          path: "/2/files/search",
          result: VinciDropbox.SearchResult,
        },
        create_folder: %{
          method: :post,
          path: "/2/files/create_folder",
          result: VinciDropbox.Metadata,
        },
        delete: %{
          method: :post,
          path: "/2/files/delete",
          result: VinciDropbox.Metadata,
        },
        copy: %{
          method: :post,
          path: "/2/files/copy",
          result: VinciDropbox.Metadata,
        },
        move: %{
          method: :post,
          path: "/2/files/move",
          result: VinciDropbox.Metadata,
        },
        get_thumbnail: %{
          method: :post,
          path: "/2/files/get_thumbnail",
          result: VinciDropbox.Metadata,
        },
        get_preview: %{
          method: :post,
          path: "/2/files/get_thumbnail",
          result: VinciDropbox.Metadata,
        },
        list_revisions: %{
          method: :post,
          path: "/2/files/list_revisions",
          result: VinciDropbox.Revisions,
        },
        restore: %{
          method: :post,
          path: "/2/files/restore",
          result: VinciDropbox.Metadata,
        },
        get_shared_links: %{
          method: :post,
          path: "/2/sharing/get_shared_links",
          result: VinciDropbox.PathLinkMetadata,
        },
        create_shared_links: %{
          method: :post,
          path: "/2/sharing/create_shared_links",
          result: VinciDropbox.PathLinkMetadata,
        },
        revoke_shared_links: %{
          method: :post,
          path: "/2/sharing/revoke_shared_link",
          result: nil,
        },
      }
    }

    Vinci.ConfigAgent.add_config(:dropbox, dropbox_config)

    {:ok, self}
  end

  defmodule Name do
    defstruct display_name: nil,
              familiar_name: nil,
              given_name: nil,
              surname: nil
  end

  defmodule BasicAccount do
    defstruct account_id: nil,
              name: Name,
              is_teammate: false
  end

  defmodule FullAccount do
    defstruct account_id: nil,
              name: Name,
              is_teammate: false,
              email: nil,
              locale: nil,
              referral_link: nil,
              is_paired: false,
              account_type: nil,
              country: nil
  end

  defmodule SpaceUsage do
    defstruct used: 0,
              allocation: %{}
  end

  defmodule Metadata do
    defstruct [
                { String.to_atom(".tag"), 0 },
                { :name, nil },
                { :path_lower, nil },
                { :client_modified, nil },
                { :server_modified, nil },
                { :rev, nil },
                { :size, nil },
                { :id, nil },
              ]
  end

  defmodule ListFolderResult do
    defstruct entries: [Metadata],
              cursor: nil,
              has_more: false
  end

  defmodule Session do
    defstruct session_id: nil
  end

  defmodule SearchMatch do
    defstruct match_type: nil,
              match_type: Metadata
  end

  defmodule SearchResult do
    defstruct matches: [SearchMatch],
              more: false,
              start: 0
  end

  defmodule PathLinkMetadata do
    defstruct url: nil,
              visibility: nil,
              path: nil,
              expires: nil
  end

  defmodule Revisions do
    defstruct entries: [Metadata],
              is_deleted: false
  end
end
