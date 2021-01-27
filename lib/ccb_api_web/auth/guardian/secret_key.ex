defmodule Auth.Guardian.SecretKey do
  def fetch do
    Application.get_env(:ccb_api, Auth.Guardian)
    |> Keyword.get(:secret_key_pem_path)
    |> File.read!()
    |> JOSE.JWK.from_pem()
  end

  def fetch_from_binary do
    Application.get_env(:ccb_api, Auth.Guardian)
    |> Keyword.get(:secret_binary)
    |> JOSE.JWK.from_binary()
  end
end
