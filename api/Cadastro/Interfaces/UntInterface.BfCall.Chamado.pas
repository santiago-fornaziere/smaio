unit UntInterface.BfCall.Chamado;

interface

type
  iChamado = interface
    ['{ABE1AA5E-59D0-47CF-A4C6-028751EF971B}']
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
  end;

implementation

end.
