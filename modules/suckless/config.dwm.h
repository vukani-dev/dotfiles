/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx = 2;       /* border pixel of windows */
static const int corner_radius = 0;
static const unsigned int snap = 32;          /* snap pixel */
static const int scalepreview = 3;            /* Tag preview scaling */
static const unsigned int gappih = 10;        /* horiz inner gap between windows */
static const unsigned int gappiv = 10;        /* vert inner gap between windows */
static const unsigned int gappoh = 10;        /* horiz outer gap between windows and screen edge */
static const unsigned int gappov = 10;        /* vert outer gap between windows and screen edge */
static const int smartgaps_fact = 1;          /* gap factor when there is only one client; 0 = no gaps, 3 = 3x outer gaps */
static const int showbar = 1;                 /* 0 means no bar */
static const int topbar = 1;                  /* 0 means bottom bar */
/*  Display modes of the tab bar: never shown, always shown, shown only in  */
/*  monocle mode in the presence of several windows.                        */
/*  Modes after showtab_nmodes are disabled.                                */
enum showtab_modes {
  showtab_never,
  showtab_auto,
  showtab_nmodes,
  showtab_always
};
static const int showtab = showtab_auto;      /* Default tab bar show mode */
static const int toptab = False;              /* False means bottom tab bar */
static const int bar_height = 0;              /* 0 means derive from font, >= 1 explicit height */
#define ICONSIZE 20                           /* icon size */
#define ICONSPACING 5                         /* space between icon and title */
/* Status is to be shown on: -1 (all monitors), 0 (a specific monitor by index), 'A' (active monitor) */
static const int statusmon = 'A';
static const unsigned int systrayspacing = 2; /* systray spacing */
static const int showsystray = 1;             /* 0 means no systray */

/* alt-tab configuration */
static const unsigned int tabmodkey = 0x40;   /* (Alt) when this key is held down the alt-tab functionality stays active. Must be the same modifier as used to run alttabstart */
static const unsigned int tabcyclekey = 0x17; /* (Tab) when this key is hit the menu moves one position forward in client stack. Must be the same key as used to run alttabstart */
static const unsigned int tabposy = 1;        /* tab position on Y axis, 0 = top, 1 = center, 2 = bottom */
static const unsigned int tabposx = 1;        /* tab position on X axis, 0 = left, 1 = center, 2 = right */
static const unsigned int maxwtab = 600;      /* tab menu width */
static const unsigned int maxhtab = 200;      /* tab menu height */

/* Indicators: see patch/bar_indicators.h for options */
static int tagindicatortype = INDICATOR_TOP_LEFT_SQUARE;
static int tiledindicatortype = INDICATOR_NONE;
static int floatindicatortype = INDICATOR_TOP_LEFT_SQUARE;

/* fonts */
static const char *fonts[] = {"FiraCode Nerd Font Mono:size=14", "Noto Color Emoji:size=14"};
static const char dmenufont[] = "FiraCode Nerd Font Mono:size=14";

/* colors */
/*
    Scheme definitions, each entry is composed of:
    fg: foreground color
    bg: background color
    border: border color when focused
    float: border color when floating
*/
static char c000000[] = "#000000"; // placeholder value (Black)

static char normfgcolor[] = "#ffffff";  // Normal foreground color (White)
static char normbgcolor[] = "#282c34";  // Normal background color (Dark Gray)
static char normbordercolor[] = "#282c34";  // Normal border color (Dark Gray)
static char normfloatcolor[] = "#db8fd9"; // Normal float color (Medium Purple)

static char selfgcolor[] = "#ffffff";     // Selected foreground color (White)
static char selbgcolor[] = "#304D75";     // Selected background color (Dark Blue)
static char selbordercolor[] = "#ff9e54";   // Selected border color (Orange)
static char selfloatcolor[] = "#304D75";  // Selected float color (Dark Blue)

static char titlenormfgcolor[] = "#ffffff";  // Title normal foreground color (White)
static char titlenormbgcolor[] = "#282c34";  // Title normal background color (Dark Gray)
static char titlenormbordercolor[] = "#444444"; // Title normal border color (Gray)
static char titlenormfloatcolor[] = "#db8fd9"; // Title normal float color (Medium Purple)

