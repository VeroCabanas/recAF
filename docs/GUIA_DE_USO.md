# Guía de uso

## Preparación

1. Instale R 4.4 o posterior.
2. Ejecute `INSTALAR_recAF.bat`.
3. Compruebe que la instalación termina sin errores.

## Procesamiento ordinario

1. Copie localmente uno o varios archivos Matrix `.bin` en `data/input/`.
2. No incluya otros tipos de archivo en esa carpeta.
3. Ejecute `EJECUTAR_recAF.bat`.
4. Mantenga abierta la ventana hasta que finalice el procesamiento.
5. Consulte `results/recAF_registro_procesamiento.csv`.

Los originales permanecen en `data/input/`. Esta decisión evita pérdidas accidentales y facilita repetir o auditar el análisis. La carpeta está excluida de Git: los `.bin` son datos de entrada para la ejecución local, no archivos que deban publicarse en GitHub.

## Repetir un análisis

Por seguridad, una carpeta ya existente se omite. Para recalcularla:

```text
Rscript scripts/ejecutar_recaf.R --input-dir data/input --output-dir results --overwrite
```

La opción `--overwrite` elimina únicamente la carpeta de resultados correspondiente antes de recalcularla. Debe utilizarse con cautela.

## Archivar los originales procesados

Solo si el protocolo de trabajo lo exige:

```text
Rscript scripts/ejecutar_recaf.R --input-dir data/input --output-dir results --archive-processed data/processed
```

El archivo se mueve únicamente después de completar el procesamiento y generar el resumen. Si ya existe un archivo con el mismo nombre en destino, el original no se mueve.

## Errores frecuentes

- **Rscript no está disponible:** reinstale R y active la opción de añadirlo al PATH.
- **GGIR no está instalado:** ejecute el instalador.
- **No se encuentra el resumen de parte 5:** revise la calidad del archivo y el registro de GGIR.
- **Faltan columnas:** confirme que se utiliza la versión de GGIR prevista.
- **Resultado omitido:** utilice `--overwrite` solo después de revisar la carpeta existente.
