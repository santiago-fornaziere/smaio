unit UntErros;

interface

uses
  System.JSON;

function ErroUsuarioExpirado : TJsonObject;

implementation

function ErroUsuarioExpirado : TJsonObject;
var vErro : TJSONObject;
begin
     vErro := TJsonObject.Create;
     vErro.AddPair('mensagem', TJSONString.Create('Data de valiadde expirada'));
     vErro.AddPair('id', TJSONNumber.Create('1'));
end;

end.
