object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'CONSULTA CNPJ + IE'
  ClientHeight = 477
  ClientWidth = 496
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblCNPJ: TLabel
    Left = 16
    Top = 31
    Width = 103
    Height = 19
    Caption = 'Digite o CNPJ:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 168
    Top = 54
    Width = 75
    Height = 25
    Caption = 'Consultar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object edtCNPJ: TEdit
    Left = 16
    Top = 56
    Width = 146
    Height = 21
    TabOrder = 1
    TextHint = '00.000.000/0000-00'
  end
  object memo1: TMemo
    Left = 16
    Top = 112
    Width = 361
    Height = 233
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object IE: TEdit
    Left = 416
    Top = 152
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object RESTClient1: TRESTClient
    BaseURL = 'https://publica.cnpj.ws/cnpj'
    Params = <>
    Left = 24
    Top = 424
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 176
    Top = 424
  end
  object RESTResponse1: TRESTResponse
    Left = 96
    Top = 424
  end
end
