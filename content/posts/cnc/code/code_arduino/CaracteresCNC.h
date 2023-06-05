#ifndef CaracteresCNC_h
#define CaracteresCNC_h

#include "Arduino.h"
#include "ctype.h"

void setup_axe();
void sethome();
void sethome_axe_X();
void sethome_axe_Y();
void sethome_axe_Z();
void sethome_fraise();
void start_pros_decoupe();
void start_pros_defonce();
void start_pros_gravure();
void calibrage_foret();
void calibrage_pointe();
void execution();
void mise_en_place_valeur();
void mise_en_place_valeur_slice();
void mise_en_place_valeur_gravure();
void depart();
void val_F1();
void decoupe_F1();
void defoncage_F1();
void gravure_F1();
void retour_machine();
void retour_travail();
void calcul_Z_dep();
void retour_travail_caracs();
void afficherA();
void afficherB();
void afficherC();
void afficherD();
void afficherE();
void afficherF();
void afficherG();
void afficherH();
void afficherI();
void afficherJ();
void afficherK();
void afficherL();
void afficherM();
void afficherN();
void afficherO();
void afficherP();
void afficherQ();
void afficherR();
void afficherS();
void afficherT();
void afficherU();
void afficherV();
void afficherW();
void afficherX();
void afficherY();
void afficherZ();
void afficher1();
void afficher2();
void afficher3();
void afficher4();
void afficher5();
void afficher6();
void afficher7();
void afficher8();
void afficher9();
void afficher0();
void affiches1();

void xd(int val1);
void xg(int val2);
void yd(int val3);
void ym(int val4);
void zd(int val5);
void zm(int val6);

void recep_var();

#endif
