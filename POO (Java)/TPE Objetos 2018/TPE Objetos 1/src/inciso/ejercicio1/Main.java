package inciso.ejercicio1;

import java.util.Random;

public class Main {

    public static void main(String[] args) {

        Cola ct1 = new ColaTerminal();
        Cola ct2 = new ColaTerminal();
        Cola ct3 = new ColaTerminal();
        Cola ct4 = new ColaTerminal();
        Cola ct5 = new ColaTerminal();
        Cola ct6 = new ColaTerminal();

        Azar c1 = new Azar();
        Intercalado c2 = new Intercalado();
        Azar c3 = new Azar();
        Azar c4 = new Azar();

        c1.addCola(c2);
        c1.addCola(c3);
        c2.addCola(c4);
        c2.addCola(ct3);
        c2.addCola(ct4);
        c3.addCola(ct5);
        c3.addCola(ct6);
        c4.addCola(ct1);
        c4.addCola(ct2);

        c1.addElemento(0);
        c1.addElemento(1);
        c1.addElemento(2);
        c1.addElemento(3);
        c1.addElemento(4);
        c1.addElemento(5);
        c1.addElemento(6);
        c1.addElemento(7);
        c1.addElemento(8);
        c1.addElemento(9);

        System.out.println("\nDespues de agregar: ");
        System.out.println("Cola Terminal 1: " + ct1);
        System.out.println("Cola Terminal 2: " + ct2);
        System.out.println("Cola Terminal 3: " + ct3);
        System.out.println("Cola Terminal 4: " + ct4);
        System.out.println("Cola Terminal 5: " + ct5);
        System.out.println("Cola Terminal 6: " + ct6);

        c1.recuperarElemento();

        System.out.println("\nDespues de recuperar: ");
        System.out.println("Cola Terminal 1: " + ct1);
        System.out.println("Cola Terminal 2: " + ct2);
        System.out.println("Cola Terminal 3: " + ct3);
        System.out.println("Cola Terminal 4: " + ct4);
        System.out.println("Cola Terminal 5: " + ct5);
        System.out.println("Cola Terminal 6: " + ct6);

    }
}
