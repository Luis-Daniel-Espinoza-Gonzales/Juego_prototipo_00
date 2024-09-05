right = keyboard_check(ord("D")) || keyboard_check(vk_right);
left = keyboard_check(ord("A")) || keyboard_check(vk_left);
up = keyboard_check(ord("W")) || keyboard_check(vk_up);
down = keyboard_check(ord("S")) || keyboard_check(vk_down);

velocidad = 0.5;

horizontal = right - left;
vertical = down - up;

if (horizontal != 0 || vertical != 0){
	dir = point_direction(0, 0, horizontal, vertical);
	for(angulo = 0; angulo < 60; angulo += 10){
		for(multiplicador = -1; multiplicador <= 1; multiplicador += 2){
			new_dir = dir + angulo * multiplicador;
			x_to = x + lengthdir_x(velocidad, new_dir);
			y_to = y + lengthdir_y(velocidad, new_dir);	
			
			if (place_free(x_to, y_to)){
				x = x_to;
				y = y_to;
			}
		}
	}
}

if(cant_vida <= 0){
	if(!instance_exists(obj_pausa)){
		instance_create_layer(x, y, "instances", obj_pausa);
		show_debug_message("El personaje ha muerto. Juego pausado");
		global.pausa = true;
		
		instance_deactivate_object(obj_hostil);
		instance_deactivate_object(obj_spawn);
	}
}

var target_x = x + lengthdir_x(1, new_dir);
var target_y = y + lengthdir_y(1, new_dir);
//comprobar si hay colision
var obj_collision = instance_place(target_x, target_y, obj_hostil);
var obj_collision_01 = instance_place(target_x, target_y, obj_lanzador);
if(obj_collision != noone){

	if(collision_line(x, y, obj_collision.x, obj_collision.y, obj_hostil, true, false)){
		tiempo_dano += 1;
	
		if(tiempo_dano >= intervalo_dano){
			obj_collision.cant_vida -= 1;
			show_debug_message("El hostil ha recibido 1 punto de daño.");
		
			tiempo_dano = 0;
		}
	}
	else{
			tiempo_dano = 0;
	}
}
if(obj_collision_01 != noone){
	if(collision_line(x, y, obj_collision_01.x, obj_collision_01.y, obj_lanzador, true, false)){
		tiempo_dano += 1;
	
		if(tiempo_dano >= intervalo_dano){
			obj_collision_01.cant_vida -= 1;
			show_debug_message("El lanzador ha recibido 1 punto de daño.");
		
			tiempo_dano = 0;
		}
	}
	else{
			tiempo_dano = 0;
	
	}
}