static char titleselfgcolor[] = "#ffffff";  // Title selected foreground color (White)
static char titleselbgcolor[] = "#304D75";  // Title selected background color (Dark Blue)
static char titleselbordercolor[] = "#304D75"; // Title selected border color (Dark Blue)
static char titleselfloatcolor[] = "#304D75"; // Title selected float color (Dark Blue)

static char tagsnormfgcolor[] = "#ffffff";  // Tags normal foreground color (White)
static char tagsnormbgcolor[] = "#304D75";  // Tags normal background color (Dark Blue)
static char tagsnormbordercolor[] = "#444444"; // Tags normal border color (Gray)
static char tagsnormfloatcolor[] = "#db8fd9"; // Tags normal float color (Medium Purple)

static char tagsselfgcolor[] = "#ffffff";  // Tags selected foreground color (White)
static char tagsselbgcolor[] = "#282c34";  // Tags selected background color (Dark Gray)
static char tagsselbordercolor[] = "#304D75"; // Tags selected border color (Dark Blue)
static char tagsselfloatcolor[] = "#304D75"; // Tags selected float color (Dark Blue)

static char hidnormfgcolor[] = "#304D75";  // Hidden normal foreground color (Dark Blue)
static char hidselfgcolor[] = "#227799";    // Hidden selected foreground color (Teal)
static char hidnormbgcolor[] = "#282c34";  // Hidden normal background color (Dark Gray)
static char hidselbgcolor[] = "#282c34";   // Hidden selected background color (Dark Gray)

static char urgfgcolor[] = "#ffffff";  // Urgent foreground color (White)
static char urgbgcolor[] = "#282c34";  // Urgent background color (Dark Gray)
static char urgbordercolor[] = "#ff0000"; // Urgent border color (Red)
static char urgfloatcolor[] = "#db8fd9"; // Urgent float color (Medium Purple)

static char *colors[][ColCount] = {
  /*                       fg                bg                border                float */
  [SchemeNorm] = {normfgcolor, normbgcolor, normbordercolor, normfloatcolor},
  [SchemeSel] = {selfgcolor, selbgcolor, selbordercolor, selfloatcolor},
  [SchemeTitleNorm] = {titlenormfgcolor, titlenormbgcolor, titlenormbordercolor,
                       titlenormfloatcolor},
  [SchemeTitleSel] = {titleselfgcolor, titleselbgcolor, titleselbordercolor,
                      titleselfloatcolor},
  [SchemeTagsNorm] = {tagsnormfgcolor, tagsnormbgcolor, tagsnormbordercolor,
                      tagsnormfloatcolor},
  [SchemeTagsSel] = {tagsselfgcolor, tagsselbgcolor, tagsselbordercolor,
                     tagsselfloatcolor},
  [SchemeHidNorm] = {hidnormfgcolor, hidnormbgcolor, c000000, c000000},
  [SchemeHidSel] = {hidselfgcolor, hidselbgcolor, c000000, c000000},
  [SchemeUrg] = {urgfgcolor, urgbgcolor, urgbordercolor, urgfloatcolor},
};

/* autostart commands */
static const char *const autostart[] = {
    NULL, NULL, NULL /* terminate */
};

/* scratchpads */
// static Sp scratchpads[] = {
//     /* name          cmd  */
//     {"spterm", spcmd1},
// };
const char *spcmd1[] = {"st", "-n", "spterm", "-g", "120x34", NULL};
static Sp scratchpads[] = {
  /* name          cmd  */
  {"spterm", spcmd1},
};

/* tagging */
static char *tagicons[][NUMTAGS] = {
    [DEFAULT_TAGS] = {"I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"},
    [ALTERNATIVE_TAGS] = {"A", "B", "C", "D", "E", "F", "G", "H", "I"},
    [ALT_TAGS_DECORATION] = {"<1>", "<2>", "<3>", "<4>", "<5>", "<6>", "<7>",
                             "<8>", "<9>"},
};

