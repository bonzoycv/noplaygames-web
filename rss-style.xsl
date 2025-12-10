<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:atom="http://www.w3.org/2005/Atom">
  <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml" lang="es">
      <head>
        <title>RSS Feed - No Play Games</title>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <style>
          body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Open Sans", "Helvetica Neue", sans-serif; line-height: 1.6; color: #333; max-width: 800px; margin: 0 auto; padding: 2rem; background: #f4f6f8; }
          header { background: #1e1e1e; color: #fff; padding: 2rem; border-radius: 8px; margin-bottom: 2rem; }
          h1 { margin: 0; }
          p { margin-top: 0.5rem; color: #ccc; }
          a { color: #0984e3; text-decoration: none; }
          .item { background: #fff; padding: 1.5rem; margin-bottom: 1rem; border-radius: 8px; border: 1px solid #ddd; }
          .item h3 { margin-top: 0; }
          .alert { background: #fff3cd; border: 1px solid #ffeeba; color: #856404; padding: 1rem; border-radius: 8px; margin-bottom: 2rem; }
        </style>
      </head>
      <body>
        <div class="alert">
          <strong>📢 RSS Feed:</strong> Estás viendo la versión web de este feed. Copia la URL de esta página en tu lector de noticias favorito (Feedly, Newsboat, etc.) para suscribirte.
        </div>
        <header>
          <h1><xsl:value-of select="/rss/channel/title"/></h1>
          <p><xsl:value-of select="/rss/channel/description"/></p>
          <a href="{/rss/channel/link}" style="color: white; text-decoration: underline;">← Volver al sitio web</a>
        </header>
        <main>
          <h2>Últimos Artículos</h2>
          <xsl:for-each select="/rss/channel/item">
            <div class="item">
              <h3>
                <a href="{link}" target="_blank">
                  <xsl:value-of select="title"/>
                </a>
              </h3>
              <p><xsl:value-of select="description"/></p>
              <small style="color: #666">Publicado: <xsl:value-of select="pubDate"/></small>
            </div>
          </xsl:for-each>
        </main>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
