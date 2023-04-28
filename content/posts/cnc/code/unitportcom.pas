unit UnitPortCOM;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process, Forms, Controls, Graphics, Dialogs, StdCtrls,
  LazSerial, Serial;

type

  { TForm1 }

  TForm1 = class(TForm)
    BTNconnect: TButton;
    BTNrefresh: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CbPort: TComboBox;
    Label1: TLabel;
    LabelportCOM: TLabel;
    LabelportCOM1: TLabel;
    LabelportCOM2: TLabel;
    Memo1: TMemo;
    PortCOM1: TLabel;
    LazCom: TLazSerial;
    PortCOM2: TLabel;
    Process1: TProcess;
    procedure BTNconnectClick(Sender: TObject);
    procedure BTNrefreshClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CbPortChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LazComRxData(Sender: TObject);
    procedure PortCOM1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.PortCOM1Click(Sender: TObject);
begin

end;

procedure TForm1.BTNrefreshClick(Sender: TObject);
begin
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Memo1.clear;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  GServerStream: TStream;
begin
  Lazcom.WriteData('coucou');
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Result : Integer;
  s:ansistring;

begin
    //Result := ShellExecute(0, nil, 'start', '.\nircmd.exe changesysvolume 0', nil, SW_SHOWNORMAL);
    //RunCommand('.\nircmd.exe changesysvolume 0',s);
    //ShellExecute(Handle,'cmd',PChar('C:\nircmd-x64\nircmd.exe changesysvolume 0'),nil,nil,5);
    //sizeof(MyWaveOutCaps)=MMSYSERR_NOERROR then

    process1.Execute;
end;

procedure TForm1.BTNconnectClick(Sender: TObject);
begin
  lazcom.Device:='/dev/ttyACM0';
  if LazCom.active then
  begin
      LazCom.close;
      BTNconnect.caption:= 'Connecter';
      PortCOM1.caption:='Déconnecté';
  end else
  begin
  Lazcom.Open;
  BTNconnect.caption:= 'Connecter';
  PortCOM1.caption:='Connecté';
  end;
end;

procedure TForm1.CbPortChange(Sender: TObject);
var StrX : String;
    S, E : Integer;
begin
StrX  := CbPort.Text;
S     := AnsiPos ('COM', StrX);
E     := AnsiPos (')' , StrX) ;
if S<>0 then LazCom.Device :=Copy (StrX, S, E-S)
else LazCom. Device :='No Port';
PortCOM2.Caption := LazCom.Device;
end;

procedure TForm1.FormCreate(Sender: TObject);

begin
      BTNrefreshClick(sender);
end;

procedure TForm1.LazComRxData(Sender: TObject);
var
    Temp : String;
     Proc: TProcess;
    Temp2: string;
begin
   if LazCom.DataAvailable then
   begin
       Temp :=  LazCom.ReadData ;
       Memo1.text := Memo1.text+Temp;
       Memo1.Lines.Add('');
       //Label1.caption:=Temp;

   end;
end;

end.

