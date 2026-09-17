# Plan de Reestructuración y Rediseño Minimalista para noplaygames.dev

Este plan define la transformación de **noplaygames.dev** hacia un blog de estética *old-school*, súper minimalista, centrado en tipografía, legibilidad y facilidad de mantenimiento, al estilo del emblemático blog de Ron Gilbert (*Grumpy Gamer*).

---

## 1. Decisiones del Usuario y Dirección Confirmada

- **Formato de Portada:** **Lista / Archivo Minimalista.** Formato *old-school* de acceso rápido. Cada entrada se presenta en una lista limpia ordenada por fecha con su título y una breve descripción de 1 línea.
- **Secciones del Menú Superior:** `Inicio` | `Proyectos` | `Sobre Mí` | `Contacto` | `RSS` | `GitHub`.
- **Cierre de Artículos:** Cada entrada incluirá al final un bloque discreto con enlaces de contacto/redes (GitHub, RSS, Email).
- **Temática:** Linux (PikaOS, Fedora, Arch), Servidor Proxmox (VMs, Docker, Pi-hole, Jellyfin a nivel inicial), Bash y terminal.

---

## 2. Comparativa sobre el Mantenimiento (HTML vs Hugo)

### ¿Cómo cambia tu flujo de trabajo entre ambas opciones?

| Acción | Con HTML + CSS puro | Con Hugo (Recomendado) |
| :--- | :--- | :--- |
| **Crear una entrada** | Copiar un HTML existente, editar manualmente encabezado, metadatos, contenido en tags `<p><code>`, y añadir el enlace manualmente a `index.html` y a la paginación. | Escribir un archivo de texto en Markdown (`hugo new posts/mi-post.md`). Ejecutar `hugo` y se compila todo automáticamente. |
| **Cambiar la cabecera/menú** | Editar el menú en los ~15 archivos HTML uno por uno. | Editar 1 sola plantilla (`header.html`) y se actualiza en toda la web. |
| **Código e imágenes** | Escribir etiquetas HTML pesadas (`<pre><code>...</code></pre>`). | Escribir con tres comillas en Markdown (```bash ... ```), Hugo aplica resaltado sintáctico automático. |
| **Dependencias** | Ninguna (0 herramientas). | 1 ejecutable binario súper ligero sin `npm` ni `node_modules`. |

---

## 3. Plan de Acción Paso a Paso

### Paso 1: Rediseño Visual de la Plantilla Minimalista (`style.css`)
- Crear la nueva hoja de estilos `style.css` inspirada en *Grumpy Gamer*:
  - Cabecera minimalista con enlaces de texto plano horizontal.
  - Título principal `noplaygames.dev` con subtítulo discreto.
  - Layout centrado de columna única (`max-width: 760px`).
  - Formato de lista de artículos: Fecha sobria a la izquierda/arriba, Título directo en Negrita/Color sobrio, Descripción limpia.
  - Bloques de código pre/code inspirados en terminal retro.
  - Botón discreto de cambio de tema (Modo Claro / Modo Oscuro).

### Paso 2: Aplicar la Portada `index.html` (Formato Lista Minimalista)
- Reestructurar `index.html` para mostrar la lista ordenada de artículos enfocados en Linux, Proxmox, PikaOS y Bash.

### Paso 3: Rediseñar Páginas de Post y Páginas Secundarias
- Actualizar `noplay/perfil.html`, `noplay/contacto.html`, `noplay/proyectos.html` y la plantilla de entradas con el footer de redes al final.

### Paso 4 (Opcional según tu respuesta): Migración a Hugo
- Si decides probar Hugo, estructuraremos las plantillas para que la generación de entradas en Markdown sea 100% automatizada.

---

## 4. Verificación
1. Servir la web localmente (`python3 -m http.server 8000` o `hugo server`).
2. Probar legibilidad en móvil y escritorio.
3. Verificar conmutación de tema claro/oscuro y funcionamiento de enlaces de navegación.
