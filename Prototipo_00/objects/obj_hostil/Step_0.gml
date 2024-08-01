

if(instance_exists(obj_personaje)){
	var x_personaje = obj_personaje.x;
	var y_personaje = obj_personaje.y;
	var direccion = point_direction(x, y, x_personaje, y_personaje);
	
	var x_anterior = x;
	var y_anterior = y;
	move_contact_solid(direccion, velocidad);
	
	var target_x = x + lengthdir_x(32, direccion);
	var target_y = y + lengthdir_y(64, direccion);

	if(collision_line(x, y, target_x, target_y, obj_personaje, true, false)){
		show_debug_message("personaje");
		direccion =	point_direction(x -1, y -1, x, y);
		var direccion_01 = point_direction(x, y, x + lengthdir_x(1, direccion), lengthdir_y(1, direccion));
		
		if(abs(direccion_01 - direccion) > 45){
			show_debug_message("rozando con personaje");
		}
	}
	
}
