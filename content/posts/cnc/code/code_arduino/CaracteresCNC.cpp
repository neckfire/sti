#include "CaracteresCNC.h"
#include "Arduino.h"
#include "Stepper.h"
#include "ctype.h"

String data[38]; // Tableau pour stocker les données reçues sur le port série
String data2[38]; // Tableau pour stocker les données reçues sur le port série

#define X_STEP_PIN         54
#define X_DIR_PIN          55
#define X_ENABLE_PIN       38

#define Y_STEP_PIN         60
#define Y_DIR_PIN          61
#define Y_ENABLE_PIN       56

#define Z_STEP_PIN         46
#define Z_DIR_PIN          48
#define Z_ENABLE_PIN       62

#define X_AXIS_STEPS       40
#define Y_AXIS_STEPS       80
#define Z_AXIS_STEPS       80

#define X_MIN_PIN          3
#define Y_MIN_PIN          14
#define Z_MIN_PIN          18

#define fraise             8
#define start_defoncage    16
#define start_decoupe      17
#define start_gravure      23

// 1 mm -> 800 steps
int echelle = 800;

//String affi = 0 ;

int X_dep = 0 ;
int Y_dep = 0 ;
int Z_dep = 0 ;
int Z_dep_calcul = 0 ;
int X_l = 0 ;
int Y_l = 0 ;
int Z_l = 0 ;

int nb_passe = 0 ;
int X_l_gros = 0 ;
int Y_l_gros = 0 ;
int finission = 0 ;
int X_l_cop = 0 ;
int Y_l_cop = 0 ;
int Z_l_cop = 0 ;
int X_defonce = 0 ;
int Y_defonce = 0 ;

int origin_X = 0 ;
int origin_Y = 0 ;
int taille_objet_X = 0 ;
int taille_objet_Y = 0 ;
int X_l_origin = 0 ;
int Y_l_origin = 0 ;

int X_retour_machine = 0 ;
int Y_retour_machine = 0 ;
int Z_retour_machine = 0 ;

int X_retour_travail = 0 ;
int Y_retour_travail = 0 ;
int Z_retour_travail = 0 ;

int X_retour_travail_caracs = 0 ;
int Y_retour_travail_caracs = 0 ;
int Z_retour_travail_caracs = 0 ;

int diam_fraise = 4 ;
int diam_fraise_div = 2 ;
int hauteur_fraise = 46 ;

                  //ep_matériaux
                         //
int coordo[6] = {10, 10, 25, 30, 20, 2};
int coordo_grav[4] = {10, 10, 20, 1};

//String affiche[36] = {afficherA, afficherB, afficherC, afficherD, afficherE, afficherF, afficherG, afficherH, afficherI, afficherJ, afficherK, afficherL, afficherM, afficherN, afficherO, afficherP, afficherQ, afficherR, afficherS, afficherT, afficherU, afficherV, afficherW, afficherX, afficherY, afficherZ, afficher0, afficher1, afficher2, afficher3, afficher4, afficher5, afficher6, afficher7, afficher8, afficher9};

Stepper x_axis(X_AXIS_STEPS, X_STEP_PIN, X_DIR_PIN);
Stepper y_axis(Y_AXIS_STEPS, Y_STEP_PIN, Y_DIR_PIN);
Stepper z_axis(Z_AXIS_STEPS, Z_STEP_PIN, Z_DIR_PIN);

void setup_axe() // init broche
{
  pinMode(X_ENABLE_PIN, OUTPUT);
  pinMode(Y_ENABLE_PIN, OUTPUT);
  pinMode(Z_ENABLE_PIN, OUTPUT);
  pinMode(X_MIN_PIN, INPUT_PULLUP);
  pinMode(Y_MIN_PIN, INPUT_PULLUP);
  pinMode(Z_MIN_PIN, INPUT_PULLUP);
  pinMode(fraise, OUTPUT);
  
  digitalWrite(X_ENABLE_PIN, LOW);
  digitalWrite(Y_ENABLE_PIN, LOW);
  digitalWrite(Z_ENABLE_PIN, LOW);
  digitalWrite(fraise, LOW);
  
  x_axis.setSpeed(17000);
  y_axis.setSpeed(17000);
  z_axis.setSpeed(17000);

  diam_fraise_div = diam_fraise / 2;
}

///////////////

void sethome() // fonction retour fin de course
{
  sethome_axe_Z();
  sethome_axe_Y();
  sethome_axe_X();
}

///////////////

void sethome_axe_X() // sethome X
{
  while (digitalRead(X_MIN_PIN) == 1)
  {
    x_axis.setSpeed(4000);
    x_axis.step(-1);
  }

  while (digitalRead(X_MIN_PIN) == 0)
  {
    x_axis.setSpeed(2500);
    x_axis.step(1);
  }
}

/////////////////

