var count = instance_number(obj_hostil);

if(hostiles_generado < max_hostiles && hostiles_room < max_hostiles_room){
	if(count == 2){

		show_debug_message("hay 2 hostiles");

	}
	else{

		sec +=	0.03;
	
		if(sec >= time){
			sec = 0;
				
			var x_pos = x;
			var y_pos = y;
				
			instance_create_layer(x_pos, y_pos, "Instances", obj_hostil);
			show_debug_message("se ha creado un nuevo hostil");
			hostiles_generado += 1;
			hostiles_room += 1;
			
		}
	
	}
}
else{
	
}
