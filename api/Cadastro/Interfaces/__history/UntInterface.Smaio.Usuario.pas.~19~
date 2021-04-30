unit UntInterface.Usuario;

interface

uses
  System.Generics.Collections, System.JSON;
type
  TyNivel = (niLoja, niSmaio);

  iUsuario = interface
    ['{BD7E1B25-9D86-40CB-A3F8-C0445AF30E3A}']
    function usu_id : integer; overload;
    function usu_id (const Value : integer) : iUsuario; overload;
    function usu_id (const Value : String) : iUsuario; overload;
    function usu_nome : String; overload;
    function usu_nome (const Value : String) : iUsuario; overload;
    function usu_email : String; overload;
    function usu_email (const Value : String) : iUsuario; overload;
    function usu_telefone : String; overload;
    function usu_telefone (const Value : String) : iUsuario; overload;
    function usu_senha : String; overload;
    function usu_senha (const Value : String = '') : iUsuario; overload;
    function usu_dt_ativacao : TDateTime; overload;
    function usu_dt_ativacao (const Value : TDateTime) : iUsuario; overload;
    function usu_dt_ativacao (const Value : String) : iUsuario; overload;
    function usu_dt_lancamento : TDateTime; overload;
    function usu_dt_lancamento (const Value : TDateTime) : iUsuario; overload;
    function usu_dt_lancamento (const Value : String) : iUsuario; overload;
    function usu_dt_validade : TDateTime; overload;
    function usu_dt_validade (const Value : TDateTime) : iUsuario; overload;
    function usu_dt_validade (const Value : String) : iUsuario; overload;
    function usu_nivel : TyNivel; overload;
    function usu_nivel (const Value : TyNivel) : iUsuario; overload;
    function usu_nivel (const Value : String) : iUsuario; overload;
    function usu_sit_reg : Boolean; overload;
    function usu_sit_reg (const Value : Boolean) : iUsuario; overload;
    function usu_loj_id : TList<integer>; overload;
    function usu_loj_id (const Value : TJSONArray) : iUsuario; overload;
    function Cadastrar: TJSONObject;
    function Alterar: TJSONObject;

  end;

implementation

end.
