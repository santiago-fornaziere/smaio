unit UntInterface.SubGruVeiAno;

interface

uses
  System.JSON;

type
  iSubgrupoVeiculoAno = interface
    ['{CFF786FF-2F04-4A6A-98AB-EBBAB11ACA86}']
    function sgvano_id : integer; overload;
    function sgvano_id (const Value : integer): iSubgrupoVeiculoAno; overload;
    function sgvano_sgru_id : integer; overload;
    function sgvano_sgru_id (const Value : integer): iSubgrupoVeiculoAno; overload;
    function sgvano_vano_id : integer; overload;
    function sgvano_vano_id (const Value : integer): iSubgrupoVeiculoAno; overload;
    function Cadastrar: TJSONObject;
  end;

implementation

end.