void sethome_axe_Y() // sethome Y
{
  while (digitalRead(Y_MIN_PIN) == 1)
  {
    y_axis.setSpeed(4000);
    y_axis.step(-1);
  }

  while (digitalRead(Y_MIN_PIN) == 0)
  {
    y_axis.setSpeed(2500);
    y_axis.step(1);
  }
}

////////////////////

void sethome_axe_Z() // sethome Z
{
  while (digitalRead(Z_MIN_PIN) == 1)
  {
    z_axis.setSpeed(4000);
    z_axis.step(1);
  }

  while (digitalRead(Z_MIN_PIN) == 0)
  {
    z_axis.setSpeed(2500);
    z_axis.step(-1);
  }
}

////////////////

void sethome_fraise() // sethome fraise
{
  digitalWrite(fraise, HIGH);
  delay(750);
  digitalWrite(fraise, LOW);
}

////////////////

void start_pros_decoupe() // test fonction 1 (decoupe)
{
  mise_en_place_valeur();
  calcul_Z_dep();
  depart();
  val_F1();
  decoupe_F1();
}

////////////////

void start_pros_defonce() // test fonction 2 (défonce)
{
  mise_en_place_valeur();
  calcul_Z_dep();
  depart();
  val_F1();
  defoncage_F1();
}
////////////////

void start_pros_gravure() // test fonction 3 (gravure)
{
  mise_en_place_valeur_gravure();
  calcul_Z_dep();
  depart();
  // set speed travail
  x_axis.setSpeed(3500);
  y_axis.setSpeed(3500);
  z_axis.setSpeed(2500);
  
  afficherS();
  xd(15);
  zd(1);
  X_retour_travail_caracs = 0 ;
  Y_retour_travail_caracs = 0 ;
  afficherT();
  xd(15);
  zd(1);
  X_retour_travail_caracs = 0 ;
  Y_retour_travail_caracs = 0 ;
  afficherI();
  xd(15);
  zd(1);
  X_retour_travail_caracs = 0 ;
  Y_retour_travail_caracs = 0 ;
  afficher2();
  xd(15);
  zd(1);
  X_retour_travail_caracs = 0 ;
  Y_retour_travail_caracs = 0 ;
  afficherD();
}

////////////////

void execution()
{
  
}

////////////////

void mise_en_place_valeur_slice()
{
  X_dep = data[0].toInt();
  Y_dep = data[1].toInt();
  Z_dep_calcul = data[2].toInt();
  taille_objet_X = data[3].toInt();
  taille_objet_Y = data[4].toInt();
  X_l = data[5].toInt();
  Y_l = data[6].toInt();
  Z_l = data[7].toInt();
  X_l_origin = data[8].toInt();
  Y_l_origin = data[9].toInt();

  /*X_dep
  X_l = X_l_origin - origin_X;
  Y_l = Y_l_origin - origin_Y;*/
  Z_l = Z_l - Z_dep_calcul;
}

////////////////

void mise_en_place_valeur()
{
  X_dep = coordo[0];
  Y_dep = coordo[1];
  Z_dep_calcul = coordo[2];
  X_l = coordo[3];
  Y_l = coordo[4];
  Z_l = coordo[5];
}

////////////////

void mise_en_place_valeur_gravure()
{
  X_dep = coordo_grav[0];
  Y_dep = coordo_grav[1];
  Z_dep_calcul = coordo_grav[2];
  Z_l = coordo_grav[3];
  diam_fraise = 0;
  diam_fraise_div = 0;
}

////////////////

void depart()
{
  X_dep = X_dep + diam_fraise_div;
  Y_dep = Y_dep + diam_fraise_div;
  x_axis.setSpeed(10000);
  y_axis.setSpeed(10000);
  z_axis.setSpeed(7500);

  for (int X = 0; X < X_dep; X++)
  {
    x_axis.step(800);
    X_retour_machine = X_retour_machine + 1;
  }

  for (int Y = 0; Y < Y_dep; Y++)
  {
    y_axis.step(800);
    Y_retour_machine = Y_retour_machine + 1;
  }

  for (int Z = 0; Z < Z_dep; Z++)
  {
    z_axis.step(-800);
    Z_retour_machine = Z_retour_machine + 1;
  }
}
  
////////////////

void val_F1()
{
  X_l_cop = X_l;
  Y_l_cop = Y_l;
  Z_l_cop = Z_l;

  X_l = X_l-diam_fraise;
  Y_l = Y_l-diam_fraise;

  X_l_gros = X_l - 2;
  Y_l_gros = Y_l - 2;

  while(Z_l_cop >= 1)
  {
    Z_l_cop = Z_l_cop - 1;
    nb_passe = nb_passe + 1;
  }

  nb_passe = nb_passe * 2;
  
  if(X_l > 3)
  {
    finission = 2;
  }
  else
  {
    finission = 1;
  }

  while(Y_l_cop >= 1)
  {
    Y_l_cop = Y_l_cop - 1;
    Y_defonce = Y_defonce + 1;
  }
  Y_defonce = Y_defonce - 8;
  Y_defonce = Y_defonce / 2;

  while(X_l_cop >= 1)
  {
    X_l_cop = X_l_cop - 1;
    X_defonce = X_defonce + 1;
  }
  X_defonce = X_defonce - 8;
}

