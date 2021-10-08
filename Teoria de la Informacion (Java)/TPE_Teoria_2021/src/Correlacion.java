
public class Correlacion {
	 
	public double calcular_correlacion(int[] vector_1,int[] vector_2,int tau){

		int iteraciones = 0;
		double correlacionAcumulada = 0;
		
		for (int i = 0; i < 999-tau; i++){
			correlacionAcumulada = correlacionAcumulada + vector_1[i] * vector_2[i+tau];
			iteraciones++;
		
		}
		return correlacionAcumulada/iteraciones;
	}

	public double[] calcular_correlacion_cruzada(int[] vector_1,int[] vector_2,int valor_tau_min, int valor_tau_max){
		double[] arregloResultado = {0,0,0,0,0};
		int aumentarTau = 50;
		double correlacionAcumulada = 0;
		int i = 0;
		double correlacionMaxima = 0;
		//int tauRetorno = 0;
		for (int tau = valor_tau_min; tau <= valor_tau_max; tau+=aumentarTau){
			correlacionAcumulada = calcular_correlacion(vector_1, vector_2, tau);
			//System.out.println(correlacionAcumulada);
			if (correlacionAcumulada > correlacionMaxima){
				
				correlacionMaxima = correlacionAcumulada;
				//tauRetorno = tau;
			}
			arregloResultado[i] = correlacionAcumulada;
			i++;
		}
		// falta sacar desvio para cada tau, para el coeficiente de correalcion cruzada
		return arregloResultado;
	}

}
