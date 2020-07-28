defmodule CcbApi.Vault do
  use Cloak.Vault, otp_app: :ccb_api

  @impl GenServer
  def init(config) do
    config =
      Keyword.put(config, :ciphers,
        default: {Cloak.Ciphers.AES.GCM, tag: "AES.GCM.V1", key: decode_env!("ECTO_CLOAK_KEY")}
      )

    {:ok, config}
  end

  defp decode_env!(var) do
    System.get_env(var)
    |> check_nil(var)
    |> Base.decode64!()
  end

  defp check_nil(nil, var), do: raise("#{var} needs to be set")
  defp check_nil(value, _), do: value
end
