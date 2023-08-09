module("luci.controller.autoreboot", package.seeall)

function index()
        entry({"admin", "system", "autoreboot"}, cbi("autoreboot"), _("定时重启"), 100)
        end
