package inciso.ejercicio3;

import java.util.Collections;
import java.util.Vector;

public class Menor implements ModificadorCola {

    public Menor(){

    }

    public void addElemento(Object e, Vector<Cola> c){
        ComparadorDeCola comp = new ComparadorDeCola();
        Collections.min(c, comp).addElemento(e);
    }

    public Object recuperarElemento(Vector<Cola> c){
        ComparadorDeCola comp = new ComparadorDeCola();
        Cola aux = Collections.min(c, comp);
        return aux.recuperarElemento();
    }
}
