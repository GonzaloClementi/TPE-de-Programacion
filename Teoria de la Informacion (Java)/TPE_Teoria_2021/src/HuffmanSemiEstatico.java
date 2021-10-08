import java.util.*;
public class HuffmanSemiEstatico {
	private PriorityQueue<NodoArbolHuffman> cola;
    private NodoArbolHuffman raiz = null;
    private HashMap<String, Integer> codificacionResultante = new HashMap<>();

    public HuffmanSemiEstatico(Map<Integer, Double> distProb) {
        NodoArbolHuffman aux;
        int cotizacion;
        double probabilidad;
        cola = new PriorityQueue<>(distProb.size(), new MyComparator());
        Iterator<Integer> it = distProb.keySet().iterator(); // Iterador por clave
        while (it.hasNext()) {
            cotizacion = it.next();
            probabilidad = distProb.get(cotizacion);
            aux = new NodoArbolHuffman(cotizacion, probabilidad, null, null);
            cola.add(aux);
        }
    }
    public void generarArbolHuffman() {
        while (cola.size() > 1) {
            NodoArbolHuffman a = cola.peek();
            cola.poll();
            NodoArbolHuffman b = cola.peek();
            cola.poll();
            double sumaProb = a.getProbabilidad() + b.getProbabilidad();
            NodoArbolHuffman nodoHuffmanAux = new NodoArbolHuffman(-1, sumaProb, a, b);
            raiz = nodoHuffmanAux;
            cola.add(nodoHuffmanAux);
        }
    }

    private void codificarArbolHuffman(NodoArbolHuffman raiz, String buffer, HashMap<String, Integer> codigoResultante) {
        if (raiz.esHoja() && raiz.getSimbolo() != -1) {
            codigoResultante.put(Integer.toString(raiz.getSimbolo()),Integer.parseInt(buffer));
            return;
        }
        codificarArbolHuffman(raiz.getMenor(), buffer + "0", codigoResultante);
        codificarArbolHuffman(raiz.getMayor(), buffer + "1", codigoResultante);
    }

    public void codificarCotizacion() {
        this.generarArbolHuffman();
        this.codificarArbolHuffman(this.raiz, "", this.codificacionResultante);
    }
    public HashMap<String, Integer> getCodificacion(){
    	HashMap<String, Integer> aux = new HashMap<String, Integer>(this.codificacionResultante);
    	return aux;
    }
}

