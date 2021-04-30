unit UntController.Authorization;

interface

uses
  Horse,
  Horse.JWT,
  UntModel.Claims;

function Authorization: THorseCallback;
function AuthorizationClaim: THorseCallback;

implementation

function Authorization: THorseCallback;
begin
  Result := HorseJWT('key');
end;

function AuthorizationClaim: THorseCallback;
begin
  Result := HorseJWT('key', TClaims);
end;

end.
