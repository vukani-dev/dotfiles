/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>
/* appearance */
static const unsigned int borderpx = 2; /* border pixel of windows */
static const int corner_radius = 0;
static const unsigned int snap = 32;   /* snap pixel */
static const int scalepreview = 3;     /* Tag preview scaling */
static const unsigned int gappih = 10; /* horiz inner gap between windows */
static const unsigned int gappiv = 10; /* vert inner gap between windows */
static const unsigned int gappoh =
    10; /* horiz outer gap between windows and screen edge */
static const unsigned int gappov =
    10; /* vert outer gap between windows and screen edge */
static const int smartgaps_fact =
    1; /* gap factor when there is only one client; 0 = no gaps, 3 = 3x outer
          gaps */
static const int showbar = 1; /* 0 means no bar */
static const int topbar = 1;  /* 0 means bottom bar */
/*  Display modes of the tab bar: never shown, always shown, shown only in  */
/*  monocle mode in the presence of several windows.                        */
/*  Modes after showtab_nmodes are disabled.                                */
enum showtab_modes {
  showtab_never,
  showtab_auto,
  showtab_nmodes,
  showtab_always
};
static const int showtab = showtab_auto; /* Default tab bar show mode */
static const int toptab = False;         /* False means bottom tab bar */
static const int bar_height =
    0;                /* 0 means derive from font, >= 1 explicit height */
#define ICONSIZE 20   /* icon size */
#define ICONSPACING 5 /* space between icon and title */
/* Status is to be shown on: -1 (all monitors), 0 (a specific monitor by index),
 * 'A' (active monitor) */
static const int statusmon = 'A';
static const unsigned int systrayspacing = 2; /* systray spacing */
static const int showsystray = 1;             /* 0 means no systray */

/* alt-tab configuration */
static const unsigned int tabmodkey =
    0x40; /* (Alt) when this key is held down the alt-tab functionality stays
             active. Must be the same modifier as used to run alttabstart */
static const unsigned int tabcyclekey =
    0x17; /* (Tab) when this key is hit the menu moves one position forward in
             client stack. Must be the same key as used to run alttabstart */
static const unsigned int tabposy =
    1; /* tab position on Y axis, 0 = top, 1 = center, 2 = bottom */
static const unsigned int tabposx =
    1; /* tab position on X axis, 0 = left, 1 = center, 2 = right */
static const unsigned int maxwtab = 600; /* tab menu width */
static const unsigned int maxhtab = 200; /* tab menu height */

/* Indicators: see patch/bar_indicators.h for options */
static int tagindicatortype = INDICATOR_TOP_LEFT_SQUARE;
static int tiledindicatortype = INDICATOR_NONE;
static int floatindicatortype = INDICATOR_TOP_LEFT_SQUARE;
static const char *fonts[] = {"FiraCode Nerd Font Mono:size=14", "Noto Color Emoji:size=14"};
static const char dmenufont[] = "FiraCode Nerd Font Mono:size=14";

// original blue: 005577
// mountain blue: 475b96
// doom black: 282c34
// bright blue: 51afef
// wakeup orange:
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
    /*                       fg                bg                border float */
    [SchemeNorm] = {normfgcolor, normbgcolor, normbordercolor, normfloatcolor},
    [SchemeSel] = {selfgcolor, selbgcolor, selbordercolor, selfloatcolor},
    [SchemeTitleNorm] = {titlenormfgcolor, titlenormbgcolor,
                         titlenormbordercolor, titlenormfloatcolor},
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

static const char *const autostart[] = {
    NULL, NULL, NULL /* terminate */
};

const char *spcmd1[] = {"st", "-n", "spterm", "-g", "120x34", NULL};
static Sp scratchpads[] = {
    /* name          cmd  */
    {"spterm", spcmd1},
};

