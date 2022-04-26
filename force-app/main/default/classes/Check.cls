/**
 * Clase externa que valida datos, en este caso solo tiene para valida nif
 */
public class Check {
    public static final String FORMATO_NIF = '^[0-9]{8}[A-Za-z]$';

    public static Boolean nif(String identificador) {
        System.debug('entro para mirar el nif');
        List<String> letras = new List<String>{'T','R','W','A','G','M','Y','F','P','D','X','B','N','J','Z','S','Q','V','H','L','C','K','E'};

        Pattern pat = Pattern.compile(FORMATO_NIF);
        Matcher mat = pat.matcher(identificador);

        if(mat.matches()) {
            Integer numeros = Integer.valueOf(identificador.substring(0, identificador.length()-1));
            String letraObtenida = letras.get(Math.mod(numeros, 23));

            if(letraObtenida.toUpperCase() == identificador.substring(identificador.length()-1, identificador.length())) {
                System.debug('nif valido');
                return true;
            }
        }

        return false;
    }
}
