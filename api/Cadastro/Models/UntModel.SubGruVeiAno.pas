unit UntModel.SubGruVeiAno;

interface

type
  TSubGrupoVeiculoAno = class
  public
    sgvano_id : integer;
    sgvano_sgru_id : integer;
    sgvano_vano_id : integer;
    constructor Create;
    destructor Destroy; override;
  end;

implementation


{ TVeiculoAno }

constructor TSubGrupoVeiculoAno.Create;
begin

end;

destructor TSubGrupoVeiculoAno.Destroy;
begin

  inherited;
end;

end.
