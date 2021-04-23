unit Untmodel.BFCall.Chamado;

interface

uses
  UntFuncoes,
  UntInterface.BfCall.Chamado;

type
  TChamado = class(TInterfacedObject, iChamado)
    private
      FchamID: integer;
      FchamUsuarioId: integer;
      FchamDtAbertura: TDateTime;
      FchamEncUsuarioId: integer;
      FchamDtEncerrameto: TDateTime;
      FchamTipoId: integer;
      FchamStatusId: integer;
      FchamSetorId: integer;
      FchamTexto: string;
      FchamSitRegId: integer;


  // funcoes da interface
      function chamID: integer; overload;
      function chamID(const Value: integer): iChamado; overload;
      function chamID(const Value: string): iChamado; overload;
      function chamUsuarioId : integer; overload;
      function chamUsuarioId(const Value: integer): iChamado; overload;
      function chamUsuarioId(const Value: string): iChamado; overload;
      function chamDtAbertura : TDateTime; overload;
      function chamDtAbertura(const Value: TDateTime): iChamado; overload;
      function chamDtAbertura(const Value: string): iChamado; overload;
      function chamEncUsuarioId: integer; overload;
      function chamEncUsuarioId(const Value: integer): iChamado; overload;
      function chamEncUsuarioId(const Value: string): iChamado; overload;
      function chamDtEncerrameto: TDateTime; overload;
      function chamDtEncerrameto(const Value: TDateTime): iChamado; overload;
      function chamDtEncerrameto(const Value: string): iChamado; overload;
      function chamTipoId : integer; overload;
      function chamTipoId(const Value: integer): iChamado; overload;
      function chamTipoId(const Value: string): iChamado; overload;
      function chamStatusId : integer; overload;
      function chamStatusId(const Value: integer): iChamado; overload;
      function chamStatusId(const Value: string): iChamado; overload;
      function chamSetorId : integer; overload;
      function chamSetorId(const Value: integer): iChamado; overload;
      function chamSetorId(const Value: string): iChamado; overload;
      function chamTexto : string; overload;
      function chamTexto(const Value: string): iChamado; overload;
      function chamSitRegId : integer; overload;
      function chamSitRegId(const Value: integer): iChamado; overload;
      function chamSitRegId(const Value: string): iChamado; overload;
      constructor Create;
    public
      destructor Destroy; override;
      class function New : iChamado;
    end;
implementation

uses
  System.SysUtils;


{ TChamado }

function TChamado.chamDtAbertura(const Value: string): iChamado;
begin
  Result := Self;
  self.FchamDtAbertura := JSONDateToDatetime(Value);
end;

function TChamado.chamDtAbertura(const Value: TDateTime): iChamado;
begin
  Result := Self;
  self.FchamDtAbertura := Value;
end;

function TChamado.chamDtAbertura: TDateTime;
begin
 Result := self.FchamDtAbertura;
end;

function TChamado.chamDtEncerrameto(const Value: string): iChamado;
begin
  Result := Self;
  if not (Value = 'null') then
    self.FchamDtEncerrameto := JSONDateToDatetime(Value);
end;

function TChamado.chamDtEncerrameto(const Value: TDateTime): iChamado;
begin
  Result := Self;
  self.FchamDtEncerrameto := Value;
end;

function TChamado.chamDtEncerrameto: TDateTime;
begin
  Result := self.FchamDtEncerrameto;
end;

function TChamado.chamEncUsuarioId: integer;
begin
  Result := self.FchamEncUsuarioId;
end;

function TChamado.chamEncUsuarioId(const Value: integer): iChamado;
begin
  Result := Self;
  self.FchamEncUsuarioId := Value;
end;

function TChamado.chamEncUsuarioId(const Value: string): iChamado;
begin
  Result := Self;
  if not (Value = 'null') then
    self.FchamEncUsuarioId := StrToInt(Value);
end;

function TChamado.chamID: integer;
begin
 Result := Self.FchamID;
end;

function TChamado.chamID(const Value: integer): iChamado;
begin
  Result := Self;
end;

function TChamado.chamID(const Value: string): iChamado;
begin
  Result := Self;
end;

function TChamado.chamSetorId(const Value: string): iChamado;
begin
  Result := Self;
  Self.FchamSetorId := StrToInt(value);
end;

function TChamado.chamSetorId(const Value: integer): iChamado;
begin
  Result := Self;
  Self.FchamSetorId := value;
end;

function TChamado.chamSetorId: integer;
begin
  Result := FchamSetorId;
end;

function TChamado.chamSitRegId(const Value: string): iChamado;
begin
  Result := Self;
  Self.FchamSitRegId := StrToInt(value);
end;

function TChamado.chamSitRegId(const Value: integer): iChamado;
begin
  Result := Self;
  Self.FchamSitRegId := value;
end;

function TChamado.chamSitRegId: integer;
begin
  Result := Self.chamSitRegId;
end;

function TChamado.chamStatusId: integer;
begin
  Result := FchamStatusId;
end;

function TChamado.chamStatusId(const Value: integer): iChamado;
begin
  Result := Self;
  Self.FchamStatusId := value;
end;

function TChamado.chamStatusId(const Value: string): iChamado;
begin
  Result := Self;
  Self.FchamStatusId := StrToInt(value);
end;

function TChamado.chamTexto: string;
begin
  Result := Self.FchamTexto;
end;

function TChamado.chamTexto(const Value: string): iChamado;
begin
  Result := Self;
  Self.FchamTexto := value;
end;

function TChamado.chamTipoId: integer;
begin
  Result := Self.chamTipoId;
end;

function TChamado.chamTipoId(const Value: integer): iChamado;
begin
  Result := Self;
  Self.FchamTipoId := value;
end;

function TChamado.chamTipoId(const Value: string): iChamado;
begin
  Result := Self;
  Self.FchamTipoId := StrToInt(value);
end;

function TChamado.chamUsuarioId(const Value: string): iChamado;
begin
  Result := Self;
  Self.FchamUsuarioId := StrToInt(value);
end;

function TChamado.chamUsuarioId(const Value: integer): iChamado;
begin
  Result := Self;
  Self.FchamUsuarioId := value;
end;

function TChamado.chamUsuarioId: integer;
begin
  Result := Self.FchamUsuarioId;
end;

constructor TChamado.Create;
begin

end;

destructor TChamado.Destroy;
begin

  inherited;
end;

class function TChamado.New: iChamado;
begin
  Result := Self.Create;
end;

end.
