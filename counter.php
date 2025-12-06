<?php
$archivo = "counter.txt";

// Si no existe, lo creamos en 0
if (!file_exists($archivo)) {
    file_put_contents($archivo, "0");
}

// Leemos el número actual
$visitas = (int)file_get_contents($archivo);

// Sumamos 1
$visitas++;

// Guardamos el nuevo número
file_put_contents($archivo, $visitas);

// Devolvemos SOLO el número (sin HTML extra)
echo $visitas;
?>
