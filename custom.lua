local platform = require("utils.platform")()
local wezterm = require("wezterm")

return function ()
    local launch_prog = {}

    if platform.is_win then
        local function command_exists(cmd)
            local success, stdout, _ =
                wezterm.run_child_process({"where", cmd})
            return success and stdout and stdout ~= ""
        end

        if command_exists("pwsh") then
            launch_prog = { "pwsh", "-NoLogo"}
        elseif command_exists("powershell") then
            launch_prog = { "powershell", "-NoLogo"}
        else
            launch_prog = { "cmd" }
        end

        return {
            default_prog = launch_prog,
        }
    elseif platform.is_mac or platform.is_linux then
        local function command_path(cmd)
            local success, stdout, _ =
                wezterm.run_child_process({ "command", "-v", cmd })
            if success and stdout and stdout ~= "" then
                return stdout:gsub("%s+$", "")
            end

            success, stdout, _ =
                wezterm.run_child_process({ "grep", cmd, "/etc/shells" })
            if success and stdout and stdout ~= "" then
                -- Only get first one(without '\n')
                return stdout:match("([^\r\n]*)")
            end

            return nil
        end

        local is_set_default = false
        local launch_list = {}
        local shell_path = command_path("fish")
        if shell_path then
            if not is_set_default then
                is_set_default = true
                launch_prog = { shell_path, "-l", "-i" }
            end
            table.insert(launch_list, { label = "Fish", args = { shell_path, "-l", "-i" } })
            table.insert(launch_list, { label = "Fish (Private)", args = { shell_path, "-l", "-i", "-P" } })
        end

        shell_path = command_path("zsh")
        if shell_path then
            if not is_set_default then
                is_set_default = true
                launch_prog = { shell_path, "-l", "-i" }
            end
            table.insert(launch_list, { label = "Zsh", args = { shell_path, "-l", "-i" } })
        end

        shell_path = command_path("bash")
        if shell_path then
            if not is_set_default then
                is_set_default = true
                launch_prog = { shell_path, "-l" }
            end
            table.insert(launch_list, { label = "Bash", args = { shell_path, "-l" } })
        end

        return {
            default_prog = launch_prog,
            launch_menu = launch_list,
        }
    end
end

