unit UntModel.Item;

interface

uses
  UntInterface.Item,
  System.Generics.Collections,
  System.JSON,
  System.SysUtils,
  DataSet.Serialize,
  UntModel.Query;

type
  TItem = class(TInterfacedObject, iItem)
  private
    Fite_id : integer;
    Fite_descricao : String;
    Fite_sgvano_id : integer;
    Fite_gru_id : integer;
    Fite_gru_descricao : String;
    Fite_pec_id : integer;
    Fite_pec_descricao : String;
    Fite_sgru_id : integer;
    Fite_sgru_descricao : String;
    Fite_vei_id : integer;
    Fite_vei_descricao : String;
    Fite_vei_fab_id : integer;
    Fite_vei_fab_nome : String;
    Fite_vano_ano_id : integer;
    Fite_vano_ano_descricao : String;
    Fite_valor : Currency;
    Fite_situacao : String;
    Fite_status : String;
    Fite_loj_id : integer;
    Fite_loj_nome : String;
    Fite_tra_entrada : integer;
    Fite_tra_dt_entrada : TDateTime;
    Fite_tra_saida : integer;
    Fite_tra_dt_saida : TDateTime;
    Fite_sit_reg : Boolean;
    Fite_usu_id : integer;

    function ite_id : integer; overload;
    function ite_id (const Value : integer): iItem; overload;
    function ite_descricao : String; overload;
    function ite_descricao (const Value : String) : iItem; overload;
    function ite_sgvano_id : integer; overload;
    function ite_sgvano_id (const Value : integer) : iItem; overload;
    function ite_gru_id : integer; overload;
    function ite_gru_id (const Value : integer) : iItem; overload;
    function ite_gru_descricao : String; overload;
    function ite_gru_descricao (const Value : String) : iItem; overload;
    function ite_pec_id : integer; overload;
    function ite_pec_id (const Value : integer) : iItem; overload;
    function ite_pec_descricao : String; overload;
    function ite_pec_descricao (const Value : String) : iItem; overload;
    function ite_sgru_id : integer; overload;
    function ite_sgru_id (const Value : integer) : iItem; overload;
    function ite_sgru_descricao : String; overload;
    function ite_sgru_descricao (const Value : String) : iItem; overload;
    function ite_vei_id : integer; overload;
    function ite_vei_id (const Value : integer) : iItem; overload;
    function ite_vei_descricao : String; overload;
    function ite_vei_descricao (const Value : String) : iItem; overload;
    function ite_vei_fab_id : integer; overload;
    function ite_vei_fab_id (const Value : integer) : iItem; overload;
    function ite_vei_fab_nome : String; overload;
    function ite_vei_fab_nome (const Value : String) : iItem; overload;
    function ite_vano_ano_id : integer; overload;
    function ite_vano_ano_id (const Value : integer) : iItem; overload;
    function ite_vano_ano_descricao : String; overload;
    function ite_vano_ano_descricao (const Value : String) : iItem; overload;
    function ite_valor : Currency; overload;
    function ite_valor (const Value : Currency) : iItem; overload;
    function ite_situacao : String; overload;
    function ite_situacao (const Value : String) : iItem; overload;
    function ite_status : String; overload;
    function ite_status (const Value : String) : iItem; overload;
    function ite_loj_id : integer; overload;
    function ite_loj_id (const Value : integer) : iItem; overload;
    function ite_loj_nome : String; overload;
    function ite_loj_nome (const Value : String) : iItem; overload;
    function ite_tra_entrada : integer; overload;
    function ite_tra_entrada (const Value : integer) : iItem; overload;
    function ite_tra_dt_entrada : TDateTime; overload;
    function ite_tra_dt_entrada (const Value : TDateTime) : iItem; overload;
    function ite_tra_dt_entrada (const Value : String) : iItem; overload;
    function ite_tra_saida : integer; overload;
    function ite_tra_saida (const Value : integer) : iItem; overload;
    function ite_tra_dt_saida : TDateTime; overload;
    function ite_tra_dt_saida (const Value : TDateTime) : iItem; overload;
    function ite_tra_dt_saida (const Value : String) : iItem; overload;
    function ite_sit_reg : boolean; overload;
    function ite_sit_reg (const Value : boolean): iItem; overload;
    function ite_usu_id (const Value : integer): iItem; overload;
    constructor Create;
    function Cadastrar: TJSONObject;
    function Alterar: TJSONObject;
  public
    destructor Destroy; override;
    class function New : iItem;
  end;

implementation

uses UntFuncoes;


{ TItem }

