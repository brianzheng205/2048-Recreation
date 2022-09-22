draw_set_color(make_color_rgb(0, 104, 171));
draw_rectangle(0, 0, 736, 180, false);

draw_set_color(make_color_rgb(46, 49, 146));
draw_set_font(font_big);
draw_set_halign(fa_center);
// 2048 title
draw_text(x, y - 10, 2048);

draw_set_font(font_small);
// score label
draw_text(449, y - 40, "Score:");
draw_text(449, y, obj_game.total_score);