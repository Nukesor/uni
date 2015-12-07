int led_output = 13;
int led_lower = 11;
int led_higher = 9;
int brightness = 50;

void setup() {
    pinMode(led_output, OUTPUT);
    pinMode(led_lower, INPUT);
    pinMode(led_higher, INPUT);
    attachInterrupt(led_lower, lower, FALLING);
    attachInterrupt(led_higher, higher, FALLING);
}

void loop() {}

void lower() {
    brightness += 10;
    if (brightness > 255) {
        brightness = 255;
    }
    analogWrite(led_output, brightness);
}

void higher() {
    brightness -= 10;
    if (brightness < 0) {
        brightness = 0;
    }
    analogWrite(led_output, brightness);
}
