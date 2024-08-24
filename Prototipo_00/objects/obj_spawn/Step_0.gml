var count = instance_number(obj_hostil);

if(hostiles_generado < max_hostiles && hostiles_room < max_hostiles_room){
	if(count == 2){

		show_debug_message("hay 2 hostiles");

	}
	else{

		sec +=	0.03;
	
		if(sec >= time){
			sec = 0;
			
			var posicion_valida = false;
            var intentos = 0;
            var max_intentos = 10;
			
			var area_width = 64;  // Ancho del área de colisión
            var area_height = 128; // Alto del área de colisión

            while (!posicion_valida && intentos < max_intentos) {
                var x_pos = random(room_width);
                var y_pos = random(room_height);

                if (!collision_rectangle(x_pos - area_width / 2, y_pos - area_height / 2, x_pos + area_width / 2, y_pos + area_height / 2, obj_pared, false, false)) {
                    posicion_valida = true;
                } else {
                    intentos += 1;
                }
            }

            if (posicion_valida) {
                instance_create_layer(x_pos, y_pos, "Instances", obj_hostil);
                show_debug_message("se ha creado un nuevo hostil");
                hostiles_generado += 1;
                hostiles_room += 1;
            } else {
                show_debug_message("no se pudo encontrar una posición válida");
            }
		}
	
	}
}

