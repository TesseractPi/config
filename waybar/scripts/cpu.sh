#!/usr/bin/env bash

# Get CPU model (removed "(R)", "(TM)", and clock speed)
model=$(awk -F ': ' '/model name/{print $2}' /proc/cpuinfo | head -n 1 | sed 's/@.*//; s/ *\((R)\|(TM)\)//g; s/^[ \t]*//; s/[ \t]*$//')

# Get CPU usage percentage
load=$(vmstat 1 2 | tail -1 | awk '{print 100 - $15}')

# Determine CPU state based on usage
if [ "$load" -ge 80 ]; then
  state="Critical"
elif [ "$load" -ge 60 ]; then
  state="High"
elif [ "$load" -ge 25 ]; then
  state="Moderate"
else
  state="Low"
fi

# Set color based on CPU load
if [ "$load" -ge 80 ]; then
  # If CPU usage is >= 80%, set color to #f38ba8
  loadText="<span color='#f38ba8'> ${load}%</span>"
else
  # Default color
  loadText=" ${load}%"
fi

# Get CPU clock speeds
getCPUFrequency() {
  freqList=$(awk '/cpu MHz/ {print $4}' /proc/cpuinfo)
  maxFreq=$(sed 's/...$//' /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq)
  avgFreq=$(echo "$freqList" | tr ' ' '\n' | awk "{sum+=\$1} END {printf \"%.0f/%s MHz\", sum/NR, $maxFreq}")
  echo "$avgFreq"
}

# Get CPU temperature
getCPUTemperature() {
  temp=$(sensors | awk '/Package id 0/ {print $4}' | awk -F '[+.]' '{print $2}')
  if [[ -z "$temp" ]]; then
    temp=$(sensors | awk '/Tctl/ {print $2}' | tr -d '+°C')
  fi
  if [[ -z "$temp" ]]; then
    temp="N/A"
  else
    freedomTemp=$(awk "BEGIN {printf \"%.1f\", ($temp * 9 / 5) + 32}")
  fi
  echo "${temp:-N/A} ${freedomTemp:-N/A}"
}

# Get the corresponding icon based on temperature
getTempIcon() {
  tempVal=$1
  if [ "$tempVal" -ge 80 ]; then
    icon="󰸁" # High temperature
  elif [ "$tempVal" -ge 70 ]; then
    icon="󱃂" # Medium temperature
  elif [ "$tempVal" -ge 60 ]; then
    icon="󰔏" # Normal temperature
  fi
  echo "$icon"
}

# Main script execution
CPUFrequency=$(getCPUFrequency)
read -r temp_info < <(getCPUTemperature)
temp=$(echo "$temp_info" | awk '{print $1}')   # Celsius
freedomTemp=$(echo "$temp_info" | awk '{print $2}') # Fahrenheit

# Determine the temperature icon
tempIcon=$(getTempIcon "$temp")

# Set color based on temperature
if [ "$temp" -ge 80 ]; then
  # If temperature is >= 80%, set color to #f38ba8
  tempTxt="<span color='#f38ba8'>${temp}°C</span>"
else
  # Default color
  tempTxt="${temp}°C"
fi

tooltip="${model}\nCPU Usage: ${state}\nTemperature: ${freedomTemp}°F\nClock Speed: ${CPUFrequency}"

# Module and tooltip
echo "{\"text\": \"${loadText}/${tempTxt}\", \"tooltip\": \"$tooltip\"}"
