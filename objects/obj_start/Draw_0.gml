draw_set_color(make_color_rgb(0, 104, 171));
draw_rectangle(100, 200, 620, 740, false);

draw_set_color(make_color_rgb(46, 49, 146));
draw_set_font(font_big);
draw_set_halign(fa_center);
draw_text(360, 270, "2048");

draw_set_font(font_small);
draw_set_color(top_color);
draw_text(360, 540, "Play");
draw_set_color(bot_color);
draw_text(360, 600, "How To Play");