////////////////

void decoupe_F1()
{
  // set speed travail
  x_axis.setSpeed(4000);
  y_axis.setSpeed(4000);
  z_axis.setSpeed(3000);

  // démarrage fraise
  digitalWrite(fraise, HIGH);

  // positionnement passage grossier
  x_axis.step(800);
  y_axis.step(800);

  // passage grossier
  for (int P = 0; P < nb_passe; P++) 
  {
    z_axis.step(-400);
    for (int X = 0; X < X_l_gros; X++)
    {
      x_axis.step(800);
    }
    for (int Y = 0; Y < Y_l_gros; Y++)
    {
      y_axis.step(800);
    }
    for (int X = 0; X < X_l_gros; X++)
    {
      x_axis.step(-800);
    }
    for (int Y = 0; Y < Y_l_gros; Y++)
    {
      y_axis.step(-800);
    }
  }

  // revient début découpe
  for (int P = 0; P < nb_passe; P++)
  {
    z_axis.step(400);
  }

  // set speed finission
  x_axis.setSpeed(3500);
  y_axis.setSpeed(3500);
  z_axis.setSpeed(3000);

  // positionnement passage finition
  x_axis.step(-800);
  y_axis.step(-800);
  
  // finission brodure
  for (int P = 0; P < nb_passe; P++) 
  {
    z_axis.step(-400);
    for (int X = 0; X < X_l; X++)
    {
      x_axis.step(800);
    }
    for (int Y = 0; Y < Y_l; Y++)
    {
      y_axis.step(800);
    }
    for (int X = 0; X < X_l; X++)
    {
      x_axis.step(-800);
    }
    for (int Y = 0; Y < Y_l; Y++)
    {
      y_axis.step(-800);
    }
    for (int X = 0; X < finission; X++)
    {
      x_axis.step(800);
    }
    for (int X = 0; X < finission; X++)
    {
      x_axis.step(-800);
    }
  }

  // revient début découpe
  for (int P = 0; P < nb_passe; P++)
  {
    z_axis.step(400);
  }

  // arrêt fraise
  digitalWrite(fraise, LOW);

  // fin travail
  delay(2000);
  retour_machine();
}

////////////////

void defoncage_F1()
{
  // set speed travail
  x_axis.setSpeed(4000);
  y_axis.setSpeed(4000);
  z_axis.setSpeed(3000);

  // démarrage fraise
  digitalWrite(fraise, HIGH);

  // positionnement passage grossier
  x_axis.step(800);
  y_axis.step(800);

  // passage grossier + défonçage
  for (int P = 0; P < nb_passe; P++) 
  {
    z_axis.step(-400);
    for (int X = 0; X < X_l_gros; X++)
    {
      x_axis.step(800);
    }
    for (int Y = 0; Y < Y_l_gros; Y++)
    {
      y_axis.step(800);
    }
    for (int X = 0; X < X_l_gros; X++)
    {
      x_axis.step(-800);
    }
    for (int Y = 0; Y < Y_l_gros; Y++)
    {
      y_axis.step(-800);
    }

    // positionnement passage défonçage
    x_axis.step(800);

    // passage défonçage
    for (int nb = 0; nb < Y_defonce; nb++)
    {
      y_axis.step(800);
      for (int X = 0; X < X_defonce; X++)
      {
        x_axis.step(800);
      }
      y_axis.step(800);
      for (int X = 0; X < X_defonce; X++)
      {
        x_axis.step(-800);
      }
    }

    // revient début défonçage + contour
    z_axis.step(800);
    for (int nb = 0; nb < Y_defonce; nb++)
    {
      y_axis.step(-1600);
    }
    x_axis.step(-800);
    z_axis.step(800);
  }

  // set speed finission
  x_axis.setSpeed(3500);
  y_axis.setSpeed(3500);
  z_axis.setSpeed(3000);
  
  // positionnement pour passage finition
  x_axis.step(-800);
  y_axis.step(-800);
  
  // finission brodure
  for (int P = 0; P < nb_passe; P++) 
  {
    z_axis.step(-400);
    for (int X = 0; X < X_l; X++)
    {
      x_axis.step(800);
    }
    for (int Y = 0; Y < Y_l; Y++)
    {
      y_axis.step(800);
    }
    for (int X = 0; X < X_l; X++)
    {
      x_axis.step(-800);
    }
    for (int Y = 0; Y < Y_l; Y++)
    {
      y_axis.step(-800);
    }
    for (int X = 0; X < finission; X++)
    {
      x_axis.step(800);
    }
    for (int X = 0; X < finission; X++)
    {
      x_axis.step(-800);
    }
  }

  // revient début découpe
  for (int P = 0; P < nb_passe; P++)
  {
    z_axis.step(400);
  }

  // arrêt fraise
  digitalWrite(fraise, LOW);

  // fin travail
  delay(2000);
  retour_machine();
}

