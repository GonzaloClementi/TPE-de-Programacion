import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Vector;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import javax.swing.JOptionPane;

public class Cotizacion {
	
    private Vector<Integer> vector_info;
	DecimalFormatSymbols separadoresPersonalizados;
	DecimalFormat formato;


	//Inicializa el Vector con todos los datos del archivo y da formato a los decimales para que se muestre de una forma mas prolija
    public Cotizacion(String file) {
    	vector_info = get_vector_de_cotizaciones(file); 
    	separadoresPersonalizados = new DecimalFormatSymbols();
    	separadoresPersonalizados.setDecimalSeparator('.');
    	formato = new DecimalFormat("#.00", separadoresPersonalizados);
    }

    //cantidad de datos del archivo
    private int size() {
    	return vector_info.size();
    }
    
    //se obtiene los datos del archivo ordenados en un vector de integers
    private Vector<Integer> get_vector_de_cotizaciones(String file) {
        
    	File archivo;
        FileReader fr;
        BufferedReader br;
        Vector<Integer> vector_aux = new Vector<Integer>();        
        try {
            archivo = new File(file);
          
            fr = new FileReader(archivo);
            br = new BufferedReader(fr);
            String linea;
            while ((linea = br.readLine()) != null) {
            	vector_aux.addElement(Integer.parseInt(linea));
            }
            br.close();
            fr.close();
            return vector_aux;
        }
        
        catch (Exception e) {
            JOptionPane.showMessageDialog(null, "error" + e);
            return null;
        }
    }

    //devuelve una copia del vector integer de todas las cotizaciones
    public Vector<Integer> get_historial_cotizaciones(){
    	Object copy_vector = vector_info.clone();	
    	return (Vector<Integer>) copy_vector;
    }
    
    //muestra el historial de todas las cotizaciones
    public void show_historial_cotizaciones(){
	    for(double e:this.get_historial_cotizaciones()) {
	    	System.out.println(e);
	    }
    }
    
	//se obtiene el vector de probabilidad de ocurrecias donde
	//    posicion 0 = baja
	//    posicion 1 = estable
	//    posicion 2 = alza
    
	// Aclaracion: al calcularse el este vector con una muestra no se asegura que la muestra sea suficiente para
	// llegar a un vector en estado estacionario.
    public double[] calculate_distribucion_de_probabilidades(){
    	double array_prob[] = {0,0,0}; // Las posicion 0=baja , 1 = igual, 2= subio
    	for (int i=1; i < this.size();i++){
    		if(vector_info.get(i-1) < vector_info.get(i)) {
    				array_prob[2]++;}
    			else if(vector_info.get(i-1) > vector_info.get(i))
    				array_prob[0]++;
    			else
    				array_prob[1]++;
    	}
    	
    	array_prob[0] = array_prob[0]/(this.size());
    	array_prob[1] = array_prob[1]/(this.size());
    	array_prob[2] = array_prob[2]/(this.size());
    	
    	return array_prob;
    }
    
//    muestra el vector con las probabilidades de las ocurrencias
    public void show_probabilidad_de_ocurrencias() {
    	double ocurrencias[] = this.calculate_distribucion_de_probabilidades();
    	
    	System.out.println("Baja:"+formato.format(ocurrencias[0])+"%");
    	System.out.println("Estable:"+formato.format(ocurrencias[1])+"%");
    	System.out.println("Alza:"+formato.format(ocurrencias[2])+"%");
    }
//  se obtiene la matriz condicional
    public double[][] get_matriz_condicional() {
		double mat_prob[][] = {{0, 0, 0}, {0, 0, 0}, {0, 0, 0}};
		int pos_actual_vector = 0;
		int[] total_retornos = {0, 0, 0};
		int ultimo_retorno = 0;
		int ultimo_retorno_col = 0;
		int valor_actual;
		while (pos_actual_vector < vector_info.size()) {
			valor_actual = vector_info.get(pos_actual_vector);
			pos_actual_vector = pos_actual_vector + 1;
			total_retornos[ultimo_retorno_col] = total_retornos[ultimo_retorno_col] + 1;
			if (valor_actual > ultimo_retorno) {
				mat_prob[0][ultimo_retorno_col] = mat_prob[0][ultimo_retorno_col] + 1;
				ultimo_retorno_col = 0;
			}
			if (valor_actual == ultimo_retorno) {
				mat_prob[1][ultimo_retorno_col] = mat_prob[1][ultimo_retorno_col] + 1;
				ultimo_retorno_col = 1;
			}
			if (valor_actual < ultimo_retorno){
				mat_prob[2][ultimo_retorno_col] = mat_prob[2][ultimo_retorno_col] + 1;
				ultimo_retorno_col = 2;
			}
			ultimo_retorno = valor_actual;
		}
		int i = 0;
		while (i < 3) {
			int j = 0;
			while (j < 3) {
				mat_prob[i][j] = mat_prob[i][j] / total_retornos[j];
				j = j + 1;
			}
			i = i + 1;
		}
		return mat_prob;
	}
    
//    se muestra la matriz condicional
    public void show_matriz_condicional() {
    	double aux[][] = this.get_matriz_condicional();
    	
    	for(int i=0 ;i<3;i++) {
    		System.out.println();
    		for(int j=0;j<3;j++) {
    			System.out.print(formato.format(aux[i][j])+" ");
    		}
    	}
    }
    
//    se obtiene la matriz conjunta
    public double[][] get_matriz_conjunta(){
    	double[][] aux1 = new double[3][3];
    	double[] aux2 = this.calculate_distribucion_de_probabilidades();
    	for(int i =0;i<aux2.length;i++) {
    		for(int j=0;j<aux2.length;j++) {
    			aux1[i][j] = (double)(aux2[i]*aux2[j]);
    		}
    	}
    	return aux1;
	}
    
//    se muestra la matriz conjunta
    public void show_matriz_conjunta() {
    	
    	double mat[][] = this.get_matriz_conjunta();
		System.out.println("MATRIZ CONJUNTA");
    	for(int i =0;i<3;i++) {
    		for(int j=0;j<3;j++) {
    			System.out.print(formato.format(mat[i][j]));
    		}
    		System.out.println();
    	}
   
    }
    
