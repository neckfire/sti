---
title: Notre code
---
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="generator" content="Lazarus SynEdit Html Exporter">
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>Unit2</title>
</head>
<body text="black" bgcolor="#292C37"><pre><code><font  size=3 face="Courier New"><font color="black"><b>unit </b>Unit2<font color="red">;

</font><b>interface

uses 
  </b>Messages<font color="red">, </font>SysUtils<font color="red">, </font>Classes<font color="red">, </font>Graphics<font color="red">, </font>Controls<font color="red">, </font>Forms<font color="red">, </font>Dialogs<font color="red">,
  </font>StdCtrls<font color="red">, </font>ExtCtrls<font color="red">, </font>TypInfo<font color="red">, </font>Clipbrd<font color="red">, </font>ComCtrls<font color="red">;

</font><b>type

  </b><font color="blue"><b>{ TFrame2 }
  </b></font>TFrame2 <font color="red">= </font><b>class</b><font color="red">(</font>TFrame<font color="red">)
    </font>Button1<font color="red">: </font>TButton<font color="red">;
    </font>save<font color="red">: </font>TButton<font color="red">;
    </font>del<font color="red">: </font>TButton<font color="red">;
    </font>ok<font color="red">: </font>TButton<font color="red">;
    </font>GroupBox1<font color="red">: </font>TGroupBox<font color="red">;
    </font>GroupBox2<font color="red">: </font>TGroupBox<font color="red">;
    </font>Shape1<font color="red">: </font>TShape<font color="red">;
    </font>Edit1<font color="red">: </font>TEdit<font color="red">;
    </font>Edit2<font color="red">: </font>TEdit<font color="red">;
    </font>trou1<font color="red">: </font>TPanel<font color="red">;
    </font>trou2<font color="red">: </font>TPanel<font color="red">;
    </font>X<font color="red">: </font>TLabel<font color="red">;
    </font>xtrou1<font color="red">: </font>TEdit<font color="red">;
    </font>xtroufin1<font color="red">: </font>TEdit<font color="red">;
    </font>Y<font color="red">: </font>TLabel<font color="red">;
    </font>new<font color="red">: </font>TButton<font color="red">;
    </font>xtrou<font color="red">: </font>TEdit<font color="red">;
    </font>Label1<font color="red">: </font>TLabel<font color="red">;
    </font>Label2<font color="red">: </font>TLabel<font color="red">;
    </font>ytrou<font color="red">: </font>TEdit<font color="red">;
    </font>xtroufin<font color="red">: </font>TEdit<font color="red">;
    </font>ytrou1<font color="red">: </font>TEdit<font color="red">;
    </font>ytroufin<font color="red">: </font>TEdit<font color="red">;
    </font>ytroufin1<font color="red">: </font>TEdit<font color="red">;
    </font>ztrou<font color="red">: </font>TEdit<font color="red">;
    </font>Label3<font color="red">: </font>TLabel<font color="red">;
    </font>Label4<font color="red">: </font>TLabel<font color="red">;
    </font>Label5<font color="red">: </font>TLabel<font color="red">;
    </font>ztrou1<font color="red">: </font>TEdit<font color="red">;
    </font><b>procedure </b>delClick<font color="red">(</font>Sender<font color="red">: </font>TObject<font color="red">);
    </font><b>procedure </b>validate<font color="red">(</font>Sender<font color="red">: </font>TObject<font color="red">);
    </font><b>procedure </b>ychange<font color="red">(</font>Sender<font color="red">: </font>TObject<font color="red">);
    </font><b>procedure </b>xchange<font color="red">(</font>Sender<font color="red">: </font>TObject<font color="red">);
    </font><b>procedure </b>trou<font color="red">(</font>Sender<font color="red">: </font>TObject<font color="red">);
    </font><b>procedure </b>savefile<font color="red">(</font>Sender<font color="red">: </font>TObject<font color="red">);
    </font><b>procedure </b>readfile<font color="red">(</font>sender<font color="red">: </font>TObject<font color="red">);

  </font><b>private
    </b><font color="blue"><b>{ Déclarations privées }
  </b></font><b>public
    </b><font color="blue"><b>{ Déclarations publiques }
    //alternatively:
    //constructor CreateFrom(srcObj: TMyObject);

  </b></font><b>end</b><font color="red">;


