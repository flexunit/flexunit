package org.sonatype.flexmojos.util;

import java.lang.reflect.Array;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

public class CollectionUtils
{

    public static <E> List<E> merge( Collection<E>... cols )
    {
        if ( cols == null )
        {
            return null;
        }

        Set<E> merged = new LinkedHashSet<E>();
        for ( Collection<E> col : cols )
        {
            if ( col == null || col.isEmpty() )
            {
                continue;
            }

            merged.addAll( col );
        }

        if ( merged.isEmpty() )
        {
            return Collections.emptyList();
        }

        return Collections.unmodifiableList( new LinkedList<E>( merged ) );
    }

    @SuppressWarnings( "unchecked" )
    public static <E> E[] merge( E[]... arrays )
    {
        if ( arrays == null )
        {
            return null;
        }

        Class<E> clazz = (Class<E>) arrays.getClass().getComponentType().getComponentType();

        Set<E> merged = new LinkedHashSet<E>();
        for ( E[] es : arrays )
        {
            if ( es == null || es.length == 0 )
            {
                continue;
            }

            merged.addAll( Arrays.asList( es ) );
        }

        if ( merged.isEmpty() )
        {
            return (E[]) Array.newInstance( clazz, 0 );
        }

        return merged.toArray( (E[]) Array.newInstance( clazz, merged.size() ) );
    }

}
