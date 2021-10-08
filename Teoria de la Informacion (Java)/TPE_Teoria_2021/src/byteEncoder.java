import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class byteEncoder {
	private static int bufferLength = 8;
	public List<Byte> byteEncoderHuffman(int[] vector_cotizacion, HashMap<String, Integer> codificacionResultante, Map<Integer, Double> distribucionProbabilidades){
        //Este metodo codifica la secuencia de cotizaciones segun el arbol de huffman para la distribucion de la misma
    	List<Byte> result = new ArrayList<>();
    	byte buffer = 0;
        int bufferPos = 0;
        int i = 0;
        int j = 0;
        /*---------------------------------------Cabecera-------------------------------------------------------------*/
        //Almaceno longitud de secuencia primero
        int longitud =vector_cotizacion.length;
        String longStr =Integer.toBinaryString(longitud);
        char[] longCot = longStr.toCharArray();
        while (j < longCot.length) {
            // La operacion de corrimiento pone un '0'
            buffer = (byte) (buffer << 1);
            bufferPos++;
            if (longCot[j] == '1') {
                buffer = (byte) (buffer | 1);
            }
            if (bufferPos == 10) { //Almaceno la longitud en un buffer fijo de 16 bites
                result.add(buffer);
                buffer = 0;
                bufferPos = 0;
            }
            j++;
        }

        if ((bufferPos < 10) && (bufferPos != 0)) {
            buffer = (byte) (buffer << (10 - bufferPos));
            result.add(buffer);
        }
        j=0;
        /* --------------------------------Distribucion de probabilidades---------------------------------------------*/
        //Se pasa el HashMap de la distribucion de probabilidades, se separa la frecuencia y se almacena una seguida de otra
        Iterator<Integer> it = distribucionProbabilidades.keySet().iterator(); // Iterador por clave
        while (it.hasNext()) {
            int cotizacion = it.next();
            double probabilidad = distribucionProbabilidades.get(cotizacion);
            int frecuencia = (int) Math.round(probabilidad * 1000); //1000: Cantidad de simbolos de la señal
            String cotizacionStr =Integer.toBinaryString(frecuencia);
            String frecuenciaStr = Integer.toBinaryString(cotizacion);
            char[] cotizacion2 = cotizacionStr.toCharArray();
            char[] frecuencia2 = frecuenciaStr.toCharArray();
            buffer = 0;
            bufferPos = 0;
            j = 0;
            while (j < cotizacion2.length) {
                // La operacion de corrimiento pone un '0'
                buffer = (byte) (buffer << 1);
                bufferPos++;
                if (cotizacion2[j] == '1') {
                    buffer = (byte) (buffer | 1);
                }
                if (bufferPos == 16) { //Almaceno cada simbolo en un buffer fijo de 16 bites
                    result.add(buffer);
                    buffer = 0;
                    bufferPos = 0;
                }
                j++;
            }

            if ((bufferPos < 16) && (bufferPos != 0)) {
                buffer = (byte) (buffer << (16 - bufferPos));
                result.add(buffer);
            }
            buffer = 0;
            bufferPos = 0;
            j = 0;
            while (j < frecuencia2.length) {
                // La operacion de corrimiento pone un '0'
                buffer = (byte) (buffer << 1);
                bufferPos++;
                if (frecuencia2[j] == '1') {
                    buffer = (byte) (buffer | 1);
                }
                if (bufferPos == 10) { //Almaceno cada frecuencia en un buffer fijo de 10 bites
                    result.add(buffer);
                    buffer = 0;
                    bufferPos = 0;
                }
                j++;
            }

            if ((bufferPos < 10) && (bufferPos != 0)) {
                buffer = (byte) (buffer << (10 - bufferPos));
                result.add(buffer);
            }
        }
        /*-------------------------------Fin de carga de cabecera------------------------------------------------------*/
        buffer = 0;
        bufferPos = 0;
        i = 0;
        j = 0;
        while (i < vector_cotizacion.length) {
            System.out.print(codificacionResultante.get(Integer.toString(vector_cotizacion[i])));//Imprimo por pantalla la codificacion
            //Guardo la codificacion del simbolo en un arreglo para recorrerlo por cada posicion
        	String codificacionAcutal = String.valueOf(codificacionResultante.get(Integer.toString(vector_cotizacion[i])));
        	char[] codificacionActualChar = codificacionAcutal.toCharArray();
        	j=0;
        	while(j < codificacionActualChar.length) {
        	// La operacion de corrimiento pone un '0'
            buffer = (byte) (buffer << 1);
            bufferPos++;
            if ( codificacionActualChar[j] == '1') {
               buffer = (byte) (buffer | 1);
            }
            if (bufferPos == bufferLength) {
                result.add(buffer);
                buffer = 0;
                bufferPos = 0;
            }
            j++;
        	}
            i++;
            }
            if ((bufferPos < bufferLength) && (bufferPos != 0)){
                buffer = (byte) (buffer << (bufferLength - bufferPos));
                result.add(buffer);
            }
        return result;
	}
        public List<Byte> encoderRLC(List<parCodificado> codificacion){
            List<Byte> result = new ArrayList<>();
            byte buffer = 0;
            int bufferPos = 0;
            int j = 0;
            for (parCodificado par : codificacion) {
                String simbolo = Integer.toBinaryString(par.getSimbolo());
                String longSec = Integer.toBinaryString(par.getLongSecuencia());
                char[] codBinSimbolo= simbolo.toCharArray();
                char[] codBinlongSec= longSec.toCharArray();
                //Almaceno el simbolo en un buffer fijo
                while (j < codBinSimbolo.length) {
                    // La operacion de corrimiento pone un '0'
                    buffer = (byte) (buffer << 1);
                    bufferPos++;
                    if (codBinSimbolo[j] == '1') {
                        buffer = (byte) (buffer | 1);
                    }
                    if (bufferPos == 16) {
                        result.add(buffer);
                        buffer = 0;
                        bufferPos = 0;
                    }
                    j++;
                }
                if ((bufferPos < 16) && (bufferPos != 0)) {
                    buffer = (byte) (buffer << (16 - bufferPos));
                    result.add(buffer);
                }
                //Almaceno la cantidad de repeticiones del simbolo en un buffer fijo
                buffer = 0;
                bufferPos = 0;
                j = 0;
                while (j < codBinlongSec.length) {
                    // La operacion de corrimiento pone un '0'
                    buffer = (byte) (buffer << 1);
                    bufferPos++;
                    if (codBinlongSec[j] == '1') {
                        buffer = (byte) (buffer | 1);
                    }
                    if (bufferPos == bufferLength) {
                        result.add(buffer);
                        buffer = 0;
                        bufferPos = 0;
                    }
                    j++;
                }
                if ((bufferPos < bufferLength) && (bufferPos != 0)) {
                    buffer = (byte) (buffer << (bufferLength - bufferPos));
                    result.add(buffer);
                }
            }
            return result;
        }
        /*Las dos codificaciones se encuentran listas para decodificar, como no se nos solicito realizar la decodificacion para este trabajo
        dejo explicado como se encuentran almacenadas cada una las compresiones.
        HuffmanSemiEstatico
        Se almacena la cabecera en el mismo archivo .bin, se almacenan consecutivamente, en primer lugar la longitud de la secuencia, luego,
        consecutivamente se almacenan en buffer fijos para decodificar el simbolo y su frecuencia. A la hora de descodificar la informacion
        se tiene que cambiar de base binaria a decimal para obtener el simbolo y su frecuencia, con la frecuencia se obtiene la probabilidad del
        simbolo y se arma la distribucion de proabilidades para volver a construir el arbol de huffman y decodificar la secuencia.
        Cabecera: Longitud de la secuencia, es almacenada en un buffer fijo de 10 bites
                  Simbolo, es almacenado en un buffer fijo de 16 bits
                  Frecuencia es almacenado en un buffer fijo de 10 bits
        Codificacion de RLC
            Se almacenan consecutivamente en una lista de bytes, el simbolo con un buffer fijo de 16 bits y la frecuencia en 8 bits
            se descodifica ordenadamente, por cada buffer se traduce de binario a decimal y se vuelve a armar la secuencia
        */
}