</font><b>implementation

</b><font color="red"><b>{$R *.dfm}

</b></font><b>procedure </b>TFrame2<font color="red">.</font>ychange<font color="red">(</font>Sender<font color="red">: </font>TObject<font color="red">);
</font><b>begin
        if</b><font color="red">(</font>Edit2<font color="red">.</font>Text<font color="red">=</font><font color="blue">''</font><font color="red">) </font><b>then
        begin
            </b>Edit2<font color="red">.</font>Text<font color="red">:=</font>inttostr<font color="red">(</font><font color="navy">0</font><font color="red">);
        </font><b>end</b><font color="red">;
        </font><b>if</b><font color="red">(</font>strtoint<font color="red">(</font>Edit2<font color="red">.</font>Text<font color="red">)&gt;</font><font color="navy">150</font><font color="red">) </font><b>then
        begin
            </b>Edit2<font color="red">.</font>Text<font color="red">:=</font>inttostr<font color="red">(</font><font color="navy">150</font><font color="red">);
        </font><b>end</b><font color="red">;
        </font>Shape1<font color="red">.</font>Height<font color="red">:= </font>strtoint<font color="red">(</font>Edit2<font color="red">.</font>Text<font color="red">)*</font><font color="navy">2</font><font color="red">;
        </font>validate<font color="red">(</font>Sender<font color="red">);

</font><b>end</b><font color="red">;

