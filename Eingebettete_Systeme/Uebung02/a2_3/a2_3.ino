int PIN_IN1 = 4;
int PIN_IN2 = 3;
int PIN_PWM = 2;
int PIN_STANDBY = 5;

int PIN_MODE = 11;
int PIN_TOGGLE = 9;

int mode = 0;
int target_mode = 0;
int stored_mode = 5;
int accelerating = 1;
int mode_length = 5000;
int running_ = 1;
float past_time = 0;
int last_time = millis();

void switchmode() {
    target_mode += 1;
    target_mode = target_mode % 2;
    Serial.println("Switch Mode \n");
}

void triggermode() {
    running_ += 1;
    running_ = running_ % 2;
    if (running_ == 0 ) {
        stored_mode = mode;
        accelerating = 0;
        target_mode = 3;
    }
    else {
        mode = stored_mode;
        accelerating = 1;
        target_mode = stored_mode;
    }
    Serial.println("Toggle \n");
}

void setup() {
    pinMode(PIN_IN1, OUTPUT);
    pinMode(PIN_IN2, OUTPUT);
    pinMode(PIN_PWM, OUTPUT);

    pinMode(PIN_MODE, INPUT);
    pinMode(PIN_TOGGLE , INPUT);
    attachInterrupt(PIN_MODE, switchmode, FALLING);
    attachInterrupt(PIN_TOGGLE, triggermode, FALLING);

    pinMode(PIN_STANDBY, OUTPUT);
    digitalWrite(PIN_STANDBY, 1);
    Serial.begin(9600);
}

/*
   Mode 0 accelerating positiv direction
   Mode 1 decelerating negative direction
   Mode 0 accelerating negativedirection
   Mode 0 decelerating positiv direction
 */

void loop(){
    /*Serial.print("Mode: ");
      Serial.print(mode);
      Serial.print("\n");
      Serial.print("Target Mode: ");
      Serial.print(target_mode);
      Serial.print("\n");
     */
    int dt = millis() - last_time;
    last_time = millis();
    if (accelerating == 1) {
        past_time += dt;
        //Serial.print("Accelerating\n");
        if (past_time > 5000) {
            past_time = 5000;
        }
    }
    else if (accelerating == 0) {
        past_time -= dt;
    }
    else if (accelerating == -1) {
        past_time = 0;
        //Serial.print("Stopped\n");
    }

    if (mode == 0) {
        digitalWrite(PIN_IN1, 1);
        digitalWrite(PIN_IN2, 0);
    }
    else if (mode == 1) {
        digitalWrite(PIN_IN1, 0);
        digitalWrite(PIN_IN2, 1);
    }

    float spd = (past_time/mode_length);
    int pwm = spd * 255;
    /*
       Serial.print("Speed: ");
       Serial.print(mode_length);
       Serial.print(",  ");
       Serial.print(past_time);
       Serial.print("\n");
     */
    analogWrite(PIN_PWM, pwm);

    if (target_mode == 3) {
        if (past_time < 0) {
            accelerating = -1;
            //Serial.print("Stop\n");
        }
    }
    else if ((target_mode != 3) && (target_mode != mode)) {
        accelerating = 0;
        if (past_time < 0) {
            mode = mode + 1;
            mode = mode % 2;
        }
    }
    else if (target_mode != 3 && target_mode == mode) {
        accelerating = 1;
    }
}

