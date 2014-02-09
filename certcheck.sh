#!/bin/sh

DEBUG=false
warning_days=360 # Number of days to warn about soon-to-expire certs
certs_to_check='benedikt-wolters.de:443
zomax.net:443'

for CERT in $certs_to_check
do
  $DEBUG && echo "Checking cert: [$CERT]"

  output=$(echo | openssl s_client -connect ${CERT} 2>/dev/null |\
  sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' |\
  openssl x509 -noout -subject -dates 2>/dev/null) 

  if [ "$?" -ne 0 ]; then
    $DEBUG && echo "Error connecting to host for cert [$CERT]"
    logger -p local6.warn "Error connecting to host for cert [$CERT]"
    continue
  fi

  start_date=$(echo $output | sed 's/.*notBefore=\(.*\).*not.*/\1/g')
  end_date=$(echo $output | sed 's/.*notAfter=\(.*\)$/\1/g')

  start_epoch=$(date +%s -d "$start_date")
  end_epoch=$(date +%s -d "$end_date")

  epoch_now=$(date +%s)

  if [ "$start_epoch" -gt "$epoch_now" ]; then
    $DEBUG && echo "Certificate for [$CERT] is not yet valid"
    logger -p local6.warn "Certificate for $CERT is not yet valid"
  fi

  seconds_to_expire=$(($end_epoch - $epoch_now))
  days_to_expire=$(($seconds_to_expire / 86400))

  $DEBUG && echo "Days to expiry: ($days_to_expire)"

  warning_seconds=$((86400 * $warning_days))

  if [ "$seconds_to_expire" -lt "$warning_seconds" ]; then
    $DEBUG && echo "Cert [$CERT] is soon to expire ($seconds_to_expire seconds)"
    logger -p local6.warn "cert [$CERT] is soon to expire ($seconds_to_expire seconds)"
  fi
done