</font><b>procedure </b>TFrame2<font color="red">.</font>validate<font color="red">(</font>Sender<font color="red">: </font>TObject<font color="red">);
</font><b>begin
     while</b><font color="red">(</font>strtoint<font color="red">(</font>xtroufin<font color="red">.</font>Text<font color="red">)+</font>strtoint<font color="red">(</font>xtrou<font color="red">.</font>Text<font color="red">)&gt;</font>shape1<font color="red">.</font>Width <b>div </b><font color="navy">2</font><font color="red">)</font><b>do
     begin
          </b>xtroufin<font color="red">.</font>Text<font color="red">:=</font>inttostr<font color="red">(</font>strtoint<font color="red">(</font>xtroufin<font color="red">.</font>Text<font color="red">)-</font><font color="navy">1</font><font color="red">);
          </font><b>while</b><font color="red">(</font>strtoint<font color="red">(</font>xtrou<font color="red">.</font>Text<font color="red">)&gt;</font>shape1<font color="red">.</font>Width <b>div </b><font color="navy">2</font><font color="red">)</font><b>do
          begin
               </b>xtrou<font color="red">.</font>Text<font color="red">:=</font>inttostr<font color="red">(</font>strtoint<font color="red">(</font>xtrou<font color="red">.</font>Text<font color="red">)-</font><font color="navy">1</font><font color="red">);
          </font><b>end</b><font color="red">;
     </font><b>end</b><font color="red">;
     </font><b>while</b><font color="red">(</font>strtoint<font color="red">(</font>ytroufin<font color="red">.</font>Text<font color="red">)+</font>strtoint<font color="red">(</font>ytrou<font color="red">.</font>Text<font color="red">)&gt;</font>shape1<font color="red">.</font>height <b>div </b><font color="navy">2</font><font color="red">)</font><b>do
     begin
          </b>ytroufin<font color="red">.</font>Text<font color="red">:=</font>inttostr<font color="red">(</font>strtoint<font color="red">(</font>ytroufin<font color="red">.</font>Text<font color="red">)-</font><font color="navy">1</font><font color="red">);
          </font><b>while</b><font color="red">(</font>strtoint<font color="red">(</font>ytrou<font color="red">.</font>Text<font color="red">)&gt;</font>shape1<font color="red">.</font>height <b>div </b><font color="navy">2</font><font color="red">)</font><b>do
          begin
               </b>ytrou<font color="red">.</font>Text<font color="red">:=</font>inttostr<font color="red">(</font>strtoint<font color="red">(</font>ytrou<font color="red">.</font>Text<font color="red">)-</font><font color="navy">1</font><font color="red">);
          </font><b>end</b><font color="red">;
     </font><b>end</b><font color="red">;
     </font>trou1<font color="red">.</font>top<font color="red">:=</font>shape1<font color="red">.</font>Top <font color="red">+ </font>strtoint<font color="red">(</font>ytrou<font color="red">.</font>Text<font color="red">) * </font><font color="navy">2</font><font color="red">;
     </font>trou1<font color="red">.</font>left<font color="red">:=</font>shape1<font color="red">.</font>left <font color="red">+ </font>strtoint<font color="red">(</font>xtrou<font color="red">.</font>Text<font color="red">) * </font><font color="navy">2</font><font color="red">;
     </font>trou1<font color="red">.</font>height<font color="red">:=</font>strtoint<font color="red">(</font>ytroufin<font color="red">.</font>Text<font color="red">) * </font><font color="navy">2</font><font color="red">;
     </font>trou1<font color="red">.</font>width<font color="red">:=</font>strtoint<font color="red">(</font>xtroufin<font color="red">.</font>Text<font color="red">) * </font><font color="navy">2</font><font color="red">;
     </font>trou1<font color="red">.</font>caption<font color="red">:=</font>ztrou<font color="red">.</font>text<font color="red">;
     </font><b>if</b><font color="red">(</font>xtrou1<font color="red">.</font>Enabled<font color="red">=</font>true<font color="red">) </font><b>then
     begin
           while</b><font color="red">(</font>strtoint<font color="red">(</font>xtroufin1<font color="red">.</font>Text<font color="red">)+</font>strtoint<font color="red">(</font>xtrou1<font color="red">.</font>Text<font color="red">)&gt;</font>shape1<font color="red">.</font>Width <b>div </b><font color="navy">2</font><font color="red">)</font><b>do
           begin
                </b>xtroufin1<font color="red">.</font>Text<font color="red">:=</font>inttostr<font color="red">(</font>strtoint<font color="red">(</font>xtroufin1<font color="red">.</font>Text<font color="red">)-</font><font color="navy">1</font><font color="red">);
                </font><b>while</b><font color="red">(</font>strtoint<font color="red">(</font>xtrou1<font color="red">.</font>Text<font color="red">)&gt;</font>shape1<font color="red">.</font>Width <b>div </b><font color="navy">2</font><font color="red">)</font><b>do
                begin
                      </b>xtrou1<font color="red">.</font>Text<font color="red">:=</font>inttostr<font color="red">(</font>strtoint<font color="red">(</font>xtrou1<font color="red">.</font>Text<font color="red">)-</font><font color="navy">1</font><font color="red">);
                </font><b>end</b><font color="red">;
           </font><b>end</b><font color="red">;
           </font><b>while</b><font color="red">(</font>strtoint<font color="red">(</font>ytroufin1<font color="red">.</font>Text<font color="red">)+</font>strtoint<font color="red">(</font>ytrou1<font color="red">.</font>Text<font color="red">)&gt;</font>shape1<font color="red">.</font>height <b>div </b><font color="navy">2</font><font color="red">)</font><b>do
           begin
                </b>ytroufin<font color="red">.</font>Text<font color="red">:=</font>inttostr<font color="red">(</font>strtoint<font color="red">(</font>ytroufin1<font color="red">.</font>Text<font color="red">)-</font><font color="navy">1</font><font color="red">);
                </font><b>while</b><font color="red">(</font>strtoint<font color="red">(</font>ytrou1<font color="red">.</font>Text<font color="red">)&gt;</font>shape1<font color="red">.</font>height <b>div </b><font color="navy">2</font><font color="red">)</font><b>do
                begin
                      </b>ytrou1<font color="red">.</font>Text<font color="red">:=</font>inttostr<font color="red">(</font>strtoint<font color="red">(</font>ytrou1<font color="red">.</font>Text<font color="red">)-</font><font color="navy">1</font><font color="red">);
                </font><b>end</b><font color="red">;
           </font><b>end</b><font color="red">;
           </font>trou2<font color="red">.</font>top<font color="red">:=</font>shape1<font color="red">.</font>Top <font color="red">+ </font>strtoint<font color="red">(</font>ytrou1<font color="red">.</font>Text<font color="red">) * </font><font color="navy">2</font><font color="red">;
           </font>trou2<font color="red">.</font>left<font color="red">:=</font>shape1<font color="red">.</font>left <font color="red">+ </font>strtoint<font color="red">(</font>xtrou1<font color="red">.</font>Text<font color="red">) * </font><font color="navy">2</font><font color="red">;
           </font>trou2<font color="red">.</font>height<font color="red">:=</font>strtoint<font color="red">(</font>ytroufin1<font color="red">.</font>Text<font color="red">) * </font><font color="navy">2</font><font color="red">;
           </font>trou2<font color="red">.</font>width<font color="red">:=</font>strtoint<font color="red">(</font>xtroufin1<font color="red">.</font>Text<font color="red">) * </font><font color="navy">2</font><font color="red">;
           </font>trou2<font color="red">.</font>caption<font color="red">:=</font>ztrou1<font color="red">.</font>text<font color="red">;
     </font><b>end</b><font color="red">;
