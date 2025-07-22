#include <Wire.h>

#define TRIG_PIN 9
#define ECHO_PIN 10

int masterSensorPins[3] = {A0, A1, A2};
int allSensors[3];

int eventLog[7] = {0, 0, 0, 0, 0, 0, 0};
int currentIndex = 0;
bool objectWasDetected = false;
bool readyToSend = false;

bool forceIdleSeen = true;  // allow first reading

void setup() {

  Serial.begin(9600);
  Wire.begin(8);
  Wire.onReceive(receiveEvent); /* register receive event */
  Wire.onRequest(requestEvent); /* register request event */

  pinMode(TRIG_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
  pinMode(6, OUTPUT);
  pinMode(7, OUTPUT);

  for (int i = 0; i < 3; i++) {
    pinMode(masterSensorPins[i], INPUT);
  }
}

// void loop() {
//   long distance = getUltrasonicDistance();
//   int result = 0;

//   if (distance < 60) {
//     Serial.print("Object detected at: ");
//     Serial.print(distance);
//     Serial.println(" cm");
//     readAllSensors();
//     displaySensorValues();
//     result = analyzePattern(allSensors, 3);
// 	Serial.print("Pattern Result: ");
// 	Serial.println(result);
//   // result = 0;
//   } else {
//     Serial.print("No object. Distance: ");
//     Serial.print(distance);
//     Serial.println(" cm");
//     // Optional: clear output or say "no data"
//     Serial.println("Force sensors idle.");
//   }

//   if (!result) {
//     digitalWrite(7, LOW);
//     digitalWrite(6, LOW);
//   } else {
//     if (result >= 1) {
//       digitalWrite(6, HIGH);
//     }
//     if (result >= 2) {
//       digitalWrite(7, HIGH);
//     }

    
//   }
//   Serial.println("---------------------------");
//   delay(1000);  // Check every second
// }

void loop() {
  long distance = getUltrasonicDistance();
  int result = 0;

  if (distance < 60) {
    objectWasDetected = true;
    Serial.println();
    Serial.print("Object detected at: ");
    Serial.print(distance);
    Serial.println(" cm");

    readAllSensors();
    displaySensorValues();
    result = analyzePattern(allSensors, 3);

    Serial.print("Pattern Result: ");
    Serial.println(result);

    // Only log result if it's 1 or 2
    // if ((result == 1 || result == 2) && currentIndex < 7) {
    //   eventLog[currentIndex++] = result;
    // }

    if (result == 0) {
  forceIdleSeen = true; // ready to log next press
} else if ((result == 1 || result == 2) && currentIndex < 7 && forceIdleSeen) {
  eventLog[currentIndex++] = result;
  forceIdleSeen = false; // block further logs until idle
}


    // Output logic
    if (!result) {
      digitalWrite(7, LOW);
      digitalWrite(6, LOW);
    } else {
      if (result >= 1) digitalWrite(6, HIGH);
      if (result >= 2) digitalWrite(7, HIGH);
    }
  } else {
    if (objectWasDetected) {
      Serial.println();
      Serial.print("Object exited. Distance: ");
      Serial.print(distance);
      Serial.println(" cm");

      // Mark to send log via Wire
      readyToSend = true;
      objectWasDetected = false;
    }

    // Serial.println("Force sensors idle.");
    Serial.print(".");
    digitalWrite(6, LOW);
    digitalWrite(7, LOW);
  }

  // Serial.println("---------------------------");
  delay(1000);
}


long getUltrasonicDistance() {
  digitalWrite(TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIG_PIN, LOW);

  long duration = pulseIn(ECHO_PIN, HIGH, 30000); // 30ms timeout
  if (duration == 0) return 999;  // no echo
  return duration * 0.034 / 2; // cm
}


void readAllSensors() {
  for (int i = 0; i < 3; i++) {
    allSensors[i] = analogRead(masterSensorPins[i]) > 300 ? 1 : 0;
  }
}



void displaySensorValues() {
  // Serial.println("=== Force Sensor Values ===");
  for (int i = 0; i < 3; i++) {
    Serial.print(allSensors[i]);
    Serial.print(" ");
  }
}

int analyzePattern(int sensors[], int len) {
  int maxGroupSize = 0;
  int currentGroup = 0;
  int blockCount = 0;

  for (int i = 0; i < len; i++) {
    if (sensors[i] == 1) {
      currentGroup++;
    } else {
      if (currentGroup > 0) {
        if (currentGroup > maxGroupSize) {
          maxGroupSize = currentGroup;
        }
        if (currentGroup >= 1) {
          blockCount++;
        }
        currentGroup = 0;
      }
    }
  }

  // handle last group if it ends at the end of the array
  if (currentGroup > 0) {
    if (currentGroup > maxGroupSize) {
      maxGroupSize = currentGroup;
    }
    blockCount++;
  }

  // Decision logic for tire counting
  if (maxGroupSize > 2 || blockCount > 1) {
    return 2;
  } else if (maxGroupSize >= 1 && maxGroupSize <= 2) {
    return 1;
  } else {
    return 0;
  }
}

// function that executes whenever data is received from master
void receiveEvent(int howMany) {
 while (0 <Wire.available()) {
    char c = Wire.read();      /* receive byte as a character */
    Serial.print(c);           /* print the character */
  }
 Serial.println();             /* to newline */
}

// function that executes whenever data is requested from master
// void requestEvent() {
//  Wire.write("Hello NodeMCU");  /*send string on request */
// }

// void requestEvent() {
//   if (readyToSend) {
//     char message[8]; // 7 digits + null terminator
//     for (int i = 0; i < 7; i++) {
//       message[i] = '0' + eventLog[i];  // convert int to char
//     }
//     message[7] = '\0';  // null terminator

//     Wire.write(message);  // send the message
//     Serial.print("Sent to master: ");
//     Serial.println(message);

//     // Reset log
//     for (int i = 0; i < 7; i++) eventLog[i] = 0;
//     currentIndex = 0;
//     readyToSend = false;
//   } else {
//     Wire.write("0000000");  // default response when nothing to send
//   }
// }

void requestEvent() {
  if (readyToSend) {
    char message[8]; // 7 digits + null
    for (int i = 0; i < 7; i++) {
      message[i] = '0' + eventLog[i];
    }
    message[7] = '\0';

    Wire.write(message);
    Serial.print("Sent to master: ");
    unsigned long now = millis();
    
    Serial.println(message);
    Serial.print(now);

    // Reset everything
    for (int i = 0; i < 7; i++) eventLog[i] = 0;
    currentIndex = 0;
    readyToSend = false;
    forceIdleSeen = true; // allow new events again
  } else {
    Wire.write("0000000");
  }
}


