//if pin 2 High & pin 3 Low spin in one direction
//if pin 2 low & pin 3 High spin in oposite direction
//if pin2 & pin3 same current, then stop the motor
const int controlPin1 = 2; //direction motor cont.
const int controlPin2 = 3; //direction motor control
const int enablePin = 9; //enable H-Brige, 5V motor nyala, 0V motor aus
const int directionPin = 4; //to change the direction
const int onoffSwitchPin = 5; // to turn on/off the motor from switch
const int potPin = A0; //how fast it will spin

int onoffState = 0;
int pOnoffState = 0;
int directionState = 0;
int pDirectionState = 0;

int motorEnable = 0;
int motorSpeed = 0;
int motorDirection = 1;

void setup() {
  // put your setup code here, to run once:
  pinMode(onoffSwitchPin, INPUT);
  pinMode(directionPin, INPUT);
  pinMode(controlPin1, OUTPUT);
  pinMode(controlPin2, OUTPUT);
  pinMode(enablePin, OUTPUT);
  digitalWrite(enablePin, LOW);

}

void loop() {
  // put your main code here, to run repeatedly:
  onoffState = digitalRead(onoffSwitchPin);
  delay(1);
  directionState = digitalRead(directionPin);
  motorSpeed = analogRead(potPin) / 4;

  if (onoffState != pOnoffState) {
    if (onoffState == HIGH) {
      motorEnable = !motorEnable;
    }
  }
  
  if (directionState != pDirectionState) {
    if (directionState == HIGH) {
      motorDirection = !motorDirection;
    }
  }

  if(motorDirection==1){
    digitalWrite(controlPin1,HIGH);
    digitalWrite(controlPin2,LOW);
  }else{
    digitalWrite(controlPin2,HIGH);
    digitalWrite(controlPin1,LOW);
  }

  if(motorEnable==1){
    analogWrite(enablePin,motorSpeed);
  }else{
    analogWrite(enablePin,0);
  }

  pDirectionState=directionState;
  pOnoffState=onoffState;


}
