#include<LiquidCrystal.h>
LiquidCrystal lcd(12,11,5,4,3,2);

const int switchPin = 6;
int switchState = 0;
int PswitchState = 0;
int reply;

void setup() {
  // put your setup code here, to run once:
  lcd.begin(16, 2);
  pinMode(switchPin, INPUT);
  lcd.print("Ask The");
  lcd.setCursor(0, 1);
  lcd.print("Crystal Ball!");

}

void loop() {
  // put your main code here, to run repeatedly:
  switchState = digitalRead(switchPin);
  if (switchState != PswitchState) {
    if (switchState == LOW) {
      reply = random(8);
    }
  }
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Crystal Ball say :");
  lcd.setCursor(0, 1);
  switch(reply){
    case 0:
    lcd.print("Yes");
    break;
    case 1:
    lcd.print("like");
    break;
    case 2:
    lcd.print("certainly");
    break;
    case 3:
    lcd.print("good");
    break;
    case 4:
    lcd.print("Unsure");
    break;
    case 5:
    lcd.print("Ask Again");
    break;
    case 6:
    lcd.print("Doubtful");
    break;
    case 7:
    lcd.print("No");
    break;
  }
  PswitchState=switchState;
}
