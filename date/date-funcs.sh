
# convert any valid date to ISO 8601 format (YYYY-MM-DD HH:MM:SS)
#
# usage: to_iso_date "date string"
# example: to_iso_date "March 14, 2023"
# output: 2023-03-14

to_iso_date() {
  local IFS=''
  local inputDate="$@"
  date -d "$inputDate" +"%Y-%m-%d %H:%M:%S"
}

# conver any valid date to RFC 2822 format (Day, DD Mon YYYY HH:MM:SS +0000)
#
# usage: to_rfc_date "date string"
# example: to_rfc_date "March 14, 2023"
# output: Tue, 14 Mar 2023 00:00:00 +000
to_rfc_date() {
  local IFS=''
  local inputDate="$@"
  date -d "$inputDate" +"%a, %d %b %Y %H:%M:%S %z"
}


# convert any valid date to Unix timestamp (seconds since epoch)
# 
# usage: to_epoch_timestamp "date string"
# example: to_epoch_timestamp "March 14, 2023"
# output: 1678752000
# note: output will vary based on timezone
# example: to_epoch_timestamp "March 14, 2023 12:00:00 UTC"
# output: 1678804800
to_epoch_timestamp() {
  local IFS=''
  local inputDate="$@"
  date -d "$inputDate" +%s
}

# convert Unix (epoch) timestamp to ISO 8601 format (YYYY-MM-DD HH:MM:SS)
# 
# usage: from_epoch_to_iso "timestamp"
# example: from_epoch_to_iso 1678752000
# output: 2023-03-14 00:00:00
from_epoch_to_iso() {
  local IFS=''
  local inputDate="$@"
  date -d "@$inputDate" +"%Y-%m-%d %H:%M:%S"
}
#
# convert epoch timestamp to RFC 2822 format (Day, DD Mon YYYY HH:MM:SS +0000)
# 
# usage: from_epoch_to_rfc "timestamp"
# example: from_epoch_to_rfc 1678752000
# output: Tue, 14 Mar 2023 00:00:00 +000
from_epoch_to_rfc() {
  local IFS=''
  local inputDate="$@"
  date -d "@$inputDate" +"%a, %d %b %Y %H:%M:%S %z"
}

