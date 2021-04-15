//Solving Debouncing !!

const int switchPin = 2;
const int motorPin = 9;
bool switchState = false;
bool temp = false; //motor status, false: motor aus ; true: motor an.

void setup() {
  // put your setup code here, to run once:
  pinMode(switchPin, INPUT);
  pinMode(motorPin, OUTPUT);

}

void loop() {
  // put your main code here, to run repeatedly:
  if (debouncingButton(switchState) == true && switchState == false && temp == false) { 
    digitalWrite(motorPin, HIGH);
    temp = true;
    switchState = true;
  }
  if (debouncingButton(switchState) == false && switchState == true) {
    switchState = false;
  }
  if (debouncingButton(switchState) == true && switchState == false && temp == true) { 
    digitalWrite(motorPin, LOW);
    temp = false;
    switchState = true;
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
