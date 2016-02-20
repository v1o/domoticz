-- demo time script
-- script names have three name components: script_trigger_name.lua
-- trigger can be 'time' or 'device', name can be any string
-- domoticz will execute all time and device triggers when the relevant trigger occurs
--
-- copy this script and change the "name" part, all scripts named "demo" are ignored.
--
-- Make sure the encoding is UTF8 of the file
--
-- ingests tables: otherdevices,otherdevices_svalues
--
-- otherdevices and otherdevices_svalues are two item array for all devices:
--   otherdevices['yourotherdevicename']="On"
--	otherdevices_svalues['yourotherthermometer'] = string of svalues
--
-- Based on your logic, fill the commandArray with device commands. Device name is case sensitive.
--
-- Always, and I repeat ALWAYS start by checking for a state.
-- If you would only specify commandArray['AnotherDevice']='On', every time trigger (e.g. every minute) will switch AnotherDevice on.
--
-- The print command will output lua print statements to the domoticz log for debugging.
-- List all otherdevices states for debugging:
--   for i, v in pairs(otherdevices) do print(i, v) end
-- List all otherdevices svalues for debugging:
--   for i, v in pairs(otherdevices_svalues) do print(i, v) end

function timedifference (s)
	year = string.sub(s, 1, 4)
	month = string.sub(s, 6, 7)
	day = string.sub(s, 9, 10)
	hour = string.sub(s, 12, 13)
	minutes = string.sub(s, 15, 16)
	seconds = string.sub(s, 18, 19)
	t1 = os.time()
	t2 = os.time{year=year, month=month, day=day, hour=hour, min=minutes, sec=seconds}
	difference = os.difftime (t1, t2)
	return difference
end

commandArray = {}

if (
	timeofday['Nighttime'] and
	timedifference(otherdevices_lastupdate['Burglar']) > 600 and
	(otherdevices['TV'] == 'On' or otherdevices['Sofa'] == 'On')) then

	commandArray['Hallway1'] = 'Off AFTER 5'
	commandArray['TV'] = 'Off AFTER 3'
	commandArray['Sofa'] = 'Off'

	print('Turning off Sofa light')
end

return commandArray