function TItem.Alterar: TJSONObject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Item\item_update.sql');
    Reset(f);
    vSQL := '';
    While not Eof(f) do
    begin
      Readln(f, fLinha);
      vSQL := vSQL + ' '+fLinha;
    end;
    CloseFile(f);
    vQry := TQuery.Create;
    vQry.Query.Connection.StartTransaction;
    try
      Fite_tra_saida := GeraTransacao(Fite_usu_id);
      vQry.Query.SQL.Add(vSQL);
      vQry.Query.ParamByName('ite_descricao').AsString := Fite_descricao;
      vQry.Query.ParamByName('ite_sgvano_id').AsInteger := Fite_sgvano_id;
      vQry.Query.ParamByName('ite_valor').AsCurrency := Fite_valor;
      vQry.Query.ParamByName('ite_situacao').AsString := Fite_situacao;
      vQry.Query.ParamByName('ite_status').AsString := Fite_status;
      vQry.Query.ParamByName('ite_loj_id').AsInteger := Fite_loj_id;
      vQry.Query.ParamByName('ite_tra_saida').AsInteger := Fite_tra_saida;
      vQry.Query.ParamByName('ite_sit_reg').AsBoolean := Fite_sit_reg;
      vQry.Query.ParamByName('ite_id').AsInteger := Fite_id;
      vQry.Query.Open;
      vQry.Query.Connection.Commit;

      Result := vQry.Query.ToJSONObject;
    except
      on E : Exception do
      begin
        vQry.Query.Connection.Rollback;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    freeandnil(vQry);
  end;
end;

function TItem.Cadastrar: TJSONObject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Item\item_insert.sql');
    Reset(f);
    vSQL := '';
    While not Eof(f) do
    begin
      Readln(f, fLinha);
      vSQL := vSQL + ' '+fLinha;
    end;
    CloseFile(f);
    vQry := TQuery.Create;
    vQry.Query.Connection.StartTransaction;
    try
      Fite_tra_entrada := GeraTransacao(Fite_usu_id);
      vQry.Query.SQL.Add(vSQL);
      vQry.Query.ParamByName('ite_descricao').AsString := Fite_descricao;
      vQry.Query.ParamByName('ite_sgvano_id').AsInteger := Fite_sgvano_id;
      vQry.Query.ParamByName('ite_valor').AsCurrency := Fite_valor;
      vQry.Query.ParamByName('ite_situacao').AsString := Fite_situacao;
      vQry.Query.ParamByName('ite_loj_id').AsInteger := Fite_loj_id;
      vQry.Query.ParamByName('ite_tra_entrada').AsInteger := Fite_tra_entrada;
      vQry.Query.ParamByName('ite_status').AsString := Fite_status;
      vQry.Query.Open;
      Fite_id := vQry.Query.FieldByName('ite_id').AsInteger;
      vQry.Query.Connection.Commit;

      Result := vQry.Query.ToJSONObject;
    except
      on E : Exception do
      begin
        vQry.Query.Connection.Rollback;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    freeandnil(vQry);
  end;
end;

constructor TItem.Create;
begin
  Fite_status := 'Á venda';
end;

destructor TItem.Destroy;
begin

  inherited;
end;

function TItem.ite_descricao: String;
begin
  Result := Fite_descricao;
end;

function TItem.ite_descricao(const Value: String): iItem;
begin
   Result := Self;
   Fite_descricao := Value;
end;

function TItem.ite_gru_descricao(const Value: String): iItem;
begin
   Result := Self;
   Fite_gru_descricao := Value;
end;

function TItem.ite_gru_descricao: String;
begin
  Result := Fite_gru_descricao;
end;

function TItem.ite_gru_id(const Value: integer): iItem;
begin
   Result := Self;
   Fite_gru_id := Value;
end;

function TItem.ite_gru_id: integer;
begin
  Result := Fite_gru_id;
end;

function TItem.ite_id(const Value: integer): iItem;
begin
   Result := Self;
   Fite_id := Value;
end;

function TItem.ite_id: integer;
begin
  Result := Fite_id;
end;

function TItem.ite_loj_id(const Value: integer): iItem;
begin
   Result := Self;
   Fite_loj_id := Value;
end;

function TItem.ite_loj_id: integer;
begin
  Result := Fite_loj_id;
end;

function TItem.ite_loj_nome: String;
begin
  Result := Fite_loj_nome;
end;

function TItem.ite_loj_nome(const Value: String): iItem;
begin
   Result := Self;
   Fite_loj_nome := Value;
end;

function TItem.ite_pec_descricao(const Value: String): iItem;
begin
   Result := Self;
   Fite_pec_descricao := Value;
end;

function TItem.ite_pec_descricao: String;
begin
   Result := Fite_pec_descricao;
end;

function TItem.ite_pec_id(const Value: integer): iItem;
begin
   Result := Self;
   Fite_pec_id := Value;
end;

function TItem.ite_pec_id: integer;
begin
   Result := Fite_pec_id;
end;

function TItem.ite_sgru_descricao(const Value: String): iItem;
begin
   Result := Self;
   Fite_sgru_descricao := Value;
end;

