unit UntModel.Peca;

interface

uses
  UntInterface.Peca,
  UntModel.SubGrupo,
  System.JSON,
  System.SysUtils,
  UntModel.Query,
  DataSet.Serialize,
  UntFuncoes,
  System.Generics.Collections;

type
  TVeiculoAno = class(TInterfacedObject, iPeca)
  private
    Fpec_id : integer;
    Fpec_descricao : string;
    Fpec_gru_id : integer;
    Fpec_tra_id : integer;
    Fpec_sit_reg : boolean;
    Fpec_sgrus : TList<TSubGrupo>;
    function pec_id : integer; overload;
    function pec_id (const Value : integer): iPeca; overload;
    function pec_descricao : String; overload;
    function pec_descricao (const Value : String): iPeca; overload;
    function pec_gru_id : integer; overload;
    function pec_gru_id (const Value : integer): iPeca; overload;
    function pec_tra_id : integer; overload;
    function pec_tra_id (const Value : integer): iPeca; overload;
    function pec_sit_reg : boolean; overload;
    function pec_sit_reg (const Value : boolean): iPeca; overload;
    function pec_sgrus : TList<TSubGrupo>; overload;
    function pec_sgrus (const Value : TList<TSubGrupo>): iPeca; overload;
    function Cadastrar: TJSONObject;
    function Alterar: TJSONObject;
    function AddSubGrupos(const Value : TSubGrupo) : iPeca;
    constructor Create;
  public
    destructor Destroy; override;
    class function New : iPeca;
  end;
implementation

{ TVeiculoAno }

function TVeiculoAno.AddSubGrupos(const Value: TSubGrupo): iPeca;
begin
  Result := Self;
  Fpec_sgrus.Add(Value);
end;

function TVeiculoAno.Alterar: TJSONObject;
begin

end;

function TVeiculoAno.Cadastrar: TJSONObject;
begin

end;

constructor TVeiculoAno.Create;
begin
  Fpec_sit_reg := true;
  Fpec_sgrus := TList<TSubGrupo>.Create;
end;

destructor TVeiculoAno.Destroy;
begin
  Fpec_sgrus.Free;
  inherited;
end;

class function TVeiculoAno.New: iPeca;
begin
   Result := Self.Create;
end;

function TVeiculoAno.pec_descricao(const Value: String): iPeca;
begin
   if not (Length(Value) > 0) then
      raise Exception.Create('Verifique a descri��o da pe�a...');

   Result := Self;
   Fpec_descricao := Value;
end;

function TVeiculoAno.pec_descricao: String;
begin
  Result := Fpec_descricao;
end;

function TVeiculoAno.pec_gru_id(const Value: integer): iPeca;
begin
   Result := Self;
   Fpec_gru_id := Value;
end;

function TVeiculoAno.pec_gru_id: integer;
begin
   Result := Fpec_gru_id;
end;

function TVeiculoAno.pec_id: integer;
begin
  Result := Fpec_id;
end;

function TVeiculoAno.pec_id(const Value: integer): iPeca;
begin
   Result := Self;
   Fpec_id := Value;
end;

function TVeiculoAno.pec_sgrus: TList<TSubGrupo>;
begin
   Result := Fpec_sgrus;
end;

function TVeiculoAno.pec_sgrus(const Value: TList<TSubGrupo>): iPeca;
begin
   Result := Self;
   Fpec_sgrus := Value;
end;

function TVeiculoAno.pec_sit_reg(const Value: boolean): iPeca;
begin
   Result := Self;
   Fpec_sit_reg := Value;
end;

function TVeiculoAno.pec_sit_reg: boolean;
begin
   Result := Fpec_sit_reg;
end;

function TVeiculoAno.pec_tra_id(const Value: integer): iPeca;
begin
   Result := Self;
   Fpec_tra_id := Value;
end;

function TVeiculoAno.pec_tra_id: integer;
begin
   Result := Fpec_tra_id;
end;

end.
