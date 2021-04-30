unit UntController.Authorization;

interface

uses
  Horse,
  Horse.JWT;

function Authorization: THorseCallback;

implementation

function Authorization: THorseCallback;
begin
  Result := HorseJWT('key');
end;


end.
