span_hi='<span color="#ff8700">'  #colour for normal battery  
 span_lo='<span color="#aaaaaa">'   #colour for normal battery  
 span_sep='<span color="#ff8700">' #colour for normal battery  
 span_warn='<span color="#ff0000">'  
 ## Set battery message  
 batt=`cat /sys/devices/platform/smapi/BAT0/remaining_percent`  
 time=`cat /sys/devices/platform/smapi/BAT0/remaining_running_time`  
 if (($batt <= 30));  
 then battstate="$span_warn$batt%% ($time min.)"' </span>'$span_lo`cat /sys/devices/platform/smapi/BAT0/state`'</span>'  
 else battstate="$span_hi$batt%% ($time min.)"' </span>'$span_lo`cat /sys/devices/platform/smapi/BAT0/state`'</span>'  
 fi  
 ## Create the output  
 echo $battstate  
