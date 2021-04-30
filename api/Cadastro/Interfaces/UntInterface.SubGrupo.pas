unit UntInterface.SubGrupo;

interface

uses
  System.JSON;


type
  iSubGrupo = interface
    function sgru_id : integer; overload;
    function sgru_id (const Value : integer): iSubGrupo; overload;
    function sgru_descricao : String; overload;
    function sgru_descricao (const Value : String): iSubGrupo; overload;
    function sgru_pec_id : integer; overload;
    function sgru_pec_id (const Value : integer): iSubGrupo; overload;
    function sgru_sit_reg : boolean; overload;
    function sgru_sit_reg (const Value : boolean): iSubGrupo; overload;
    function Alterar: TJSONObject;
  end;

implementation

end.
