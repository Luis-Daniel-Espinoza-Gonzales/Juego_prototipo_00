draw_self();
draw_set_color(c_white);
draw_text(x, y, "vida: " + string(cant_vida));

// Calcula la distancia
if (instance_exists(obj_personaje)) {
    var x_personaje = obj_personaje.x;
    var y_personaje = obj_personaje.y;
    var distancia = point_distance(x, y, x_personaje, y_personaje);

    // Dibuja la distancia en la pantalla
    draw_text(x, y - 20, "Distancia: " + string(distancia));
}
