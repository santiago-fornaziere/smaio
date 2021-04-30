unit UntInterface.Loja;

interface

uses
  System.JSON;

type
  TyStatus = (stAtivo, stInativo, stSuspenso);


  iLoja = interface
    ['{98AF9366-83C9-4EC3-AFEB-A62AC54D038E}']
    function loj_id : integer; overload;
    function loj_id (const Value : integer): iLoja; overload;
    function loj_nome : String; overload;
    function loj_nome (const Value : String) : iLoja; overload;
    function loj_ativacao : TDatetime; overload;
    function loj_ativacao (const Value : TDatetime) : iLoja; overload;
    function loj_ativacao (const Value : String) : iLoja; overload;
    function loj_dt_validade : TDatetime; overload;
    function loj_dt_validade (const Value : TDatetime) : iLoja; overload;
    function loj_dt_validade (const Value : String) : iLoja; overload;
    function loj_cnpj : String; overload;
    function loj_cnpj (const Value : String) : iLoja; overload;
    function loj_email : String; overload;
    function loj_email (const Value : String) : iLoja; overload;
    function loj_telefone_1 : String; overload;
    function loj_telefone_1 (const Value : String) : iLoja; overload;
    function loj_telefone_2 : String; overload;
    function loj_telefone_2 (const Value : String) : iLoja; overload;
    function loj_cep : String; overload;
    function loj_cep (const Value : String) : iLoja; overload;
    function loj_logradouro : String; overload;
    function loj_logradouro (const Value : String) : iLoja; overload;
    function loj_numero : String; overload;
    function loj_numero (const Value : String) : iLoja; overload;
    function loj_bairro : String; overload;
    function loj_bairro (const Value : String) : iLoja; overload;
    function loj_cid_id : integer; overload;
    function loj_cid_id (const Value : integer): iLoja; overload;
    function loj_status : TyStatus; overload;
    function loj_status (const Value : String): iLoja; overload;
    function loj_status (const Value : TyStatus): iLoja; overload;
    function loj_latitude : String; overload;
    function loj_latitude (const Value : String): iLoja; overload;
    function loj_longitude : String; overload;
    function loj_longitude (const Value : String): iLoja; overload;
    function loj_tra_id : integer; overload;
    function loj_tra_id (const Value : integer): iLoja; overload;
    function loj_sit_reg : Boolean; overload;
    function loj_sit_reg (const Value : Boolean): iLoja; overload;
    function loj_usu_id (const Value : integer): iLoja; overload;
    function Cadastrar: TJSONObject;
    function Alterar: TJSONObject;
  end;

implementation

end.
