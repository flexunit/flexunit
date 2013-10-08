package org.sonatype.flexmojos.coverage.util;

public class ApparatUtil {

    public static String toClassname(String apparatClassname) {
        String cn = apparatClassname;
        cn = cn.substring( cn.indexOf( ';' ) + 1 );
        cn = cn.substring( 0, cn.indexOf( '.' ) );
        cn = cn.replace( '/', '.' ).replace( '\\', '.' ).replace( ';', '.' );
        return cn;
    }

}
