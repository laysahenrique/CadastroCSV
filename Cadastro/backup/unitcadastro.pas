unit unitCadastro;

{$mode objfpc}{$H+}

interface

uses
Classes, SysUtils, SQLDB, DB, csvdataset, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, ComCtrls, DBGrids, StdCtrls, DBCtrls, Buttons, Types;

type

  { TFormCadastro }

  TFormCadastro = class(TForm)
    ButtonAlterar: TButton;
    ButtonCancelar: TButton;
    ButtonExcluir: TButton;
    ButtonInserir: TButton;
    ButtonSalvar: TButton;
    CSVDataset1: TCSVDataset;
    CSVDataset1Bairro: TStringField;
    CSVDataset1Email: TStringField;
    CSVDataset1Id: TLongintField;
    CSVDataset1Nome: TStringField;
    CSVDataset1Numero: TStringField;
    CSVDataset1Rua: TStringField;
    CSVDataset1Telefone: TLongintField;
    DataSource1: TDataSource;
    DBEditBairro: TDBEdit;
    DBEditEmail: TDBEdit;
    DBEditId: TDBEdit;
    DBEditName: TDBEdit;
    DBEditNumero: TDBEdit;
    DBEditRua: TDBEdit;
    DBEditTelefone: TDBEdit;
    DBGrid1: TDBGrid;
    PageControlFormulario: TPageControl;
    Panel1: TPanel;
    StaticTextBairro: TStaticText;
    StaticTextEmail: TStaticText;
    StaticTextId: TStaticText;
    StaticTextNome: TStaticText;
    StaticTextNumero: TStaticText;
    StaticTextRua: TStaticText;
    StaticTextTelefone: TStaticText;
    TabSheetCadastrados: TTabSheet;
    TabSheetCadastrar: TTabSheet;
    procedure ButtonAlterarClick(Sender: TObject);
    procedure ButtonCancelarClick(Sender: TObject);
    procedure ButtonExcluirClick(Sender: TObject);
    procedure ButtonInserirClick(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private

  public

  end;

var
  FormCadastro: TFormCadastro;
  ArquivoCSV: TextFile;
  Contador, I: Integer;
  Linha: String;
  escrita, leitura : TstringList;

implementation

{$R *.lfm}

{ TFormCadastro }

procedure TFormCadastro.FormCreate(Sender: TObject);
var
   escrita, leitura : TstringList;
   i: integer;
begin
   CSVDataset1.CreateDataset;
   escrita := TstringList.Create;
   leitura := TstringList.Create;

   leitura.LoadFromFile('D:\Cadastro\tabelacadastro.csv');

   escrita.Delimiter:= ',';
   escrita.StrictDelimiter:= true;

   for i := 0 to Pred(leitura.Count) do
     begin
       escrita.DelimitedText:= leitura.Strings[i];
       CSVDataset1.Append;
       CSVDataset1.FieldByName('Id').AsAnsiString:= escrita.Strings[1];
       CSVDataset1.FieldByName('Nome').AsAnsiString:= escrita.Strings[0];
       CSVDataset1.FieldByName('Email').AsAnsiString:= escrita.Strings[2];
       CSVDataset1.FieldByName('Telefone').AsAnsiString:= escrita.Strings[3];
       CSVDataset1.FieldByName('Rua').AsAnsiString:= escrita.Strings[4];
       CSVDataset1.FieldByName('Bairro').AsAnsiString:= escrita.Strings[5];
       CSVDataset1.FieldByName('Numero').AsAnsiString:= escrita.Strings[6];
       CSVDataset1.Post;
     end;
end;

procedure TFormCadastro.ButtonSalvarClick(Sender: TObject);
begin

  if DBEditId.Text = '' then
       ShowMessage('ID esta vazio.')
  else
  begin
     CSVDataset1.Post;
     CSVDataset1.SaveToCSVFile('D:\Cadastro\tabelacadastro.csv');
     PageControlFormulario.ActivePage:= TabSheetCadastrados;
  end;
end;

procedure TFormCadastro.ButtonAlterarClick(Sender: TObject);
begin
  CSVDataset1.Edit;
  PageControlFormulario.ActivePage:= TabSheetCadastrar;
end;


procedure TFormCadastro.ButtonCancelarClick(Sender: TObject);
begin
  CSVDataset1.Cancel;
  CSVDataset1.SaveToCSVFile('D:\Cadastro\tabelacadastro.csv');
  PageControlFormulario.ActivePage:= TabSheetCadastrados;
end;

procedure TFormCadastro.ButtonExcluirClick(Sender: TObject);
begin
  CSVDataset1.Delete;
  CSVDataset1.SaveToCSVFile('D:\Cadastro\tabelacadastro.csv');
end;

procedure TFormCadastro.ButtonInserirClick(Sender: TObject);
begin
  CSVDataset1.Append;
  PageControlFormulario.ActivePage:= TabSheetCadastrar;
end;


end.



