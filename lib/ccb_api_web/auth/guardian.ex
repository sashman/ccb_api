defmodule Auth.Guardian do
  @moduledoc """
  This is the main Guardian module used by the application to gain access to claims,
  identity, token, etc.
  Implements callback to properly integrate with Auth0.
  """
  use Guardian, otp_app: :ccb_api

  alias Auth.Identity

  @impl Guardian
  @doc false
  def resource_from_claims(%{"sub" => "auth0|" <> id} = claims),
    do: claims_to_identity(id, claims)

  def resource_from_claims(%{"sub" => "google-oauth2|" <> id} = claims),
    do: claims_to_identity(id, claims)

  defp claims_to_identity(id, claims) do
    {:ok,
     %Identity{
       id: id,
       given_name: claims["given_name"],
       family_name: claims["family_name"],
       nickname: claims["nickname"],
       name: claims["name"],
       picture: claims["picture"],
       locale: claims["locale"],
       updated_at: claims["updated_at"]
     }}
  end

  def subject_for_token(resource, claims) do
    # You can use any value for the subject of your token but
    # it should be useful in retrieving the resource later, see
    # how it being used on `resource_from_claims/1` function.
    # A unique `id` is a good subject, a non-unique email address
    # is a poor subject.

    IO.inspect(claims)
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end
end
