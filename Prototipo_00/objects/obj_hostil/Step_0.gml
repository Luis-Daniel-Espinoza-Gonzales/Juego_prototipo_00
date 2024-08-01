

if(instance_exists(obj_personaje)){
	var x_personaje = obj_personaje.x;
	var y_personaje = obj_personaje.y;
	var direccion = point_direction(x, y, x_personaje, y_personaje);
	
	var x_anterior = x;
	var y_anterior = y;
	
	move_contact_solid(direccion, velocidad);
	
	if (x == x_anterior && y == y_anterior) {
    // El objeto está "quieto"
	
		if (instance_exists(obj_pared) && place_meeting(x, y, obj_pared)) {
            show_debug_message("Colisión con pared");
        }
        
        // Verificar si el objeto ha colisionado con el personaje
        if (place_meeting(x, y, obj_personaje)) {
            show_debug_message("Colisión con personaje");
        }
		
	}

}
