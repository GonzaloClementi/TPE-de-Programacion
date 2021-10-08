import java.util.ArrayList;
import java.util.List;

public class RLC {
	private List<parCodificado> codificaciones = new ArrayList<parCodificado>();
			
	public void codificarCotizacion(int[] vectorCotizacion) {
		parCodificado simbolo = new parCodificado(vectorCotizacion[0]);
		simbolo.aumentarSecuencia();
		codificaciones.add(simbolo);
		for(int i=1; i<vectorCotizacion.length; i++) {
			if ((codificaciones.get(codificaciones.size()-1).getSimbolo()) == vectorCotizacion[i]) {
				simbolo=codificaciones.get(codificaciones.size()-1);
				simbolo.aumentarSecuencia();
				codificaciones.set(codificaciones.size()-1, simbolo);
			} else {
				simbolo = new parCodificado(vectorCotizacion[i]);
				simbolo.aumentarSecuencia();
				codificaciones.add(simbolo);
			}
		}
	}
	public int getSize() {
		int aux=0;
		for(parCodificado par : this.codificaciones) {
			aux += par.getLongSecuencia()*par.getLongSimbolo();
		}
		return aux;
	}
	public List<Integer> descodificarCotizacion() {
			List<Integer> cotizacionDescodificada = new ArrayList<Integer>();
			for(int j=0; j<codificaciones.size();j++) {
				for(int i=0; i<codificaciones.get(j).getLongSecuencia(); i++) {
					cotizacionDescodificada.add(codificaciones.get(j).getSimbolo());
				}
			}
			return cotizacionDescodificada;
	}
	public List<parCodificado> getCodificacion(){
		List<parCodificado> clon = new ArrayList<parCodificado>(codificaciones);			
		return clon;
	}
}