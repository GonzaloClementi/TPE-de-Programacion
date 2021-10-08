package inciso.ejercicio3;

import java.util.Vector;

public class ColaTerminal implements Cola {

    private Vector<Object> elemento;

    public ColaTerminal(){
        elemento = new Vector<Object>();
    }

    public int getCantElementos(){
        return elemento.size();
    }

    public Vector<ColaTerminal> getColas(){
        Vector<ColaTerminal> aux = new Vector<>();
        aux.add(this);
        return aux;
    }

    public void addElemento(Object e){
        if(!elemento.contains(e))
           elemento.add(e);
    }

    public Object recuperarElemento(){
        Object auxiliar = null;
        if (elemento.size() > 0){
            auxiliar = elemento.elementAt(0);
            elemento.remove(0);
            return auxiliar;
        }
        else 
            return auxiliar;
    }

    public String toString(){
        return elemento.toString();
    }
}
