

if(instance_exists(obj_personaje)){
	var x_personaje = obj_personaje.x;
	var y_personaje = obj_personaje.y;
	var direccion = point_direction(x, y, x_personaje, y_personaje);
	
	var distancia = point_distance(x, y, x_personaje, y_personaje);
	
	if(cant_vida = 0){
		show_debug_message("El Hostil ha muerto. Juego pausado");
		instance_deactivate_object(obj_hostil);
	}
	
	if(distancia <= 300){
		move_contact_solid(direccion, velocidad);
	
		var target_x = x + lengthdir_x(64, direccion);
		var target_y = y + lengthdir_y(65, direccion);

		if(collision_line(x, y, target_x, target_y, obj_personaje, true, false)){
		
			tiempo_dano += 1;
		
			show_debug_message("personaje");
			direccion =	point_direction(x -1, y -1, x, y);
			var direccion_01 = point_direction(x, y, x + lengthdir_x(1, direccion), lengthdir_y(1, direccion));
		
			if(abs(direccion_01 - direccion) > 75){
				show_debug_message("rozando con personaje");
				if(tiempo_dano >= intervalo_dano){
					obj_personaje.cant_vida -= 1;
					show_debug_message("El personaje ha recibido 1 punto de daño.");
		
					tiempo_dano = 0;
				}	
			}
		}
		else{
			tiempo_dano = 0;
		}
	}
}
