unit UntModel.Safra;

interface

uses
  UntConst;

type
  TSafra = class
    private
      FId: integer;
      FNome: String;
      FDtInicioPlantio: TDate;
      FDtFimColheita: TDate;
      FDtInicioColheita: TDate;
      FSitReg: integer;
      procedure SetId(const Value: integer);
      procedure SetNome(const Value: String);
      procedure SetDtInicioPlantio(const Value: TDate);
      procedure SetDtFimColheita(const Value: TDate);
      procedure SetDtInicioColheita(const Value: TDate);
      procedure SetSitReg(const Value: integer);
    public
      constructor Create;
      destructor Destroy; override;
      property safID : integer read FId write SetId;
      property safDescricao : String read FNome write SetNome;
      property safDtInicPlantio : TDate read FDtInicioPlantio write SetDtInicioPlantio;
      property safDtInicColheita : TDate read FDtInicioColheita write SetDtInicioColheita;
      property safDtFinalColheita : TDate read FDtFimColheita write SetDtFimColheita;
      property safSitRegId : integer read FSitReg write SetSitReg;

  end;

implementation


{ TSafra }

constructor TSafra.Create;
begin
  self.FSitReg := ConstSitRegAtivo;
end;

destructor TSafra.Destroy;
begin

  inherited;
end;

procedure TSafra.SetDtFimColheita(const Value: TDate);
begin
  FDtFimColheita := Value;
end;

procedure TSafra.SetDtInicioColheita(const Value: TDate);
begin
  FDtInicioColheita := Value;
end;

procedure TSafra.SetDtInicioPlantio(const Value: TDate);
begin
  FDtInicioPlantio := Value;
end;

procedure TSafra.SetId(const Value: integer);
begin
  FId := Value;
end;

procedure TSafra.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TSafra.SetSitReg(const Value: integer);
begin
  FSitReg := Value;
end;

end.
