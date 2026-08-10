# Lista de comprobación para publicar recAF

## 1. Revisión previa

- Confirmar `METADATOS_PENDIENTES.md`.
- Mantener diferenciadas la fecha de desarrollo de v1.0.0 —17/05/2025— y la fecha efectiva de publicación de la *release*.
- Revisar que no existen datos reales ni identificadores.
- Ejecutar `Rscript tests/ejecutar_pruebas.R`.
- Probar al menos un archivo autorizado fuera del repositorio.

## 2. Crear el repositorio

1. Crear un repositorio vacío llamado `recAF`.
2. Elegir inicialmente visibilidad privada mientras se revisa.
3. Subir únicamente el contenido de esta carpeta.
4. Revisar el historial completo antes de cambiarlo a público.
5. Añadir temas como `accelerometry`, `physical-activity`, `ggir`, `r` y `open-science`.

URL prevista: https://github.com/VeroCabanas/recAF

## 3. Completar metadatos

- Comprobar que `CITATION.cff` y `codemeta.json` apuntan a `https://github.com/VeroCabanas/recAF`.
- Confirmar que GitHub detecta la licencia MIT.
- Completar relaciones con publicaciones o protocolos, si existen.
- Confirmar la versión y fecha de publicación.
- Añadir `date-released` a `CITATION.cff` únicamente cuando se publique la *release*, utilizando la fecha efectiva.

## 4. Conectar Zenodo

1. Vincular las cuentas de GitHub, Zenodo y ORCID.
2. Sincronizar los repositorios en Zenodo.
3. Activar `recAF` en la integración GitHub–Zenodo.
4. Crear en GitHub una *release* etiquetada como `v1.0.0`.
5. Comprobar que Zenodo ha archivado la versión y asignado DOI.
6. Añadir el DOI y su insignia al README y a la ficha del tomo de TU.

## 5. Evidencia para el concurso

- Guardar en PDF la portada del repositorio.
- Guardar la página de la *release*.
- Guardar el registro de Zenodo con DOI, autoría, versión, fecha y licencia.
- Incorporar la referencia de software y una explicación narrativa al tomo.
