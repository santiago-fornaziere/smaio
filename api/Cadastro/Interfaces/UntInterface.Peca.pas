unit UntInterface.Peca;

interface

uses
  UntModel.Subgrupo,
  System.JSON,
  System.Generics.Collections;

type
  iPeca = interface
    ['{3AAA3242-3B2B-4202-A650-ECC9FD36A90E}']
    function pec_id : integer; overload;
    function pec_id (const Value : integer): iPeca; overload;
    function pec_descricao : String; overload;
    function pec_descricao (const Value : String): iPeca; overload;
    function pec_gru_id : integer; overload;
    function pec_gru_id (const Value : integer): iPeca; overload;
    function pec_tra_id : integer; overload;
    function pec_tra_id (const Value : integer): iPeca; overload;
    function pec_sit_reg : boolean; overload;
    function pec_sit_reg (const Value : boolean): iPeca; overload;
    function pec_sgrus : TList<TSubGrupo>; overload;
    function pec_sgrus (const Value : TList<TSubGrupo>): iPeca; overload;
    function AddSubGrupos(const Value : TSubGrupo) : iPeca;
    function Cadastrar: TJSONObject;
    function Alterar: TJSONObject;
  end;

implementation

end.
