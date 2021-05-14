unit UntInterface.Item;

interface

uses
  System.JSON;

type
  iItem = interface
    ['{4659B3B7-C928-4F5F-809A-FF116D9C1333}']
    function ite_id : integer; overload;
    function ite_id (const Value : integer): iItem; overload;
    function ite_descricao : String; overload;
    function ite_descricao (const Value : String) : iItem; overload;
    function ite_sgvano_id : integer; overload;
    function ite_sgvano_id (const Value : integer) : iItem; overload;
    function ite_gru_id : integer; overload;
    function ite_gru_id (const Value : integer) : iItem; overload;
    function ite_gru_descricao : String; overload;
    function ite_gru_descricao (const Value : String) : iItem; overload;
    function ite_pec_id : integer; overload;
    function ite_pec_id (const Value : integer) : iItem; overload;
    function ite_pec_descricao : String; overload;
    function ite_pec_descricao (const Value : String) : iItem; overload;
    function ite_sgru_id : integer; overload;
    function ite_sgru_id (const Value : integer) : iItem; overload;
    function ite_sgru_descricao : String; overload;
    function ite_sgru_descricao (const Value : String) : iItem; overload;
    function ite_vei_id : integer; overload;
    function ite_vei_id (const Value : integer) : iItem; overload;
    function ite_vei_descricao : String; overload;
    function ite_vei_descricao (const Value : String) : iItem; overload;
    function ite_vei_fab_id : integer; overload;
    function ite_vei_fab_id (const Value : integer) : iItem; overload;
    function ite_vei_fab_nome : String; overload;
    function ite_vei_fab_nome (const Value : String) : iItem; overload;
    function ite_vano_ano_id : integer; overload;
    function ite_vano_ano_id (const Value : integer) : iItem; overload;
    function ite_vano_ano_descricao : String; overload;
    function ite_vano_ano_descricao (const Value : String) : iItem; overload;
    function ite_valor : Currency; overload;
    function ite_valor (const Value : Currency) : iItem; overload;
    function ite_situacao : String; overload;
    function ite_situacao (const Value : String) : iItem; overload;
    function ite_status : String; overload;
    function ite_status (const Value : String) : iItem; overload;
    function ite_loj_id : integer; overload;
    function ite_loj_id (const Value : integer) : iItem; overload;
    function ite_loj_nome : String; overload;
    function ite_loj_nome (const Value : String) : iItem; overload;
    function ite_tra_entrada : integer; overload;
    function ite_tra_entrada (const Value : integer) : iItem; overload;
    function ite_tra_dt_entrada : TDateTime; overload;
    function ite_tra_dt_entrada (const Value : TDateTime) : iItem; overload;
    function ite_tra_dt_entrada (const Value : String) : iItem; overload;
    function ite_tra_saida : integer; overload;
    function ite_tra_saida (const Value : integer) : iItem; overload;
    function ite_tra_dt_saida : TDateTime; overload;
    function ite_tra_dt_saida (const Value : TDateTime) : iItem; overload;
    function ite_tra_dt_saida (const Value : String) : iItem; overload;
    function ite_sit_reg : boolean; overload;
    function ite_sit_reg (const Value : boolean): iItem; overload;
    function ite_usu_id (const Value : integer): iItem; overload;
    function Alterar: TJSONObject;
    function Cadastrar: TJSONObject;
  end;

implementation

end.