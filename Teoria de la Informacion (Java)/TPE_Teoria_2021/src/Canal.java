public class Canal {
    private static int CANT = 3;
    int SIZE = 1000;
    double[][] matConjunta = new double[CANT][CANT];

    public Canal(int[] ETH, int[]BTC) {
        this.matConjunta = get_matriz_conjuntaCotizaciones(ETH,BTC);
    }

    public double[][] get_matriz_conjuntaCotizaciones(int []ETH, int []BTC) { // BTC Entrada ; ETH Salida
        double v_antBTC = BTC[0];
        double v_antETH = ETH[0];
        double v_actualBTC;
        double v_actualETH;
        for (int i=1; i < SIZE; i++) { // 0: subio ; 1: mantiene ; 2: bajo
            v_actualBTC = BTC[i];
            v_actualETH = ETH[i];
            if (Double.compare(v_actualBTC, v_antBTC) == 0 ) {
                if (Double.compare(v_actualETH, v_antETH) == 0 ) {
                    this.matConjunta[1][0]++;
                    v_antBTC = v_actualBTC;
                    v_antETH = v_actualETH;

                }else
                if (Double.compare(v_actualETH, v_antETH) > 0 ) {
                    this.matConjunta[1][2]++;
                    v_antBTC = v_actualBTC;
                    v_antETH = v_actualETH;
                }
                else {
                    this.matConjunta[1][1]++;
                    v_antBTC = v_actualBTC;
                    v_antETH = v_actualETH;
                }
            }
            else {
                if (Double.compare(v_actualBTC, v_antBTC) > 0) {
                    if (Double.compare(v_actualETH, v_antETH) == 0 ) {
                        this.matConjunta[0][0]++;
                        v_antBTC = v_actualBTC;
                        v_antETH = v_actualETH;
                    }else
                    if (Double.compare(v_actualETH, v_antETH) > 0 ) {
                        this.matConjunta[0][2]++;
                        v_antBTC = v_actualBTC;
                        v_antETH = v_actualETH;
                    }
                    else {
                        this.matConjunta[0][1]++;
                        v_antBTC = v_actualBTC;
                        v_antETH = v_actualETH;
                    }
                } else
                    if (Double.compare(v_actualETH, v_antETH) == 0 ) {
                        this.matConjunta[2][0]++;
                        v_antBTC = v_actualBTC;
                        v_antETH = v_actualETH;
                    }else
                    if (Double.compare(v_actualETH, v_antETH) > 0 ) {
                        this.matConjunta[2][2]++;
                        v_antBTC = v_actualBTC;
                        v_antETH = v_actualETH;
                    }
                    else {
                        this.matConjunta[2][1]++;
                        v_antBTC = v_actualBTC;
                        v_antETH = v_actualETH;
                    }
            }
        }
        for (int i=0; i< CANT; i++) {
            for (int j=0; j < CANT; j++) {
                matConjunta[i][j]= matConjunta[i][j] / SIZE;
            }
        }
        return matConjunta;
    }

    public double[][] matrizCondicionalETHBTC(){ // Matriz P(Y/X) para calcular ruido, siendo X = BTC e Y = ETH (Salida dada entrada)
        double matCondicional[][] =  new double[CANT][CANT];
        double[] entrada = getProbETH();
        for (int i = 0; i < CANT; i++) {
            for (int j = 0; j < CANT; j++) {
                matCondicional[i][j] = matConjunta[i][j] / entrada[i];
            }
        }

        return matCondicional;
    }

    public double[][] matrizCondicionalBTCETH(){ // Matriz P(X/Y) para calcular perdida, siendo X = BTC e Y = ETH (entrada dada salida)
        double matCondicional[][] =  new double[CANT][CANT];
        double[] salida = getProbBTC();
        for (int i = 0; i < CANT; i++) {
            for (int j = 0; j < CANT; j++) {
                matCondicional[i][j] = matConjunta[i][j] / salida[i];
            }
        }

        return matCondicional;
    }

    public double getRuido(){ // P(Y(ETH)/X(BTC)) = P(X(BTC),Y(ETH)) / P(BTC)
        double resultado = 0;
        double total = 0;
        double[] salida = getProbBTC();
        for (int i = 0; i < CANT; i++) {
            resultado = 0;
            for (int j = 0; j < CANT; j++) {
                resultado = resultado + (- this.matrizCondicionalETHBTC()[j][i]*(Math.log(this.matrizCondicionalETHBTC()[j][i]) / Math.log(2)));
            }
            total = (resultado * salida[i]) + total;
        }
        return total;
    }
    public double getPerdida(){
        double resultado = 0;
        double total = 0;
        double[] salida = getProbETH();
        for (int i = 0; i < CANT; i++) {
            resultado = 0;
            for (int j = 0; j < CANT; j++) {
                resultado = resultado + (- this.matrizCondicionalBTCETH()[j][i]*(Math.log(this.matrizCondicionalBTCETH()[j][i]) / Math.log(2)));

            }
            total = (resultado * salida[i]) + total;
        }
        return total;
    }

    public double[] getProbBTC() {
        double[] arrSumaCol = new double[CANT];
        double suma = 0;
        for (int i = 0; i < CANT; i++) {
            for (int j = 0; j < CANT; j++) {
                suma += matConjunta[j][i];
            }
            arrSumaCol[i] = suma;
            suma = 0;
        }
        return arrSumaCol;
    }

    public double[] getProbETH() {
        double[] arrSumaFil = new double[CANT];
        double suma = 0;
        for (int i = 0; i < CANT; i++) {
            for (int j = 0; j < CANT; j++) {
                suma += matConjunta[i][j];
            }
            arrSumaFil[i] = suma;
            suma = 0;
        }
        return arrSumaFil;
    }
    public  double getInformacionMutua(){
        double[] BTC = this.getProbBTC();
        double resultadoParcial = 0;
        double perdida = this.getPerdida();
        for (int i = 0; i < CANT; i++){
            resultadoParcial+= - BTC[i]*(Math.log(BTC[i]) / Math.log(2));
        }
        return(resultadoParcial - perdida);
    }

}