    public double calculate_media() {
    	int suma = 0;
    	for(int value : this.vector_info)
    		suma += value;
    	return suma/this.size();
    }
    
    public double calculate_varianza() {
    	double media = this.calculate_media();
    	double s2 = 0;
    	for(int value : this.vector_info)
    		s2 += Math.pow((value-media),2);
    	return s2/(this.size()-1);
    }
    
    public double calculate_desvio_estandar() {
    	return Math.sqrt(calculate_varianza());
    }
    
    public double calculate_coeficiente_de_variacion() {
    	return (double) (this.calculate_desvio_estandar()/this.calculate_media());
    }
    
    public double calculate_covarianza(Cotizacion cot) {
    	Vector<Integer> y = cot.get_historial_cotizaciones();
    	double cov_xy = 0;
    	double media_x = this.calculate_media();
    	double media_y = cot.calculate_media();
    	int i = 0;
    	for(Integer x : this.vector_info) {
    		cov_xy += ((x-media_x)*(y.get(i)-media_y));
    		i++;
    	}
    	
    	return cov_xy/this.size();
    }
    
    public double calculate_correlacion_lineal(Cotizacion cot) {
    	double cov_xy = this.calculate_covarianza(cot);
    	return (double) (cov_xy/(this.calculate_desvio_estandar()*cot.calculate_desvio_estandar()));
    }
    
    public static double[][] multiplicar_matrices(double[][] m1, double[][] m2) {
        double[][] mr = new double[m1.length][m2[0].length];
        if (m1[0].length == m2.length) {
            for (int i = 0; i < m1.length; i++) {
                for (int j = 0; j < m2[0].length; j++) {
                    for (int k = 0; k < m1[0].length; k++) {
                        mr[i][j] += m1[i][k] * m2[k][j];
                    }
                }
            }
        }
        return mr;
    }
    
    public static double[][] pow_matriz(double[][] mat,int exponente){
    	double[][] mr = new double[mat.length][mat[0].length];
    	for(int i = 0; i<exponente;i++) {
    		mr = multiplicar_matrices(mat, mat);
    	}
    	return mr;
    }
    
    public double[] calculate_vector_de_estado_inicial() {
    	double[] vec_i = {0,0,0};
		if(vector_info.get(0) > vector_info.get(1))
			vec_i[0] = 1;
		else if(vector_info.get(0) < vector_info.get(1))
			vec_i[2] = 1;
		else
			vec_i[1] = 1;   		
    	return vec_i;
    }
    
    public double[] calculate_vector_de_estado_t(int t) {
        double[] vec_t = new double[3];
        double[] vec_i = calculate_vector_de_estado_inicial();
        double[][] mat_aux = pow_matriz(get_matriz_condicional(), t+1);
        for(int i =0;i<3;i++) {
        	for(int j=0;j<3;j++) {
        		vec_t[i] = mat_aux[i][j]*vec_i[j];
        	}
        }
        return vec_t;
    }

public double calcular_autocorrelacion(int valor_tau_min, int valor_tau_max){
	float autocorrelacion [] = new float[valor_tau_max+1];
	int tau = valor_tau_min;
	int tau_actual = 0;
	int tamanio = vector_info.size();
	while (tau <= valor_tau_max){
		while (tau + tau_actual < tamanio){
			int s1 = vector_info.get(tau_actual);
			int s2 = vector_info.get(tau_actual+tau);
			tau_actual += 1;
			autocorrelacion[tau] += s1 * s2;
		}
		autocorrelacion[tau] /= tau_actual;
		tau_actual = 0;
		tau += 1;
	}
	for (int i = 1; i < 50; i++){ // Arranca en 1, porque el primer valor muestra 0
		System.out.print(autocorrelacion[i] +" ");
	}

	return 0;
}

public int[] getVectorCotizacion() {
	int[] aux = new int[vector_info.size()];
	for(int i=0; i< vector_info.size(); i++) {
		aux[i]= vector_info.get(i);
		//System.out.println(vector_info.get(i));
	}
	return aux;
}
}