f = (loadfile "/home/pi/dev-domoticz/scripts/lua/tools.lua")()

commandArray = {}

-- Livingroom PIR
if (
	timeofday['Nighttime'] and
	timedifference(otherdevices_lastupdate['MainDoorMotion']) > 600 and
	otherdevices_svalues['Livingroom PIR'] == '0' and
	(lightStatus('Hallway1') == 'On' or lightStatus('TV') == 'On' or lightStatus('Sofa') == 'On')) then

	print('Livingroom PIR inactive, closing some lights')

	commandArray['Hallway1'] = 'Off AFTER 5'
	commandArray['TV'] = 'Off AFTER 3'
	commandArray['Sofa'] = 'Off'
end

-- Bedroom PIR
if (
	timeofday['Nighttime'] and
	otherdevices_svalues['Bedroom PIR'] == '0' and
	otherdevices_svalues['Hallway PIR'] == '0' and
	(lightStatus('BedroomStrip') == 'On' or lightStatus('Bedroom') == 'On')) then

	print('Bedroom PIR inactive, closing some lights')

	commandArray['BedroomStrip'] = 'Off AFTER 3'
	commandArray['Bedroom'] = 'Off'
end

-- Hallway PIR
if (
	timeofday['Nighttime'] and
	otherdevices_svalues['Hallway PIR'] == '0' and
	(lightStatus('Hallway2') == 'On' or lightStatus('Hallway3') == 'On' or lightStatus('Hallway4') == 'On')) then

	print('Hallway PIR inactive, closing some lights')

	commandArray['Hallway2'] = 'Off AFTER 1'
	commandArray['Hallway3'] = 'Off AFTER 5'
	commandArray['Hallway4'] = 'Off AFTER 3'
end


return commandArray

