var count = instance_number(obj_hostil);

if(hostiles_generado < max_hostiles){
	if(count = 2){

		show_debug_message("hay 2 hostiles");

	}
	else{

		sec +=	0.03;
	
		if(sec >= time){
			sec = 0;
			instance_create_layer(x, y, "Instances", obj_hostil);
			show_debug_message("se ha creado un nuevo hostil");
			hostiles_generado += 1;
		}
	
	}
}
else{
	
}
