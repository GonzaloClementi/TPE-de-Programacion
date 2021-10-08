package inciso.ejercicio3;

import java.util.Comparator;

public class ComparadorDeCola implements Comparator<Cola> {

    public ComparadorDeCola(){

    }

    public int compare (Cola c1, Cola c2){
        return Integer.compare(c1.getCantElementos() , c2.getCantElementos());
    }
}
