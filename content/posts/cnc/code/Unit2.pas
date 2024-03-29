unit Unit2;

interface

uses
  Messages, SysUtils, Classes, process, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, TypInfo, Clipbrd, ComCtrls, LCLIntf, Buttons, Menus,
  LazSerial, TAGraph, Serial;

type

  { TFrame2 }
  TFrame2 = class(TFrame)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    CLEAR: TButton;
    center: TButton;
    circle: TButton;
    del: TButton;
    delcircle: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    positiononx: TEdit;
    positionony: TEdit;
    positiononz: TEdit;
    ONOFF: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Image1: TImage;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    RadioGroup1: TRadioGroup;
    Shape4: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LazCom: TLazSerial;
    Memo1: TMemo;
    Memo2: TMemo;
    new: TButton;
    ok: TButton;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    Panel1: TPanel;
    pick: TButton;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    ToggleBox1: TToggleBox;
    ToggleBox2: TToggleBox;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    trou1: TPanel;
    trou2: TPanel;
    X: TLabel;
    xorigin: TEdit;
    Xoriginlabel: TLabel;
    xtrou: TEdit;
    xtrou1: TEdit;
    xtrou2: TEdit;
    xtroufin: TEdit;
    xtroufin1: TEdit;
    xtroufin2: TEdit;
    Y: TLabel;
    yorigin: TEdit;
    Yoriginlabel: TLabel;
    ytrou: TEdit;
    ytrou1: TEdit;
    ytrou2: TEdit;
    ytroufin: TEdit;
    ytroufin1: TEdit;
    ytroufin2: TEdit;
    Z: TLabel;
    zedit: TEdit;
    ztrou: TEdit;
    ztrou1: TEdit;
    ztrou2: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
    procedure centerClick(Sender: TObject);   //center the shape
    procedure check(Sender: TObject);
    procedure clearcanva(Sender: TObject);
    procedure close(Sender: TObject);
    procedure delClick(Sender: TObject);      //delete a hole
    procedure circledraw(Sender: TObject);    //draw a circle
    procedure delecircle(Sender: TObject);    //delete a circle
    procedure Image1Click(Sender: TObject);   //send to the site when clicking the logo
    procedure LazComRxData(Sender: TObject);
    procedure newfile(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure pickonscreen2(Sender: TObject); //pick 2 points on the shape to make a hole
    procedure RadioButton6Change(Sender: TObject);
    procedure startpick(Sender: TObject);     //manage the pickonscreen2 procedure
    procedure TabSheet3Show(Sender: TObject);
    procedure Test(Sender: TObject);
    procedure ToggleBox1Change(Sender: TObject);
    procedure ToggleBox1Click(Sender: TObject);
    procedure ToggleBox2Change(Sender: TObject);
    procedure validate(Sender: TObject);      //actualise the hole and the shape
    procedure xbar(Sender: TObject);          //executed when changing the x progressbar value
    procedure xoriginchange(Sender: TObject); //executed when changing the x origin edit
    procedure ybar(Sender: TObject);          //executed when changing the y progressbar value
    procedure ychange(Sender: TObject);       //executed when changing the y value of the shape
    procedure xchange(Sender: TObject);       //executed when changing the x value of the shape
    procedure trou(Sender: TObject);          //activate a new rectangular hole
    procedure savefile(Sender: TObject);      //save settings to test.txt
    procedure readfile(sender: TObject);      //read settings from test.txt
    procedure yoriginchange(Sender: TObject); //executed when changing the y origin edit

  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    var
       Image: TImage;
       onetime: integer;
       CursorPos: TPoint;
       placed: integer;
       xpos: integer;
       ypos: integer;
       input: string;
       positionx: integer;
       positiony: integer;
       xhere, yhere, zhere: integer;
       checkedvar: integer;
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
   if(xtrou2.enabled=true)then
   begin
     while(strtoint(xtroufin2.Text)+strtoint(xtrou2.Text)>shape1.Width div 2)do
     begin
          xtroufin2.Text:=inttostr(strtoint(xtroufin2.Text)-1);
          while(strtoint(xtrou2.Text)>shape1.Width div 2)do
          begin
               xtrou2.Text:=inttostr(strtoint(xtrou2.Text)-1);
          end;
     end;
     while(strtoint(ytroufin2.Text)+strtoint(ytrou2.Text)>shape1.height div 2)do
     begin
          ytroufin2.Text:=inttostr(strtoint(ytroufin2.Text)-1);
          while(strtoint(ytrou2.Text)>shape1.height div 2)do
          begin
               ytrou2.Text:=inttostr(strtoint(ytrou2.Text)-1);
          end;
     end;
   shape3.top:=shape1.Top + strtoint(ytrou2.Text) * 2;
   shape3.left:=shape1.left + strtoint(xtrou2.Text) * 2;
   shape3.height:=strtoint(ytroufin2.Text) * 2;
   shape3.width:=strtoint(xtroufin2.Text) * 2;
   //shape3.caption:=ztrou2.text;  //don't work with this shape
   end;
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

           xtrou1.text:=inttostr(0);
           ytrou1.text:=inttostr(0);
           xtroufin1.text:=inttostr(0);
           ytroufin1.text:=inttostr(0);
           ztrou1.text:=inttostr(0);

           new.enabled:=true;
           new.Top:= new.Top-30;
           ok.Top:=ok.Top-30;
           del.Top:=del.top-30;
           button1.top:=button1.top-30;
     end
     else
     begin
        xtrou.text:=inttostr(0);
        ytrou.text:=inttostr(0);
        xtroufin.text:=inttostr(0);
        ytroufin.text:=inttostr(0);
        ztrou.text:=inttostr(0);

        xtrou.Enabled:=false;
        ytrou.enabled:=false;
        xtroufin.Enabled:=false;
        ytroufin.enabled:=false;
        ztrou.Enabled:=false;
        trou1.Visible:=false;
        //ok.enabled:=false;
        del.enabled:=false;
     end;

end;

procedure TFrame2.circledraw(Sender: TObject);
var
  placed: integer;
begin
  xtrou2.top := circle.top - 30;
  ytrou2.top := circle.top - 30;
  xtroufin2.top := circle.top - 30;
  ytroufin2.top := circle.top - 30;
  ztrou2.top := circle.top - 30;
  xtrou2.enabled := true;
  ytrou2.Enabled := true;
  xtroufin2.enabled := true;
  ytroufin2.enabled := true;
  ztrou2.enabled := true;
  circle.enabled := false;
  delcircle.enabled := true;
  showmessage('Now you can pick 2 points on the area' + #13#10 + 'Note: This pick will works only for the circular hole');
  onetime:=0;
  while(placed<>2)do
  begin
   while(onetime=0)do
   begin
        Application.ProcessMessages; //just waiting still the user pick 1 points
        GetCursorPos(CursorPos);
        xpos:= CursorPos.X;
        ypos:= CursorPos.Y;
        xtrou2.Text:=inttostr(xpos div 2 - shape1.Left div 2 - Groupbox2.Left div 2 - 5);
        ytrou2.Text:=inttostr(ypos div 2 - shape1.Top div 2 - Groupbox2.Top div 2 - 33);
        validate(Sender);
   end;
   xpos:= CursorPos.X;
   ypos:= CursorPos.Y;
   xtrou2.Text:=inttostr(xpos div 2 - shape1.Left div 2 - Groupbox2.Left div 2 - 5);
   ytrou2.Text:=inttostr(ypos div 2 - shape1.Top div 2 - Groupbox2.Top div 2 - 33);
   placed:=1;
   while(onetime=1)do
   begin
        Application.ProcessMessages; //just waiting still the user pick 1 points
        GetCursorPos(CursorPos);
        xpos:= CursorPos.X;
        ypos:= CursorPos.Y;
        xtroufin2.Text:=inttostr(xpos div 2 - shape1.Left div 2 - Groupbox2.Left div 2 - 5 - strtoint(xtrou2.Text));
        ytroufin2.Text:=inttostr(ypos div 2 - shape1.Top div 2 - Groupbox2.Top div 2 - 33 - strtoint(ytrou2.text));
        validate(Sender);
   end;
   begin
          xpos:= CursorPos.X;
          ypos:= CursorPos.Y;
          xtroufin2.Text:=inttostr(xpos div 2 - shape1.Left div 2 - Groupbox2.Left div 2 - 5 - strtoint(xtrou2.Text));
          ytroufin2.Text:=inttostr(ypos div 2 - shape1.Top div 2 - Groupbox2.Top div 2 - 33 - strtoint(ytrou2.text));
          placed:=2;
   end;
  end;
  Input := InputBox('Depth', 'Depth of the hole :', '');
  ztrou2.text:=Input;
  placed:=0;
  onetime:=0;
  validate(Sender);
end;

procedure TFrame2.delecircle(Sender: TObject);
begin
  xtrou2.top := xtrou.top;
  ytrou2.top := xtrou.top;
  xtroufin2.top := xtrou.top;
  ytroufin2.top := xtrou.top;
  ztrou2.top := xtrou.top;
  xtrou2.enabled := false;
  ytrou2.Enabled := false;
  xtroufin2.enabled := false;
  ytroufin2.enabled := false;
  ztrou2.enabled := false;
  circle.enabled := true;
  delcircle.enabled := false;
end;

procedure TFrame2.centerClick(Sender: TObject);
begin
  xorigin.Text:=inttostr(135 div 2);
  yorigin.Text:=inttostr(75 div 2);
  trackbar1.Position:=135 + 135 div 2;
  trackbar2.position:=75 + 75 div 2;
end;

procedure TFrame2.check(Sender: TObject);
begin
  case (Sender as TCheckBox).Tag of
    1: begin //test1
         Checkedvar:=1;
       end;
    2: begin //test2
         Checkedvar:=2;
       end;
    3: begin //test3
         Checkedvar:=3;
       end;
    end;
end;

procedure TFrame2.clearcanva(Sender: TObject);
begin
  Shape4.Canvas.Clear;
  Shape4.Canvas.Pen.Width:=5;
  Shape4.Canvas.pen.Color:=clWhite;
  Shape4.Canvas.Rectangle(0,0,Shape4.Width,Shape4.Height);
  Shape4.Canvas.pen.Color:=clBlack;
  Button2.Enabled:=true;
  Button3.Enabled:=true;
  Button4.Enabled:=true;
  Button5.Enabled:=true;
  ToggleBox2.Enabled:=true;
  Button6.Enabled:=true;
  Button7.Enabled:=true;
  Button8.caption:='READY';
  xhere:=0;
  yhere:=0;
  zhere:=40;
  lazcom.WriteData('r');
  lazcom.WriteData(',');
end;


procedure TFrame2.ButtonClick(Sender: TObject);
var
  dx, dy, dz: integer;
begin
  // Determine the direction of the line based on the button that was clicked
  Panel2.Visible:=true;
  Button9.Enabled:=false;
  case (Sender as TButton).Tag of
    1: begin // Up
         dx := 0;
         dy := -5;
       end;
    2: begin // Down
         dx := 0;
         dy := 5;
       end;
    3: begin // Left
         dx := -5;
         dy := 0;

       end;
    4: begin // Right
         dx := 5;
         dy := 0;

       end;
    5: begin // upside
         dz := 5;
       end;
    6: begin // downside
         dz := -5
       end;
  end;
  // Draw the line on Shape4
  //Shape4.Canvas.Pen.Width:=round((zhere+dz) div 10);
  if (xhere=0) and (dx=-5) then
     dx:=0;
  if (yhere=0) and (dy=-5) then
     dy:=0;
  if (xhere=270) and (dx=5) then
     dx:=0;
  if (yhere=150) and (dy=5) then
     dy:=0;
  if not(dx = 0) then
  begin
       lazcom.WriteData('x');
       lazcom.WriteData(',');
       lazcom.WriteData(inttostr(dx));
       lazcom.WriteData(',');
  end;
  if not(dy = 0) then
  begin
       lazcom.WriteData('y');
       lazcom.WriteData(',');
       lazcom.WriteData(inttostr(dy));
       lazcom.WriteData(',');
  end;

  Shape4.Canvas.Line(xhere*2,yhere*2,xhere*2+dx*2, yhere*2+dy*2);
  xhere:=xhere+dx;
  yhere:=yhere+dy;
  zhere:=zhere+dz;
  positiononx.Text:=inttostr(xhere);
  positionony.Text:=inttostr(yhere);
  positiononz.Text:=inttostr(zhere);
end;

procedure TFrame2.Button2Click(Sender: TObject);
begin
  lazcom.WriteData('z');
  lazcom.WriteData(',');
  lazcom.WriteData('5');
  lazcom.WriteData(',');
end;

procedure TFrame2.Button3Click(Sender: TObject);
begin
  lazcom.WriteData('z');
  lazcom.WriteData(',');
  lazcom.WriteData('-5');
  lazcom.WriteData(',');
end;

procedure TFrame2.Button9Click(Sender: TObject);
var
  text: String;
  i: Integer;
begin
  Panel2.Visible:=true;
  Button9.enabled:=false;
  if (RadioButton1.Checked=true) then
  begin
     lazcom.WriteData('t1');
     lazcom.WriteData(',');
  end;
  if (RadioButton2.Checked=true) then
  begin
     lazcom.WriteData('t2');
     lazcom.WriteData(',');
  end;
  if (RadioButton3.Checked=true) then
  begin
     lazcom.WriteData('t3');
     lazcom.WriteData(',');
  end;
  if (Radiobutton4.Checked=true) then
  begin
     lazcom.WriteData('t4');
     lazcom.WriteData(',');
  end;
  if (RadioButton3.Checked=true) then
  begin
     lazcom.WriteData('t5');
     lazcom.WriteData(',');
  end;
  if (RadioButton6.Checked=true) then
  begin
     lazcom.WriteData('t');
     lazcom.WriteData(',');
     text := edit3.Text;
      for i := 1 to Length(text) do
      begin
        if (text[i] >= 'a') and (text[i] <= 'z') then
          lazcom.WriteData(IntToStr(Ord(text[i]) - Ord('a') + 1))
        else if (text[i] >= '0') and (text[i] <= '9') then
          lazcom.WriteData(IntToStr(Ord(text[i]) - Ord('0') + 27))
        else
          lazcom.WriteData('');
        lazcom.WriteData(',');
      end;
  end;
end;


procedure TFrame2.close(Sender: TObject);
begin
  application.Terminate;
end;

procedure TFrame2.Image1Click(Sender: TObject);
begin
  OpenURL('https://stistlouis.netlify.app');
end;

procedure TFrame2.LazComRxData(Sender: TObject);
var
    Temp : String;
     Proc: TProcess;
    Temp2: string;
begin
   if LazCom.DataAvailable then
   begin
       Button9.enabled:=true;
       Panel2.Visible:=false;
       Temp := LazCom.ReadData ;
       Memo2.text := Memo2.text+Temp;
       //Memo2.Lines.Add('');
       //Label1.caption:=Temp;

   end;
end;

procedure TFrame2.newfile(Sender: TObject);
begin
   xorigin.text:='0';
   yorigin.Text:='0';
   zedit.text:='0';
   xtrou.text:='0';
   ytrou.text:='0';
   ztrou.text:='0';
   xtrou1.text:='0';
   ytrou1.text:='0';
   ztrou1.text:='0';
   xtrou2.text:='0';
   ytrou2.text:='0';
   ztrou2.text:='0';
   xtroufin1.text:='0';
   ytroufin1.text:='0';
   xtroufin.text:='0';
   ytroufin.text:='0';
   xtroufin2.text:='0';
   ytroufin2.text:='0';
   Trackbar1.Position:=Trackbar1.Max;
   Trackbar2.Position:=Trackbar2.Max;
   validate(sender);
end;

procedure TFrame2.Panel1Click(Sender: TObject);
begin

end;

procedure TFrame2.pickonscreen2(Sender: TObject);
begin
   GetCursorPos(CursorPos);
   onetime:=onetime+1;
end;

procedure TFrame2.RadioButton6Change(Sender: TObject);
begin
  edit3.enabled:=radiobutton6.Checked;
end;

procedure TFrame2.startpick(Sender: TObject);
begin
 if(xtrou1.enabled=false)then
 begin
  showmessage('Now you can pick 2 points on the area' + #13#10 + 'Note: This pick will works only for the first hole');
  onetime:=0;
  while(placed<>2)do
  begin
   while(onetime=0)do
   begin
        Application.ProcessMessages; //just waiting still the user pick 1 points
        GetCursorPos(CursorPos);
        xpos:= CursorPos.X;
        ypos:= CursorPos.Y;
        xtrou.Text:=inttostr(xpos div 2 - shape1.Left div 2 - Groupbox2.Left div 2);
        ytrou.Text:=inttostr((ypos div 2 - shape1.Top div 2 - Groupbox2.Top div 2)-33);
        validate(Sender);
   end;
   xpos:= CursorPos.X;
   ypos:= CursorPos.Y;
   xtrou.Text:=inttostr(xpos div 2 - shape1.Left div 2 - Groupbox2.Left div 2 - 5);
   ytrou.Text:=inttostr((ypos div 2 - shape1.Top div 2 - Groupbox2.Top div 2) - 33);
   placed:=1;
   while(onetime=1)do
   begin
        Application.ProcessMessages; //just waiting still the user pick 1 points
        GetCursorPos(CursorPos);
        xpos:= CursorPos.X;
        ypos:= CursorPos.Y;
        xtroufin.Text:=inttostr(xpos div 2 - shape1.Left div 2 - Groupbox2.Left div 2 - 5 - strtoint(xtrou.Text));
        ytroufin.Text:=inttostr((ypos div 2 - shape1.Top div 2 - Groupbox2.Top div 2 -55 -strtoint(ytrou.text)));
        validate(Sender);
   end;
   begin
          xpos:= CursorPos.X;
          ypos:= CursorPos.Y;
          xtroufin.Text:=inttostr(xpos div 2 - shape1.Left div 2 - Groupbox2.Left div 2 - 5 - strtoint(xtrou.Text));
          ytroufin.Text:=inttostr(ypos div 2 - shape1.Top div 2 - Groupbox2.Top div 2 -55- strtoint(ytrou.text));
          placed:=2;
   end;
  end;
  Input := InputBox('Depth', 'Depth of the hole :', '');
  ztrou.text:=Input;
  placed:=0;
  onetime:=0;
  validate(Sender);
 end
 else
 begin
  showmessage('Now you can pick 2 points on the area' + #13#10 + 'Note: This pick will works only for the second hole');
  onetime:=0;
  while(placed<>2)do
  begin
   while(onetime=0)do
   begin
        Application.ProcessMessages; //just waiting still the user pick 1 points
        GetCursorPos(CursorPos);
        xpos:= CursorPos.X;
        ypos:= CursorPos.Y;
        xtrou1.Text:=inttostr(xpos div 2 - shape1.Left div 2 - Groupbox2.Left div 2 - 5);
        ytrou1.Text:=inttostr(ypos div 2 - shape1.Top div 2 - Groupbox2.Top div 2 - 33);
        validate(Sender);
   end;
   xpos:= CursorPos.X;
   ypos:= CursorPos.Y;
   xtrou1.Text:=inttostr(xpos div 2 - shape1.Left div 2 - Groupbox2.Left div 2 - 5);
   ytrou1.Text:=inttostr(ypos div 2 - shape1.Top div 2 - Groupbox2.Top div 2 - 33);
   placed:=1;
   while(onetime=1)do
   begin
        Application.ProcessMessages; //just waiting still the user pick 1 points
        GetCursorPos(CursorPos);
        xpos:= CursorPos.X;
        ypos:= CursorPos.Y;
        xtroufin1.Text:=inttostr(xpos div 2 - shape1.Left div 2 - Groupbox2.Left div 2 - 5 - strtoint(xtrou1.Text));
        ytroufin1.Text:=inttostr(ypos div 2 - shape1.Top div 2 - Groupbox2.Top div 2 - 33 - strtoint(ytrou1.text));
        validate(Sender);
   end;
   begin
          xpos:= CursorPos.X;
          ypos:= CursorPos.Y;
          xtroufin1.Text:=inttostr(xpos div 2 - shape1.Left div 2 - Groupbox2.Left div 2 - 5 - strtoint(xtrou1.Text));
          ytroufin1.Text:=inttostr(ypos div 2 - shape1.Top div 2 - Groupbox2.Top div 2 - 33 - strtoint(ytrou1.text));
          placed:=2;
   end;
  end;
  Input := InputBox('Depth', 'Depth of the hole :', '');
  ztrou1.text:=Input;
  placed:=0;
  onetime:=0;
  validate(Sender);
 end;
end;

procedure TFrame2.TabSheet3Show(Sender: TObject);
begin
   //positiononx:=Shape4.Left;
   //positionony:=Shape4.Top;
end;

procedure TFrame2.Test(Sender: TObject);
begin
 if Button8.caption='READY' then
 begin
    Button9.enabled:=true;
    Shape4.Canvas.Pen.Width:=5;
    Shape4.Canvas.pen.Color:=clWhite;
    Shape4.Canvas.Rectangle(0,0,Shape4.Width,Shape4.Height);
    Shape4.Canvas.pen.Color:=clBlack;
    Button2.Enabled:=true;
    Button3.Enabled:=true;
    Button4.Enabled:=true;
    Button5.Enabled:=true;
    ToggleBox2.Enabled:=true;
    Button6.Enabled:=true;
    Button7.Enabled:=true;
    Button8.Caption:='DISCONNECT';
    xhere:=0;
    yhere:=0;
    zhere:=40;
    lazcom.ShowSetupDialog;
    lazcom.Active:=true;
    Lazcom.Open;
 end
 else
 begin
    Shape4.Canvas.Pen.Width:=5;
    Shape4.Canvas.pen.Color:=clWhite;
    Shape4.Canvas.Rectangle(0,0,Shape4.Width,Shape4.Height);
    Shape4.Canvas.pen.Color:=clBlack;
    Button2.Enabled:=false;
    Button3.Enabled:=false;
    Button4.Enabled:=false;
    Button5.Enabled:=false;
    ToggleBox2.Enabled:=false;
    Button6.Enabled:=false;
    Button7.Enabled:=false;
    Button8.Caption:='READY';
    xhere:=0;
    yhere:=0;
    zhere:=40;
    Lazcom.Close;
    lazcom.Active:=false;
 end;
end;

procedure TFrame2.ToggleBox1Change(Sender: TObject);
begin

end;


  //TShape1.Canvas.MoveTo(TShape1.Left, TShape1.Top); // start at the current position
  //TShape1.Canvas.LineTo(TShape1.Left + 10, TShape1.Top); // draw a line to the new position

procedure TFrame2.ToggleBox1Click(Sender: TObject);
var
  Txt: TextFile;
  s: string;
  AllText: string;
  i: integer;
  filename: string;
  l: integer;
begin
  Panel2.Visible:=true;
  button9.Enabled:=false;
  AllText := '';
 if OpenDialog1.execute then
 begin
  filename := OpenDialog1.Filename;
  AssignFile(Txt, filename);
  Reset(Txt);
  i:=1;
  l:=0;
  while not Eof(Txt) do
  begin
    Readln(Txt, s);
    l:=l+1;
    AllText := AllText + s;
    // Write out each line; comment out to stop.
    //Writeln(s);
    Lazcom.WriteData(s);
    Lazcom.WriteData(',');
    i:=i+1;
  end;
  CloseFile(Txt);
  memo2.Lines.Add(alltext);
end;

end;

procedure TFrame2.ToggleBox2Change(Sender: TObject);
begin
 if ToggleBox2.Checked = true then
 begin
  ONOFF.Text:='True';
  lazcom.WriteData('i');
  lazcom.WriteData(',');
 end
 else
  ONOFF.Text:='False';
  lazcom.WriteData('o');
  lazcom.WriteData(',');
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
         button1.Top:=button1.top+30;
      end;

end;

procedure TFrame2.savefile(Sender: TObject);
var
  MyText: TStringlist;
  movx: integer;
  movy: integer;
  z: integer;
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
   xtrou2.text := StringReplace(xtrou2.text, ' ', '', [rfReplaceAll]); //Remove spaces
   ytrou2.Text := StringReplace(ytrou2.Text, ' ', '', [rfReplaceAll]); //Remove spaces
   xtroufin2.text := StringReplace(xtroufin2.text, ' ', '', [rfReplaceAll]); //Remove spaces
   ytroufin2.text := StringReplace(ytroufin2.text, ' ', '', [rfReplaceAll]); //Remove spaces
   ztrou2.text := StringReplace(ztrou2.text, ' ', '', [rfReplaceAll]); //Remove spaces
   xorigin.Text := StringReplace(xorigin.text, ' ', '', [rfReplaceAll]); //Remove spaces
   yorigin.Text := StringReplace(yorigin.Text, ' ', '', [rfReplaceAll]); //Remove spaces
   zedit.Text := StringReplace(zedit.Text, ' ', '', [rfReplaceAll]); //Remove spaces

   if(xtrou.Enabled=true) then
   begin
    //object
    MyText.Add(xorigin.Text);
    MyText.Add(yorigin.Text);
    MyText.Add(zedit.Text);
    MyText.Add(inttostr(trackbar1.Position));
    MyText.Add(inttostr(trackbar2.Position));
    //hole0
    MyText.Add(xtrou.Text);
    MyText.Add(ytrou.Text);
    z:=strtoint(zedit.Text) + strtoint(ztrou.Text);
    MyText.Add(inttostr(z));
    movx:=strtoint(xtrou.Text) + strtoint(xtroufin.Text);
    MyText.Add(inttostr(movx));
    movy:=strtoint(ytrou.text) + strtoint(ytroufin.Text);
    MyText.Add(inttostr(movy));
    movx:=movx - strtoint(xtroufin.Text);
    MyText.Add(inttostr(movx));
    movy:=movy - strtoint(ytroufin.Text);
    MyText.Add(inttostr(movy));
    MyText.Add('0'); //reset Z
   end
   else
   begin
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
   end;
   if(xtrou1.Enabled=true) then   //hole1
   begin
    MyText.Add('---'); //distinc line to separate hole, represented as a rectangle ABCD
    MyText.Add(xorigin.Text);                                //xorigin
    MyText.Add(yorigin.Text);                                //yorigin
    MyText.Add(zedit.Text);                                  //zobject
    MyText.Add(inttostr(trackbar1.Position));
    MyText.Add(inttostr(trackbar2.Position));
    //hole
    MyText.Add(xtrou1.Text);                                 //point A (x)
    MyText.Add(ytrou1.Text);                                 //point A (y)
    z:=strtoint(zedit.Text) + strtoint(ztrou1.Text);         //point A (z)
    MyText.Add(inttostr(z));
    movx:=strtoint(xtrou1.Text) + strtoint(xtroufin1.Text);  //point B(x)
    MyText.Add(inttostr(movx));
    movy:=strtoint(ytrou1.Text) + strtoint(ytroufin1.Text);  //point D (y)
    MyText.Add(inttostr(movy));
    movx:=movx - strtoint(xtroufin1.Text);                   //point C (x)
    MyText.Add(inttostr(movx));
    movy:=movy - strtoint(ytroufin1.Text);                   //point A (y)
    MyText.Add(inttostr(movy));
    MyText.Add('0'); //reset Z                               //point A (z)
   end
   else
   begin
      MyText.Add('---');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
   end;
   if(xtrou2.Enabled=true) then   //circle
   begin
    MyText.Add('+++'); //distinc line to separate hole
    MyText.Add(xorigin.Text);
    MyText.Add(yorigin.Text);
    MyText.Add(zedit.Text);
    MyText.Add(inttostr(trackbar1.Position));
    MyText.Add(inttostr(trackbar2.Position));
    //hole
    MyText.Add(xtrou2.Text);
    MyText.Add(ytrou2.Text);
    z:=strtoint(zedit.Text) + strtoint(ztrou2.Text);
    MyText.Add(inttostr(z));
    //we are wroting data for a eliptic shape, to get a shorter code, we will
    //write it as a rectangle ABCD, so the higest point in the left is on AC
    //the higest point in the top is on AB, the higest on the right is on BD,
    //and the higest in the down on CD
    MyText.Add(xtrou2.text);
    MyText.Add(ytrou2.text);
    movx:=strtoint(xtrou2.text) + strtoint(xtroufin2.text);
    MyText.Add(inttostr(movx));
    movy:=strtoint(ytrou2.text) + strtoint(ytroufin2.text);
    MyText.Add(inttostr(movy));
    movx:=movx - strtoint(xtroufin2.text);
    MyText.Add(inttostr(movx));
    movy:=movy - strtoint(ytroufin2.text);
    MyText.Add(inttostr(movy));
    MyText.Add('0'); //reset Z
   end
   else
   begin
      MyText.Add('---');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
      MyText.Add('0');
   end;
    MyText.Add('...');  //end the file

    with SelectDirectoryDialog1.Create(nil) do
    try
       if Execute then
       begin
           if (filename = '')then
           begin
              filename:= '.';
           end;
           Input := InputBox('Filename', 'Chose a filename for the file :', '');
           if(input='')then
           begin
              Input:='data';
           end;
           MyText.SaveToFile(filename + '/' + Input + '.sti2d');
         end;
       finally
         SelectDirectoryDialog1.Close;
       end;

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
  filename: string;
  l: integer;
begin
 AllText := '';
 if OpenDialog1.execute then
 begin
  filename := OpenDialog1.Filename;
  AssignFile(Txt, filename);
  Reset(Txt);
  i:=1;
  l:=0;
  while not Eof(Txt) do
  begin
    Readln(Txt, s);
    l:=l+1;
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
          trackbar1.Position:=strtoint(s);
    end;
    if(i=5)then
    begin
          trackbar2.Position:=strtoint(s);
    end;
    if(i=6)then
    begin
          xtrou.text:=s;
    end;
    if(i=7)then
    begin
          ytrou.text:=s;
    end;
    if(i=8)then
    begin
          ztrou.text:=inttostr(strtoint(s) - strtoint(zedit.text));
    end;
    if(i=9)then
    begin
          xtroufin.text:=inttostr(strtoint(s) - strtoint(xtrou.Text));
    end;
    if(i=10)then
    begin
         ytroufin.text:=inttostr(strtoint(s) - strtoint(ytrou.Text));
    end;

    if(s='...')then
    begin
          Exit();
    end;

    if(i=15) then
    begin
          xorigin.text:=s;
    end;
    if(i=16)then
    begin
          yorigin.text:=s;
    end;
    if(i=17)then
    begin
          zedit.text:=s;
    end;
    if(i=18)then
    begin
          trackbar1.Position:=strtoint(s);
    end;
    if(i=19)then
    begin
          trackbar2.Position:=strtoint(s);
    end;
    if(i=20)then
    begin
          xtrou1.text:=s;
    end;
    if(i=21)then
    begin
          ytrou1.text:=s;
    end;
    if(i=22)then
    begin
          ztrou1.text:=inttostr(strtoint(s) - strtoint(zedit.text));
    end;
    if(i=23)then
    begin
          xtroufin1.text:=inttostr(strtoint(s) - strtoint(xtrou1.Text));
    end;
    if(i=24)then
    begin
          ytroufin1.text:=inttostr(strtoint(s) - strtoint(ytrou1.Text));
    end;
    if(s='+++')then
    begin
     xtrou2.top := circle.top - 30;
     ytrou2.top := circle.top - 30;
     xtroufin2.top := circle.top - 30;
     ytroufin2.top := circle.top - 30;
     ztrou2.top := circle.top - 30;
     xtrou2.enabled := true;
     ytrou2.Enabled := true;
     xtroufin2.enabled := true;
     ytroufin2.enabled := true;
     ztrou2.enabled := true;
     circle.enabled := false;
     delcircle.enabled := true;
    end;
    if(i=29) then
    begin
          xorigin.text:=s;
    end;
    if(i=30)then
    begin
          yorigin.text:=s;
    end;
    if(i=31)then
    begin
          zedit.text:=s;
    end;
    if(i=32)then
    begin
          trackbar1.Position:=strtoint(s);
    end;
    if(i=33)then
    begin
          trackbar2.Position:=strtoint(s);
    end;
    if(i=34)then
    begin
          xtrou2.text:=s;
    end;
    if(i=35)then
    begin
          ytrou2.text:=s;
    end;
    if(i=36)then
    begin
          ztrou2.text:=inttostr(strtoint(s) - strtoint(zedit.text));
    end;
    if(i=37)then
    begin
          xtroufin2.text:=inttostr(strtoint(s) - strtoint(xtrou2.Text));
    end;
    if(i=38)then
    begin
          ytroufin2.text:=inttostr(strtoint(s) - strtoint(ytrou2.Text));
    end;

    i:=i+1;
  end;
  CloseFile(Txt);
  memo1.Lines.Add(alltext);
  validate(Sender);
end;

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
