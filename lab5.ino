#include <Servo.h>
//declarar varibales
const int trigPin = 5;
const int echoPin = 6;
long duracion;
int distanciaCM;
Servo radarServo;
void setup(){
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  Serial.begin(9600);
  radarServo.attach(10);
}
void loop(){
  for(int i=0;i<=180;i++){
    radarServo.write(i);
    delay(50);
    
    digitalWrite(trigPin, LOW); 
    delayMicroseconds(4);
    digitalWrite(trigPin, HIGH); 
    delayMicroseconds(10);
    digitalWrite(trigPin, LOW);
    duracion = pulseIn(echoPin, HIGH);
    distanciaCM = duracion*0.034/2;
    
    Serial.print(i);
    Serial.print("*");
    Serial.print(distanciaCM);
    Serial.print("#");
  }
  
  for(int i=180;i>=0;i--){
    radarServo.write(i);
    delay(50);
    digitalWrite(trigPin, LOW); 
    delayMicroseconds(4);
    digitalWrite(trigPin, HIGH); 
    delayMicroseconds(10);
    digitalWrite(trigPin, LOW);
    duracion = pulseIn(echoPin, HIGH);
    distanciaCM = duracion*0.034/2;
    
    Serial.print(i);
    Serial.print("*");
    Serial.print(distanciaCM);
    Serial.print("#");
  }
}
