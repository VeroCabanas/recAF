# Ficha provisional para el tomo de TU

## recAF — Recomendaciones de Actividad Física

**Tipo de resultado.** Software científico y herramienta de apoyo al procesamiento y transferencia de resultados de investigación.

**Desarrollo.** La versión 1.0.0 fue desarrollada el 17/05/2025. Es un flujo de trabajo en R para automatizar el procesamiento mediante GGIR de archivos Matrix `.bin` obtenidos en la muñeca no dominante y obtener, para cada registro, una estimación semanal de actividad física moderada-vigorosa, su porcentaje respecto de un criterio configurable y un mini-informe gráfico individual. La herramienta integra la configuración analítica, la extracción de variables del resumen de la parte 5, el cálculo y la generación de resultados en un único procedimiento reproducible.

**Aportación personal.** Verónica Cabanas Sánchez es la autora única: conceptualizó la herramienta, definió la configuración analítica, programó el flujo en R, diseñó la representación de resultados y preparó su documentación y validación.

**Utilidad y transferencia.** `recAF` reduce tareas manuales, homogeneiza el procesamiento entre registros y permite conocer rápidamente si una persona adulta alcanza el criterio semanal de AFMV establecido en un protocolo. Puede apoyar, por ejemplo, la selección para una intervención de ejercicio de supervivientes de cáncer con niveles bajos de actividad física. La publicación del código, la documentación metodológica y un ejemplo sintético permitirá auditar el procedimiento, reproducirlo y adaptar sus parámetros a otras poblaciones o estudios.

**Ciencia abierta.** El repositorio personal de la autora incorporará código fuente bajo licencia MIT, documentación, metadatos de citación, control de versiones y una *release* preservada en Zenodo con DOI. Los archivos Matrix `.bin` se utilizarán únicamente como entradas locales y los datos individuales quedan expresamente excluidos del repositorio.

**Limitaciones.** El resultado depende de la versión y configuración de GGIR, de la calidad del registro y de la adecuación de los umbrales y criterios a la población estudiada. No constituye una herramienta diagnóstica.

**Indicadores y evidencias que se incorporarán.** Repositorio previsto: https://github.com/VeroCabanas/recAF; versión; fecha; licencia; DOI de Zenodo; número de *releases*; descargas de Zenodo/GitHub cuando estén disponibles; reutilizaciones, citas, *forks*, *stars* o incidencias documentadas.

**Información pendiente.** Publicación efectiva del repositorio, fecha de publicación de la *release* y DOI de Zenodo.
