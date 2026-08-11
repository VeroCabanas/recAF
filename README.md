# recAF

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.21887021.svg)](https://doi.org/10.5281/zenodo.21887021)

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
