/**
 *  @title:  StrongLink SL018/SL030 RFID reader demo
 *  @author: marc@marcboon.com
 *  @see:    http://www.stronglink.cn/english/sl018.htm
 *  @see:    http://www.stronglink.cn/english/sl030.htm
 *
 *  Arduino to SL018/SL030 wiring:
 *  A4/SDA     2     3
 *  A5/SCL     3     4
 *  5V         4     -
 *  GND        5     6
 *  3V3        -     1
 */

#include <Wire.h>
#include <SL018.h>

SL018 rfid;

String rfidTag = "";
String k = "";
int ledPin = 2;
char* myStrings[]={"This is string 1", "9C728BFE", "This is string 3", "This is string 4", "This is string 5","This is string 6"};

void setup()
{
  Wire.begin();
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);       //The digital pin that drives the relay

  // prompt for tag
  Serial.println("Show me your tag");
}

void loop()
{
  // start seek mode
  rfid.seekTag();
  // wait until tag detected
  while(!rfid.available());
  // print tag id
  rfidTag = rfid.getTagString();
  //Serial.println(rfidTag);

  for (int i = 0; i < 6; i++){
   Serial.println(myStrings[i]);
   if(rfidTag == myStrings[i]){
     open();
   }
   delay(100);
  }
  
//  if(rfidTag == "9C728BFE")
//  {
//    open();
//  }
  
}

// functions

// digital ping 2 high / low
//void open(int k){
  void open(){
    
  Serial.print("Door Open  Key number:");
  //Serial.print(k);
  Serial.println("");
  //Serial.println(k+1, DEC);
    
  digitalWrite(ledPin, HIGH);
  delay(3000);              // wait for 3 seconds
  digitalWrite(ledPin, LOW);
  delay(1000);              // wait for 2 seconds  
}
