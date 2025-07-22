// #include <Wire.h>

// #include <ESP8266WiFi.h>
// #include <PubSubClient.h>

// const char* ssid = "Jala";
// const char* password = "hhhhhhhh";
// const char* mqtt_server = "5.196.78.28"; // ping test.mosquitto.org 

// WiFiClient espClient;
// PubSubClient client(espClient);
// unsigned long lastMsg = 0;
// #define MSG_BUFFER_SIZE	(50)
// char msg[MSG_BUFFER_SIZE];
// int value = 0;

// void setup() {
//  Serial.begin(9600); /* begin serial for debug */
//  Wire.begin(D1, D2); /* join i2c bus with SDA=D1 and SCL=D2 of NodeMCU */
// //  Serial.begin(115200);
//  setup_wifi();
//  client.setServer(mqtt_server, 1883);
//  client.setCallback(callback);
// }

// void loop() {
//  Wire.beginTransmission(8); /* begin with device address 8 */
// //  Wire.write("Hello Arduino");  /* sends hello string */
//  Wire.endTransmission();    /* stop transmitting */

//  Wire.requestFrom(8, 7); /* request & read data of size 7 for 7 gandar */
//  while(Wire.available()){
//     char c = Wire.read();
//   Serial.print(c);
//  }
//  Serial.println();

//  if (!client.connected()) {
//     reconnect();
//   }
//   client.loop();

//   unsigned long now = millis();
//   if (now - lastMsg > 2000) {
//     lastMsg = now;
//     ++value;
//     snprintf (msg, MSG_BUFFER_SIZE, "hello world #%ld", value);
//     Serial.print("Publish message: ");
//     Serial.println(msg);
//     client.publish("outTopic", msg);
//   }

//  delay(1000);
// }


// void setup_wifi() {

//   delay(10);
//   // We start by connecting to a WiFi network
//   Serial.println();
//   Serial.print("Connecting to ");
//   Serial.println(ssid);

//   WiFi.mode(WIFI_STA);
//   WiFi.begin(ssid, password);

//   while (WiFi.status() != WL_CONNECTED) {
//     delay(500);
//     Serial.print(".");
//   }

//   randomSeed(micros());

//   Serial.println("");
//   Serial.println("WiFi connected");
//   Serial.println("IP address: ");
//   Serial.println(WiFi.localIP());
// }

// void callback(char* topic, byte* payload, unsigned int length) {
//   Serial.print("Message arrived [");
//   Serial.print(topic);
//   Serial.print("] ");
//   for (int i = 0; i < length; i++) {
//     Serial.print((char)payload[i]);
//   }
//   Serial.println();

//   // Switch on the LED if an 1 was received as first character
//   if ((char)payload[0] == '1') {
//     digitalWrite(BUILTIN_LED, LOW);   // Turn the LED on (Note that LOW is the voltage level
//     // but actually the LED is on; this is because
//     // it is active low on the ESP-01)
//   } else {
//     digitalWrite(BUILTIN_LED, HIGH);  // Turn the LED off by making the voltage HIGH
//   }

// }

// void reconnect() {
//   // Loop until we're reconnected
//   while (!client.connected()) {
//     Serial.print("Attempting MQTT connection...");
//     // Create a random client ID
//     String clientId = "ESP8266Client-";
//     clientId += String(random(0xffff), HEX);
//     // Attempt to connect
//     if (client.connect(clientId.c_str())) {
//       Serial.println("connected");
//       // Once connected, publish an announcement...
//       client.publish("outTopic", "hello world");
//       // ... and resubscribe
//       client.subscribe("inTopic");
//     } else {
//       Serial.print("failed, rc=");
//       Serial.print(client.state());
//       Serial.println(" try again in 5 seconds");
//       // Wait 5 seconds before retrying
//       delay(5000);
//     }
//   }
// }

#include <Wire.h>
#include <ESP8266WiFi.h>
#include <PubSubClient.h>

const char* ssid = "Jala";
const char* password = "hhhhhhhh";
const char* mqtt_server = "5.196.78.28"; // test.mosquitto.org

WiFiClient espClient;
PubSubClient client(espClient);
unsigned long lastMsg = 0;
#define MSG_BUFFER_SIZE	(50)
char msg[MSG_BUFFER_SIZE];
int value = 0;

void setup() {
  Serial.begin(9600); /* Begin serial for debug */
  Wire.begin(D1, D2); /* SDA=D1, SCL=D2 on NodeMCU */

  setup_wifi();
  client.setServer(mqtt_server, 1883);
  client.setCallback(callback);
}

void loop() {
  // I2C Communication with Arduino slave at address 8
  Wire.beginTransmission(8); 
  Wire.endTransmission();

  Wire.requestFrom(8, 7); // Read 7 bytes (from FS0 to FS5 + logic result)

  String sensorData = "";
  while (Wire.available()) {
    char c = Wire.read();
    sensorData += c;
  }

  Serial.print("Received from Arduino: ");
  Serial.println(sensorData);

  // Reconnect to MQTT if needed
  if (!client.connected()) {
    reconnect();
  }
  client.loop();

  // Publish sensorData to MQTT every 2 seconds
  // unsigned long now = millis();
  // if (now - lastMsg > 2000) {
  //   lastMsg = now;
  //   client.publish("forceSensor/data", sensorData.c_str());

  //   // Optional: send hello message (can be removed if not needed)
  //   // snprintf (msg, MSG_BUFFER_SIZE, "hello world #%ld", value++);
  //   // Serial.print("Publish message: ");
  //   // Serial.println(msg);
  //   // client.publish("outTopic", msg);
  // }

  // Publish sensorData to MQTT every 2 seconds, only if it's not all zeroes
unsigned long now = millis();
if (now - lastMsg > 500) {
  lastMsg = now;

  if (sensorData != "0000000") {
    Serial.print("Publishing to MQTT: ");
    Serial.println(sensorData);
    client.publish("forceSensor/data", sensorData.c_str());
  } else {
    Serial.println("Sensor data is 0000000, not publishing.");
  }
}


  delay(1000);
}

void setup_wifi() {
  delay(10);
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);

  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  randomSeed(micros());

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}

void callback(char* topic, byte* payload, unsigned int length) {
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");
  for (int i = 0; i < length; i++) {
    Serial.print((char)payload[i]);
  }
  Serial.println();

  // Toggle built-in LED based on message
  if ((char)payload[0] == '1') {
    digitalWrite(BUILTIN_LED, LOW);   // Turn LED on
  } else {
    digitalWrite(BUILTIN_LED, HIGH);  // Turn LED off
  }
}

void reconnect() {
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    String clientId = "ESP8266Client-";
    clientId += String(random(0xffff), HEX);

    if (client.connect(clientId.c_str())) {
      Serial.println("connected");
      client.publish("outTopic", "hello world");
      client.subscribe("inTopic");
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      delay(5000);
    }
  }
}
