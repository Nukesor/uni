int PIN_IN1 = 4;
int PIN_IN2 = 3;
int PIN_PWM = 2;
int PIN_STANDBY = 5;

int PIN_MODE = 11;
int PIN_TOGGLE = 9;

int mode = 0;
int mode_length = 5000;
int last_time = millis();
float past_time = 0;
int direction = 1;
int running = 1;

void setup() {
    pinMode(PIN_IN1, OUTPUT);
    pinMode(PIN_IN2, OUTPUT);
    pinMode(PIN_PWM, OUTPUT);

    pinMode(PIN_MODE, INPUT_PULLUP);
    pinMode(PIN_TOGGLE , INPUT_PULLUP);

    pinMode(PIN_STANDBY, OUTPUT);
    digitalWrite(PIN_STANDBY, 1);
    Serial.begin(9600);
}



void loop(){


    int dt = millis() - last_time;
    last_time = millis();
    if (mode == 0 || mode == 2) {
        past_time += dt;
    }
    else if (mode == 1 || mode == 3) {
        past_time -= dt;
    }
    if (mode == 0 || mode == 1) {
        digitalWrite(PIN_IN1, 1);
        digitalWrite(PIN_IN2, 0);
    }
    else if (mode == 2 || mode == 3) {
        digitalWrite(PIN_IN1, 0);
        digitalWrite(PIN_IN2, 1);
    }

    float speed = (past_time/mode_length);
    int pwm = speed * 255;
    Serial.println(pwm);
    analogWrite(PIN_PWM, pwm);

    if (past_time > 5000 || past_time < 0) {
        mode += 1;
        mode = mode % 4;
    }
}


