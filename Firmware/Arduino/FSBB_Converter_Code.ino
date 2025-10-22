// Arduino code for Four-Switch Buck-Boost Converter will go here.
#include <PWM.h>

const int buckPin  = 9;   // Buck mode PWM output
const int boostPin = 3;   // Boost mode PWM output
const int freq     = 50000; // 50 kHz switching frequency

// Analog inputs
const int feedbackPin   = A0;  // Output voltage feedback
const int setVoltagePin = A1;  // Potentiometer for reference
const int inputPin      = A3;  // Input voltage measurement

// Control variables
int32_t pwmBuck  = 120;
int32_t pwmBoost = 120;
const float gain = 0.3;        // proportional gain for control adjustment
const int tolerance = 5;       // small voltage tolerance (ADC units)

// calibration
const float Vref = 5.0;        // ADC reference voltage
const int ADCmax = 1023;       // 10-bit ADC resolution

void setup() {
  Serial.begin(9600);

  pinMode(5, OUTPUT);          // enable pin for driver
  digitalWrite(5, HIGH);

  InitTimersSafe();
  SetPinFrequencySafe(buckPin, freq);
  SetPinFrequencySafe(boostPin, freq);

  Serial.println(F("FOUR-SWITCH BUCK-BOOST CONVERTER INITIALIZED"));
}

void loop() {
  // Read analog signals
  int rawFeedback = analogRead(feedbackPin);
  int rawSet      = analogRead(setVoltagePin);
  int rawInput    = analogRead(inputPin);

  // Convert to actual voltage (if needed for monitoring)
  float feedbackV = (rawFeedback * Vref) / ADCmax;
  float setV      = (rawSet * Vref) / ADCmax;
  float inputV    = (rawInput * Vref) / ADCmax;

  // Determine mode
  bool buckMode = inputV > setV + 0.1; // small buffer to prevent jitter
  bool boostMode = inputV < setV - 0.1;

  // Print debug info periodically
  static unsigned long lastPrint = 0;
  if (millis() - lastPrint > 500) {
    Serial.print("SetV: "); Serial.print(setV, 2);
    Serial.print(" | FeedbackV: "); Serial.print(feedbackV, 2);
    Serial.print(" | InputV: "); Serial.print(inputV, 2);
    Serial.print(" | Mode: "); Serial.println(buckMode ? "BUCK" : "BOOST");
    lastPrint = millis();
  }

  // Compute error (difference between setpoint and feedback)
  int error = rawSet - rawFeedback;

  // Apply proportional control
  if (buckMode) {
    pwmBuck += gain * error;
    pwmBuck = constrain(pwmBuck, 1, 254);
    pwmWrite(buckPin, pwmBuck);
    pwmWrite(boostPin, 0); // disable boost side
  }

  if (boostMode) {
    pwmBoost += gain * (-error);
    pwmBoost = constrain(pwmBoost, 1, 254);
    pwmWrite(boostPin, pwmBoost);
    pwmWrite(buckPin, 0); // disable buck side
  }

  delayMicroseconds(200); // 
}
