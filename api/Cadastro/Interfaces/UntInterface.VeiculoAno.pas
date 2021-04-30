unit UntInterface.VeiculoAno;

interface

uses
  System.JSON;

type
  iVeiculoAno = interface
    ['{E1F2B507-97A0-44A6-800D-5D4CE3F61414}']
    function vano_id : integer; overload;
    function vano_id (const Value : integer): iVeiculoAno; overload;
    function vano_vei_id : integer; overload;
    function vano_vei_id (const Value : integer): iVeiculoAno; overload;
    function vano_ano_id : integer; overload;
    function vano_ano_id (const Value : integer): iVeiculoAno; overload;
    function Cadastrar: TJSONObject;
  end;

implementation

end.
