# Metodología

## Finalidad

`recAF` —Recomendaciones de Actividad Física— automatiza el procesamiento de archivos Matrix `.bin`, obtenidos en su configuración original mediante colocación en la muñeca no dominante, y genera un mini-informe individual del tiempo semanal de actividad física moderada-vigorosa (AFMV) conforme a un criterio configurable.

Está orientado inicialmente a población adulta y a estudios que necesitan conocer con rapidez si una persona alcanza un criterio de AFMV definido en el protocolo. Un caso de uso posible es la selección para una intervención de ejercicio de supervivientes de cáncer que no alcancen 150 min/semana de AFMV. El programa no adopta por sí mismo la decisión: proporciona un resultado estandarizado para aplicar el protocolo del estudio.

## Procesamiento con GGIR

La versión preparada conserva los parámetros sustantivos identificados en el código original:

| Parámetro | Valor |
|---|---:|
| Partes de GGIR | 1–5 |
| Colocación del dispositivo | Muñeca no dominante |
| Ventana de parte 5 | MM |
| Agregación de parte 5 | 60 s |
| Umbral actividad ligera | 35 mg |
| Umbral actividad moderada | 100 mg |
| Umbral actividad vigorosa | 400 mg |
| Episodios de AFMV | 3 min |
| Criterio del episodio AFMV | 1 |
| Día válido, parte 5 | 10 h |
| Criterio semanal predeterminado | 150 min |

GGIR permite proporcionar a `datadir` una lista de archivos concretos. `recAF` utiliza explícitamente un archivo por ejecución para mantener una correspondencia inequívoca entre entrada, resumen y figura.

## Cálculo

Del archivo `part5_personsummary_MM...csv` se utilizan:

- `dur_day_total_MOD_min_wei`;
- `dur_day_MOD_unbt_min_wei`;
- `dur_day_total_VIG_min_wei`.

La regla heredada es:

```text
MOD acumulada semanal = 7 × (MOD total diaria − MOD no acumulada diaria)
VIG semanal = 7 × VIG total diaria
AFMV semanal = MOD acumulada semanal + VIG semanal
Porcentaje = 100 × AFMV semanal / criterio semanal
```

Los valores diarios utilizados son estimaciones ponderadas producidas por GGIR.

## Interpretación

El valor de 150 min/semana coincide con una referencia habitual para actividad aeróbica moderada-vigorosa en población adulta. Sin embargo, `recAF` aplica una definición operacional específica de intensidad y acumulación; el resultado no debe presentarse automáticamente como equivalencia perfecta con una recomendación clínica o poblacional sin justificar previamente:

- población y edad;
- dispositivo y lugar de colocación;
- protocolo de uso;
- criterios de validez;
- umbrales de aceleración;
- tratamiento de episodios;
- posibles ponderaciones entre actividad moderada y vigorosa.

Los parámetros se encuentran visibles en `R/recaf_ggir.R` y pueden modificarse para otras poblaciones o protocolos. Cualquier adaptación deberá documentar la justificación científica y generar una nueva versión del software.

## Reproducibilidad

La versión objetivo de GGIR es 3.2-6. Los resultados pueden cambiar con otras versiones si cambian los nombres de variables, los algoritmos o los valores predeterminados. Toda modificación metodológica debe acompañarse de una nueva versión de `recAF` y de su correspondiente documentación.

## Referencias fundamentales

- Migueles JH, Rowlands AV, Huber F, Sabia S, van Hees VT. GGIR: A Research Community–Driven Open Source R Package for Generating Physical Activity and Sleep Outcomes From Multi-Day Raw Accelerometer Data. *Journal for the Measurement of Physical Behaviour*. 2019;2(3):188–196. https://doi.org/10.1123/jmpb.2018-0063
- Bull FC, Al-Ansari SS, Biddle S, et al. World Health Organization 2020 guidelines on physical activity and sedentary behaviour. *British Journal of Sports Medicine*. 2020;54:1451–1462. https://doi.org/10.1136/bjsports-2020-102955
- Documentación oficial de GGIR: https://wadpac.github.io/GGIR/
