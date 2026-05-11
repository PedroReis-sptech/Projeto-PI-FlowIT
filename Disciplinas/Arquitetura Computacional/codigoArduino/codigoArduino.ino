#include "Ultrasonic.h"

int pinoTrigger = 12;
int pinoEcho = 13;
HC_SR04 sensor(pinoTrigger, pinoEcho);
int valorLeitura = 0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  float distancia = sensor.distance();

  if(distancia > 0 && distancia < 15){
    valorLeitura = 1;
  }else{
    valorLeitura = 0;
  }

  Serial.print(valorLeitura);
  Serial.println("");

  delay(1000);
}
