int led_output = 13;
int led_input = 11;
bool stream = false;
int pulse_length = 0;

void setup() {
    pinMode(led_output, OUTPUT);
    pinMode(led_input, INPUT);
    attachInterrupt(led_input, trigger, FALLING);
}

void loop() {
    pulse_length += 1;
    if (pulse_length > 255) {
        pulse_length = 0;
    }
    delay(5);
    if (stream) { 
        analogWrite(led_output, pulse_length);
    }
}

void trigger() {
    stream = !stream;
    if (!stream) {
        analogWrite(led_output, 0);
    }
}

