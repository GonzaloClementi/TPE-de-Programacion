	import java.util.HashMap;
	import java.util.Map;

public class distribucionProbabilidades {

	public Map<Integer, Double> set_Probabilidad(Map<Integer,Double> resultado){
	        for (Map.Entry<Integer, Double> entry : resultado.entrySet()) {
	            resultado.put(entry.getKey(), entry.getValue() / 1000);
	        }
	        return resultado;
	    }
	    public Map<Integer, Double> calcular_distribucion_de_probabilidades(int[] vector_info) {
	        Map<Integer, Double> resultado = new HashMap<>();
	        for (int i = 0; i < vector_info.length; i++) {
	        	if (resultado.containsKey(vector_info[i])) {
	        		resultado.put(vector_info[i], resultado.get(vector_info[i]) + 1);
	            } else {
	                resultado.put(vector_info[i], 1.0);
	        	}
	        }
	        set_Probabilidad(resultado);
			return resultado;
	    }
	}
	

