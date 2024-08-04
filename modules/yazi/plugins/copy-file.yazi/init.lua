-- REF: https://github.com/yazi-rs/plugins/blob/main/chmod.yazi/init.lua

local selected_or_hovered = ya.sync(function()
	local tab, paths = cx.active, {}
	for _, u in pairs(tab.selected) do
		paths[#paths + 1] = tostring(u)
	end
	if #paths == 0 and tab.current.hovered then
		paths[1] = tostring(tab.current.hovered.url)
	end
	return paths
end)

return {
	entry = function()
		ya.manager_emit("escape", { visual = true })

		local files = selected_or_hovered()
		-- local files = cx.active.current.hovered

		ya.dbg(files)
		if #files == 0 then
			return ya.notify({ title = "XClip", content = "No file selected", level = "warn", timeout = 5 })
		end

		-- xclip -t <MIME_TYPE> -selection clipboard -i <FILE>
		local status, err = Command("xclip")
			-- :arg("-t")
			-- :arg(files:mime())
			:arg("-selection")
			:arg("clipboard")
			:arg("-i")
			-- :arg(files.url)
			:spawn()
			:wait()

		ya.dbg({ status, err })

		if not status or not status.success then
			ya.notify({
				title = "XClip",
				content = string.format(
					"xclip with selected files failed, exit code %s",
					status and status.code or err
				),
				level = "error",
				timeout = 5,
			})
		end
	end,
}
