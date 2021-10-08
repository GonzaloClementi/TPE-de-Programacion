package inciso.ejercicio3;

import java.util.Comparator;

public class ComparadorTerminal implements Comparator<ColaTerminal> {

    public ComparadorTerminal(){

    }

    public int compare (ColaTerminal c1, ColaTerminal c2){
        return Integer.compare(c1.getCantElementos() , c2.getCantElementos());
    }

}
