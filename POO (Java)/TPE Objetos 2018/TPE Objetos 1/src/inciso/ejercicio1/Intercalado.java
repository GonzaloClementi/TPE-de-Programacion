package inciso.ejercicio1;

public class Intercalado extends ColaMultiple {

    private int contador;

    public Intercalado(){
        super();
        contador = 0;
    }

    public  void addElemento(Object e){
        if (contador == colas.size())
            contador = 0;
        Cola auxiliar = colas.elementAt(contador);
        if (contador < colas.size()){
            auxiliar.addElemento(e);
            contador++;
        }
    }

    public Object recuperarElemento(){
        if(contador >= colas.size())
            contador = 0;
        Cola auxiliar = colas.elementAt(contador);
        contador++;
        return auxiliar.recuperarElemento();
    }
}
