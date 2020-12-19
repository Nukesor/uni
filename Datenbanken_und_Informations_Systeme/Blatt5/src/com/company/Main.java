package com.company;

public class Main {

    public static void main(String[] args) {
        Recovery recovery = new Recovery();
        recovery.recover();

        Client a = new Client();
        Client b = new Client();

        a.beginTransaction();
        b.beginTransaction();

        a.write(1, "Hallo"); // Überschrieben
        a.write(1, "Hi");
        a.write(2, "Grues dik");

        b.write(10, "Sup!"); // Überschrieben
        b.write(10, "Moin!");
        b.write(11, "und Servus");
        b.write(12, "und Eyy");
        b.write(13, "und Digga");
        b.write(14, "und Alda Fatta");
        b.commit();
        a.commit();

        // Crash - a wurde nicht persistiert

    }
}
