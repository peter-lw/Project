#include <Servo.h>
Servo myservo;

const int red = 13;
const int yellow = 12;
const int green = 11;
const int switchPin = 3;
const int sensorPin = A0;

int switchState;
int pSwitchState = 0;
bool lock = false; // false is when unlock | true when lock
int sensVal = 0;
int numberKnock = 0;
int minim=40;
int maximum=100;

void setup() {
  // put your setup code here, to run once:
  myservo.attach(10);
  Serial.begin(9600);
  pinMode(red, OUTPUT);
  pinMode(yellow, OUTPUT);
  pinMode(green, OUTPUT);
  pinMode(switchState, INPUT);
  digitalWrite(green, HIGH);
  Serial.print("The box is unlock");
  myservo.write(0);
}

void loop() {
  // put your main code here, to run repeatedly:
  if (debouncingButton(switchState) == true && lock == false && switchState == false) {
    myservo.write(90);
    digitalWrite(red, HIGH);
    digitalWrite(green, LOW);
    Serial.println("box is lock");
    switchState = true;
    lock = true;
    delay(1000);
  }
  if (debouncingButton(switchState) == false && switchState == true) {
    switchState = false;
  }
  if (lock == true) {
    sensVal = analogRead(sensorPin);
    if (numberKnock < 3 && sensVal > 0) {
      if (checkKnock(sensVal) == true) {
        numberKnock++;
      }
      Serial.println(3 - numberKnock);
      Serial.println("more to knock");
    }
  }
  if (numberKnock == 3) {
    myservo.write(0);
    digitalWrite(red, LOW);
    digitalWrite(green, HIGH);
    Serial.println("box is unlock");
    lock = false;
    numberKnock = 0;
    delay(1000);
  }
  
}
bool checkKnock (int value) {
  if (value > minim && value < maximum) {
    digitalWrite(yellow, HIGH);
    delay(50);
    digitalWrite(yellow, LOW);
    Serial.print("knock is valid");
    Serial.println(value);
    return true;
  } else {
    Serial.print("knock is not valid");
    Serial.println(value);
    return false;
  }
}

bool debouncingButton(bool state) {
  bool stateNow = digitalRead(switchPin);
  if (state != stateNow) {
    delay(10);
    stateNow = digitalRead(switchPin);
  }
  return stateNow;
}
