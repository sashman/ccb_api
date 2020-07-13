defmodule Auth.Identity do
  @moduledoc """
  This struct represents the Identitiy accessible on each connection
  """
  @enforce_keys [:id]
  defstruct id: nil,
            given_name: nil,
            family_name: nil,
            nickname: nil,
            name: nil,
            picture: nil,
            locale: nil,
            updated_at: nil

  @type t() :: [
          id: String.t(),
          given_name: String.t(),
          family_name: String.t(),
          nickname: String.t(),
          name: String.t(),
          picture: String.t(),
          locale: String.t(),
          updated_at: String.t()
        ]
end