/* Tags
 * In a traditional dwm the number of tags in use can be changed simply by
 * changing the number of strings in the tags array. This build does things a
 * bit different which has some added benefits. If you need to change the number
 * of tags here then change the NUMTAGS macro in dwm.c.
 *
 * Examples:
 *
 *  1) static char *tagicons[][NUMTAGS*2] = {
 *         [DEFAULT_TAGS] = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "A",
 * "B", "C", "D", "E", "F", "G", "H", "I" },
 *     }
 *
 *  2) static char *tagicons[][1] = {
 *         [DEFAULT_TAGS] = { "•" },
 *     }
 *
 * The first example would result in the tags on the first monitor to be 1
 * through 9, while the tags for the second monitor would be named A through I.
 * A third monitor would start again at 1 through 9 while the tags on a fourth
 * monitor would also be named A through I. Note the tags count of NUMTAGS*2 in
 * the array initialiser which defines how many tag text / icon exists in the
 * array. This can be changed to *3 to add separate icons for a third monitor.
 *
 * For the second example each tag would be represented as a bullet point. Both
 * cases work the same from a technical standpoint - the icon index is derived
 * from the tag index and the monitor index. If the icon index is is greater
 * than the number of tag icons then it will wrap around until it an icon
 * matches. Similarly if there are two tag icons then it would alternate between
 * them. This works seamlessly with alternative tags and alttagsdecoration
 * patches.
 */
static char *tagicons[][NUMTAGS] = {
    [DEFAULT_TAGS] = {"I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"},
    [ALTERNATIVE_TAGS] = {"A", "B", "C", "D", "E", "F", "G", "H", "I"},
    [ALT_TAGS_DECORATION] = {"<1>", "<2>", "<3>", "<4>", "<5>", "<6>", "<7>",
                             "<8>", "<9>"},
};

/* There are two options when it comes to per-client rules:
 *  - a typical struct table or
 *  - using the RULE macro
 *
 * A traditional struct table looks like this:
 *    // class      instance  title  wintype  tags mask  isfloating  monitor
 *    { "Gimp",     NULL,     NULL,  NULL,    1 << 4,    0,          -1 },
 *    { "Firefox",  NULL,     NULL,  NULL,    1 << 7,    0,          -1 },
 *
 * The RULE macro has the default values set for each field allowing you to only
 * specify the values that are relevant for your rule, e.g.
 *
 *    RULE(.class = "Gimp", .tags = 1 << 4)
 *    RULE(.class = "Firefox", .tags = 1 << 7)
 *
 * Refer to the Rule struct definition for the list of available fields
 * depending on the patches you enable.
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

/* Bar rules allow you to configure what is shown where on the bar, as well as
 * introducing your own bar modules.
 *
 *    monitor:
 *      -1  show on all monitors
 *       0  show on monitor 0
 *      'A' show on active monitor (i.e. focused / selected) (or just -1 for
 * active?) bar - bar index, 0 is default, 1 is extrabar alignment - how the
 * module is aligned compared to other modules widthfunc, drawfunc, clickfunc -
 * providing bar module width, draw and click functions name - does nothing,
 * intended for visual clue and for logging / debugging
 */
static const BarRule barrules[] = {
    /* monitor   bar    alignment         widthfunc                 drawfunc
       clickfunc                hoverfunc                name */
    {-1, 0, BAR_ALIGN_LEFT, width_tags, draw_tags, click_tags, hover_tags,
     "tags"},
    {0, 0, BAR_ALIGN_RIGHT, width_systray, draw_systray, click_systray, NULL,
     "systray"},
    {statusmon, 0, BAR_ALIGN_RIGHT, width_status2d, draw_status2d,
     click_status2d, NULL, "status2d"},
    {-1, 0, BAR_ALIGN_NONE, width_wintitle, draw_wintitle, click_wintitle, NULL,
     "wintitle"},
};

/* layout(s) */
static const float mfact = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;    /* number of clients in master area */
static const int resizehints =
    0; /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen =
    1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
    /* symbol     arrange function */
    {"(@)", spiral},
    {"><>", NULL}, /* no layout function means floating behavior */
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
static char dmenumon[2] =
    "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = {"/home/vukani/scripts/launcher", NULL}; // required by dwm.c
static const char *roficmd[] = {"/home/vukani/scripts/launcher", NULL};
static const char *termcmd[] = {"ghostty", NULL};
static const char *browsercmd[] = {"librewolf", NULL};
static const char *discordcmd[] = {"discord", NULL};
static const char *emailcmd[] = {"thunderbird", NULL};
static const char *keepasscmd[] = {"bitwarden", NULL};
static const char *logseqcmd[] = {"logseq", NULL};


/* HOTKEYS */
static const Key keys[] = {
    /* modifier                     key            function argument */
    {MODKEY, XK_r, spawn, {.v = roficmd}},
    {MODKEY | ShiftMask, XK_Return, spawn, {.v = termcmd}},
    {MODKEY, XK_b, togglebar, {0}},
    // { MODKEY|ShiftMask,          XK_b,          toggletopbar,           {0}
    // },
    {MODKEY | ControlMask, XK_b, tabmode, {-1}},
    // { MODKEY,                       XK_j,          focusstack, {.i = +1 } },
    // { MODKEY,                       XK_k,          focusstack, {.i = -1 } },
    {MODKEY, XK_h, focusdir, {.i = 0}},             // left
    {MODKEY, XK_l, focusdir, {.i = 1}},             // right
    {MODKEY, XK_k, focusdir, {.i = 2}},             // up
    {MODKEY, XK_j, focusdir, {.i = 3}},             // down
    {MODKEY | ShiftMask, XK_h, placedir, {.i = 0}}, // left
    {MODKEY | ShiftMask, XK_l, placedir, {.i = 1}}, // right
    {MODKEY | ShiftMask, XK_k, placedir, {.i = 2}}, // up
    {MODKEY | ShiftMask, XK_j, placedir, {.i = 3}}, // down
    // { MODKEY,                       XK_i,          incnmaster, {.i = +1 } },
    // { MODKEY,                       XK_d,          incnmaster, {.i = -1 } },
    {MODKEY | ControlMask, XK_h, setmfact, {.f = -0.05}},
    {MODKEY | ControlMask, XK_l, setmfact, {.f = +0.05}},
    {MODKEY, XK_Return, zoom, {0}},
    {MODKEY | Mod4Mask, XK_u, incrgaps, {.i = +1}},
    {MODKEY | Mod4Mask | ShiftMask, XK_u, incrgaps, {.i = -1}},
    {MODKEY | Mod4Mask, XK_i, incrigaps, {.i = +1}},
    {MODKEY | Mod4Mask | ShiftMask, XK_i, incrigaps, {.i = -1}},
    {MODKEY | Mod4Mask, XK_o, incrogaps, {.i = +1}},
    {MODKEY | Mod4Mask | ShiftMask, XK_o, incrogaps, {.i = -1}},
    {MODKEY | Mod4Mask, XK_6, incrihgaps, {.i = +1}},
    {MODKEY | Mod4Mask | ShiftMask, XK_6, incrihgaps, {.i = -1}},
    {MODKEY | Mod4Mask, XK_7, incrivgaps, {.i = +1}},
    {MODKEY | Mod4Mask | ShiftMask, XK_7, incrivgaps, {.i = -1}},
    {MODKEY | Mod4Mask, XK_8, incrohgaps, {.i = +1}},
    {MODKEY | Mod4Mask | ShiftMask, XK_8, incrohgaps, {.i = -1}},
    {MODKEY | Mod4Mask, XK_9, incrovgaps, {.i = +1}},
    {MODKEY | Mod4Mask | ShiftMask, XK_9, incrovgaps, {.i = -1}},
    {MODKEY | Mod4Mask, XK_0, togglegaps, {0}},
    {MODKEY | Mod4Mask | ShiftMask, XK_0, defaultgaps, {0}},

    // APPLICATIONS
    {MODKEY, XK_w, spawn, {.v = browsercmd}},
    {MODKEY, XK_d, spawn, {.v = discordcmd}},
    {MODKEY, XK_e, spawn, {.v = emailcmd}},
    {MODKEY, XK_p, spawn, {.v = keepasscmd}},
    {MODKEY, XK_n, spawn, {.v = logseqcmd}},

    // UTILITIES
    {MODKEY | ShiftMask, XK_b, spawn, SHCMD("st -e bluetuith")},
    {MODKEY, XK_y, spawn, SHCMD("st -e yazi")},
    {MODKEY, XK_i, spawn, SHCMD("st -e nmtui")},
    {MODKEY, XK_q, spawn, SHCMD("st -e gotop")},
    {MODKEY, XK_c, spawn, SHCMD("st -e /home/vukani/scripts/toggle-syncthing.sh")},
    {MODKEY| ShiftMask, XK_s, spawn, SHCMD("/home/vukani/scripts/screenshot.sh")},
    {MODKEY | ShiftMask, XK_m, spawn,
     SHCMD("/home/vukani/scripts/toggle-monitors.sh")},
    {MODKEY | ShiftMask, XK_x, spawn, SHCMD("st -e sudo slock")},

    // GENERAL SHORTCUTS
    // {MODKEY | ShiftMask, XK_d, spawn, SHCMD("st cd /home/vukani/.dotfiles && nvim")},

    // SOUND
    {MODKEY, XK_s, spawn, SHCMD("st -e pulsemixer")},
    {0, XF86XK_MonBrightnessUp, spawn, SHCMD("brightnessctl set 5%+")},
    {0, XF86XK_MonBrightnessDown, spawn, SHCMD("brightnessctl set 5%-")},
    {0, XF86XK_AudioRaiseVolume, spawn, SHCMD("pulsemixer --change-volume +5")},
    {0, XF86XK_AudioLowerVolume, spawn, SHCMD("pulsemixer --change-volume -5")},
    {0, XF86XK_AudioMute, spawn, SHCMD("pulsemixer --id sink-0 --toggle-mute")},

    {Mod1Mask, XK_Tab, alttabstart, {0}},
    {MODKEY | ShiftMask, XK_c, killclient, {0}},
    {MODKEY | ShiftMask, XK_q, quit, {0}},
    {MODKEY, XK_t, setlayout, {.v = &layouts[0]}},
    {MODKEY, XK_f, setlayout, {.v = &layouts[1]}},
    {MODKEY, XK_m, setlayout, {.v = &layouts[2]}},
    {MODKEY, XK_space, setlayout, {0}},
    {MODKEY | ShiftMask, XK_space, togglefloating, {0}},
    {MODKEY, XK_grave, togglescratch, {.ui = 0}},
    {MODKEY | ControlMask, XK_grave, setscratch, {.ui = 0}},
    {MODKEY | ShiftMask, XK_grave, removescratch, {.ui = 0}},
    // fullscreen moved - was conflicting with yazi on XK_y
    {MODKEY | ShiftMask, XK_f, togglefullscreen, {0}},
    {MODKEY, XK_0, view, {.ui = ~SPTAGMASK}},
    {MODKEY | ShiftMask, XK_0, tag, {.ui = ~SPTAGMASK}},
    {MODKEY, XK_comma, focusmon, {.i = -1}},
    {MODKEY, XK_period, focusmon, {.i = +1}},
    {MODKEY | ShiftMask, XK_comma, tagmon, {.i = -1}},
    {MODKEY | ShiftMask, XK_period, tagmon, {.i = +1}},
    TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2) TAGKEYS(XK_4, 3)
        TAGKEYS(XK_5, 4) TAGKEYS(XK_6, 5) TAGKEYS(XK_7, 6) TAGKEYS(XK_8, 7)
            TAGKEYS(XK_9, 8)};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
 * ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
    /* click                event mask           button          function
       argument */
    {ClkLtSymbol, 0, Button1, setlayout, {0}},
    {ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]}},
    {ClkWinTitle, 0, Button2, zoom, {0}},
    {ClkStatusText, 0, Button2, spawn, {.v = termcmd}},
    {ClkClientWin, MODKEY, Button1, movemouse, {0}},
    {ClkClientWin, MODKEY, Button2, togglefloating, {0}},
    {ClkClientWin, MODKEY, Button3, resizemouse, {0}},
    {ClkClientWin, MODKEY | ShiftMask, Button1, dragmfact, {0}},
    {ClkTagBar, 0, Button1, view, {0}},
    {ClkTagBar, 0, Button3, toggleview, {0}},
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
    {ClkTabBar, 0, Button1, focuswin, {0}},
};