////////////////

void gravure_F1()
{
  // set speed travail
  x_axis.setSpeed(3500);
  y_axis.setSpeed(3500);
  z_axis.setSpeed(2500);

  xd(1);
  yd(1);

  delay(500);

  affiches1();
}

////////////////

void retour_machine()
{
  x_axis.setSpeed(10000);
  y_axis.setSpeed(10000);
  z_axis.setSpeed(7500);

  for (int Z = 0; Z < Z_retour_machine; Z++)
  {
    z_axis.step(800);
  }

  for (int X = 0; X < X_retour_machine; X++)
  {
    x_axis.step(-800);
  }

  for (int Y = 0; Y < Y_retour_machine; Y++)
  {
    y_axis.step(-800);
  }

  X_retour_machine = 0;
  Y_retour_machine = 0;
  Z_retour_machine = 0;
}

////////////////

void retour_travail()
{
  //
}

////////////////

void calcul_Z_dep()
{
  Z_dep = hauteur_fraise - Z_dep_calcul;
}

////////////////

void calibrage_foret()
{
  calcul_Z_dep();
  X_dep = X_dep + diam_fraise_div;
  Y_dep = Y_dep + diam_fraise_div;
  x_axis.setSpeed(10000);
  y_axis.setSpeed(10000);
  z_axis.setSpeed(7500);

  for (int X = 0; X < X_dep; X++)
  {
    x_axis.step(800);
    X_retour_machine = X_retour_machine + 1;
  }

  for (int Y = 0; Y < Y_dep; Y++)
  {
    y_axis.step(800);
    Y_retour_machine = Y_retour_machine + 1;
  }

  for (int Z = 0; Z < Z_dep; Z++)
  {
    z_axis.step(-800);
    Z_retour_machine = Z_retour_machine + 1;
  }
}

////////////////

void calibrage_pointe()
{
  calcul_Z_dep();
  x_axis.setSpeed(10000);
  y_axis.setSpeed(10000);
  z_axis.setSpeed(7500);

  for (int X = 0; X < X_dep; X++)
  {
    x_axis.step(800);
    X_retour_machine = X_retour_machine + 1;
  }

  for (int Y = 0; Y < Y_dep; Y++)
  {
    y_axis.step(800);
    Y_retour_machine = Y_retour_machine + 1;
  }

  for (int Z = 0; Z < Z_dep; Z++)
  {
    z_axis.step(-800);
    Z_retour_machine = Z_retour_machine + 1;
  }
}

////////////////

