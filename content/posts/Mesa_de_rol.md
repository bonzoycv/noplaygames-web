---
title: "Mesa de rol: la app que empezó como libreta de notas"
date: 2026-10-19
draft: false
description: "Cómo pasó de ser una libreta de notas para una campaña de D&D a una mesa de juego completa, abierta y pensada para sumar más sistemas."
tags: ["rol", "dnd", "open-source", "nodejs", "docker"]
categories: ["rol"]
---

Esta app empezó como algo muy simple: un sitio donde guardar las notas de mi campaña de D&D para que el máster y los jugadores pudieran leerlas. Hoy es una mesa de juego completa, con chat, dados, combate, mapas, fichas de personaje y reglas en español. En este post cuento cómo llegamos hasta aquí, qué hace hoy y hacia dónde quiero ir.

## Cómo empezó

La idea original era sencilla:

- Un lugar común para las notas de la campaña.
- Una cuenta para el máster y una para cada jugador.
- Notas privadas, que solo ve quien las escribe, y notas compartidas con toda la mesa.
- Que dos personas editando a la vez no se pisen los cambios.
- Que sea seguro y fácil de mantener.

Antes existía un prototipo de escritorio con Electron y un lanzador de dados suelto. La app nueva los reemplazó y fue creciendo a partir de ahí. Por el camino cambió de nombre, de "Notas D&D" a "Mesa de rol", porque ya no es solo de D&D. También cambió de dominio, pensando en sumar otros juegos.

## Cómo está hecha

Por dentro es una aplicación web bastante sencilla:

- **Backend:** Node.js con Hono.
- **Base de datos:** SQLite. Es un solo archivo, fácil de copiar.
- **Frontend:** React con Vite.
- **Despliegue:** Docker en mi homelab, detrás de Caddy y de un túnel de Cloudflare.

El camino que sigue una petición se ve así:

```text
Internet
   │
   ▼
Cloudflare Tunnel  ──►  Caddy  ──►  dnd-notes (Docker, puerto 3000)
                                      │
                                      └──► SQLite (copias nocturnas)
```

El contenedor de la app no publica ningún puerto. Solo Caddy puede hablar con él, así que no hace falta abrir puertos en el router.

<!-- [CAPTURA: pantalla de la mesa con chat, dados y combate] -->

## Decisiones de diseño

Hubo algunas decisiones que definieron el resto del proyecto:

- **Los permisos se comprueban en el servidor.** El navegador solo oculta botones. Si alguien intenta leer una nota privada de otro usuario, el servidor responde que no.
- **Las tiradas también las hace el servidor.** Así el cliente solo envía qué dados quiere tirar, y nadie puede hacer trampa.
- **No hay registro público.** Las cuentas se crean por línea de comandos. Restablecer una contraseña olvidada también se hace así, porque si el máster pudiera hacerlo desde la app, podría entrar en las notas privadas de un jugador.
- **Las copias de seguridad se verifican.** Cada noche la app hace una copia en caliente de la base de datos y la revisa antes de darla por buena.

## Lo que hace hoy

**En la mesa**

- Chat en vivo, con susurros y tiradas como `/r 1d20+5`.
- Dados públicos u ocultos.
- Combate con iniciativa, turnos, rondas y aviso de "es tu turno", también en el móvil.

**La campaña**

- Sesiones, personajes, PNJ, misiones y mapas.
- Notas privadas, compartidas con todos o con personas concretas.
- Enlaces entre notas con `[[corchetes]]` y modo lectura.
- Misiones con estado, progreso y tareas que el grupo puede marcar.
- Mapas de pergamino para dibujar a carbón en vivo, con fichas de personajes y monstruos, cuadrícula opcional y figuras.

**Las reglas**

- Reglas de D&D del SRD 5.2.1 en español, con un buscador que mira a la vez reglas, conjuros, dotes, equipo, objetos y monstruos.
- Hojas de personaje de 2024 con cálculos automáticos: modificadores, competencia, CD de conjuros y ataques.
- Bestiario de 330 monstruos y animales, solo para el máster.

**Para preparar la sesión**

- Personaje aleatorio completo, del nivel 1 al 20.
- Criaturas preparadas con ficha interactiva.
- Tablas de tesoro y de objetos mágicos según el nivel del grupo.
- Situaciones aleatorias por entorno, para improvisar encuentros.

**Seguridad y móvil**

- Copias automáticas cada noche: se guardan 7 diarias y 4 semanales.
- Exportar la campaña a un ZIP, con las notas en Markdown y los mapas en SVG.
- Instalable en el móvil como una app más, en Android y en iPhone.

<!-- [CAPTURA: hoja de personaje 2024] -->

## Lo que viene

La hoja de ruta tiene ideas de tres tamaños. Son ideas, no compromisos:

- **Pequeñas:** un ícono nuevo acorde con "Mesa de rol", pulir algunas tablas de reglas y mostrar la fecha de la próxima sesión.
- **Medianas:** un inventario compartido por la party, estados como "derribado" o "asustado" que duren varias rondas, imágenes de fondo para los mapas, hojas en PDF para imprimir y un diario de campaña con una línea de tiempo.
- **Grandes:** soportar varios sistemas de juego, de forma que cada campaña elija su reglamento. Shadowdark y Old-School Essentials tienen material bajo licencia abierta, así que podrían incluir sus reglas. Alien RPG no tiene reglas abiertas, así que cada mesa escribiría su propio contenido. También están un modo sin conexión y las notificaciones con la app cerrada.

Lo general (notas, misiones, mapas, chat, dados y combate) ya sirve para cualquier juego. Lo que falta es la parte específica de cada sistema.

## Instalarla

Necesitas Node.js 20 o superior.

```bash
git clone git@github.com:bonzoycv/dnd-notes.git
cd dnd-notes
npm install
npm run user -- add <nombre> --master   # primera cuenta; muestra la contraseña generada
npm run dev                             # servidor en :3000 y Vite en http://localhost:5173
npm test                                # pruebas
```

En mi servidor la ejecuto con Docker:

```bash
docker compose up -d --build
docker exec -it dnd-notes node dist/server/cli.js add <nombre> --master
```

Para actualizar, basta con `git pull` y volver a levantar el contenedor. Los datos viven en un archivo SQLite que se puede copiar para tener un respaldo.

## Créditos y licencia

El proyecto incluye material del documento de referencia del sistema 5.2.1 (SRD 5.2.1) de Wizards of the Coast LLC, disponible en [dndbeyond.com/srd](https://www.dndbeyond.com/srd). Su licencia es la [Creative Commons Atribución 4.0 Internacional](https://creativecommons.org/licenses/by/4.0/legalcode).

Si la pruebas o tienes ideas para otro sistema de juego, dímelo. Todavía está en construcción y las ideas que más se usan son las que terminan en la lista de cosas por hacer.
