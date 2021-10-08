package inciso.ejercicio1;

import java.util.Collections;
import java.util.Vector;

public abstract class ColaMultiple implements Cola{

    protected Vector<Cola> colas;

    protected ColaMultiple (){
        colas = new Vector<Cola>();
    }

    public int getCantElementos(){
        int elementos = 0;
        Cola auxiliar = colas.elementAt(0);
        for (int i = 0 ; i < colas.size(); i++)
            elementos += auxiliar.getCantElementos();
        return elementos;
    }

    public void addCola(Cola c){
        colas.add(c);
    }

    public ColaTerminal getMayorCola(){
        Vector<ColaTerminal> aux = this.getColas();
        ComparadorTerminal ct = new ComparadorTerminal();
        return Collections.max(aux, ct);
    }

    public Vector<ColaTerminal> getColas(){
        Vector<ColaTerminal> aux = new Vector<>();
        for (int i = 0; i < colas.size(); i++){
            Cola temp = colas.elementAt(i);
            aux.addAll(temp.getColas());
        }
        return aux;
    }

    public int cantColasTerminales(){
        Vector<ColaTerminal> aux = this.getColas();
        return aux.size();
    }

    public abstract void addElemento(Object e);
    public abstract Object recuperarElemento();

}
