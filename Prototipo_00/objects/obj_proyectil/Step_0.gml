x += lengthdir_x(velocidad, direction);
y += lengthdir_y(velocidad, direction);

// Detectar colisión con el personaje
if (place_meeting(x, y, obj_personaje)) {
    obj_personaje.cant_vida -= 2; // O el daño que quieras hacer
    instance_destroy(); // Destruir el proyectil al impactar
}

// Detectar colisión con las paredes
if (place_meeting(x, y, obj_pared)) {
    instance_destroy(); // Destruir el proyectil al colisionar con obj_pared
}