package inciso.ejercicio3;

import java.util.Vector;

public class Intercalado implements ModificadorCola {

    private int contador;

    public Intercalado(){
        contador = 0;
    }

    public  void addElemento(Object e, Vector<Cola> c){
        if (contador == c.size())
            contador = 0;
        Cola auxiliar = c.elementAt(contador);
        if (contador < c.size()){
            auxiliar.addElemento(e);
            contador++;
        }
    }

    public Object recuperarElemento(Vector<Cola> c){
        if(contador >= c.size())
            contador = 0;
        Cola auxiliar = c.elementAt(contador);
        contador++;
        return auxiliar.recuperarElemento();
    }
}