</font><b>end</b><font color="red">;

</font><b>procedure </b>TFrame2<font color="red">.</font>delClick<font color="red">(</font>Sender<font color="red">: </font>TObject<font color="red">);
</font><b>begin
     if</b><font color="red">(</font>new<font color="red">.</font>top<font color="red">=</font><font color="navy">110</font><font color="red">)</font><b>then
     begin
           </b>xtrou1<font color="red">.</font>Top<font color="red">:=</font>xtrou1<font color="red">.</font>top<font color="red">-</font><font color="navy">30</font><font color="red">;
           </font>ytrou1<font color="red">.</font>Top<font color="red">:=</font>ytrou1<font color="red">.</font>top<font color="red">-</font><font color="navy">30</font><font color="red">;
           </font>xtroufin1<font color="red">.</font>Top<font color="red">:=</font>xtroufin1<font color="red">.</font>top<font color="red">-</font><font color="navy">30</font><font color="red">;
           </font>ytroufin1<font color="red">.</font>Top<font color="red">:=</font>ytroufin1<font color="red">.</font>top<font color="red">-</font><font color="navy">30</font><font color="red">;
           </font>ztrou1<font color="red">.</font>Top<font color="red">:=</font>ztrou1<font color="red">.</font>top<font color="red">-</font><font color="navy">30</font><font color="red">;
           </font>trou2<font color="red">.</font>Visible<font color="red">:=</font>false<font color="red">;

           </font>xtrou1<font color="red">.</font>Enabled<font color="red">:=</font>false<font color="red">;
           </font>ytrou1<font color="red">.</font>enabled<font color="red">:=</font>false<font color="red">;
           </font>xtroufin1<font color="red">.</font>Enabled<font color="red">:=</font>false<font color="red">;
           </font>ytroufin1<font color="red">.</font>enabled<font color="red">:=</font>false<font color="red">;
           </font>ztrou1<font color="red">.</font>Enabled<font color="red">:=</font>false<font color="red">;

           </font>new<font color="red">.</font>enabled<font color="red">:=</font>true<font color="red">;
           </font>new<font color="red">.</font>Top<font color="red">:= </font>new<font color="red">.</font>Top<font color="red">-</font><font color="navy">30</font><font color="red">;
           </font>ok<font color="red">.</font>Top<font color="red">:=</font>ok<font color="red">.</font>Top<font color="red">-</font><font color="navy">30</font><font color="red">;
           </font>del<font color="red">.</font>Top<font color="red">:=</font>del<font color="red">.</font>top<font color="red">-</font><font color="navy">30</font><font color="red">;
     </font><b>end
     else
     begin
        </b>xtrou<font color="red">.</font>Enabled<font color="red">:=</font>false<font color="red">;
        </font>ytrou<font color="red">.</font>enabled<font color="red">:=</font>false<font color="red">;
        </font>xtroufin<font color="red">.</font>Enabled<font color="red">:=</font>false<font color="red">;
        </font>ytroufin<font color="red">.</font>enabled<font color="red">:=</font>false<font color="red">;
        </font>ztrou<font color="red">.</font>Enabled<font color="red">:=</font>false<font color="red">;
        </font>trou1<font color="red">.</font>Visible<font color="red">:=</font>false<font color="red">;
        </font>ok<font color="red">.</font>enabled<font color="red">:=</font>false<font color="red">;
        </font>del<font color="red">.</font>enabled<font color="red">:=</font>false<font color="red">;
     </font><b>end</b><font color="red">;