void recep_var()
{
  if (Serial.available()) 
  { // Si des données sont disponibles sur le port série
      String message = Serial.readStringUntil('\n'); // Lit les données jusqu'à un retour à la ligne
      message.trim(); // Supprime les espaces en début et fin de chaîne
  
      // Découpe la chaîne de caractères en 38 sous-chaînes séparées par des virgules
      for (int i = 0; i < 38; i++) 
      {
        int commaIndex = message.indexOf(',');
        if (commaIndex >= 0) 
        {
          String value = message.substring(0, commaIndex);
          message = message.substring(commaIndex + 1);
          data[i] = value;
        }
      }
      
if (data[0]=="x") 
  {
    if (data[1].toInt()>0) 
    {
      for (int X = 0; X < data[1].toInt(); X++)
      {
        x_axis.step(800);
      }
    }
    else
    {
      for (int X = 0; X < -data[1].toInt(); X++)
      {
        x_axis.step(-800);
      }
    }
  }
  if (data[0]=="y") 
  {
    if (data[1].toInt()>0) 
    {
      for (int X = 0; X < data[1].toInt(); X++)
      {
        y_axis.step(800);
      }
    }
    else
    {
      for (int X = 0; X < -data[1].toInt(); X++)
      {
        y_axis.step(-800);
      }
    }
  }
  if (data[0]=="z") 
  {
    if (data[1].toInt()>0) 
    {
      for (int X = 0; X < data[1].toInt(); X++)
      {
        z_axis.step(800);
      }
    }
    else
    {
      for (int X = 0; X < -data[1].toInt(); X++)
      {
        z_axis.step(-800);
      }
    }
  }
  if (data[0]=="o") 
  {
    digitalWrite(fraise, LOW);
  }
  if (data[0]=="i") 
  {
    digitalWrite(fraise, HIGH);
  }
      
  if (data[0]=="t1") // test découpe
  {
    start_pros_decoupe();
  }
  if (data[0]=="t2") // test défonce
  {
    start_pros_defonce();
  }
  if (data[0]=="t3") // test gravure
  {
    start_pros_gravure();
  }
  if (data[0]=="t4") // test calibrage
  {
    calibrage_foret();
  }
  if (data[0]=="t5") // test calibrage
  {
    calibrage_pointe();
  }
  if (data[0]=="t") //écrire du texte
  {
    /*mise_en_place_valeur_gravure();
    calcul_Z_dep();
    depart();

    // set speed travail
    x_axis.setSpeed(3500);
    y_axis.setSpeed(3500);
    z_axis.setSpeed(2500);
    for (int N = 1; N < 36; N++)
    {
      affi = data[N];
      (*affiche[int(affi) - 1])();
      xd(15);
      zd(1);
      X_retour_travail_caracs = 0 ;
      Y_retour_travail_caracs = 0 ;
    }*/
    
  }
      
  if (data[0]=="r") 
  {
    sethome();
  }

  if (data[0].toInt() != 0)
  {
    mise_en_place_valeur_slice();
    calcul_Z_dep();
    depart();
    val_F1();
    
    // set speed travail
    x_axis.setSpeed(4000);
    y_axis.setSpeed(4000);
    z_axis.setSpeed(3000);

    // démarrage fraise
    digitalWrite(fraise, HIGH);

    // positionnement passage grossier
    x_axis.step(800);
    y_axis.step(800);

    // passage grossier
    for (int P = 0; P < nb_passe; P++) 
    {
      z_axis.step(-400);
      for (int X = 0; X < X_l_gros; X++)
      {
        x_axis.step(800);
      }
      for (int Y = 0; Y < Y_l_gros; Y++)
      {
        y_axis.step(800);
      }
      for (int X = 0; X < X_l_gros; X++)
      {
        x_axis.step(-800);
      }
      for (int Y = 0; Y < Y_l_gros; Y++)
      {
        y_axis.step(-800);
      }
    }

    // revient début découpe
    for (int P = 0; P < nb_passe; P++)
    {
      z_axis.step(400);
    }

    // set speed finission
    x_axis.setSpeed(3500);
    y_axis.setSpeed(3500);
    z_axis.setSpeed(3000);

    // positionnement passage finition
    x_axis.step(-800);
    y_axis.step(-800);
    
    // finission brodure
    for (int P = 0; P < nb_passe; P++) 
    {
      z_axis.step(-400);
      for (int X = 0; X < X_l; X++)
      {
        x_axis.step(800);
      }
      for (int Y = 0; Y < Y_l; Y++)
      {
        y_axis.step(800);
      }
      for (int X = 0; X < X_l; X++)
      {
        x_axis.step(-800);
      }
      for (int Y = 0; Y < Y_l; Y++)
      {
        y_axis.step(-800);
      }
      for (int X = 0; X < finission; X++)
      {
        x_axis.step(800);
      }
      for (int X = 0; X < finission; X++)
      {
        x_axis.step(-800);
      }
    }

    // revient début découpe
    for (int P = 0; P < nb_passe; P++)
    {
      z_axis.step(400);
    }

    // arrêt fraise
    digitalWrite(fraise, LOW);

    // fin travail
    delay(2000);
    retour_machine();
  }

      // Envoie les données stockées sur le port série
      for (int i = 0; i < 38; i++) {
        Serial.print(data[i]);
        if (i < 37) { // Ajoute un hashtag entre chaque valeur (sauf après la dernière)
          Serial.print("#");
        }
      }
      for (int i = 0; i < 38; i++) {
          data[i] = '#';
      }
      Serial.println(); // Ajoute deux retour à la ligne à la fin de la liste de données
      Serial.println();
      data[0] = 'w';
  }
}

////////////////
////////////////
////////////////
// Code caractères

void retour_travail_caracs()
{
  for (int X = 0; X < X_retour_travail_caracs; X++)
  {
    x_axis.step(-800);
  }
  for (int Y = 0; Y < Y_retour_travail_caracs; Y++)
  {
    y_axis.step(-800);
  }
  X_retour_travail_caracs = 0 ;
  Y_retour_travail_caracs = 0 ;
}

// boucle mouvement

void xd(int val1)
{
  for (int X = 0; X < val1; X++)
  {
    x_axis.step(800);
    X_retour_travail_caracs = X_retour_travail_caracs + 1;
  }
}

void xg(int val2)
{
  for (int X = 0; X < val2; X++)
  {
    x_axis.step(-800);
    X_retour_travail_caracs = X_retour_travail_caracs - 1;
  }
}

void yd(int val3)
{
  for (int Y = 0; Y < val3; Y++)
  {
    y_axis.step(800);
    Y_retour_travail_caracs = Y_retour_travail_caracs + 1;
  }
}

void ym(int val4)
{
  for (int Y = 0; Y < val4; Y++)
  {
    y_axis.step(-800);
    Y_retour_travail_caracs = Y_retour_travail_caracs - 1;
  }
}

void zd(int val5)
{
  for (int Z = 0; Z < val5; Z++)
  {
    z_axis.step(-800);
  }
}

