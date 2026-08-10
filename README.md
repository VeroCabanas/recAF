# recAF

**Procesamiento reproducible de acelerometría Matrix para resumir el cumplimiento de las recomendaciones de actividad física moderada-vigorosa (AFMV).**

`recAF` significa **Recomendaciones de Actividad Física**. Es un flujo de trabajo en R para procesar archivos `.bin` generados por acelerómetros Matrix mediante [GGIR](https://wadpac.github.io/GGIR/), extraer estimaciones semanales de AFMV y generar un mini-informe numérico y gráfico por participante.

La versión 1.0.0 fue desarrollada íntegramente por Verónica Cabanas Sánchez el 17 de mayo de 2025 para facilitar un procesamiento estandarizado y rápido en entorno Windows. La configuración original se diseñó para archivos Matrix obtenidos mediante colocación en la muñeca no dominante y para estudios en población adulta en los que el nivel de AFMV medido objetivamente sea necesario para aplicar decisiones previamente definidas en el protocolo, como determinar la elegibilidad para una intervención de ejercicio.

> **Estado:** versión 1.0.0 validada técnicamente y preparada para su publicación inicial. La autora ha optado por no asociar el software a un proyecto concreto, de modo que pueda reutilizarse en distintos estudios y poblaciones adultas.

## Funcionalidad

Para cada archivo Matrix `.bin`, `recAF`:

1. ejecuta las partes 1–5 de GGIR con una configuración predefinida;
2. localiza el resumen individual generado en la parte 5;
3. calcula los minutos semanales de AFMV conforme a la regla operacional documentada;
4. genera un archivo CSV de síntesis;
5. crea una figura individual del resultado;
6. registra el éxito o el error del procesamiento sin eliminar el archivo original.

El mini-informe permite conocer rápidamente si el tiempo estimado de AFMV alcanza el criterio configurado. Puede servir, por ejemplo, para aplicar un criterio de inclusión que reserve un programa de ejercicio a personas adultas con niveles bajos de actividad física. La decisión final debe estar definida en el protocolo y ser revisada por el equipo investigador.

## Regla operacional

La implementación original calcula:

```text
AFMV semanal = 7 × [(MOD total diaria − MOD no acumulada diaria) + VIG total diaria]
```

y expresa el resultado como porcentaje de un criterio configurable, cuyo valor predeterminado es 150 min/semana.

Esta clasificación depende de la configuración de GGIR y del protocolo analítico. No constituye por sí sola una medición clínica ni debe interpretarse al margen de la población, el dispositivo, el lugar de colocación, el periodo de registro y los criterios de validez utilizados. Los parámetros se conservan para reproducir el procedimiento original, pero pueden modificarse justificadamente para otros protocolos o poblaciones. Véase [Metodología](docs/METODOLOGIA.md).

## Configuración de GGIR conservada

- GGIR: versión objetivo `3.2-6`.
- GGIRread: versión objetivo `1.0.8`.
- Colocación prevista: muñeca no dominante.
- Partes: `1:5`.
- Identificación: `idloc = 6`.
- Detección de sueño/periodo no válido: `HASPT.algo = c("NotWorn", "HDCZA")`.
- Agregación en parte 5: 60 segundos.
- Umbrales: 35, 100 y 400 mg para actividad ligera, moderada y vigorosa.
- Duración mínima de episodios de AFMV: 3 minutos.
- Criterio del episodio: 1.
- Ventana temporal: medianoche–medianoche (`MM`).
- Horas mínimas de día válido en parte 5: 10.
- Informes GGIR: partes 2, 4 y 5.

## Requisitos

- Windows 10/11 para los lanzadores `.bat`; el script R también puede ejecutarse directamente en otros sistemas.
- R 4.4 o posterior. Aunque GGIR 3.2-6 declara R ≥3.5, la instalación reproducible validada utiliza una dependencia necesaria que actualmente requiere R ≥4.4.
- GGIR 3.2-6, GGIRread 1.0.8 y sus dependencias.

## Instalación

En Windows, ejecute:

```text
INSTALAR_recAF.bat
```

O desde R:

```r
source("scripts/instalar_dependencias.R")
```

La instalación de versiones archivadas puede requerir Rtools en Windows.

## Uso

1. Copie localmente los archivos Matrix `.bin` en `data/input/`.
2. Ejecute `EJECUTAR_recAF.bat`.
3. Consulte `results/`.

También puede ejecutarse desde una terminal:

```text
Rscript scripts/ejecutar_recaf.R --input-dir data/input --output-dir results
```

Opciones disponibles:

```text
--threshold 150          Criterio semanal en minutos
--overwrite              Recalcula resultados ya existentes
--archive-processed DIR  Mueve el original tras un procesamiento correcto
--help                   Muestra la ayuda
```

El comportamiento predeterminado es conservador: **no mueve ni borra los archivos de entrada**.

## Resultados

Para cada archivo se crea una carpeta con:

- resultados completos de GGIR;
- `<ID>_resumen_recAF.csv`;
- `<ID>_cumplimiento_AFMV.png`.

El registro general se guarda en `results/recAF_registro_procesamiento.csv`.

## Ejemplo reproducible

La carpeta `examples/` contiene un resumen completamente sintético. Para generar su figura:

```text
Rscript examples/generar_ejemplo.R
```

Este ejemplo comprueba el cálculo y la generación de resultados sin distribuir datos de participantes.

## Validación técnica

El 10 de agosto de 2026 se ejecutó el flujo completo sobre un archivo Matrix `.bin` autorizado y conservado fuera del repositorio. La prueba terminó correctamente con R 4.4.3, GGIR 3.2-6 y GGIRread 1.0.8, generó los informes de GGIR, el resumen individual, la figura y el registro de procesamiento, y no modificó el archivo de entrada. Los detalles no identificativos se documentan en [Revisión de veracidad](docs/REVISION_DE_VERACIDAD.md).

## Privacidad y datos

Los archivos Matrix `.bin` son entradas locales del programa: **no deben subirse a GitHub**. Los datos brutos, resultados individuales y nombres o códigos de participantes están excluidos mediante `.gitignore`. Antes de cualquier publicación debe comprobarse que el historial de Git tampoco contenga datos personales. Véase [Privacidad y seguridad](docs/PRIVACIDAD_Y_SEGURIDAD.md).

## Citación

La información provisional de citación se encuentra en [`CITATION.cff`](CITATION.cff). GitHub mostrará automáticamente la opción **Cite this repository** cuando el archivo se publique en la rama principal. La fecha de desarrollo de v1.0.0 es 17/05/2025; la fecha de publicación se incorporará cuando se cree la *release*. El DOI se añadirá después de conectar el repositorio con Zenodo y archivar esa versión.

## Licencia

`recAF` se distribuye bajo [licencia MIT](LICENSE). Esta licencia permite usar, copiar, modificar, publicar, distribuir, sublicenciar y comercializar el software, siempre que se conserve el aviso de autoría y licencia.

## Reconocimiento

`recAF` utiliza GGIR, desarrollado por Vincent T. van Hees y colaboradores y distribuido bajo licencia Apache 2.0. `recAF` es una herramienta independiente y no está afiliada oficialmente al equipo de GGIR.

## Limitación de responsabilidad

El software se proporciona para investigación. Sus resultados requieren revisión por personal con experiencia en acelerometría y epidemiología de la actividad física.