</font><b>end</b><font color="red">;

</font><b>procedure </b>TFrame2<font color="red">.</font>xchange<font color="red">(</font>Sender<font color="red">: </font>TObject<font color="red">);
</font><b>begin
        if</b><font color="red">(</font>Edit1<font color="red">.</font>Text<font color="red">=</font><font color="blue">''</font><font color="red">) </font><b>then
        begin
            </b>Edit1<font color="red">.</font>Text<font color="red">:=</font>inttostr<font color="red">(</font><font color="navy">0</font><font color="red">);
        </font><b>end</b><font color="red">;
        </font><b>if</b><font color="red">(</font>strtoint<font color="red">(</font>Edit1<font color="red">.</font>Text<font color="red">)&gt;</font><font color="navy">270</font><font color="red">) </font><b>then
        begin
            </b>Edit1<font color="red">.</font>Text<font color="red">:=</font>inttostr<font color="red">(</font><font color="navy">270</font><font color="red">);
        </font><b>end</b><font color="red">;
        </font>Shape1<font color="red">.</font>width<font color="red">:= </font>strtoint<font color="red">(</font>Edit1<font color="red">.</font>Text<font color="red">)*</font><font color="navy">2</font><font color="red">;
        </font>validate<font color="red">(</font>Sender<font color="red">);
</font><b>end</b><font color="red">;

</font><b>procedure </b>TFrame2<font color="red">.</font>trou<font color="red">(</font>Sender<font color="red">: </font>TObject<font color="red">);
</font><b>begin
      if</b><font color="red">(</font>xtrou<font color="red">.</font>enabled<font color="red">=</font>false<font color="red">) </font><b>then
      begin
        </b>xtrou<font color="red">.</font>Enabled<font color="red">:=</font>true<font color="red">;
        </font>ytrou<font color="red">.</font>enabled<font color="red">:=</font>true<font color="red">;
        </font>xtroufin<font color="red">.</font>Enabled<font color="red">:=</font>true<font color="red">;
        </font>ytroufin<font color="red">.</font>enabled<font color="red">:=</font>true<font color="red">;
        </font>ztrou<font color="red">.</font>Enabled<font color="red">:=</font>true<font color="red">;
        </font>trou1<font color="red">.</font>Visible<font color="red">:=</font>true<font color="red">;
        </font>ok<font color="red">.</font>enabled<font color="red">:=</font>true<font color="red">;
        </font>del<font color="red">.</font>enabled<font color="red">:=</font>true<font color="red">;
      </font><b>end
      else
      begin
         if</b><font color="red">(</font>new<font color="red">.</font>top<font color="red">=</font><font color="navy">80</font><font color="red">)</font><b>then
         begin
             </b>xtrou1<font color="red">.</font>Top<font color="red">:=</font>xtrou1<font color="red">.</font>top<font color="red">+</font><font color="navy">30</font><font color="red">;
             </font>ytrou1<font color="red">.</font>Top<font color="red">:=</font>ytrou1<font color="red">.</font>top<font color="red">+</font><font color="navy">30</font><font color="red">;
             </font>xtroufin1<font color="red">.</font>Top<font color="red">:=</font>xtroufin1<font color="red">.</font>top<font color="red">+</font><font color="navy">30</font><font color="red">;
             </font>ytroufin1<font color="red">.</font>Top<font color="red">:=</font>ytroufin1<font color="red">.</font>top<font color="red">+</font><font color="navy">30</font><font color="red">;
             </font>ztrou1<font color="red">.</font>Top<font color="red">:=</font>ztrou1<font color="red">.</font>top<font color="red">+</font><font color="navy">30</font><font color="red">;
             </font>trou2<font color="red">.</font>Visible<font color="red">:=</font>true<font color="red">;

             </font>xtrou1<font color="red">.</font>Enabled<font color="red">:=</font>true<font color="red">;
             </font>ytrou1<font color="red">.</font>enabled<font color="red">:=</font>true<font color="red">;
             </font>xtroufin1<font color="red">.</font>Enabled<font color="red">:=</font>true<font color="red">;
             </font>ytroufin1<font color="red">.</font>enabled<font color="red">:=</font>true<font color="red">;
             </font>ztrou1<font color="red">.</font>Enabled<font color="red">:=</font>true<font color="red">;

             </font>new<font color="red">.</font>enabled<font color="red">:=</font>false<font color="red">;
         </font><b>end</b><font color="red">;
         </font>new<font color="red">.</font>Top<font color="red">:= </font>new<font color="red">.</font>Top<font color="red">+</font><font color="navy">30</font><font color="red">;
         </font>ok<font color="red">.</font>Top<font color="red">:=</font>ok<font color="red">.</font>Top<font color="red">+</font><font color="navy">30</font><font color="red">;
         </font>del<font color="red">.</font>Top<font color="red">:=</font>del<font color="red">.</font>top<font color="red">+</font><font color="navy">30</font><font color="red">;
      </font><b>end</b><font color="red">;

