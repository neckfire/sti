unit Unit2;

interface

uses 
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, TypInfo, Clipbrd, ComCtrls, LCLIntf;

type

  { TFrame2 }
  TFrame2 = class(TFrame)
    center: TButton;
    zedit: TEdit;
    Z: TLabel;
    Shape2: TShape;
    Yoriginlabel: TLabel;
    Xoriginlabel: TLabel;
    xorigin: TEdit;
    yorigin: TEdit;
    GroupBox3: TGroupBox;
    Image1: TImage;
    loadfile: TButton;
    save: TButton;
    del: TButton;
    ok: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Shape1: TShape;
    Edit1: TEdit;
    Edit2: TEdit;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    trou1: TPanel;
    trou2: TPanel;
    X: TLabel;
    xtrou1: TEdit;
    xtroufin1: TEdit;
    Y: TLabel;
    new: TButton;
    xtrou: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ytrou: TEdit;
    xtroufin: TEdit;
    ytrou1: TEdit;
    ytroufin: TEdit;
    ytroufin1: TEdit;
    ztrou: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ztrou1: TEdit;
    procedure centerClick(Sender: TObject);
    procedure delClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure validate(Sender: TObject);
    procedure xbar(Sender: TObject);
    procedure xoriginchange(Sender: TObject);
    procedure ybar(Sender: TObject);
    procedure ychange(Sender: TObject);
    procedure xchange(Sender: TObject);
    procedure trou(Sender: TObject);
    procedure savefile(Sender: TObject);
    procedure readfile(sender: TObject);
    procedure yoriginchange(Sender: TObject);

  private
    { Déclarations privées }
  public
    { Déclarations publiques }

  end;


implementation

{$R *.dfm}

procedure TFrame2.ychange(Sender: TObject);
begin
        if(Edit2.Text='') then
        begin
            Edit2.Text:=inttostr(0);
        end;
        if(strtoint(Edit2.Text)>150) then
        begin
            Edit2.Text:=inttostr(150);
        end;
        Shape1.Height:= strtoint(Edit2.Text)*2;
        validate(Sender);

end;

procedure TFrame2.validate(Sender: TObject);
begin
   if(xtrou.Enabled=true) then
   begin
     while(strtoint(xtroufin.Text)+strtoint(xtrou.Text)>shape1.Width div 2)do
     begin
          xtroufin.Text:=inttostr(strtoint(xtroufin.Text)-1);
          while(strtoint(xtrou.Text)>shape1.Width div 2)do
          begin
               xtrou.Text:=inttostr(strtoint(xtrou.Text)-1);
          end;
     end;
     while(strtoint(ytroufin.Text)+strtoint(ytrou.Text)>shape1.height div 2)do
     begin
          ytroufin.Text:=inttostr(strtoint(ytroufin.Text)-1);
          while(strtoint(ytrou.Text)>shape1.height div 2)do
          begin
               ytrou.Text:=inttostr(strtoint(ytrou.Text)-1);
          end;
     end;
     trou1.top:=shape1.Top + strtoint(ytrou.Text) * 2;
     trou1.left:=shape1.left + strtoint(xtrou.Text) * 2;
     trou1.height:=strtoint(ytroufin.Text) * 2;
     trou1.width:=strtoint(xtroufin.Text) * 2;
     trou1.caption:=ztrou.text;
   end;
   if(xtrou1.Enabled=true) then
   begin
       while(strtoint(xtroufin1.Text)+strtoint(xtrou1.Text)>shape1.Width div 2)do
       begin
                xtroufin1.Text:=inttostr(strtoint(xtroufin1.Text)-1);
                while(strtoint(xtrou1.Text)>shape1.Width div 2)do
                begin
                      xtrou1.Text:=inttostr(strtoint(xtrou1.Text)-1);
                end;
       end;
       while(strtoint(ytroufin1.Text)+strtoint(ytrou1.Text)>shape1.height div 2)do
       begin
                ytroufin.Text:=inttostr(strtoint(ytroufin1.Text)-1);
                while(strtoint(ytrou1.Text)>shape1.height div 2)do
                begin
                      ytrou1.Text:=inttostr(strtoint(ytrou1.Text)-1);
                end;
       end;
           trou2.top:=shape1.Top + strtoint(ytrou1.Text) * 2;
           trou2.left:=shape1.left + strtoint(xtrou1.Text) * 2;
           trou2.height:=strtoint(ytroufin1.Text) * 2;
           trou2.width:=strtoint(xtroufin1.Text) * 2;
           trou2.caption:=ztrou1.text;
     end;
end;

procedure TFrame2.xbar(Sender: TObject);
begin
  edit1.Text:=inttostr(Trackbar1.Position - strtoint(xorigin.Text));
end;

