program Project1;

{$MODE Delphi}

uses
  {$ifdef UseCmem}
  cmem,
  {$endif}
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}      
 
  Forms, Interfaces,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Frame2: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
