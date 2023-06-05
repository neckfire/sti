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

#define X_MIN_PIN           3

Stepper x_axis(X_AXIS_STEPS, X_STEP_PIN, X_DIR_PIN);
Stepper y_axis(Y_AXIS_STEPS, Y_STEP_PIN, Y_DIR_PIN);
Stepper z_axis(Z_AXIS_STEPS, Z_STEP_PIN, Z_DIR_PIN);

bool x_endstop = 0;
int data[38];

void setup() {
  pinMode(X_ENABLE_PIN, OUTPUT);
  pinMode(Y_ENABLE_PIN, OUTPUT);
  pinMode(Z_ENABLE_PIN, OUTPUT);
  pinMode(X_MIN_PIN, INPUT_PULLUP);
  
  digitalWrite(X_ENABLE_PIN, LOW);
  digitalWrite(Y_ENABLE_PIN, LOW);
  digitalWrite(Z_ENABLE_PIN, LOW);
  
  x_axis.setSpeed(17000);
  y_axis.setSpeed(100);
  z_axis.setSpeed(100);
  
  //x_axis.step(-5000);
  
  x_endstop = digitalRead(X_MIN_PIN);
  while (x_endstop == 1)
  {
    x_endstop = digitalRead(X_MIN_PIN);
    x_axis.setSpeed(4000);
    x_axis.step(-10);
  }

  x_axis.setSpeed(3000);
  x_axis.step(700);

  x_endstop = digitalRead(X_MIN_PIN);
  while (x_endstop == 1)
  {
    x_endstop = digitalRead(X_MIN_PIN);
    x_axis.setSpeed(2500);
    x_axis.step(-1);
  }
  x_axis.setSpeed(4000);
  x_axis.step(10000);

}
  
void loop() 
{
   deplace = Serial.readStringUntil('\n');
}
  

