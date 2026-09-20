<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:atom="http://www.w3.org/2005/Atom">
  <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml" lang="es" data-theme="dark">
      <head>
        <title>RSS Feed — No Play Games</title>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <style>
          @import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;500&amp;family=IBM+Plex+Sans:wght@400;500;600;700&amp;display=swap');
          
          body { 
            font-family: 'IBM Plex Sans', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; 
            line-height: 1.6; 
            color: #f3f4f6; 
            max-width: 760px; 
            margin: 0 auto; 
            padding: 2rem 1.25rem; 
            background: #121212; 
          }
          
          header { 
            background: #18181b; 
            color: #f3f4f6; 
            padding: 1.5rem; 
            border-radius: 6px; 
            border: 1px solid #27272a; 
            margin-bottom: 2rem; 
            text-align: center;
          }
          
          h1 { margin: 0; font-size: 1.8rem; }
          p { margin-top: 0.4rem; color: #9ca3af; }
          a { color: #38bdf8; text-decoration: none; }
          a:hover { text-decoration: underline; }
          
          .back-link {
            display: inline-block;
            margin-top: 0.75rem;
            color: #4ade80;
            font-weight: 500;
          }

          .item { 
            padding: 1.25rem 0; 
            border-bottom: 1px dashed #27272a; 
          }
          .item h3 { margin: 0 0 0.4rem 0; font-size: 1.2rem; }
          .item h3 a { color: #f3f4f6; }
          .item h3 a:hover { color: #4ade80; }
          .item p { color: #9ca3af; margin: 0 0 0.4rem 0; font-size: 0.95rem; }
          .item small { font-family: 'IBM Plex Mono', monospace; color: #6b7280; font-size: 0.85rem; }
          
          .alert { 
            background: #1e1e24; 
            border: 1px solid #3f3f46; 
            color: #e4e4e7; 
            padding: 1rem; 
            border-radius: 6px; 
            margin-bottom: 2rem; 
            font-size: 0.92rem;
          }
        </style>
      </head>
      <body>
        <div class="alert">
          <strong>📢 RSS Feed:</strong> Estás viendo la versión web de este feed. Copia la URL de esta página en tu lector de noticias favorito (Feedly, Newsboat, etc.) para suscribirte.
        </div>
        <header>
          <h1><xsl:value-of select="/rss/channel/title"/></h1>
          <p><xsl:value-of select="/rss/channel/description"/></p>
          <a href="/index.html" class="back-link">← Volver al sitio web</a>
        </header>
        <main>
          <h2 style="font-size: 1.15rem; text-transform: uppercase; color: #9ca3af; letter-spacing: 0.05em; border-bottom: 1px solid #27272a; padding-bottom: 0.5rem; margin-bottom: 1.5rem;">Últimos Artículos</h2>
          <xsl:for-each select="/rss/channel/item">
            <div class="item">
              <small><xsl:value-of select="pubDate"/></small>
              <h3>
                <a href="{link}">
                  <xsl:value-of select="title"/>
                </a>
              </h3>
              <p><xsl:value-of select="description"/></p>
            </div>
          </xsl:for-each>
        </main>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
