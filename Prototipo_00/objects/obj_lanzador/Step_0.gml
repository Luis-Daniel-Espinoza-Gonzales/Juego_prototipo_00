

if(instance_exists(obj_personaje)){
	var x_personaje = obj_personaje.x;
	var y_personaje = obj_personaje.y;
	var direccion = point_direction(x, y, x_personaje, y_personaje);
	
	var distancia = point_distance(x, y, x_personaje, y_personaje);
	
	if(cant_vida == 0){
		show_debug_message("El Hostil ha muerto. Juego pausado");
		instance_destroy();
	}
	
	if(distancia <= 300){
		
		var deslizar = true;
		var deslizamientos = [0, 90, 180, 270];
		var mejor_direccion = direccion;
		var mejor_distancia = distancia;
		
		var intento_x = x + lengthdir_x(velocidad, direccion);
        var intento_y = y + lengthdir_y(velocidad, direccion);
		
		if (place_meeting(intento_x, intento_y, obj_pared)) {
            deslizar = true;
			
			while(deslizar){
				
				deslizar = false;
			
				for(var i = 0; i < array_length(deslizamientos); i++){
					var dir_actual = deslizamientos[i];
					var nuevo_x_deslizar = x + lengthdir_x(velocidad, dir_actual);
					var nuevo_y_deslizar = y + lengthdir_y(velocidad, dir_actual);
					
					if(!place_meeting(nuevo_x_deslizar, nuevo_y_deslizar, obj_pared) && !place_meeting(nuevo_x_deslizar, nuevo_y_deslizar, obj_hostil)){
						var distancia_deslizar = point_distance(nuevo_x_deslizar, nuevo_y_deslizar, x_personaje, y_personaje);
                        if (distancia_deslizar < mejor_distancia) {
                            mejor_direccion = dir_actual;
                            mejor_distancia = distancia_deslizar;
                            deslizar = true;
                        }
					}
				}
				direccion = mejor_direccion;
                intento_x = x + lengthdir_x(velocidad, direccion);
                intento_y = y + lengthdir_y(velocidad, direccion);
			}
		}
		var nuevo_x = x + lengthdir_x(velocidad, direccion);
        var nuevo_y = y + lengthdir_y(velocidad, direccion);
		
		if (!place_meeting(nuevo_x, nuevo_y, obj_pared)) {
            x = nuevo_x;
            y = nuevo_y;
        } else {
            // Si no se puede mover en la dirección deseada, intentar deslizarse en la dirección alternativa
            move_contact_solid(direccion, velocidad);
        }
		
		if (place_meeting(x, y, obj_hostil)) {
            var desplazado = false;
            // Intentar mover el `obj_hostil` para evitar superposición
            for (var i = 0; i < 4; i++) {
                var dir_ajuste = i * 90;
                var x_ajustado = x + lengthdir_x(5, dir_ajuste);
                var y_ajustado = y + lengthdir_y(5, dir_ajuste);
                
                if (!place_meeting(x_ajustado, y_ajustado, obj_pared) && !place_meeting(x_ajustado, y_ajustado, obj_hostil)) {
                    x = x_ajustado;
                    y = y_ajustado;
                    desplazado = true;
                    break;
                }
            }
            // Si no se pudo ajustar, mover hacia atrás
            if (!desplazado) {
                x -= lengthdir_x(velocidad, direccion);
                y -= lengthdir_y(velocidad, direccion);
            }
        }
		
		if (place_meeting(x, y, obj_lanzador)) {
            var desplazado = false;
            // Intentar mover el `obj_hostil` para evitar superposición
            for (var i = 0; i < 4; i++) {
                var dir_ajuste = i * 90;
                var x_ajustado = x + lengthdir_x(5, dir_ajuste);
                var y_ajustado = y + lengthdir_y(5, dir_ajuste);
                
                if (!place_meeting(x_ajustado, y_ajustado, obj_pared) && !place_meeting(x_ajustado, y_ajustado, obj_lanzador)) {
                    x = x_ajustado;
                    y = y_ajustado;
                    desplazado = true;
                    break;
                }
            }
            // Si no se pudo ajustar, mover hacia atrás
            if (!desplazado) {
                x -= lengthdir_x(velocidad, direccion);
                y -= lengthdir_y(velocidad, direccion);
            }
        }
		
		if (place_meeting(x, y, obj_personaje)) {
            var corregido_x = x - lengthdir_x(velocidad, direccion);
            var corregido_y = y - lengthdir_y(velocidad, direccion);
            if (!place_meeting(corregido_x, corregido_y, obj_pared)) {
                x = corregido_x;
                y = corregido_y;
            }
        }

		
		var target_x = x + lengthdir_x(65, direccion);
		var target_y = y + lengthdir_y(129, direccion);

		
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
	}
	if(distancia > 300 && distancia < 350){
			
		var direccion_alejamiento = point_direction(x, y, x_personaje, y_personaje);
		var nuevo_x = x + lengthdir_x(-velocidad, direccion_alejamiento);
		var nuevo_y = y + lengthdir_y(-velocidad, direccion_alejamiento);
		
		if (place_meeting(x, y, obj_lanzador)) {
            var desplazado = false;
            // Intentar mover el `obj_hostil` para evitar superposición
            for (var i = 0; i < 4; i++) {
                var dir_ajuste = i * 90;
                var x_ajustado = x + lengthdir_x(5, dir_ajuste);
                var y_ajustado = y + lengthdir_y(5, dir_ajuste);
                
                if (!place_meeting(x_ajustado, y_ajustado, obj_pared) && !place_meeting(x_ajustado, y_ajustado, obj_lanzador)) {
                    x = x_ajustado;
                    y = y_ajustado;
                    desplazado = true;
                    break;
                }
            }
            // Si no se pudo ajustar, mover hacia atrás
            if (!desplazado) {
                x -= lengthdir_x(velocidad, direccion);
                y -= lengthdir_y(velocidad, direccion);
            }
        }
    
		if (!place_meeting(nuevo_x, nuevo_y, obj_pared)) {
		    x = nuevo_x;
		    y = nuevo_y;
		}
			
		tiempo_dano += 1;
		
		show_debug_message("disparando a personaje");
		if(tiempo_dano >= intervalo_dano_proyectil){
			//crear proyectil
			var proyectil_00 = instance_create_layer(x, y, "proyectiles", obj_proyectil);
		
			//establecer direccion hacia el jugador
			var dir_proyectil = point_direction(x, y, x_personaje, y_personaje);
			proyectil_00.direction = dir_proyectil;
		
			tiempo_dano = 0;
		}
			
	}
	if(distancia > 350 && distancia < 400){	
		
		if (place_meeting(x, y, obj_lanzador)) {
            var desplazado = false;
            // Intentar mover el `obj_hostil` para evitar superposición
            for (var i = 0; i < 4; i++) {
                var dir_ajuste = i * 90;
                var x_ajustado = x + lengthdir_x(5, dir_ajuste);
                var y_ajustado = y + lengthdir_y(5, dir_ajuste);
                
                if (!place_meeting(x_ajustado, y_ajustado, obj_pared) && !place_meeting(x_ajustado, y_ajustado, obj_lanzador)) {
                    x = x_ajustado;
                    y = y_ajustado;
                    desplazado = true;
                    break;
                }
            }
            // Si no se pudo ajustar, mover hacia atrás
            if (!desplazado) {
                x -= lengthdir_x(velocidad, direccion);
                y -= lengthdir_y(velocidad, direccion);
            }
        }
		
		show_debug_message("disparando a personaje");
			
		tiempo_dano += 1;
		if(tiempo_dano >= intervalo_dano_proyectil){
			//crear proyectil
			var proyectil_00 = instance_create_layer(x, y, "proyectiles", obj_proyectil);
		
			//establecer direccion hacia el jugador
			var dir_proyectil = point_direction(x, y, x_personaje, y_personaje);
			proyectil_00.direction = dir_proyectil;
		
			tiempo_dano = 0;
		}	
	}
	if(distancia > 400 && distancia < 450){
		
		var deslizar = true;
		var deslizamientos = [0, 90, 180, 270];
		var mejor_direccion = direccion;
		var mejor_distancia = distancia;
		
		var intento_x = x + lengthdir_x(velocidad, direccion);
        var intento_y = y + lengthdir_y(velocidad, direccion);
		
		if (place_meeting(intento_x, intento_y, obj_pared)) {
            deslizar = true;
			
			while(deslizar){
				
				deslizar = false;
			
				for(var i = 0; i < array_length(deslizamientos); i++){
					var dir_actual = deslizamientos[i];
					var nuevo_x_deslizar = x + lengthdir_x(velocidad, dir_actual);
					var nuevo_y_deslizar = y + lengthdir_y(velocidad, dir_actual);
					
					if(!place_meeting(nuevo_x_deslizar, nuevo_y_deslizar, obj_pared) && !place_meeting(nuevo_x_deslizar, nuevo_y_deslizar, obj_hostil)){
						var distancia_deslizar = point_distance(nuevo_x_deslizar, nuevo_y_deslizar, x_personaje, y_personaje);
                        if (distancia_deslizar < mejor_distancia) {
                            mejor_direccion = dir_actual;
                            mejor_distancia = distancia_deslizar;
                            deslizar = true;
                        }
					}
				}
				direccion = mejor_direccion;
                intento_x = x + lengthdir_x(velocidad, direccion);
                intento_y = y + lengthdir_y(velocidad, direccion);
			}
		}
		var nuevo_x = x + lengthdir_x(velocidad, direccion);
        var nuevo_y = y + lengthdir_y(velocidad, direccion);
		
		if (!place_meeting(nuevo_x, nuevo_y, obj_pared)) {
            x = nuevo_x;
            y = nuevo_y;
        } else {
            // Si no se puede mover en la dirección deseada, intentar deslizarse en la dirección alternativa
            move_contact_solid(direccion, velocidad);
        }
		
		if (place_meeting(x, y, obj_hostil)) {
            var desplazado = false;
            // Intentar mover el `obj_hostil` para evitar superposición
            for (var i = 0; i < 4; i++) {
                var dir_ajuste = i * 90;
                var x_ajustado = x + lengthdir_x(5, dir_ajuste);
                var y_ajustado = y + lengthdir_y(5, dir_ajuste);
                
                if (!place_meeting(x_ajustado, y_ajustado, obj_pared) && !place_meeting(x_ajustado, y_ajustado, obj_hostil)) {
                    x = x_ajustado;
                    y = y_ajustado;
                    desplazado = true;
                    break;
                }
            }
            // Si no se pudo ajustar, mover hacia atrás
            if (!desplazado) {
                x -= lengthdir_x(velocidad, direccion);
                y -= lengthdir_y(velocidad, direccion);
            }
        }
		
		if (place_meeting(x, y, obj_lanzador)) {
            var desplazado = false;
            // Intentar mover el `obj_hostil` para evitar superposición
            for (var i = 0; i < 4; i++) {
                var dir_ajuste = i * 90;
                var x_ajustado = x + lengthdir_x(5, dir_ajuste);
                var y_ajustado = y + lengthdir_y(5, dir_ajuste);
                
                if (!place_meeting(x_ajustado, y_ajustado, obj_pared) && !place_meeting(x_ajustado, y_ajustado, obj_lanzador)) {
                    x = x_ajustado;
                    y = y_ajustado;
                    desplazado = true;
                    break;
                }
            }
            // Si no se pudo ajustar, mover hacia atrás
            if (!desplazado) {
                x -= lengthdir_x(velocidad, direccion);
                y -= lengthdir_y(velocidad, direccion);
            }
        }
		
		if (place_meeting(x, y, obj_personaje)) {
            var corregido_x = x - lengthdir_x(velocidad, direccion);
            var corregido_y = y - lengthdir_y(velocidad, direccion);
            if (!place_meeting(corregido_x, corregido_y, obj_pared)) {
                x = corregido_x;
                y = corregido_y;
            }
        }

		
		var target_x = x + lengthdir_x(65, direccion);
		var target_y = y + lengthdir_y(129, direccion);
	}
}