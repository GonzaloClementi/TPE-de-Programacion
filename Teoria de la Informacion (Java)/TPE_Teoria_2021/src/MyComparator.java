import java.util.Comparator;

public class MyComparator implements Comparator<NodoArbolHuffman> {
    public int compare (NodoArbolHuffman a, NodoArbolHuffman b){
        if (a.getProbabilidad() > b.getProbabilidad()){
            return 1;
        }else
            return -1;
    }
}
