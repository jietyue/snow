------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "DP-1",
    mode     = "1920x1080@180",
    position = "0x0",
    scale    = "1",
})

hl.monitor({
  output = "HDMI-A-1",
  mode = "1920x1080@75",
  position = "-1920x0",
  scale = "1",
})

hl.workspace_rule({
    workspace = "1",
    monitor = "DP-1",
})