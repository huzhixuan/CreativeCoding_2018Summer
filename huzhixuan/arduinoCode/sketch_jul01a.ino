#include <Keypad.h>
byte rows[4] = {2, 3, 4, 5};
byte columns[4] = {6, 7, 8, 9};
char keys[4][4] = {
  '1', '2', '3', 'A',
  '4', '5', '6', 'B',
  '7', '8', '9', 'C',
  '*', '0', '#', 'D'
};
Keypad mykeypad = Keypad( makeKeymap(keys), rows, columns, 4, 4);
void setup() {
  // put your setup code here, to run once:

  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  char key = mykeypad.getKey();
  if (key != NO_KEY) {
    Serial.write(key);
    delay(10);
  }

}
