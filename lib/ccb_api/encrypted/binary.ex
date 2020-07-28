defmodule CcbApi.Encrypted.Binary do
  use Cloak.Ecto.Binary, vault: CcbApi.Vault
end