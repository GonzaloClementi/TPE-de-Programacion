package inciso.ejercicio2;

import java.util.Random;
import java.util.Vector;

public class Azar implements ModificadorCola {

    public Azar(){

    }

    public  void addElemento(Object e, Vector<Cola> c){
        Random random = new Random();
        int indice = random.nextInt(c.size());
        Cola auxiliar = c.elementAt(indice);
        auxiliar.addElemento(e);
    }

    public  Object recuperarElemento(Vector<Cola> c){
        Random random = new Random();
        int indice = random.nextInt(c.size());
        Cola auxiliar = c.elementAt(indice);
        return auxiliar.recuperarElemento();
    }

}
