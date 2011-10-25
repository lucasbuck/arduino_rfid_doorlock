/**
 *  SL018.h: created by marc@marcboon.com
 *  @title:  StrongLink SL018/SL030 RFID doorlock
 *  @author: matt@cowbox.net
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
int ledPin = 12;

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
  Serial.println(rfidTag);
  
  if(rfidTag == "9C728BFE")
  {
    open();
  }
  
}

/* functions */
void open(){
    
  Serial.print("Door Open  Key number:");

    
  digitalWrite(ledPin, HIGH);
  delay(3000);              // wait for 3 seconds
  digitalWrite(ledPin, LOW);
  delay(2000);              // wait for 2 seconds  
}
