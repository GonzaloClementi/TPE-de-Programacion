package inciso.ejercicio1;

import java.util.Random;

public class Azar extends ColaMultiple {

    public Azar (){
        super();
    }

    public  void addElemento(Object e){
        Random random = new Random();
        int indice = random.nextInt(colas.size());
        Cola auxiliar = colas.elementAt(indice);
        auxiliar.addElemento(e);
    }

    public  Object recuperarElemento(){
        Random random = new Random();
        int indice = random.nextInt(colas.size());
        //System.out.println(indice);
        Cola auxiliar = colas.elementAt(indice);
        return auxiliar.recuperarElemento();
    }

}
