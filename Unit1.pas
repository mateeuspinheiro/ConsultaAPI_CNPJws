unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope;

type
  TfrmPrincipal = class(TForm)
    Button1: TButton;
    edtCNPJ: TEdit;
    lblCNPJ: TLabel;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    memo1: TMemo;
    IE: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.Button1Click(Sender: TObject);
begin

      memo1.Clear;

      RESTClient1.BaseURL := 'https://publica.cnpj.ws/cnpj/' + edtCNPJ.Text;
      RESTRequest1.Execute;
      memo1.Lines.Add(RESTRequest1.Response.JSONText);



end;

end.
