# Revisión de veracidad de recAF

Fecha de revisión: 10/08/2026.

## Evidencia comprobada en los archivos originales

- El ejecutable original `recAF.exe` declara versión de archivo `1.0.0.0`, producto `AFMVrecom_Matrix_GGIR_VCS` y compañía/autora abreviada `VCS`.
- El ejecutable y los scripts originales tienen fecha de 17/05/2025; esta fecha se utiliza como fecha de desarrollo de v1.0.0, no como fecha de publicación pública.
- El encabezado del script identifica a Verónica Cabanas Sánchez como desarrolladora.
- La entrada prevista son archivos Matrix `.bin` y el procesamiento se realiza mediante GGIR.
- El script original ejecuta las partes 1–5 y utiliza umbrales de 35, 100 y 400 mg, episodios de AFMV de 3 minutos, ventana `MM` y criterio predeterminado de 150 min/semana.
- El cálculo central implementado en el repositorio reproduce la fórmula del script original y el resultado conservado de 12,502 min, mostrado gráficamente como 12,50 min.
- Los resultados conservados de julio de 2026 indican en `config.csv` que se generaron con R 4.5.1, GGIR 3.3-4 y GGIRread 1.0.8. Esta ejecución posterior no debe confundirse con la versión GGIR 3.2-6 incluida en los materiales de desarrollo de 2025.

## Información confirmada por la autora

- `recAF` significa Recomendaciones de Actividad Física.
- Verónica Cabanas Sánchez es la única autora.
- La configuración original corresponde a colocación del Matrix en la muñeca no dominante.
- La población objetivo general es adulta; los parámetros pueden adaptarse justificadamente.
- El software no se asociará formalmente a un proyecto concreto.
- El caso de uso que motivó su desarrollo fue la identificación rápida de personas adultas que no alcanzaban 150 min/semana de AFMV para aplicar decisiones definidas en un protocolo de intervención.

## Comprobaciones técnicas realizadas

- Los archivos R se analizan sintácticamente sin errores.
- Las pruebas del cálculo central terminan correctamente.
- El ejemplo sintético genera un CSV y una figura sin utilizar datos reales.
- El repositorio no contiene `.bin`, `.cwa`, `.gt3x`, objetos R con datos ni identificadores de los participantes utilizados en las pruebas originales.
- `CITATION.cff`, `codemeta.json`, README y licencia atribuyen el software a Verónica Cabanas Sánchez y utilizan el ORCID 0000-0003-1235-3535.

## Comprobación integral

El 10/08/2026 se realizó una prueba integral con el archivo Matrix autorizado `0000000.bin`, sin incorporarlo al repositorio ni publicar sus resultados individuales.

- Tamaño del archivo de entrada: 292.249.568 bytes.
- Huella SHA-256 antes y después de la prueba: `1953A57999DB7F6AA2023CBAF65EF849701B5E2F75F4D431654237973683A52D`.
- Entorno aislado: R 4.4.3, GGIR 3.2-6, GGIRread 1.0.8 y ActCR 0.4.0.
- Duración registrada por `recAF`: 94,72 segundos.
- Estado final del registro: `correcto`.
- Productos comprobados: resultados completos de GGIR, resumen individual en CSV, figura PNG y registro general de procesamiento.
- Parámetros confirmados en `config.csv`: `acc.metric = ENMO`, umbrales 35/100/400 mg, `strategy = 1`, día válido de 10 horas en parte 5 y ventana `MM`.
- El archivo de entrada permaneció en su ubicación original y conservó exactamente su huella digital.

Los resultados derivados del registro real se mantienen fuera del repositorio. El repositorio contiene únicamente un ejemplo sintético.

## Corrección de requisitos tras la prueba

GGIR 3.2-6 declara formalmente R ≥3.5, pero el conjunto de dependencias necesario y disponible durante la validación incluye ActCR 0.4.0, que requiere R ≥4.4. Por ello, `recAF` documenta R ≥4.4 como requisito operativo reproducible y fija GGIR 3.2-6 y GGIRread 1.0.8 como versiones objetivo.
