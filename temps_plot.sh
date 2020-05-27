#!/bin/bash
while true; do \
  date; \
  gnuplot ~/gnuplot/temps.gpl; \
  mv /var/www/html/simon/temps/temps.tmp.svg /var/www/html/simon/temps/temps.svg; \
  sleep 10; \
done