function TItem.ite_sgru_descricao: String;
begin
   Result := Fite_sgru_descricao;
end;

function TItem.ite_sgru_id: integer;
begin
   Result := Fite_sgru_id;
end;

function TItem.ite_sgru_id(const Value: integer): iItem;
begin
   Result := Self;
   Fite_sgru_id := Value;
end;

function TItem.ite_sgvano_id(const Value: integer): iItem;
begin
   Result := Self;
   Fite_sgvano_id := Value;
end;

function TItem.ite_sgvano_id: integer;
begin
   Result := Fite_sgvano_id;
end;

function TItem.ite_situacao: String;
begin
   Result := Fite_situacao;
end;

function TItem.ite_situacao(const Value: String): iItem;
begin
   Result := Self;
   Fite_situacao := Value;
end;

function TItem.ite_sit_reg: boolean;
begin
   Result := Fite_sit_reg;
end;

function TItem.ite_sit_reg(const Value: boolean): iItem;
begin
   Result := Self;
   Fite_sit_reg := Value;
end;

function TItem.ite_status: String;
begin
   Result := Fite_status;
end;

function TItem.ite_status(const Value: String): iItem;
begin
   Result := Self;
   Fite_status := Value;
end;

function TItem.ite_tra_dt_entrada: TDateTime;
begin
   Result := Fite_tra_dt_entrada;
end;

function TItem.ite_tra_dt_entrada(const Value: TDateTime): iItem;
begin
   Result := Self;
   Fite_tra_dt_entrada := Value;
end;

function TItem.ite_tra_dt_entrada(const Value: String): iItem;
begin
   try
    Result := Self;
    Fite_tra_dt_entrada := JSONDateToDatetime(Value);
   except
   on E : Exception do
     begin
       raise Exception.Create('Verifique a data de entrada...');
     end;
   end;
end;

function TItem.ite_tra_dt_saida(const Value: TDateTime): iItem;
begin
   Result := Self;
   Fite_tra_dt_saida := Value;
end;

function TItem.ite_tra_dt_saida: TDateTime;
begin
   Result := Fite_tra_dt_saida;
end;

function TItem.ite_tra_dt_saida(const Value: String): iItem;
begin
   try
    Result := Self;
    Fite_tra_dt_saida := JSONDateToDatetime(Value);
   except
   on E : Exception do
     begin
       raise Exception.Create('Verifique a data de entrada...');
     end;
   end;
end;

function TItem.ite_tra_entrada: integer;
begin
   Result := Fite_tra_entrada;
end;

function TItem.ite_tra_entrada(const Value: integer): iItem;
begin
   Result := Self;
   Fite_tra_entrada := Value;
end;

function TItem.ite_tra_saida(const Value: integer): iItem;
begin
   Result := Self;
   Fite_tra_saida := Value;
end;

function TItem.ite_tra_saida: integer;
begin
   Result := Fite_tra_saida;
end;

function TItem.ite_usu_id(const Value: integer): iItem;
begin
   Result := Self;
   Fite_usu_id := Value;
end;

function TItem.ite_valor: Currency;
begin
   Result := Fite_valor;
end;

function TItem.ite_valor(const Value: Currency): iItem;
begin
   Result := Self;
   Fite_valor := Value;
end;

function TItem.ite_vano_ano_descricao: String;
begin
   Result := Fite_vano_ano_descricao;
end;

function TItem.ite_vano_ano_descricao(const Value: String): iItem;
begin
   Result := Self;
   Fite_vano_ano_descricao := Value;
end;

function TItem.ite_vano_ano_id: integer;
begin
   Result := Fite_vano_ano_id;
end;

function TItem.ite_vano_ano_id(const Value: integer): iItem;
begin
   Result := Self;
   Fite_vano_ano_id := Value;
end;

function TItem.ite_vei_descricao(const Value: String): iItem;
begin
   Result := Self;
   Fite_vei_descricao := Value;
end;

function TItem.ite_vei_descricao: String;
begin
   Result := Fite_vei_descricao;
end;

function TItem.ite_vei_fab_id(const Value: integer): iItem;
begin
   Result := Self;
   Fite_vei_fab_id := Value;
end;

function TItem.ite_vei_fab_id: integer;
begin
   Result := Fite_vei_fab_id;
end;

function TItem.ite_vei_fab_nome: String;
begin
   Result := Fite_vei_fab_nome;
end;

function TItem.ite_vei_fab_nome(const Value: String): iItem;
begin
   Result := Self;
   Fite_vei_fab_nome := Value;
end;

function TItem.ite_vei_id: integer;
begin
   Result := Fite_vei_id;
end;

function TItem.ite_vei_id(const Value: integer): iItem;
begin
   Result := Self;
   Fite_vei_id := Value;
end;

class function TItem.New: iItem;
begin
  Result := Self.Create;
end;

end.