/* rules */
/*
  Configure specific window rules.
  RULE MACRO:
    - wintype: Window type, e.g., WTYPE "DIALOG"
    - isfloating: Whether the window should float, 1 for true, 0 for false.
    - class: Window class, e.g., "Gimp"
    - tags: Tag mask, e.g., 1 << 4 (for the 5th tag)
    - instance: Window instance, e.g., "spterm"
*/
static const Rule rules[] = {
  /* xprop(1):
   *	WM_CLASS(STRING) = instance, class
   *	WM_NAME(STRING) = title
   *	WM_WINDOW_ROLE(STRING) = role
   *	_NET_WM_WINDOW_TYPE(ATOM) = wintype
   */
  RULE(.wintype = WTYPE "DIALOG", .isfloating = 1)
      RULE(.wintype = WTYPE "UTILITY", .isfloating = 1)
          RULE(.wintype = WTYPE "TOOLBAR", .isfloating = 1)
              RULE(.wintype = WTYPE "SPLASH", .isfloating = 1)
                  RULE(.class = "Gimp", .tags = 1 << 4)
                      RULE(.class = "Firefox", .tags = 1 << 7)
                          RULE(.instance = "spterm", .tags = SPTAG(0),
                               .isfloating = 1)};

/* Bar rules */
/*
  Configure what is shown on the bar and where.
  - monitor: -1 for all monitors, 0 for a specific monitor, 'A' for the active monitor.
  - bar: Bar index, 0 is the default bar, 1 is an extra bar.
  - alignment: How the module is aligned (BAR_ALIGN_LEFT, BAR_ALIGN_RIGHT, BAR_ALIGN_NONE).
  - widthfunc, drawfunc, clickfunc, hoverfunc: Functions for bar module width, drawing, clicking, and hovering.
  - name: Visual clue for logging/debugging.
*/
static const BarRule barrules[] = {
  /* monitor   bar    alignment         widthfunc                 drawfunc
     clickfunc                hoverfunc                name */
  {-1, 0, BAR_ALIGN_LEFT, width_tags, draw_tags, click_tags, hover_tags,
   "tags"},
  {0, 0, BAR_ALIGN_RIGHT, width_systray, draw_systray, click_systray, NULL,
   "systray"},
  {statusmon, 0, BAR_ALIGN_RIGHT, width_status2d, draw_status2d, click_status2d,
   NULL, "status2d"},
  {-1, 0, BAR_ALIGN_NONE, width_wintitle, draw_wintitle, click_wintitle, NULL,
   "wintitle"},
};

/* layout(s) */
static const float mfact = 0.55;      /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;         /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
    /* symbol     arrange function */
    {"(@)", spiral},   /* first entry is default */
    {"><>", NULL},     /* no layout function means floating behavior */
    {"[M]", monocle},
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY, TAG)                                                      \
  {MODKEY, KEY, view, {.ui = 1 << TAG}},                                       \
      {MODKEY | ControlMask, KEY, toggleview, {.ui = 1 << TAG}},               \
      {MODKEY | ShiftMask, KEY, tag, {.ui = 1 << TAG}},                        \
      {MODKEY | ControlMask | ShiftMask, KEY, toggletag, {.ui = 1 << TAG}},

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                             \
  {                                                                            \
    .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL }                       \
  }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
                        // static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *dmenucmd[] = {"/home/vukani/scripts/launcher", NULL};
static const char *roficmd[] = {"/home/vukani/scripts/launcher", NULL};
static const char *termcmd[] = {"st", NULL};
static const char *browsercmd[] = {"firefox", NULL};
static const char *discordcmd[] = {"discord", NULL};
static const char *emailcmd[] = {"thunderbird", NULL};
static const char *codiumcmd[] = {"codium", NULL};
static const char *keepasscmd[] = {"keepassxc", NULL};
static const char *logseqcmd[] = {"logseq", NULL};

