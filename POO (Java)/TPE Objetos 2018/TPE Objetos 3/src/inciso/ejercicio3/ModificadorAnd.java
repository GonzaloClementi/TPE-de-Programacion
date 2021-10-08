package inciso.ejercicio3;

import java.util.Vector;

public class ModificadorAnd implements ModificadorCola {
    private ModificadorCola mc_agregar, mc_recuperar;

    public ModificadorAnd(ModificadorCola mc_agregar, ModificadorCola mc_recuperar){
        this.mc_agregar = mc_agregar;
        this.mc_recuperar = mc_recuperar;
    }

    public void addElemento(Object e, Vector<Cola> c){
        mc_agregar.addElemento(e,c);
    }

    public Object recuperarElemento(Vector<Cola> c){
        return mc_recuperar.recuperarElemento(c);
    }
}
