#undef	FOG_SCROLL_TIME
#define FOG_SCROLL_TIME 60000 //30000

#undef	THINFOG_SCROLL_TIME
#define THINFOG_SCROLL_TIME 100000 //50000

itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			FULLSCREEN_WIDE
	background		"deathrun"
	visible			1
	decoration
}

itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			-107 200 64 64
	exp				rect X((-107) - ((float(milliseconds() % FOG_SCROLL_TIME) / FOG_SCROLL_TIME) * (854)))
	background		"killiconheadshot"
	visible			1
	decoration
}
itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			-107 300 64 64
	exp				rect X((-961) + ((float(milliseconds() % THINFOG_SCROLL_TIME) / THINFOG_SCROLL_TIME) * (854)))
	background		"killiconmelee"
	visible			1
	decoration
}

itemDef
{
	style			WINDOW_STYLE_SHADER
	rect			-107 400 64 64
	exp				rect X((-107) - ((float(milliseconds() % FOG_SCROLL_TIME) / FOG_SCROLL_TIME) * (854)))
	background		"killiconsuicide"
	visible			1
	decoration
}


