package inciso.ejercicio3;

import java.util.Collections;
import java.util.Vector;

public class ColaMultiple implements Cola{
    private ModificadorCola mc;
    private Vector<Cola> colas;

    public ColaMultiple (ModificadorCola mc){
        colas = new Vector<Cola>();
        this.mc = mc;
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
        ComparadorDeCola ct = new ComparadorDeCola();
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

    public void addElemento(Object e){
        mc.addElemento(e, colas);
    }
    public Object recuperarElemento(){
        return mc.recuperarElemento(colas);
    }

}