/* keybinds */
/*
  Keybinding definitions.
  - modifier: Key modifier, e.g., Mod4Mask (Super key)
  - key: Key symbol, e.g., XK_Return
  - function: Function to execute, e.g., spawn
  - argument: Argument for the function, e.g., {.v = termcmd}
*/
static const Key keys[] = {
  /* modifier                     key            function            argument */
  /* ----------------------------- Apps ----------------------------- */
  {MODKEY, XK_r, spawn, {.v = roficmd}},         // rofi launcher
  {MODKEY, XK_Return, spawn, {.v = termcmd}},    // terminal
  {MODKEY, XK_w, spawn, {.v = browsercmd}},      // browser
  {MODKEY, XK_d, spawn, {.v = discordcmd}},      // discord
  {MODKEY, XK_e, spawn, {.v = emailcmd}},        // email
  {MODKEY, XK_p, spawn, {.v = keepasscmd}},      // keepassxc
  {MODKEY, XK_n, spawn, {.v = logseqcmd}},       // logseq
  /* ----------------------------- DWM ----------------------------- */
  {MODKEY, XK_b, togglebar, {0}},                // toggle status bar visibility
  {MODKEY, XK_h, focusdir, {.i = 0}},            // focus left
  {MODKEY, XK_l, focusdir, {.i = 1}},            // focus right
  {MODKEY, XK_k, focusdir, {.i = 2}},            // focus up
  {MODKEY, XK_j, focusdir, {.i = 3}},            // focus down
  {MODKEY | ShiftMask, XK_h, placedir, {.i = 0}}, // move window left
  {MODKEY | ShiftMask, XK_l, placedir, {.i = 1}}, // move window right
  {MODKEY | ShiftMask, XK_k, placedir, {.i = 2}}, // move window up
  {MODKEY | ShiftMask, XK_j, placedir, {.i = 3}}, // move window down
  {MODKEY | ControlMask, XK_h, setmfact, {.f = -0.05}}, // decrease master area size
  {MODKEY | ControlMask, XK_l, setmfact, {.f = +0.05}}, // increase master area size
  {MODKEY, XK_Return, zoom, {0}},                       // swap focused window with master
  /* ----------------------------- Gaps ----------------------------- */
  {MODKEY | Mod4Mask, XK_u, incrgaps, {.i = +1}}, // increase gaps
  {MODKEY | Mod4Mask | ShiftMask, XK_u, incrgaps, {.i = -1}}, // decrease gaps
  {MODKEY | Mod4Mask, XK_i, incrigaps, {.i = +1}}, // increase inner gaps
  {MODKEY | Mod4Mask | ShiftMask, XK_i, incrigaps, {.i = -1}}, // decrease inner gaps
  {MODKEY | Mod4Mask, XK_o, incrogaps, {.i = +1}}, // increase outer gaps
  {MODKEY | Mod4Mask | ShiftMask, XK_o, incrogaps, {.i = -1}}, // decrease outer gaps
  {MODKEY | Mod4Mask, XK_6, incrihgaps, {.i = +1}}, // increase inner horizontal gaps
  {MODKEY | Mod4Mask | ShiftMask, XK_6, incrihgaps, {.i = -1}}, // decrease inner horizontal gaps
  {MODKEY | Mod4Mask, XK_7, incrivgaps, {.i = +1}}, // increase inner vertical gaps
  {MODKEY | Mod4Mask | ShiftMask, XK_7, incrivgaps, {.i = -1}}, // decrease inner vertical gaps
  {MODKEY | Mod4Mask, XK_8, incrohgaps, {.i = +1}}, // increase outer horizontal gaps
  {MODKEY | Mod4Mask | ShiftMask, XK_8, incrohgaps, {.i = -1}}, // decrease outer horizontal gaps
  {MODKEY | Mod4Mask, XK_9, incrovgaps, {.i = +1}}, // increase outer vertical gaps
  {MODKEY | Mod4Mask | ShiftMask, XK_9, incrovgaps, {.i = -1}}, // decrease outer vertical gaps
  {MODKEY | Mod4Mask, XK_0, togglegaps, {0}},                      // toggle gaps
  {MODKEY | Mod4Mask | ShiftMask, XK_0, defaultgaps, {0}},          // reset gaps to default
  /* ----------------------------- Utils ----------------------------- */
  {MODKEY | ShiftMask, XK_b, spawn, SHCMD("st -e bluetuith")}, // bluetooth manager
  {MODKEY, XK_y, spawn, SHCMD("st -e yazi")},                   // file manager
  {MODKEY, XK_i, spawn, SHCMD("st -e nmtui")},                  // network manager
  {MODKEY, XK_q, spawn, SHCMD("st -e gotop")},                  // system monitor
  {MODKEY, XK_c, spawn,
   SHCMD("st -e /home/vukani/scripts/toggle-syncthing.sh")}, // toggle syncthing
  {MODKEY | ShiftMask, XK_s, spawn, SHCMD("/home/vukani/scripts/screenshot.sh")}, // screenshot
  {MODKEY | ShiftMask, XK_m, spawn,
   SHCMD("/home/vukani/scripts/toggle-monitors.sh")}, // toggle monitors
  {MODKEY | ShiftMask, XK_x, spawn, SHCMD("st -e sudo slock")}, // lock screen
  /* ----------------------------- Sound ----------------------------- */
  {MODKEY, XK_s, spawn, SHCMD("st -e pulsemixer")}, // audio mixer
  {0, XF86XK_MonBrightnessUp, spawn, SHCMD("brightnessctl set 5%+")}, // increase brightness
  {0, XF86XK_MonBrightnessDown, spawn, SHCMD("brightnessctl set 5%-")}, // decrease brightness
  {0, XF86XK_AudioRaiseVolume, spawn,
   SHCMD("pulsemixer --change-volume +5")}, // increase volume
  {0, XF86XK_AudioLowerVolume, spawn,
   SHCMD("pulsemixer --change-volume -5")}, // decrease volume
  {0, XF86XK_AudioMute, spawn,
   SHCMD("pulsemixer --id sink-0 --toggle-mute")}, // mute audio
  /* ----------------------------- Other ----------------------------- */
  {Mod1Mask, XK_Tab, alttabstart, {0}},               // start alt-tab
  {MODKEY | ShiftMask, XK_c, killclient, {0}},        // kill focused window
  {MODKEY | ShiftMask, XK_q, quit, {0}},              // quit dwm
  {MODKEY, XK_t, setlayout, {.v = &layouts[0]}},      // set tiled layout
  {MODKEY, XK_f, setlayout, {.v = &layouts[1]}},      // set floating layout
  {MODKEY, XK_m, setlayout, {.v = &layouts[2]}},      // set monocle layout
  {MODKEY, XK_space, setlayout, {0}},                 // cycle through layouts
  {MODKEY | ShiftMask, XK_space, togglefloating, {0}}, // toggle floating state
  {MODKEY, XK_grave, togglescratch, {.ui = 0}},        // toggle scratchpad
  {MODKEY | ControlMask, XK_grave, setscratch, {.ui = 0}}, // move focused window to scratchpad
  {MODKEY | ShiftMask, XK_grave, removescratch, {.ui = 0}}, // remove focused window from scratchpad
  {MODKEY, XK_y, togglefullscreen, {0}},                   // toggle fullscreen
  {MODKEY, XK_0, view, {.ui = ~SPTAGMASK}},                // view all tags
  {MODKEY | ShiftMask, XK_0, tag, {.ui = ~SPTAGMASK}},     // tag all tags
  {MODKEY, XK_comma, focusmon, {.i = -1}},                 // focus previous monitor
  {MODKEY, XK_period, focusmon, {.i = +1}},                // focus next monitor
  {MODKEY | ShiftMask, XK_comma, tagmon, {.i = -1}},       // move window to previous monitor
  {MODKEY | ShiftMask, XK_period, tagmon, {.i = +1}},      // move window to next monitor
  /* ----------------------------- Tags ----------------------------- */
  TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2) TAGKEYS(XK_4, 3)
      TAGKEYS(XK_5, 4) TAGKEYS(XK_6, 5) TAGKEYS(XK_7, 6) TAGKEYS(XK_8, 7)
          TAGKEYS(XK_9, 8)};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
  /* click                event mask      button          function            argument */
  {ClkLtSymbol, 0, Button1, setlayout, {0}},    // change layout
  {ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]}}, // change layout
  {ClkWinTitle, 0, Button2, zoom, {0}},        // swap focused window with master
  {ClkStatusText, 0, Button2, spawn, {.v = termcmd}}, // spawn terminal
  {ClkClientWin, MODKEY, Button1, movemouse, {0}}, // move window
  {ClkClientWin, MODKEY, Button2, togglefloating, {0}}, // toggle floating
  {ClkClientWin, MODKEY, Button3, resizemouse, {0}}, // resize window
  {ClkClientWin, MODKEY | ShiftMask, Button1, dragmfact, {0}}, // drag master factor
  {ClkTagBar, 0, Button1, view, {0}},             // view tag
  {ClkTagBar, 0, Button3, toggleview, {0}},       // toggle tag view
  {ClkTagBar, MODKEY, Button1, tag, {0}},         // tag window
  {ClkTagBar, MODKEY, Button3, toggletag, {0}},   // toggle tag
  {ClkTabBar, 0, Button1, focuswin, {0}},         // focus window in tab bar
};