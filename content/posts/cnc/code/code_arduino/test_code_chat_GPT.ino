  // 32 000 steps max
  // 32 000 steps -> 4 cm 
  // 1 mm -> 800 steps
String data[38]; // Tableau pour stocker les données reçues sur le port série
String data2[38]; // Tableau pour stocker les données reçues sur le port série


#include <Stepper.h>

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
#define start_pros         16

// 1 mm -> 800 steps
int echelle = 800;


int X_dep = 90 ;
int Y_dep = 15 ;
int Z_dep = 22 ;

int F_1_1 = 10 ;
int F_1_2 = 10 ;
int F_1_Z = 3 ;

Stepper x_axis(X_AXIS_STEPS, X_STEP_PIN, X_DIR_PIN);
Stepper y_axis(Y_AXIS_STEPS, Y_STEP_PIN, Y_DIR_PIN);
Stepper z_axis(Z_AXIS_STEPS, Z_STEP_PIN, Z_DIR_PIN);


void setup() 
{
  Serial.begin(115200); // Initialise le port série à 115200 bauds
  setup_axe();
  sethome();
  sethome_fraise();

  mise_en_place_valeur();
  
}

///////////////

void setup_axe()
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
}

///////////////

void loop() 
{
//  if(digitalRead(start_pros) == 0)
//  {
//    depart();
//  }

  
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
      
      if (data[0]=="t1") 
      {
          //test1
      }
      if (data[0]=="t2") 
      {
          //test2
      }
      if (data[0]=="t3") 
      {
          //test3
      }
      
      if (data[0]=="r") 
      {
        sethome();
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
    
  }
}

///////////////

void sethome()
{
  sethome_axe_Z();
  sethome_axe_X();
  sethome_axe_Y();
}

///////////////

void sethome_axe_X()
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

void sethome_axe_Y()
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

void sethome_axe_Z()
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

void sethome_fraise()
{
  digitalWrite(fraise, HIGH);
  delay(750);
  digitalWrite(fraise, LOW);
}

////////////////

void mise_en_place_valeur()
{
  
}

////////////////

void depart()
{
  x_axis.setSpeed(10000);
  y_axis.setSpeed(10000);
  z_axis.setSpeed(7500);

  for (int X = 0; X < X_dep; X++)
  {
    x_axis.step(800);
  }

  for (int Y = 0; Y < Y_dep; Y++)
  {
    y_axis.step(800);
  }

  for (int Z = 0; Z < Z_dep; Z++)
  {
    z_axis.step(-800);
  }
  
}
  
