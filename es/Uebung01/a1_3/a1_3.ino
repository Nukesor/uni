int led_output = 13;
int led_input = 11;
bool stream = false;
bool not_pressed = true;

void setup() {
    pinMode(led_output, OUTPUT);
    pinMode(led_input, INPUT);
    attachInterrupt(led_input, trigger, FALLING);
}

void loop() {}

void trigger() {
    stream = !stream;
    if (stream) {
        digitalWrite(led_output, HIGH);
    } else {
        digitalWrite(led_output, LOW);
    }
}

