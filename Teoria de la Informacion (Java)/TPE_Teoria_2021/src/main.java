import java.io.IOException;
import java.util.List;
public class main {

public static void main(String[] args) throws IOException {

	Cotizacion ETH = new Cotizacion("ETH.txt");
	Cotizacion BTC = new Cotizacion("BTC.txt");
	/*---------------------------------------------------------------------------------------------------------------------------*/
	//1)a)
	System.out.println("Ejercicio 1:");
	System.out.println("1)a) Calcular la matriz de pasaje para cada moneda virtual");
	System.out.print("Matriz de BTC");
	BTC.show_matriz_condicional();
	System.out.println();
	System.out.print("Matriz de ETH");
	ETH.show_matriz_condicional();
	/*---------------------------------------------------------------------------------------------------------------------------*/
	//1)b)Calcular la autocorrelación de la cotización de cada moneda (usar los valores provistos originalmente).
		System.out.println();
		System.out.println(" 1)b)Calcular la autocorrelación de la cotización de cada moneda (usar los valores provistos originalmente)");
		System.out.println("Autocorrelacion ETH: ");
		ETH.calcular_autocorrelacion(1,50);
		System.out.println();
		System.out.println("Autocorrelacion BTC: ");
		BTC.calcular_autocorrelacion(1,50);
		System.out.println();
	/*--------------------------------------------------------------------------------------------------------------------------*/
	//1)c)Calcular la correlación cruzada entre ambas monedas, también usando
	// los valores de la cotización. Analizar en estado estacionario considerando como diferencia de tiempo (?): 0, 50, 100, 150, 200.
	Correlacion aux = new Correlacion();
	System.out.println();
	System.out.println("1)c)Calcular la correlación cruzada entre ambas monedas, también usando los valores de la cotización.");
	System.out.println("Correlacion cruzada ETH: ");
	for (int i = 0; i < 5; i++) {
		System.out.println("Correlacion cruzada: " + aux.calcular_correlacion_cruzada(ETH.getVectorCotizacion(), BTC.getVectorCotizacion(), 0, 200)[i]);
	}
	System.out.println("Correlacion cruzada BTC: ");
	for (int i = 0; i < 5; i++) {
		System.out.println("Correlacion cruzada: " + aux.calcular_correlacion_cruzada(BTC.getVectorCotizacion(), ETH.getVectorCotizacion(), 0, 200)[i]);
	}
	System.out.println();
	/*---------------------------------------------------------------------------------------------------------------------------*/
	// 2)a) - Calcular la distribución de probabilidades de los valores de cotización de cada moneda
	System.out.println("Ejercicio 2: ");
	System.out.println("2)a) - Calcular la distribución de probabilidades de los valores de cotización de cada moneda");
	distribucionProbabilidades aux1 = new distribucionProbabilidades();
	System.out.println("Distribucion de probabilidades (ETH): " + aux1.calcular_distribucion_de_probabilidades(ETH.getVectorCotizacion()));
		/*Iterator<Integer> it = aux1.calcular_distribucion_de_probabilidades(BTC.getVectorCotizacion()).keySet().iterator(); // Iterador por clave
		while (it.hasNext()) {
			int cotizacion = it.next();
			double probabilidad = aux1.calcular_distribucion_de_probabilidades(BTC.getVectorCotizacion()).get(cotizacion);

			System.out.println(cotizacion);
		}
		System.out.println();
		Iterator<Integer> ilt = aux1.calcular_distribucion_de_probabilidades(BTC.getVectorCotizacion()).keySet().iterator();
		while (ilt.hasNext()) {
				int cotizacion = ilt.next();
				double probabilidad = aux1.calcular_distribucion_de_probabilidades(BTC.getVectorCotizacion()).get(cotizacion);

				System.out.println(probabilidad);
			}*/
	System.out.println("Distribucion de probabilidades (BTC): " + aux1.calcular_distribucion_de_probabilidades(BTC.getVectorCotizacion()));
	System.out.println("");
	/*---------------------------------------------------------------------------------------------------------------------------*/
	// 2)b) - Codificar las cotizaciones de cada moneda usando Huffman semi-estático (sin considerar memoria)
	System.out.println("2)b)Codificar las cotizaciones de cada moneda usando Huffman semi-estático (sin considerar memoria) ");
	//ETH
	System.out.println("ETH Archivo original: 5520 Bytes");//Datos tomados por fuera del sistema, del archivo original
	HuffmanSemiEstatico H_ETH = new HuffmanSemiEstatico(aux1.calcular_distribucion_de_probabilidades(ETH.getVectorCotizacion()));
	H_ETH.codificarCotizacion();
	byteEncoder bytes = new byteEncoder();
	System.out.println("Codificacion de ETH usando Huffman Semi-Estatico");
	List<Byte> B_ETH = bytes.byteEncoderHuffman(ETH.getVectorCotizacion(), H_ETH.getCodificacion(), aux1.calcular_distribucion_de_probabilidades(ETH.getVectorCotizacion()));
	fileManager f_Out = new fileManager("Huffman_ETH");
	f_Out.fileOut(B_ETH);
	System.out.println("");
	System.out.println("Tamaño archivo ETH codificado con Huffman Semi-Estatico: " + f_Out.getFileSize() + " Bytes");
	//BTC
	HuffmanSemiEstatico H_BTC = new HuffmanSemiEstatico(aux1.calcular_distribucion_de_probabilidades(BTC.getVectorCotizacion()));
	H_BTC.codificarCotizacion();
	byteEncoder bytes2 = new byteEncoder();
	System.out.println();
	System.out.println("BTC Archivo original: 6998 Bytes"); //Datos tomados por fuera del sistema, del archivo original
	System.out.println("Codificacion de BTC usando Huffman Semi-Estatico");
	List<Byte> B_BTC = bytes2.byteEncoderHuffman(BTC.getVectorCotizacion(), H_BTC.getCodificacion(), aux1.calcular_distribucion_de_probabilidades(BTC.getVectorCotizacion()));
	fileManager f_Out2 = new fileManager("Huffman_BTC");
	f_Out2.fileOut(B_BTC);
	System.out.println("");
	System.out.println("Tamaño archivo BTC codificado con Huffman Semi-Estatico: " + f_Out2.getFileSize() + " Bytes");
	System.out.println("");
	/*----------------------------------------------------------------------------------------------------------------*/
	// 2)c) - Codificar las cotizaciones de cada moneda usando RLC (Run Length Coding)
	//ETC
	System.out.println("2)c) Codificar las cotizaciones de cada moneda usando RLC (Run Length Coding) ");
	System.out.println("ETH Archivo original: 5520 Bytes");//Datos tomados por fuera del sistema, del archivo original
	System.out.println("ETH codificado con RLC:");
	RLC ETHCodificadoRLC = new RLC();
	ETHCodificadoRLC.codificarCotizacion(ETH.getVectorCotizacion());
	List<parCodificado> codificacion = ETHCodificadoRLC.getCodificacion();
	for (parCodificado par : codificacion) {
		System.out.print(par.getSimbolo() + "-" + par.getLongSecuencia() + " ");
	}
	fileManager Out_ETH_RLC = new fileManager("ETH_RLC.bin");
	byteEncoder encRLC = new byteEncoder();
	Out_ETH_RLC.fileOut(encRLC.encoderRLC(codificacion));
	System.out.println();
	System.out.println("Tamaño archivo ETH codificado con RLC: " + Out_ETH_RLC.getFileSize() + " Bytes");
	System.out.println();
	//BTC
	System.out.println("BTC Archivo original: 6998 Bytes"); //Datos tomados por fuera del sistema, del archivo original
	System.out.println("BTC codificado con RLC:");
	RLC BTCCodificadoRLC = new RLC();
	BTCCodificadoRLC.codificarCotizacion(BTC.getVectorCotizacion());
	List<parCodificado> codificacion2 = BTCCodificadoRLC.getCodificacion();
	for (parCodificado par : codificacion2) {
		System.out.print(par.getSimbolo() + "-" + par.getLongSecuencia() + " ");
	}
	fileManager Out_BTC_RLC = new fileManager("BTC_RLC.bin");
	byteEncoder encRLC2 = new byteEncoder();
	Out_BTC_RLC.fileOut(encRLC2.encoderRLC(codificacion2));
	System.out.println();
	System.out.println("Tamaño archivo BTC codificado con RLC: " + Out_BTC_RLC.getFileSize() + " Bytes");
	System.out.println();
	//-----------------------------------------------------------------------------------------------------------------
	// 3a) Calcular el canal asociado a partir de las señales de tres estados generadas en el Ejercicio 1.
	System.out.println("Ejercicio 3: ");
	System.out.println("3)a) Calcular el canal asociado a partir de las señales de tres estados generadas en el Ejercicio 1");
		Canal canal = new Canal(ETH.getVectorCotizacion(), BTC.getVectorCotizacion());
		// P(BTC,ETH)
		System.out.println("Matriz Conjunta: P(BTC,ETH) - Canal generado");
		double[][] matriz_conjunta_BTC_ETH = canal.get_matriz_conjuntaCotizaciones(ETH.getVectorCotizacion(), BTC.getVectorCotizacion());
		for (int i = 0; i < 3; i++) {
			for (int j = 0; j < 3; j++) {
				System.out.print(" " + matriz_conjunta_BTC_ETH[i][j]);
			}
			System.out.println();
		}
	/*----------------------------------------------------------------------------------------------------------------*/
	//3)b)Calcular el Ruido y Pérdida del canal e interpretar.
		System.out.println();
		System.out.println("3)b)Ruido y Perdida del canal ");
		System.out.println();
		// P(ETH/BTC)
		System.out.println("Matriz Conjunta: P(ETH/BTC)");
		double[][] matriz_condicional_ETH_BTC = canal.matrizCondicionalETHBTC();
		for (int i = 0; i < 3; i++) {
			for (int j = 0; j < 3; j++) {
				System.out.print(" " + matriz_condicional_ETH_BTC[i][j]);
			}
			System.out.println();
		}
		System.out.println();
		// P(BTC/ETH)
		System.out.println("Matriz Conjunta: P(ETH/BTC)");
		double[][] matriz_condicional_BTC_ETH = canal.matrizCondicionalBTCETH();
		for (int i = 0; i < 3; i++) {
			for (int j = 0; j < 3; j++) {
				System.out.print(" " + matriz_condicional_BTC_ETH[i][j]);
			}
			System.out.println();
		}
		System.out.println();
		// Ruido del canal
		System.out.println("Ruido del canal: " + canal.getRuido());
		// Perdida del canal
		System.out.println("Perdida del canal: " + canal.getPerdida());
	/*----------------------------------------------------------------------------------------------------------------*/
	//3)c)Analizar la utilidad del canal para estimar el comportamiento de una moneda en base a la otra.
		System.out.println();
		System.out.println("3)c)Analizar la utilidad del canal para estimar el comportamiento de una moneda en base a la otra. ");
		System.out.println("Utilidad del canal: "+canal.getInformacionMutua());
		System.out.println();
		System.out.println("Se exportaron los archivos comprimidos al directorio del sistema.");

	}
}
