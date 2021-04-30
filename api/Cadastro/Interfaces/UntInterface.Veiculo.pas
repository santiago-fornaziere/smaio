unit UntInterface.Veiculo;

interface

uses
  System.JSON;

type
  iVeiculo = interface
    ['{D580A4E9-F7B6-4F6C-869D-788D55D78F1F}']
    function vei_id : integer; overload;
    function vei_id (const Value : integer): iVeiculo; overload;
    function vei_descricao : String; overload;
    function vei_descricao (const Value : String) : iVeiculo; overload;
    function vei_fab_id : integer; overload;
    function vei_fab_id (const Value : integer): iVeiculo; overload;
    function vei_sit_reg : boolean; overload;
    function vei_sit_reg (const Value : boolean): iVeiculo; overload;
    function Cadastrar: TJSONObject;
    function Alterar: TJSONObject;
  end;

implementation

end.
