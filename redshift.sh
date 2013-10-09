#!/bin/bash

pidof gtk-redshift > /dev/null 2>&1 && {
        killall gtk-redshift
            exit
}

gtk-redshift -t 6500:6200 -l 50.937531:6.960279
