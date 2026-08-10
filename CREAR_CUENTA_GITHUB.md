# Crear la cuenta personal de GitHub

## 1. Registro

1. Abra https://github.com/ y pulse **Sign up**.
2. Utilice un correo personal estable como dirección principal. Después puede añadir y verificar el correo institucional de la UAM.
3. Nombre de usuario elegido: `VeroCabanas`.
4. Verifique el correo electrónico.
5. Mantenga inicialmente el plan gratuito, suficiente para repositorios públicos y privados de este tipo.

## 2. Seguridad

1. Active la autenticación en dos pasos —**Settings > Password and authentication > Two-factor authentication**—.
2. Utilice preferentemente una aplicación de autenticación o una *passkey*.
3. Guarde los códigos de recuperación fuera del ordenador y de OneDrive en un lugar seguro.

## 3. Perfil científico

Complete el perfil `https://github.com/VeroCabanas` con:

- nombre: `Verónica Cabanas Sánchez`;
- afiliación: `Universidad Autónoma de Madrid`;
- biografía: opcional; se deja sin completar por ahora;
- ubicación: `Madrid, Spain`;
- web: `https://orcid.org/0000-0003-1235-3535` —completado—;
- fotografía profesional;
- correo público solo si desea mostrarlo.

## 4. README del perfil

GitHub puede mostrar una presentación en la página personal. Para ello, cree un repositorio público cuyo nombre coincida exactamente con el nombre de usuario y añada un `README.md`.

La presentación puede incluir:

- puesto y afiliación;
- líneas de investigación;
- ORCID;
- software y recursos abiertos destacados;
- contacto institucional.

## 5. Primer repositorio: recAF

1. Pulse **New repository**.
2. Nombre: `recAF`.
3. Descripción: `R workflow for processing Matrix accelerometry files with GGIR and summarising weekly moderate-to-vigorous physical activity.`
4. Seleccione inicialmente **Private**.
5. No active la creación automática de README, `.gitignore` o licencia: ya están preparados.
6. Suba el contenido de `recAF_GitHub_READY_DRAFT`, no la carpeta contenedora ni el `recAF` original.
7. Compruebe que `README.md`, `LICENSE` y `CITATION.cff` aparecen en la raíz.
8. Revise el repositorio privado antes de convertirlo en público.

## 6. Qué no debe subir

- archivos Matrix `.bin`;
- carpetas `data/input`, salvo el archivo vacío `.gitkeep`;
- resultados individuales;
- el ejecutable original;
- historiales de R, rutas locales o documentos con identificadores.

Cuenta creada: `VeroCabanas`. URL prevista del primer repositorio: `https://github.com/VeroCabanas/recAF`.
