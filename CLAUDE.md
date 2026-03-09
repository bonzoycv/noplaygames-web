# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

"No Play Games" (`noplay_neo`) is a personal static HTML/CSS blog written in Spanish. There is no build system, no framework, no package manager, and no JavaScript dependencies — just plain HTML files and a single shared stylesheet.

## Previewing the Site

Since there is no build step, serve the root directory with any static file server:

```bash
python3 -m http.server 8000
```

Then open `http://localhost:8000` in a browser. The site uses absolute paths (e.g., `/index.html`, `/style.css`) so it must be served from a server, not opened directly as a `file://` URL.

## Architecture

### File Structure

- `index.html` — home page, lists recent posts manually
- `not_found.html` — 404 page
- `style.css` — single global stylesheet shared by all pages
- `sources/` — static assets (images, logo, favicon)
- `noplay/perfil.html` — author profile page
- `noplay/post/linux.html` — articles index page (lists all posts manually)
- `noplay/post/*.html` — individual blog post pages

### No Templating

There is no templating system. The header (with nav), footer, and the mobile menu `<script>` block are **copy-pasted into every HTML file**. When changing shared UI elements (nav links, footer text, logo), every file must be updated individually.

### CSS Path Convention

- Pages at the root level reference styles as `./style.css` or `style.css`
- Pages under `noplay/` use `/style.css` (absolute) or `../../style.css` (relative)
- All asset paths in `noplay/post/` pages use `../../sources/` (relative) or `/sources/` (absolute)

### Adding a New Post

1. Create `noplay/post/<slug>.html` — copy an existing post file as a template
2. Add an `<article class="blog-entry">` card to `noplay/post/linux.html` (articles index)
3. Add the same card to `index.html` if it should appear in "Últimas entradas" (recent posts)

### CSS Design Tokens

CSS custom properties are defined in `:root` in `style.css`:
- `--accent: #0984e3` — blue accent color
- `--header-bg` / `--footer-bg: #1e1e1e` — dark header/footer
- `--blog-bg: #ffffff` — white article cards
- `--code-bg: #f4f4f4` — inline/block code background

The mobile nav is toggled by adding/removing the `.showing` class via inline `<script>` at the bottom of each page's `<body>`.

### Deploy

Push local changes to GitHub, then pull on the server:

```bash
git push origin master && ssh noplaygames "cd /home/ubuntu/noplay_neo && git pull origin master"
```
