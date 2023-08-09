local fs = require "nixio.fs"

function string_split(input, delimiter)
	input = tostring(input)
	delimiter = tostring(delimiter)
	if delimiter == '' then
		return false
	end
	local pos = 0
	local arr = {}
	for st, sp in function() return string.find(input, delimiter, pos, true) end do
		table.insert(arr, string.sub(input, pos, st - 1))
		pos = sp + 1
	end
	table.insert(arr, string.sub(input, pos))
	return arr
end

mp = Map("cpufreq", translate("CPU Freq Settings"))
mp.description = translate("Set CPU Scaling Governor to Max Performance or Balance Mode")

s = mp:section(NamedSection, "cpufreq", "settings")
s.anonymouse = true

local policy_nums = luci.sys.exec("echo -n $(find /sys/devices/system/cpu/cpufreq/policy* -maxdepth 0 | grep -Eo '[0-9]+')")

for _, policy_num in ipairs(string_split(policy_nums, " ")) do
	local cpu_drv_type = 0
	local cpu_freqs = nil
	local freq_array = {}
	local cpu_dir = "/sys/devices/system/cpu/cpufreq"
	local cpufreq_list1 = cpu_dir .. "/policy" .. policy_num .. "/scaling_available_frequencies"
	local cpufreq_list2 = cpu_dir .. "/policy" .. policy_num .. "/stats/trans_table"
	if fs.access(cpufreq_list1) then
		cpu_drv_type = 1
		cpu_freqs = fs.readfile(cpufreq_list1)
		cpu_freqs = string.sub(cpu_freqs, 1, -3)
		freq_array = string_split(cpu_freqs, " ")
	elseif fs.access(cpufreq_list2) then
		cpu_drv_type = 2
		cpu_freqs = fs.readfile(cpufreq_list2)
		for v in string.gmatch(cpu_freqs, "[^\n][%s]*(%d+)[%s]*:") do
			table.insert(freq_array, v)
		end
	end
	if not freq_array or not cpu_freqs or cpu_drv_type == 0 then
		nixio.syslog("info", "[CpuFreq] Current CPU driver not supported!")
		return
	end

	cpu_governors = fs.readfile("/sys/devices/system/cpu/cpufreq/policy" .. policy_num .. "/scaling_available_governors")
	cpu_governors = string.sub(cpu_governors, 1, -3)

	governor_array = string_split(cpu_governors, " ")

	s:tab(policy_num, translate("Policy " .. policy_num))

	governor = s:taboption(policy_num, ListValue, "governor" .. policy_num, translate("CPU Scaling Governor"))
	for _, e in ipairs(governor_array) do
		if e ~= "" then governor:value(e, translate(e, string.upper(e))) end
	end

	minfreq = s:taboption(policy_num, ListValue, "minfreq" .. policy_num, translate("Min Idle CPU Freq"))
	for _, e in ipairs(freq_array) do
		if e ~= "" then minfreq:value(e) end
	end

	maxfreq = s:taboption(policy_num, ListValue, "maxfreq" .. policy_num, translate("Max Turbo Boost CPU Freq"))
	for _, e in ipairs(freq_array) do
		if e ~= "" then maxfreq:value(e) end
	end

	sdfactor = s:taboption(policy_num, Value, "sdfactor" .. policy_num, translate("CPU Switching Sampling rate"))
	sdfactor.datatype="range(1,100000)"
	sdfactor.description = translate("The sampling rate determines how frequently the governor checks to tune the CPU (ms)")
	sdfactor.placeholder = 10
	sdfactor.default = 10
	sdfactor:depends("governor" .. policy_num, "ondemand")

	upthreshold = s:taboption(policy_num, Value, "upthreshold" .. policy_num, translate("CPU Switching Threshold"))
	upthreshold.datatype="range(1,99)"
	upthreshold.description = translate("Kernel make a decision on whether it should increase the frequency (%)")
	upthreshold.placeholder = 50
	upthreshold.default = 50
	upthreshold:depends("governor" .. policy_num, "ondemand")
end

return mp