procedure TFrame2.xoriginchange(Sender: TObject);
begin
  if(xorigin.Text='') then
        begin
            xorigin.Text:=inttostr(0);
        end;
        if(strtoint(xorigin.Text)>250) then
        begin
            xorigin.Text:=inttostr(250);
        end;
  Trackbar1.Min:=strtoint(Xorigin.Text);
  shape1.Left:=240 + strtoint(Xorigin.Text)*2;
  Trackbar1.left:=230 + strtoint(Xorigin.Text)*2;
  Trackbar1.Width:=560 - strtoint(Xorigin.Text)*2;
  xbar(sender);
end;

procedure TFrame2.ybar(Sender: TObject);
begin
   edit2.Text:=inttostr(Trackbar2.Position - strtoint(yorigin.Text));
end;

procedure TFrame2.delClick(Sender: TObject);
begin
     if(new.top=110)then
     begin
           xtrou1.Top:=xtrou1.top-30;
           ytrou1.Top:=ytrou1.top-30;
           xtroufin1.Top:=xtroufin1.top-30;
           ytroufin1.Top:=ytroufin1.top-30;
           ztrou1.Top:=ztrou1.top-30;
           trou2.Visible:=false;

           xtrou1.Enabled:=false;
           ytrou1.enabled:=false;
           xtroufin1.Enabled:=false;
           ytroufin1.enabled:=false;
           ztrou1.Enabled:=false;

           new.enabled:=true;
           new.Top:= new.Top-30;
           ok.Top:=ok.Top-30;
           del.Top:=del.top-30;
     end
     else
     begin
        xtrou.Enabled:=false;
        ytrou.enabled:=false;
        xtroufin.Enabled:=false;
        ytroufin.enabled:=false;
        ztrou.Enabled:=false;
        trou1.Visible:=false;
        ok.enabled:=false;
        del.enabled:=false;
     end;

end;

procedure TFrame2.centerClick(Sender: TObject);
begin
  xorigin.Text:=inttostr(135 div 2);
  yorigin.Text:=inttostr(75 div 2);
  trackbar1.Position:=135 + 135 div 2;
  trackbar2.position:=75 + 75 div 2;
end;

procedure TFrame2.Image1Click(Sender: TObject);
begin
  OpenURL('https://stistlouis.netlify.app');
end;

procedure TFrame2.xchange(Sender: TObject);
begin
        if(Edit1.Text='') then
        begin
            Edit1.Text:=inttostr(0);
        end;
        if(strtoint(Edit1.Text)>270) then
        begin
            Edit1.Text:=inttostr(270);
        end;
        Shape1.width:= strtoint(Edit1.Text)*2;
        validate(Sender);
end;

procedure TFrame2.trou(Sender: TObject);
begin
      if(xtrou.enabled=false) then
      begin
        xtrou.Enabled:=true;
        ytrou.enabled:=true;
        xtroufin.Enabled:=true;
        ytroufin.enabled:=true;
        ztrou.Enabled:=true;
        trou1.Visible:=true;
        ok.enabled:=true;
        del.enabled:=true;
      end
      else
      begin
         if(new.top=80)then
         begin
             xtrou1.Top:=xtrou1.top+30;
             ytrou1.Top:=ytrou1.top+30;
             xtroufin1.Top:=xtroufin1.top+30;
             ytroufin1.Top:=ytroufin1.top+30;
             ztrou1.Top:=ztrou1.top+30;
             trou2.Visible:=true;

             xtrou1.Enabled:=true;
             ytrou1.enabled:=true;
             xtroufin1.Enabled:=true;
             ytroufin1.enabled:=true;
             ztrou1.Enabled:=true;

             new.enabled:=false;
         end;
         new.Top:= new.Top+30;
         ok.Top:=ok.Top+30;
         del.Top:=del.top+30;
      end;

end;

procedure TFrame2.savefile(Sender: TObject);
var
  MyText: TStringlist;
  movx: integer;
  movy: integer;