</font><b>end</b><font color="red">;

</font><b>procedure </b>TFrame2<font color="red">.</font>savefile<font color="red">(</font>Sender<font color="red">: </font>TObject<font color="red">);
</font><b>var
  </b>MyText<font color="red">: </font>TStringlist<font color="red">;
</font><b>begin
  </b>MyText<font color="red">:= </font>TStringlist<font color="red">.</font>create<font color="red">;
  </font><b>try
   </b>xtrou<font color="red">.</font>text <font color="red">:= </font>StringReplace<font color="red">(</font>xtrou<font color="red">.</font>text<font color="red">, </font><font color="blue">' '</font><font color="red">, </font><font color="blue">''</font><font color="red">, [</font>rfReplaceAll<font color="red">]); </font><font color="blue"><b>//Remove spaces
   </b></font>ytrou<font color="red">.</font>Text <font color="red">:= </font>StringReplace<font color="red">(</font>ytrou<font color="red">.</font>Text<font color="red">, </font><font color="blue">' '</font><font color="red">, </font><font color="blue">''</font><font color="red">, [</font>rfReplaceAll<font color="red">]); </font><font color="blue"><b>//Remove spaces
   </b></font>xtroufin<font color="red">.</font>text <font color="red">:= </font>StringReplace<font color="red">(</font>xtroufin<font color="red">.</font>text<font color="red">, </font><font color="blue">' '</font><font color="red">, </font><font color="blue">''</font><font color="red">, [</font>rfReplaceAll<font color="red">]); </font><font color="blue"><b>//Remove spaces
   </b></font>ytroufin<font color="red">.</font>text <font color="red">:= </font>StringReplace<font color="red">(</font>ytroufin<font color="red">.</font>text<font color="red">, </font><font color="blue">' '</font><font color="red">, </font><font color="blue">''</font><font color="red">, [</font>rfReplaceAll<font color="red">]); </font><font color="blue"><b>//Remove spaces
   </b></font>ztrou<font color="red">.</font>text <font color="red">:= </font>StringReplace<font color="red">(</font>ztrou<font color="red">.</font>text<font color="red">, </font><font color="blue">' '</font><font color="red">, </font><font color="blue">''</font><font color="red">, [</font>rfReplaceAll<font color="red">]); </font><font color="blue"><b>//Remove spaces
   </b></font>xtrou1<font color="red">.</font>text <font color="red">:= </font>StringReplace<font color="red">(</font>xtrou1<font color="red">.</font>text<font color="red">, </font><font color="blue">' '</font><font color="red">, </font><font color="blue">''</font><font color="red">, [</font>rfReplaceAll<font color="red">]); </font><font color="blue"><b>//Remove spaces
   </b></font>ytrou1<font color="red">.</font>text <font color="red">:= </font>StringReplace<font color="red">(</font>ytrou1<font color="red">.</font>text<font color="red">, </font><font color="blue">' '</font><font color="red">, </font><font color="blue">''</font><font color="red">, [</font>rfReplaceAll<font color="red">]); </font><font color="blue"><b>//Remove spaces
   </b></font>xtroufin1<font color="red">.</font>text <font color="red">:= </font>StringReplace<font color="red">(</font>xtroufin1<font color="red">.</font>text<font color="red">, </font><font color="blue">' '</font><font color="red">, </font><font color="blue">''</font><font color="red">, [</font>rfReplaceAll<font color="red">]); </font><font color="blue"><b>//Remove spaces
   </b></font>ytroufin1<font color="red">.</font>text <font color="red">:= </font>StringReplace<font color="red">(</font>ytroufin1<font color="red">.</font>text<font color="red">, </font><font color="blue">' '</font><font color="red">, </font><font color="blue">''</font><font color="red">, [</font>rfReplaceAll<font color="red">]); </font><font color="blue"><b>//Remove spaces
   </b></font>ztrou1<font color="red">.</font>Text <font color="red">:= </font>StringReplace<font color="red">(</font>ztrou1<font color="red">.</font>Text<font color="red">, </font><font color="blue">' '</font><font color="red">, </font><font color="blue">''</font><font color="red">, [</font>rfReplaceAll<font color="red">]); </font><font color="blue"><b>//Remove spaces

   </b></font><b>if</b><font color="red">(</font>xtrou<font color="red">.</font>Enabled<font color="red">=</font>true<font color="red">) </font><b>then
   begin
    </b>MyText<font color="red">.</font>Add<font color="red">(</font>xtrou<font color="red">.</font>text<font color="red">);
    </font>MyText<font color="red">.</font>Add<font color="red">(</font>ytrou<font color="red">.</font>text<font color="red">);
    </font>MyText<font color="red">.</font>Add<font color="red">(</font>xtroufin<font color="red">.</font>text<font color="red">);
    </font>MyText<font color="red">.</font>Add<font color="red">(</font>ytroufin<font color="red">.</font>text<font color="red">);
    </font>MyText<font color="red">.</font>Add<font color="red">(</font>ztrou<font color="red">.</font>text<font color="red">);
   </font><b>end</b><font color="red">;
   </font><b>if</b><font color="red">(</font>xtrou1<font color="red">.</font>Enabled<font color="red">=</font>true<font color="red">) </font><b>then
   begin
    </b>MyText<font color="red">.</font>Add<font color="red">(</font>xtrou1<font color="red">.</font>text<font color="red">);
    </font>MyText<font color="red">.</font>Add<font color="red">(</font>ytrou1<font color="red">.</font>text<font color="red">);
    </font>MyText<font color="red">.</font>Add<font color="red">(</font>xtroufin1<font color="red">.</font>text<font color="red">);
    </font>MyText<font color="red">.</font>Add<font color="red">(</font>ytroufin1<font color="red">.</font>text<font color="red">);
    </font>MyText<font color="red">.</font>Add<font color="red">(</font>ztrou1<font color="red">.</font>text<font color="red">);
   </font><b>end</b><font color="red">;
    </font>MyText<font color="red">.</font>Add<font color="red">(</font><font color="blue">'...'</font><font color="red">);
    </font>MyText<font color="red">.</font>SaveToFile<font color="red">(</font><font color="blue">'./test.txt'</font><font color="red">);
  </font><b>finally
    </b>MyText<font color="red">.</font>Free
  <b>end</b><font color="red">; </font><font color="blue"><b>{try}
