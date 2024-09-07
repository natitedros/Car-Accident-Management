#include <WiFi.h>;
#include <HTTPClient.h>;
#include <ArduinoJson.h>;
#include <Adafruit_MPU6050.h>;
#include <Adafruit_Sensor.h>;
#include <Wire.h>;
#include <TinyGPS++.h>;
#include <SoftwareSerial.h>;

#define WIFI_NAME "Hotspot"
#define WIFI_PASSWORD "1234567890"
#define WIFI_TIMEOUT_MS 20000
int wifi_led = 2;
char jsonOutput[128];
Adafruit_MPU6050 mpu;

//Vibration sensor pins
int SW420 = 12;

int VpushBtn = 32;
int GpushBtn = 33;
int Vbuzzer = 4;
int Gbuzzer = 27;

double prevGforce = 1.29;

//GPS pins
const int RX_PIN = 16; // GPIO 16 for RX pin
const int TX_PIN = 17; // GPIO 17 for TX pin
SoftwareSerial ss(RX_PIN, TX_PIN);
TinyGPSPlus gps;

double maxPW = 0.0;
double maxGforce = 0.0;
double maxDiff = 0;

struct LatLng {
  double latitude;
  double longitude;
};

String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY0MWIxYjdlYmMwNmVlMWQ4NzI3ZTI4OCIsImlhdCI6MTY4Njc3MzE3NSwiZXhwIjoxNjg3MDMyMzc1fQ.r7_YGG5PWWEaZKZxSn5KEL7skX5buPYad2w6Zl2DAN0";


void connectToWifi(){
  Serial.print("Connecting to Wifi");
  WiFi.mode(WIFI_STA);
  WiFi.begin(WIFI_NAME, WIFI_PASSWORD);
  unsigned long startAttemptTime = millis();

  while(WiFi.status() != WL_CONNECTED && millis() - startAttemptTime < WIFI_TIMEOUT_MS){
    Serial.print(".");
    delay(100);
    }
  if(WiFi.status() != WL_CONNECTED){
     Serial.println("Failed to Connect!");
  }
  else{
    Serial.println("Connected!");
    digitalWrite(wifi_led, HIGH);
    
  }
}

struct LatLng getLatLng(){
// Check if data is available from the GPS module
  while (ss.available() > 0) {
    // Read the GPS data
    char c = ss.read();
    // Pass the data to the TinyGPS++ library
    gps.encode(c);
  }
  struct LatLng pos;
  pos.latitude = gps.location.lat();
  pos.longitude = gps.location.lng();
  return pos;
}

void postCase(){
  if (WiFi.status() == WL_CONNECTED){
    HTTPClient client;
    client.begin("https://adega.onrender.com/driver/major/addcase");
    client.addHeader("Content-Type", "application/json");
    client.addHeader("Authorization", "Bearer " + token);

    const size_t CAPACITY = JSON_OBJECT_SIZE(4);
    StaticJsonDocument<CAPACITY> doc;
    JsonObject object = doc.to<JsonObject>();
    
    struct LatLng pos = getLatLng(); //fetch location from gps
    
    object["longitude"] = pos.longitude;
    object["latitude"] = pos.latitude;
    if(object["longitude"] == 0 && object["latitude"] == 0){
      object["latitude"] = 9.040560; //5 kilo
      object["longitude"] = 38.763066;
    }
    object["driverId"] = "641b1b7ebc06ee1d8727e288";
    object["carId"] = "641b1c5dbc06ee1d8727e293";

    serializeJson(doc, jsonOutput);
    
    int httpCode = client.POST(String(jsonOutput));

    if (httpCode > 0){
      String payload = client.getString();
      Serial.println(payload);
      Serial.println(String(httpCode));

      client.end();
    }
    else{
      Serial.println("Error on http Request");
    }
  }
  else{
    Serial.println("Not Connected to WiFi!");
  }
}

void buzzer(){
  int counter = 0;
  bool isPressed = false;
  while (counter < 6 && isPressed == false){
    digitalWrite(Vbuzzer, HIGH);
    delay(500);
    if (digitalRead(GpushBtn) == HIGH){
      isPressed = true;
      digitalWrite(Vbuzzer, LOW);
      break;
    }
    digitalWrite(Vbuzzer, LOW);
    delay(500);
    counter++;
    }
  if (isPressed == true){
    Serial.println("Case posting aborted!");
//    sendCrashVals(555,555);
    
  }
  else{
    Serial.println("Case posted!");
    postCase();
  } 
  maxGforce = 0;
  maxPW = 0; 
  maxDiff = 0;
}
//void sendCrashVals(double longitude, double latitude){
//  if (WiFi.status() == WL_CONNECTED){
//    HTTPClient client;
//    client.begin("http://192.168.1.4:3000/postvals");
//    client.addHeader("Content-Type", "application/json");
//
//    const size_t CAPACITY = JSON_OBJECT_SIZE(2);
//    StaticJsonDocument<CAPACITY> doc;
//    JsonObject object = doc.to<JsonObject>();
//
//    object["lng"] = longitude;
//    object["lat"] = latitude;
//    serializeJson(doc, jsonOutput);
//    
//    int httpCode = client.POST(String(jsonOutput));
//
//    if (httpCode > 0){
//      String payload = client.getString();
//      Serial.println(payload);
//      Serial.println(String(httpCode));
//
//      client.end();
//    }
//    else{
//      Serial.println("Error on http Request");
//    }
//  }
//  else{
//    Serial.println("Not Connected to WiFi!");
//  }
//}

void setup() {
  Serial.begin(9600);
  ss.begin(9600);
  pinMode(wifi_led, OUTPUT);
  connectToWifi();
  if (mpu.begin()){
    Serial.println("MPU6050 Found!");  
  }
  pinMode(SW420, INPUT);
  pinMode(Vbuzzer, OUTPUT);
  pinMode(VpushBtn, OUTPUT);
  pinMode(Gbuzzer, OUTPUT);
  pinMode(GpushBtn, INPUT);
  digitalWrite(Gbuzzer, LOW);
  digitalWrite(VpushBtn, HIGH);

  mpu.setAccelerometerRange(MPU6050_RANGE_8_G);

}

void loop() {
  sensors_event_t a, g, temp;
  mpu.getEvent(&a, &g, &temp);
  double x2 = a.acceleration.x * a.acceleration.x;
  double y2 = a.acceleration.y * a.acceleration.y;
  double z2 = a.acceleration.z * a.acceleration.z;
  double sum = x2 + y2 + z2;
  double gForce = sqrt(sum) / 8.9;
  if(maxGforce < gForce){
    maxGforce = gForce;
  }
  double diff = prevGforce - gForce;
  if (maxDiff < diff){
    maxDiff = diff;
  }
  prevGforce = gForce;
  long pulseWidth = pulseIn (SW420, HIGH);
    delay(10);
    if (maxPW < pulseWidth){
      maxPW = pulseWidth;
    }
//    sendCrashVals(pos.longitude, pos.latitude);
  if (diff > 0.4){
    if (pulseWidth >= 20000){
     buzzer(); 
    }
  }
  delay(10); //asfasdfasdfas
  if (digitalRead(GpushBtn) == HIGH){
    maxPW = 0;
    maxGforce = 0;
    maxDiff = 0;
  }

}