begin
  MyText:= TStringlist.create;
  try
   xtrou.text := StringReplace(xtrou.text, ' ', '', [rfReplaceAll]); //Remove spaces
   ytrou.Text := StringReplace(ytrou.Text, ' ', '', [rfReplaceAll]); //Remove spaces
   xtroufin.text := StringReplace(xtroufin.text, ' ', '', [rfReplaceAll]); //Remove spaces
   ytroufin.text := StringReplace(ytroufin.text, ' ', '', [rfReplaceAll]); //Remove spaces
   ztrou.text := StringReplace(ztrou.text, ' ', '', [rfReplaceAll]); //Remove spaces
   xtrou1.text := StringReplace(xtrou1.text, ' ', '', [rfReplaceAll]); //Remove spaces
   ytrou1.text := StringReplace(ytrou1.text, ' ', '', [rfReplaceAll]); //Remove spaces
   xtroufin1.text := StringReplace(xtroufin1.text, ' ', '', [rfReplaceAll]); //Remove spaces
   ytroufin1.text := StringReplace(ytroufin1.text, ' ', '', [rfReplaceAll]); //Remove spaces
   ztrou1.Text := StringReplace(ztrou1.Text, ' ', '', [rfReplaceAll]); //Remove spaces
   xorigin.Text := StringReplace(xorigin.text, ' ', '', [rfReplaceAll]); //Remove spaces
   yorigin.Text := StringReplace(yorigin.Text, ' ', '', [rfReplaceAll]); //Remove spaces
   zedit.Text := StringReplace(zedit.Text, ' ', '', [rfReplaceAll]); //Remove spaces

   if(xtrou.Enabled=true) then
   begin
    //object
    MyText.Add(xorigin.Text);
    MyText.Add(yorigin.Text);
    MyText.Add(zedit.Text);
    //hole0
    MyText.Add(xtrou.Text);
    MyText.Add(ytrou.Text);
    MyText.Add(ztrou.Text);
    movx:=strtoint(xorigin.Text) + strtoint(xtroufin.Text);
    MyText.Add(inttostr(movx));
    movy:=strtoint(yorigin.text) + strtoint(ytroufin.Text);
    MyText.Add(inttostr(movy));
    movx:=movx - strtoint(xtroufin.Text);
    MyText.Add(inttostr(movx));
    movy:=movy - strtoint(ytroufin.Text);
    MyText.Add(inttostr(movy));
    MyText.Add('0'); //reset Z
   end;
   if(xtrou1.Enabled=true) then   //hole1
   begin
    MyText.Add('---'); //distinc line to separate hole
    MyText.Add(xorigin.Text);
    MyText.Add(yorigin.Text);
    MyText.Add(zedit.Text);
    //hole
    MyText.Add(xtrou1.Text);
    MyText.Add(ytrou1.Text);
    MyText.Add(ztrou1.Text);
    movx:=strtoint(xorigin.Text) + strtoint(xtroufin1.Text);
    MyText.Add(inttostr(movx));
    movy:=strtoint(yorigin.Text) + strtoint(ytroufin1.Text);
    MyText.Add(inttostr(movy));
    movx:=movx - strtoint(xtroufin1.Text);
    MyText.Add(inttostr(movx));
    movy:=movy - strtoint(ytroufin1.Text);
    MyText.Add(inttostr(movy));
    MyText.Add('0'); //reset Z
   end;
    MyText.Add('...');  //end the file
    MyText.SaveToFile('./test.txt');
  finally
    MyText.Free
  end; {try}
end;

procedure TFrame2.readfile(sender: TObject);
var
  Txt: TextFile;
  s: string;
  AllText: string;
  i: integer;

begin
  AllText := '';
  AssignFile(Txt, './test.txt');
  Reset(Txt);
  i:=1;
  while not Eof(Txt) do
  begin
    Readln(Txt, s);
    AllText := AllText + s;

    // Write out each line; comment out to stop.
    //Writeln(s);
    if(i=1) then
    begin
          xorigin.text:=s;
    end;
    if(i=2)then
    begin
          yorigin.text:=s;
    end;
    if(i=3)then
    begin
          zedit.text:=s;
    end;
    if(i=4)then
    begin
          xtrou.text:=s;
    end;
    if(i=5)then
    begin
          ytrou.text:=s;
    end;
    if(i=6)then
    begin
          ztrou.text:=s;
    end;
    if(i=7)then
    begin
          xtroufin.text:=inttostr(strtoint(s) - strtoint(xorigin.Text));
    end;
    if(i=8)then
    begin
          ytroufin.text:=inttostr(strtoint(s) - strtoint(yorigin.Text));
    end;

    if(s='...')then
    begin
          Exit();
    end;

    if(i=13) then
    begin
          xorigin.text:=s;
    end;
    if(i=14)then
    begin
          yorigin.text:=s;
    end;
    if(i=15)then
    begin
          zedit.text:=s;
    end;
    if(i=16)then
    begin
          xtrou1.text:=s;
    end;
    if(i=17)then
    begin
          ytrou1.text:=s;
    end;
    if(i=18)then
    begin
          ztrou1.text:=s;
    end;
    if(i=19)then
    begin
          xtroufin1.text:=inttostr(strtoint(s) - strtoint(xorigin.Text));
    end;
    if(i=20)then
    begin
          ytroufin1.text:=inttostr(strtoint(s) - strtoint(yorigin.Text));
    end;

    i:=i+1;
  end;
  CloseFile(Txt);
  validate(Sender);

end;

procedure TFrame2.yoriginchange(Sender: TObject);
begin
  if(yorigin.Text='') then
        begin
            yorigin.Text:=inttostr(0);
        end;
        if(strtoint(yorigin.Text)>130) then
        begin
            yorigin.Text:=inttostr(130);
        end;
  Trackbar2.Min:=strtoint(yorigin.Text);
  Shape1.Top:=152 + strtoint(yorigin.Text)*2;
  Trackbar2.top:=120 + strtoint(Yorigin.Text)*2;
  Trackbar2.Height:=344 - strtoint(Yorigin.Text)*2;
  ybar(sender);
end;

end.
