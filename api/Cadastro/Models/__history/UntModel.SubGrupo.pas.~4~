unit UntModel.SubGrupo;

interface

uses
  UntModel.SubGruVeiAno,
  System.Generics.Collections,
  System.JSON;

type
  TSubGrupo = class
  public
    sgru_id : integer;
    sgru_descricao : String;
    sgru_pec_id : integer;
    sgru_tra_id : integer;
    sgru_sit_reg : boolean;
    sgru_vanos : TList<TSubGrupoVeiculoAno>;
    constructor Create;
    procedure AddVeiculoAno(const Value : TSubGrupoVeiculoAno);
    destructor Destroy; override;
  end;
implementation

{ TSubGrupo }

procedure TSubGrupo.AddVeiculoAno(const Value: TSubGrupoVeiculoAno);
begin
  sgru_vanos.Add(Value);
end;

constructor TSubGrupo.Create;
begin
  sgru_vanos := TList<TSubGrupoVeiculoAno>.Create;
  sgru_sit_reg := true;
end;

destructor TSubGrupo.Destroy;
begin
  sgru_vanos.Free;
  inherited;
end;

end.
