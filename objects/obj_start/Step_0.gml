key_up = keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up);
key_down = keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down);
key_enter = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter);

if (select == 0) {
	if (key_down) {
		select = 1;
		audio_stop_sound(sound_switch);
		audio_play_sound(sound_switch, 1, false);
	}
	else {
		top_color = c_red;
		bot_color = make_color_rgb(46, 49, 146);
		if (key_enter) {
			audio_stop_sound(sound_switch);
			audio_play_sound(sound_select, 1, false);
			room = game_screen;
		}
	}
}

if (select == 1) {
	if (key_up) {
		select = 0;
		audio_stop_sound(sound_switch);
		audio_play_sound(sound_switch, 1, false);
	}
	else {
		bot_color = c_red;
		top_color = make_color_rgb(46, 49, 146);
	}
}