void zm(int val6)
{
  for (int Z = 0; Z < val6; Z++)
  {
    z_axis.step(800);
  }
}

// boucle caractères

void afficherA() 
{
  // placer avant travail à rat le matériaux
  zm(1);
  yd(2);

  //mise en route fraise
  digitalWrite(fraise, HIGH);

  // descente pour début travail
  zd(2);

  // début travail
  xd(2);
  ym(2);
  xd(6);
  yd(2);
  xd(2);
  yd(13);
  xg(2);
  ym(6);
  xg(6);
  yd(6);
  xg(2);
  ym(13);

  // lève pour déplacement
  zm(2);

  // déplacement
  xd(2);

  // descente pour reprendre travail
  zd(2);

  // travail
  xd(6);
  yd(4);
  xg(6);
  ym(4);
  
  // fin travail
  // remonte fraise
  zm(2);
  // arrêt fraise
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherB()
{
  digitalWrite(fraise, HIGH);
  // descente pour début travail
  zd(1);

  // travail
  xd(8);
  yd(2);
  xd(2);
  yd(4);
  xg(2);
  yd(3);
  xd(2);
  yd(4);
  xg(2);
  yd(2);
  xg(8);
  ym(15);

  // déplacement
  zm(2);
  xd(2);
  yd(2);
  zd(2);  

  //reprise travail
  xd(6);
  yd(4);
  xg(6);
  ym(4);

  // déplacement
  zm(2);
  yd(7);
  zd(2);  

  //reprise travail
  xd(6);
  yd(4);
  xg(6);
  ym(4);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherC() 
{
  // placer avant travail à rat le matériaux
  zm(1);
  yd(2);

  digitalWrite(fraise, HIGH);

  // descente pour début travail
  zd(2);

  // travail
  xd(2);
  ym(2);
  xd(6);
  yd(2);
  xd(2);
  yd(2);
  xg(2);
  ym(2);
  xg(6);
  yd(11);
  xd(6);
  ym(2);
  xd(2);
  yd(2);
  xg(2);
  yd(2);
  xg(6);
  ym(2);
  xg(2);
  ym(11);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherD() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  xd(8);
  yd(2);
  xd(2);
  yd(11);
  xg(2);
  yd(2);
  xg(8);
  ym(15);
  
  // déplacement
  zm(2);
  xd(2);
  yd(2);
  zd(2);

  //reprise travail
  xd(6);
  yd(11);
  xg(6);
  ym(11);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherE() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  xd(10);
  yd(2);
  xg(8);
  yd(4);
  xd(6);
  yd(3);
  xg(6);
  yd(4);
  xd(8);
  yd(2);
  xg(10);
  ym(15);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherF() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  xd(10);
  yd(2);
  xg(8);
  yd(4);
  xd(6);
  yd(3);
  xg(6);
  yd(6);
  xg(2);
  ym(15);  

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherG() 
{
  // placer avant travail à rat le matériaux
  zm(1);
  yd(2);

  //mise en route fraise
  digitalWrite(fraise, HIGH);

  // descente pour début travail
  zd(2);

  // travail
  xd(2);
  ym(2);
  xd(6);
  yd(2);
  xd(2);
  yd(2);
  xg(2);
  ym(2);
  xg(6);
  yd(11);
  xd(6);
  ym(2);
  xg(2);
  ym(2);
  xd(4);
  yd(4);
  xg(2);
  yd(2);
  xg(6);
  ym(2);
  xg(2);
  ym(11);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherH() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  xd(2);
  yd(6);
  xd(6);
  ym(6);
  xd(2);
  yd(15);
  xg(2);
  ym(6);
  xg(6);
  yd(6);
  xg(2);
  ym(15);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherI() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  xd(10);
  yd(2);
  xg(4);
  yd(11);
  xd(4);
  yd(2);
  xg(10);
  ym(2);
  xd(4);
  ym(11);
  xg(4);
  ym(2);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherJ() 
{
  // placer avant travail à rat le matériaux
  zm(1);
  xd(4);

  //mise en route fraise
  digitalWrite(fraise, HIGH);

  // descente pour début travail
  zd(2);

  // travail
  xd(6);
  yd(2);
  xg(2);
  yd(11);
  xg(2);
  yd(2);
  xg(4);
  ym(2);
  xg(2);
  ym(3);
  xd(2);
  yd(3);
  xd(4);
  ym(11);
  xg(2);
  ym(2);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherK() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  xd(2);
  yd(6);
  xd(2);
  ym(2);
  xd(2);
  ym(2);
  xd(2);
  ym(2);
  xd(2);
  yd(2);
  xg(2);
  yd(2);
  xg(2);
  yd(2);
  xg(2);
  yd(3);
  xd(2);
  yd(2);
  xd(2);
  yd(2);
  xd(2);
  yd(2);
  xg(2);
  ym(2);
  xg(2);
  ym(2);
  xg(2);
  ym(2);
  xg(2);
  yd(6);
  xg(2);
  ym(15);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherL() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  xd(2);
  yd(13);
  xd(8);
  yd(2);
  xg(10);
  ym(15);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherM() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  xd(2);
  yd(2);
  xd(2);
  yd(2);
  xd(2);
  ym(2);
  xd(2);
  ym(2);
  xd(2);
  yd(15);
  xg(2);
  ym(11);
  xg(2);
  yd(4);
  xg(2);
  ym(4);
  xg(2);
  yd(11);
  xg(2);
  ym(15);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherN() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  xd(2);
  yd(4);
  xd(2);
  yd(2);
  xd(2);
  yd(2);
  xd(2);
  ym(8);
  xd(2);
  yd(15);
  xg(2);
  ym(5);
  xg(2);
  ym(2);
  xg(2);
  ym(2);
  xg(2);
  yd(9);
  xg(2);
  ym(15);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherO() 
{
  // placer avant travail à rat le matériaux
  zm(1);
  xd(2);

  //mise en route fraise
  digitalWrite(fraise, HIGH);

  // descente pour début travail
  zd(2);

  // travail
  xd(6);
  yd(2);
  xd(2);
  yd(11);
  xg(2);
  yd(2);
  xg(6);
  ym(2);
  xg(2);
  ym(11);
  xd(2);
  ym(2);

  // lève pour déplacement
  zm(2);

  // déplacement
  yd(2);

  // descente pour reprendre travail
  zd(2);

  // travail
  xd(6);
  yd(11);
  xg(6);
  ym(11);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherP() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  xd(8);
  yd(2);
  xd(2);
  yd(4);
  xg(2);
  yd(2);
  xg(6);
  yd(7);
  xg(2);
  ym(15);

  //boucle
  xd(2);
  zm(2);
  yd(2);
  zd(2);
  xd(6);
  yd(4);
  xg(6);
  ym(4);
  zm(2);
  ym(2);
  xg(2);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherQ() 
{
  // placer avant travail à rat le matériaux
  zm(1);
  xd(2);

  //mise en route fraise
  digitalWrite(fraise, HIGH);

  // descente pour début travail
  zd(2);

  // travail
  xd(6);
  yd(2);
  xd(2);
  yd(8);
  xg(2);
  yd(2);
  xd(2);
  yd(2);
  xg(2);
  ym(2);
  xg(2);
  yd(2);
  xg(4);
  ym(2);
  xg(2);
  ym(10);
  xd(8);
  yd(8);
  xg(2);
  ym(2);
  xg(2);
  yd(2);
  xd(2);
  yd(2);
  xg(4);
  ym(12);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherR() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  xd(8);
  yd(2);
  xd(2);
  yd(4);
  xg(2);
  yd(2);
  xg(2);
  yd(2);
  xd(2);
  yd(2);
  xd(2);
  yd(2);
  xg(2);
  ym(2);
  xg(2);
  ym(2);
  xg(2);
  yd(6);
  xg(2);
  ym(14);

  // lève pour déplacement
  zm(2);

  // déplacement
  xd(2);
  yd(2);

  // descente pour reprendre travail
  zd(2);

  // travail
  xd(6);
  yd(4);
  xg(6);
  ym(4);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherS() 
{
  // placer avant travail à rat le matériaux
  zm(1);
  xd(2);

  //mise en route fraise
  digitalWrite(fraise, HIGH);

  // descente pour début travail
  zd(2);

  // travail
  xd(8);
  yd(2);
  xg(8);
  yd(4);
  xd(6);
  yd(2);
  xd(2);
  yd(4);
  xg(2);
  yd(2);
  xg(8);
  ym(2);
  xd(8);
  ym(4);
  xg(6);
  ym(2);
  xg(2);
  ym(4);
  xd(2);
  ym(2);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherT() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  xd(10);
  yd(2);
  xg(4);
  yd(12);
  xg(2);
  ym(12);
  xg(4);
  ym(2);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherU() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  xd(2);
  yd(12);
  xd(6);
  ym(12);
  xd(2);
  yd(12);
  xg(2);
  yd(2);
  xg(6);
  ym(2);
  xg(2);
  ym(12);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherV() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  yd(8); 
  xd(2);
  yd(4);
  xd(2);
  yd(2);
  xd(2);
  ym(2);
  xd(2);
  ym(4);
  xd(2);
  ym(8);
  xg(2);
  yd(8);
  xg(2);
  yd(4);
  xg(2);
  ym(4);
  xg(2);
  ym(8);
  xg(2);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherW() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  xd(2);
  yd(12);
  xd(2);
  ym(6);
  xd(2);
  yd(6);
  xd(2);
  ym(12);
  xd(2);
  yd(12);
  xg(2);
  yd(2);
  xg(2);
  ym(2);
  xg(2);
  yd(2);
  xg(2);
  ym(2);
  xg(2);
  ym(12);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherX() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  xd(2);
  yd(4);
  xd(2);
  yd(2);
  xd(2);
  ym(2);
  xd(2);
  ym(4);
  xd(2);
  yd(4);
  xg(2);
  yd(2);
  xg(2);
  yd(2);
  xd(2);
  yd(2);
  xd(2);
  yd(4);
  xg(2);
  ym(4);
  xg(2);
  ym(2);
  xg(2);
  yd(2);
  xg(2);
  yd(4);
  xg(2);
  ym(4);
  xd(2);
  ym(2);
  xd(2);
  ym(2);
  xg(2);
  ym(2);
  xg(2);
  ym(4);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherY() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  xd(2);
  yd(4);
  xd(2);
  yd(2);
  xd(2);
  ym(2);
  xd(2);
  ym(4);
  xd(2);
  yd(4);
  xg(2);
  yd(2);
  xg(2);
  yd(8);
  xg(2);
  ym(8);
  xg(2);
  ym(2);
  xg(2);
  ym(4);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficherZ() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  xd(10);
  yd(4);
  xg(2);
  yd(2);
  xg(2);
  yd(2);
  xg(2);
  yd(2);
  xg(2);
  yd(2);
  xd(8);
  yd(2);
  xg(10);
  ym(4);
  xd(2);
  ym(2);
  xd(2);
  ym(2);
  xd(2);
  ym(2);
  xd(2);
  ym(2);
  xg(8);
  ym(2);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficher0() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficher1() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficher2() 
{
  // placer avant travail à rat le matériaux
  zm(1);
  xd(2);

  //mise en route fraise
  digitalWrite(fraise, HIGH);

  // descente pour début travail
  zd(2);

  // travail
  xd(6);
  yd(2);
  xd(2);
  yd(4);
  xg(2);
  yd(2);
  xg(2);
  yd(2);
  xg(2);
  yd(2);
  xd(6);
  yd(2);
  xg(10);
  ym(2);
  xd(2);
  ym(2);
  xd(2);
  ym(2);
  xd(2);
  ym(2);
  xd(2);
  ym(4);
  xg(6);
  yd(2);
  xg(2);
  ym(2);
  xd(2);
  ym(2);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficher3() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficher4() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficher5() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficher6() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficher7() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficher8() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void afficher9() 
{
  // descente pour début travail
  zd(1);
  digitalWrite(fraise, HIGH);

  // travail
  

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}

void affiches1()
{
  // placer avant travail à rat le matériaux
  zm(1);
  xd(10);

  //mise en route fraise
  digitalWrite(fraise, HIGH);

  // descente pour début travail
  zd(2);

  // travail
  xd(8);	//debut premier cercle
  yd(2);
  xd(4);
  yd(2);
  xd(2);
  yd(2);
  xd(2);
  yd(4);
  xd(2);
  yd(8);
  xg(2);
  yd(4);
  xg(2);
  yd(2);
  xg(2);
  yd(2);
  xg(4);
  yd(2);
  xg(8);
  ym(2);
  xg(4);
  ym(2);
  xg(2);
  ym(2);
  xg(2);
  ym(4);
  xg(2);
  ym(8);
  xd(2);
  ym(4);
  xg(2);
  ym(2);
  xd(2);
  ym(2);
  xd(4);
  ym(2);	//fin premier cercle

  zm(2);
  yd(2);
  zd(2);

  xd(8);	//début deuxième cercle
  yd(2);
  xd(4);
  yd(2);
  xd(2);
  yd(2);
  xd(2);
  yd(4);
  xd(2);
  yd(8);
  xg(2);
  yd(4);
  xg(2);
  yd(2);
  xg(2);
  yd(2);
  xg(4);
  yd(2);
  xg(8);
  ym(2);
  xg(4);
  ym(2);
  xg(2);
  ym(2);
  xg(2);
  ym(4);
  xg(2);
  ym(8);
  xd(2);
  ym(4);
  xg(2);
  ym(2);
  xd(2);
  ym(2);
  xd(4);	//fin deuxième cercle

  zm(2);		//première oeil
  yd(6);
  zd(2);

  yd(4);
  xg(4);
  ym(4);
  xd(4);

  zm(2);		// deuxieme oeil
  xd(12);
  zd(2);

  yd(4);
  xg(4);
  ym(4);
  xd(4);

  zm(2);	//bouche
  yd(6);
  zd(2);

  yd(2);
  xg(2);
  yd(2);
  xg(2);
  yd(2);
  xg(8);
  ym(2);
  xg(2);
  ym(2);
  xg(2);
  ym(2);
  xd(2);
  yd(2);
  xd(2);
  yd(2);
  xd(8);
  ym(2);
  xd(2);
  ym(2);
  xd(2);

  // fin travail
  // remonte fraise
  zm(2);
  digitalWrite(fraise, LOW);
  delay(500);
  retour_travail_caracs();
  delay(500);
}