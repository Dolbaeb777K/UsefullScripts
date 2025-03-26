#!/bin/bash
#   - made by AI-GigaChat and me - Dolbaeb777K or Hip.



#  __________.__               .__           __                       .__                               .__        __   
#  \______   \  |  __ __  ____ |__| ____   _/  |_  ____   ____   ____ |  |   ____     ______ ___________|__|______/  |_ 
#   |     ___/  | |  |  \/ ___\|  |/    \  \   __\/  _ \ / ___\ / ___\|  | _/ __ \   /  ___// ___\_  __ \  \____ \   __\
#   |    |   |  |_|  |  / /_/  >  |   |  \  |  | (  <_> ) /_/  > /_/  >  |_\  ___/   \___ \\  \___|  | \/  |  |_> >  |  
#   |____|   |____/____/\___  /|__|___|  /  |__|  \____/\___  /\___  /|____/\___  > /____  >\___  >__|  |__|   __/|__|  
#                      /_____/         \/              /_____//_____/           \/       \/     \/         |__|         


enabDis() {
	plugin="$1"

	# GET STATUS hyprbars FROM hyprpm list
	status=$(hyprpm list | awk "/Plugin ${plugin}/ {getline; print \$NF}" | tr -d '\n ')

	# CHECK STATUS AND DISABLING OR ENABLING PLUGING.
	if [[ "$status" == *"true"* ]]; then
		  # If ENABLED, DISABLING...
			echo "$status"
			hyprpm disable "$plugin"
	else
		  # IF DISABLED, ENABLING...
			hyprpm enable "$plugin"
	fi
}

# CHOOSING.
if [[ "$1" ]]; then
	arg="$1"
	enabDis ${arg:2}
else
	echo -e "Select your existing plugin. Usage \"--plugin\" \nExample: PluginToggle.sh --hyprbars\n\n（︶︿︶）"
fi

# ▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬▬
