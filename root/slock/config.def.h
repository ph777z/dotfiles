/* user and group to drop privileges to */
static const char *user  = "nobody";
static const char *group = "nobody";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#11111b",     /* after initialization */
	[INPUT] =  "#bac2de",   /* during input */
	[FAILED] = "#f38ba8",   /* wrong password */
	[CAPS] = "#f9e2af",         /* CapsLock on */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* default message */
static const char * message = "Bem vindo <3";

/* text color */
static const char * text_color = "#11111b";

/* text size (must be a valid size) */
static const char * font_name = "-misc-jetbrains mono-bold-i-normal--0-0-0-0-m-0-ascii-0";
