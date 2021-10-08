package inciso.ejercicio3;

import java.util.Collections;
import java.util.Vector;

public class Mayor implements ModificadorCola {

    public Mayor(){

    }

    public void addElemento(Object e, Vector<Cola> c){
        ComparadorDeCola comp = new ComparadorDeCola();
        Collections.max(c, comp).addElemento(e);
    }

    public Object recuperarElemento(Vector<Cola> c){
        ComparadorDeCola comp = new ComparadorDeCola();
        Cola aux = Collections.max(c, comp);
        return aux.recuperarElemento();
    }
}
