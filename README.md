# Construcciones F. Garcia

Sitio web estatico recuperado para `construccionesfgarcia.es`.

## Estructura

- `index.html`: pagina principal.
- `assets/`: logos, imagenes y galeria estatica.

## Despliegue en Hostinger

1. Subir el contenido del repositorio al directorio `public_html` del dominio.
2. Mantener la estructura tal cual, sin mover `assets/`.
3. No hace falta PHP para la galeria actual.

## Desarrollo local

```bash
python3 -m http.server 8123
```

Luego abrir `http://127.0.0.1:8123/`.

## Deploy por SSH a Hostinger

Comprobacion de acceso:

```bash
./scripts/check-hostinger.sh
```

Deploy del dominio actual:

```bash
./scripts/deploy-hostinger.sh construccionesfgarcia.es
```

Dry run:

```bash
./scripts/deploy-hostinger.sh construccionesfgarcia.es . --dry-run
```