</b></font><b>end</b><font color="red">;

</font><b>procedure </b>TFrame2<font color="red">.</font>readfile<font color="red">(</font>sender<font color="red">: </font>TObject<font color="red">);
</font><b>var
  </b>Txt<font color="red">: </font>TextFile<font color="red">;
  </font>s<font color="red">: </font><b>string</b><font color="red">;
  </font>AllText<font color="red">: </font><b>string</b><font color="red">;
  </font>i<font color="red">: </font>integer<font color="red">;

</font><b>begin
  </b>AllText <font color="red">:= </font><font color="blue">''</font><font color="red">;
  </font>AssignFile<font color="red">(</font>Txt<font color="red">, </font><font color="blue">'./test.txt'</font><font color="red">);
  </font>Reset<font color="red">(</font>Txt<font color="red">);
  </font>i<font color="red">:=</font><font color="navy">1</font><font color="red">;
  </font><b>while not </b>Eof<font color="red">(</font>Txt<font color="red">) </font><b>do
  begin
    </b>Readln<font color="red">(</font>Txt<font color="red">, </font>s<font color="red">);
    </font>AllText <font color="red">:= </font>AllText <font color="red">+ </font>s<font color="red">;

    </font><font color="blue"><b>// Write out each line; comment out to stop.
    //Writeln(s);
    </b></font><b>if</b><font color="red">(</font>i<font color="red">=</font><font color="navy">1</font><font color="red">) </font><b>then
    begin
          </b>xtrou<font color="red">.</font>text<font color="red">:=</font>s<font color="red">;
    </font><b>end</b><font color="red">;
    </font><b>if</b><font color="red">(</font>i<font color="red">=</font><font color="navy">2</font><font color="red">)</font><b>then
    begin
          </b>ytrou<font color="red">.</font>text<font color="red">:=</font>s<font color="red">;
    </font><b>end</b><font color="red">;
    </font><b>if</b><font color="red">(</font>i<font color="red">=</font><font color="navy">3</font><font color="red">)</font><b>then
    begin
          </b>xtroufin<font color="red">.</font>text<font color="red">:=</font>s<font color="red">;
    </font><b>end</b><font color="red">;
    </font><b>if</b><font color="red">(</font>i<font color="red">=</font><font color="navy">4</font><font color="red">)</font><b>then
    begin
          </b>ytroufin<font color="red">.</font>text<font color="red">:=</font>s<font color="red">;
    </font><b>end</b><font color="red">;
    </font><b>if</b><font color="red">(</font>i<font color="red">=</font><font color="navy">5</font><font color="red">)</font><b>then
    begin
          </b>ztrou<font color="red">.</font>text<font color="red">:=</font>s<font color="red">;
    </font><b>end</b><font color="red">;
    </font><b>if</b><font color="red">(</font>s<font color="red">=</font><font color="blue">'...'</font><font color="red">)</font><b>then
    begin
          </b>Exit<font color="red">();
    </font><b>end</b><font color="red">;
    </font><b>if</b><font color="red">(</font>i<font color="red">=</font><font color="navy">6</font><font color="red">)</font><b>then
    begin
          </b>xtrou1<font color="red">.</font>text<font color="red">:=</font>s<font color="red">;
    </font><b>end</b><font color="red">;
    </font><b>if</b><font color="red">(</font>i<font color="red">=</font><font color="navy">7</font><font color="red">)</font><b>then
    begin
          </b>ytrou1<font color="red">.</font>text<font color="red">:=</font>s<font color="red">;
    </font><b>end</b><font color="red">;
    </font><b>if</b><font color="red">(</font>i<font color="red">=</font><font color="navy">8</font><font color="red">)</font><b>then
    begin
          </b>xtroufin1<font color="red">.</font>text<font color="red">:=</font>s<font color="red">;
    </font><b>end</b><font color="red">;
    </font><b>if</b><font color="red">(</font>i<font color="red">=</font><font color="navy">9</font><font color="red">)</font><b>then
    begin
          </b>ytroufin1<font color="red">.</font>text<font color="red">:=</font>s<font color="red">;
    </font><b>end</b><font color="red">;
    </font><b>if</b><font color="red">(</font>i<font color="red">=</font><font color="navy">10</font><font color="red">)</font><b>then
    begin
          </b>ztrou1<font color="red">.</font>text<font color="red">:=</font>s<font color="red">;
    </font><b>end</b><font color="red">;

    </font>i<font color="red">:=</font>i<font color="red">+</font><font color="navy">1</font><font color="red">;
  </font><b>end</b><font color="red">;
  </font>CloseFile<font color="red">(</font>Txt<font color="red">);
  </font>validate<font color="red">(</font>Sender<font color="red">);

</font><b>end</b><font color="red">;

</font><b>end</b><font color="red">.
</font></font>
</code></pre>
</body>
</html>
