from i3pystatus import Status
status = Status(standalone=True)


status.register("clock",
	format="%a %-d %b %X KW%V",
	on_leftclick= ["/usr/local/bin/orage_toggle"],
)


status.register("network",
	interface="enp0s31f6",
	format_up="{v4cidr}",
	format_down="enp0s31f6 down",
	color_up="#FFFFFF",
	color_down="#A3A3A3",
)


status.register("network",
	interface="wlp4s0",
	format_up="{essid} {quality:3.0f}% ({v4cidr})",
	format_down="WLAN aus",
	color_up="#FFFFFF",
	color_down="#A3A3A3",
)


status.register("pulseaudio",
	format="{volume}",
	format_muted="{volume}",
)


status.register("battery",
	format="{status} {percentage:.0f}",
	full_color="#FFFFFF",
	color="#FFFFFF",
	charging_color="#FFFFFF",
	alert=True,
	alert_percentage=7,
	status={
		"DIS": "",
		"CHR": "",
		"FULL": "",
	},
)


#status.register('weather',
#        backend=weathercom.Weathercom(
#            location_code='USAZ0247:1:US',
#	    units='imperial',
#            update_error='<span color="#ff0000">!</span>',
#            ),
#	format="S: {current_temp}",
#	colorize=False,
#	on_leftclick= ["google-chrome-stable --app=http://www.weather.com/de-DE/wetter/heute/l/GMXX0446"],
#)
#
#
#status.register("weather",
#        location_code="USAZ0247:1:US",
#	format="D: {current_temp}",
#	colorize=False,
#	units="metric",
#	on_leftclick= ["google-chrome-stable --app=http://www.yr.no/place/Germany/North_Rhine-Westphalia/D%C3%BCsseldorf/"],
#)


status.run()
