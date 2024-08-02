

if(instance_exists(obj_personaje)){
	var x_personaje = obj_personaje.x;
	var y_personaje = obj_personaje.y;
	var direccion = point_direction(x, y, x_personaje, y_personaje);
	
	var distancia = point_distance(x, y, x_personaje, y_personaje);
	
	if(cant_vida == 0){
		show_debug_message("El Hostil ha muerto. Juego pausado");
		instance_deactivate_object(obj_hostil);
	}
	
	if(distancia <= 300){
		move_contact_solid(direccion, velocidad);
	
		var target_x = x + lengthdir_x(33, direccion);
		var target_y = y + lengthdir_y(65, direccion);

		if(!move_contact_solid(direccion, 0.1)){
			show_debug_message("noo")
			
			var deslizamientos = [
				direccion + 90, //derecha
				direccion - 90, //izquierda
				direccion + 180, //arriba
				direccion, //abajo
				direccion + 45, //diagonal derecha-abajo
				direccion - 45, //diagonal izquierda-arriba
				direccion + 135, //diagonal derecha-arriba
				direccion - 135 //diagonal izquierda-abajo
			];
			
			var deslizar_efectivo = false;
			
			for(var i = 0; i <=	 array_length(deslizamientos); i++){
				var deslizar_direccion = deslizamientos[i];
				var deslizar_target_x = x + lengthdir_x(33, deslizar_direccion);
				var deslizar_target_y = y + lengthdir_y(65, deslizar_direccion);
				
				if (!collision_line(x, y, deslizar_target_x, deslizar_target_y, obj_personaje, true, false)) {
					direccion = deslizar_direccion;
					move_contact_solid(direccion, velocidad);
					deslizar_efectivo = true;
					break;
				}
			}
			
			if(!deslizar_efectivo){
				if (direccion < 0) {
				    direccion += 360;
				}

				if (direccion % 90 == 0) {
				    direccion += 15; // Ajusta el incremento si la dirección es un múltiplo de 90 grados
				} 
				else {
				    direccion += 5;  // Ajusta el incremento para otras direcciones
				}

				if (direccion >= 360) {
				    direccion -= 360;
				}
				if (direccion % 90 == 0) {
				    direccion -= 15; // Ajusta el incremento si la dirección es un múltiplo de 90 grados
				} 
				else {
				    direccion -= 5;  // Ajusta el incremento para otras direcciones
				}
			}
			
		}
		if(collision_line(x, y, target_x, target_y, obj_personaje, true, false)){
			
			tiempo_dano += 1;
		
			show_debug_message("personaje");
			
			var direccion_01 = point_direction(x, y, x + lengthdir_x(1, direccion), lengthdir_y(1, direccion));
		
			if(abs(direccion_01 - direccion) > 0){
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
			move_bounce_solid(false);
		}
	}
}
