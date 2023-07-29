unit ComunicacaoAPI;

interface

uses REST.Json,
     REST.Client,
     StrUtils,
     System.JSON,
     System.JSON.Readers,
     REST.Types,
     REST.Authenticator.Basic,
     System.SysUtils,
     system.Classes;

type TUtilREST = class
  public
    class function restRequestVazio(pURLBase, pAuthToken: String; pContentType: String = 'application/json'): TRESTRequest;
    class function converteObjetoJsonString(pObjeto: TObject): String;
end;

type TComunicacaoAPI = Class(TObject)
  private
  public
    procedure request(
      pURL, pAuthToken: String; Objeto: TObject; out pSucesso: Boolean;
      out pJsonEnviado, pJsonRecebido, pMensagemErro: String;
      pMetodo: TRESTRequestMethod; pBearer: Boolean);
end;

implementation

{ TComunicacaoAPI }

procedure TComunicacaoAPI.request(pURL, pAuthToken: String; Objeto: TObject;
  out pSucesso: Boolean; out pJsonEnviado, pJsonRecebido, pMensagemErro: String;
  pMetodo: TRESTRequestMethod; pBearer: Boolean);
var
Request: TUtilREST;
vBody: String;
begin
  Request := TUtilREST.Create;
  try
    with (Request.restRequestVazio(pURL, ifthen(pBearer = True, 'Bearer ' + pAuthToken,pAuthToken))) do
      begin
        Method := pMetodo;
        if Objeto <> nil then
          begin
            vBody := Request.converteObjetoJsonString(Objeto);
            vBody := ReplaceStr(vBody, '\\n', '\n');
            Body.Add(
              vBody,
              TRESTContentType.ctAPPLICATION_JSON
            );
          end;

        try
          Execute();
        except
        end;

        case Response.StatusCode of
          200, 201, 202:
            begin
                begin
                  pSucesso := True;
                  try
                    pJsonRecebido := Response.Content;
                  except
                    on e:exception do
                      begin
                        if pJsonRecebido = '' then
                          pJsonRecebido := Response.Content
                      end;

                  end;

                  try
                    pJsonEnviado := vBody;
                  except
                    on e:exception do
                      begin
                        if pJsonEnviado = '' then
                          pJsonEnviado := vBody
                      end;

                  end;
                end;
            end
          else
            begin
              pSucesso := False;

              try
                pJsonRecebido := Response.Content;
              except
                on e:exception do
                  begin
                    if pJSonRecebido = '' then
                      pJsonRecebido := Response.Content;
                  end;
              end;

              pJsonEnviado := vBody;
              pMensagemErro := 'Falha ao enviar, status code: '+IntToStr(Response.StatusCode)+
                       ' JSON Recebido: '+Response.Content+''+
                       ' JSON Enviado: '+vBody+'';
            end;
        end;

        Response.Free;
        Client.Free;
        Free;
      end;
  finally
    Request.Free;
  end;
end;

{ TUtilREST }

class function TUtilREST.converteObjetoJsonString(pObjeto: TObject): String;
begin
  Result := TJson.ObjectToJsonString(pObjeto,[joIgnoreEmptyStrings, joIgnoreEmptyArrays]);
end;

class function TUtilREST.restRequestVazio(pURLBase, pAuthToken,
  pContentType: String): TRESTRequest;
begin
  Result := TRESTRequest.Create(nil);
  with (Result) do
    begin
      Client := TRESTClient.Create(Result);
      Client.BaseURL := pURLBase;
      Client.AutoCreateParams := True;
      AutoCreateParams := True;
      Response := TRESTResponse.Create(Result);
      if pContentType <> 'multipart/form-data; boundary=1' then
        begin
          Client.ContentType := pContentType;
          if pAuthToken <> '' then
            begin
              Params.AddHeader('Authorization',pAuthToken);
              Params.ParameterByIndex(0).Options := [poDoNotEncode];
            end;
        end;
    end;
end;

end.
