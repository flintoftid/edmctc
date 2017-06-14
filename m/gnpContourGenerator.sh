#!/bin/bash
# gnpContourGenerator.sh - generator contours and labels for gnuplot.
#
# "Gnuplotter's" gawk script from:
#
# http://gnuplot-tricks.blogspot.co.uk/2009/07/maps-contour-plots-with-labels.html
#
# based on Petr Mikulik's (http://www.sci.muni.cz/~mikulik/english.html) gawk script from:
#
# http://www.gnuplot.info/scripts/files/label_contours.awk
#

gawk -v d=$2 -v w=$3 -v os=$4 'function abs(x) { return (x>=0?x:-x) }
    {
            if($0~/# Contour/) nr=0
            if(nr==int(os+w/2) && d==0) {a[i]=$1; b[i]=$2; c[i]=$3;}
            if(nr==int(os+w/2)-1 && d==0) {i++; x = $1; y = $2;}
            if(nr==int(os+w/2)+1 && d==0) r[i]= 180.0*atan2(y-$2, x-$1)/3.14
            if(abs(nr-os-w/2)>w/2 && d==1) print $0
            nr++
    }
    END {   if(d==0) {
                    for(j=1;j<=i;j++)
                    printf "set label %d \"%g\" at %g, %g centre front rotate by %d font \",8\"\n", j, c[j], a[j], b[j], r[j]
            }
    }' $1
