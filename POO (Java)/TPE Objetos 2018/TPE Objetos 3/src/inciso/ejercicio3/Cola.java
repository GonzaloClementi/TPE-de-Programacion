package inciso.ejercicio3;

import java.util.Vector;

public interface Cola {

    int getCantElementos();
    Vector<ColaTerminal> getColas();
    void addElemento(Object e);
    Object recuperarElemento();
}
