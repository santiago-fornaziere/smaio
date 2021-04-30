unit UntInterface.Fabricante;

interface

uses
  System.JSON;

type
  iFabricante = interface
    ['{1650ABEB-D616-4792-B666-D35200460080}']
    function fab_id : integer; overload;
    function fab_id (const Value : integer): iFabricante; overload;
    function fab_nome : String; overload;
    function fab_nome (const Value : String) : iFabricante; overload;
    function Cadastrar: TJSONObject;
    function Alterar: TJSONObject;
  end;

implementation

end.
