local wezterm = require('wezterm')
local config = wezterm.config_builder()
local act = wezterm.action
local mux = wezterm.mux

-- Styles
-- config.color_scheme = 'Dracula'
-- config.color_scheme = 'Kanagawa (Gogh)'
-- config.color_scheme = 'Tokyo Night'
-- config.color_scheme = 'Catppuccin Mocha'
config.color_scheme = 'nightfox'
config.font_size = 15.0
config.font = wezterm.font {
    family = 'JetBrains Mono',
    weight = 500,
    italic = false,
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
}
config.window_decorations = "RESIZE"


-- ░██████████   ░███    ░████████     ░██████
--     ░██      ░██░██   ░██    ░██   ░██   ░██
--     ░██     ░██  ░██  ░██    ░██  ░██
--     ░██    ░█████████ ░████████    ░████████
--     ░██    ░██    ░██ ░██     ░██         ░██
--     ░██    ░██    ░██ ░██     ░██  ░██   ░██
--     ░██    ░██    ░██ ░█████████    ░██████

config.tab_bar_at_bottom = true
-- Better GUI controls
config.use_fancy_tab_bar = false
-- Don't let any tab name take too much room
config.tab_max_width = 33
-- Switch to the last active tab when closing a tab
config.switch_to_last_active_tab_when_closing_tab = false

-- ░██████   ░██████████   ░██████     ░██████   ░██████  ░██████   ░███    ░██   ░██████
-- ░██   ░██  ░██          ░██   ░██   ░██   ░██    ░██   ░██   ░██  ░████   ░██  ░██   ░██
-- ░██         ░██         ░██         ░██           ░██  ░██     ░██ ░██░██  ░██ ░██
-- ░████████  ░█████████   ░████████   ░████████    ░██  ░██     ░██ ░██ ░██ ░██  ░████████
--       ░██ ░██                 ░██         ░██   ░██  ░██     ░██ ░██  ░██░██         ░██
-- ░██   ░██  ░██          ░██   ░██   ░██   ░██    ░██   ░██   ░██  ░██   ░████  ░██   ░██
-- ░██████   ░██████████   ░██████     ░██████   ░██████  ░██████   ░██    ░███   ░██████

-- Setup a mux server off a unix socket
config.unix_domains = {
    {
        name = 'unix',
    },
}

-- session saving
local session_manager = require('wezterm-session-manager/session-manager')

-- plugin to replace eventually
wezterm.on("save_session", function(window) session_manager.save_state(window) end)
wezterm.on("load_session", function(window) session_manager.load_state(window) end)
wezterm.on("restore_session", function(window) session_manager.restore_state(window) end)

wezterm.on("update-right-status", function(window, pane)
    local workspace = mux.get_active_workspace()
    local scheme = window:effective_config().resolved_palette

    window:set_right_status(wezterm.format({
        { Foreground = { Color = scheme.ansi[8] } },
        { Text = "<" .. workspace .. ">" },
    }))
end)

-- keymaps
config.leader = {
    key = 'a',
    mods = 'CTRL',
    timeout_milliseconds = 2000,
}

config.keys = {
    {
        key = '[',
        mods = 'LEADER',
        action = wezterm.action.ActivateCopyMode,
    },
    -- create a tab
    {
        key = 'c',
        mods = 'LEADER',
        action = act.SpawnTab('CurrentPaneDomain'),
    },
    -- close pane
    {
        key = 'x',
        mods = 'LEADER',
        action = act.CloseCurrentPane({ confirm = false }),
    },
    -- go next
    {
        key = 'n',
        mods = 'LEADER',
        action = wezterm.action.ActivateTabRelative(1),
    },
    -- go prev
    {
        key = 'p',
        mods = 'LEADER',
        action = wezterm.action.ActivateTabRelative(-1),
    },
    -- rename current tab
    {
        key = ',',
        mods = 'LEADER',
        action = act.PromptInputLine({
            description = 'Enter new name for tab',
            action = wezterm.action_callback(
                function(window, _, line)
                    if line then
                        window:active_tab():set_title(line)
                    end
                end
            ),
        }),
    },
    -- display tab navigator
    {
        key = 't',
        mods = 'LEADER',
        action = act.ShowTabNavigator,
    },
    -- Vertical split
    {
        key = '|',
        mods = 'LEADER|SHIFT',
        action = act.SplitPane({
            direction = 'Right',
            size = { Percent = 50 },
        }),
    },
    -- Horizontal split
    {
        key = '-',
        mods = 'LEADER',
        action = act.SplitPane({
            direction = 'Down',
            size = { Percent = 50 },
        }),
    },
    -- Swap panes
    {
        key = '{',
        mods = 'LEADER|SHIFT',
        action = act.PaneSelect({ mode = 'SwapWithActiveKeepFocus' })
    },
    -- Attach to muxer
    {
        key = 'a',
        mods = 'LEADER',
        action = act.AttachDomain('unix'),
    },
    -- Detach from muxer
    {
        key = 'd',
        mods = 'LEADER',
        action = act.DetachDomain({ DomainName = 'unix' }),
    },
    -- create a new workspace
    {
        key = "C",
        mods = "LEADER",
        action = act.SwitchToWorkspace,
    },
    -- Rename current session; analagous to command in tmux
    {
        key = '$',
        mods = 'LEADER|SHIFT',
        action = act.PromptInputLine({
            description = 'Enter new name for session',
            action = wezterm.action_callback(
                function(window, _, line)
                    if line then
                        mux.rename_workspace(
                            window:mux_window():get_workspace(),
                            line
                        )
                    end
                end
            ),
        }),
    },
    -- Show list of workspaces
    {
        key = 's',
        mods = 'LEADER',
        action = act.ShowLauncherArgs({ flags = 'WORKSPACES' }),
    },
    -- Close all tabs in active workspace -> close workspace
    {
        key = "X",
        mods = "LEADER|SHIFT",
        action = wezterm.action_callback(function(window, _)
            local mux_window = window:mux_window()

            for _, tab in ipairs(mux_window:tabs()) do
                tab:active_pane():activate()
                window:perform_action(
                    act.CloseCurrentPane({ confirm = true }),
                    tab:active_pane()
                )
            end
        end),
    },
    {
        key = 's',
        mods = 'LEADER|SHIFT',
        action = act({ EmitEvent = "save_session" }),
    },
    {
        key = 'l',
        mods = 'LEADER|SHIFT',
        action = act({ EmitEvent = "load_session" }),
    },
    {
        key = 'r',
        mods = 'LEADER|SHIFT',
        action = act({ EmitEvent = "restore_session" }),
    },
    {
        key = 'h',
        mods = 'LEADER',
        action = act.ActivatePaneDirection('Left'),
    },
    {
        key = 'l',
        mods = 'LEADER',
        action = act.ActivatePaneDirection('Right'),
    },
    {
        key = 'k',
        mods = 'LEADER',
        action = act.ActivatePaneDirection('Up'),
    },
    {
        key = 'j',
        mods = 'LEADER',
        action = act.ActivatePaneDirection('Down'),
    },
}

for i = 1, 9 do
    -- CTRL+ALT + number to activate that tab
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'LEADER',
        action = act.ActivateTab(i - 1),
    })
end


return config
