# Práctica 1: Problema de programación lineal

Asignatura: Heurística y Optimización 2024/25

Miembros:

- Javier Rosales Lozano: 100495802
- Alonso Rios Guerra: 100495821

## Descripción del Proyecto

Este proyecto forma parte de una práctica de **Heurística y Optimización** y abarca dos problemas diferentes que se modelan y resuelven utilizando técnicas de  **Programación Lineal** . Ambos problemas son abordados usando **MathProg** y resueltos con **GLPK** (GNU Linear Programming Kit).

# Parte 1

El primer problema se enfoca en la optimización de la oferta de billetes para una aerolínea. La empresa tiene tres tipos de tarifas: estándar, leisure plus y business plus, cada una con diferentes características y precios. Además, la aerolínea dispone de cinco aviones con diferentes capacidades en términos de asientos y peso máximo de equipaje.

El objetivo de esta parte es determinar el número óptimo de billetes que se deben ofertar para cada tarifa, de modo que se maximicen los beneficios, respetando las restricciones de capacidad de los aviones, el número mínimo de billetes a ofertar para ciertas tarifas, y las proporciones entre los diferentes tipos de billetes.

# Parte 2

El segundo problema aborda la optimización en la asignación de pistas de aterrizaje en un aeropuerto. El aeropuerto cuenta con cuatro pistas con disponibilidad variable en diferentes slots de tiempo, y se requiere asignar estos slots a cinco aviones que aterrizarán en el aeropuerto.

El objetivo es minimizar el costo asociado al retraso en los aterrizajes, teniendo en cuenta que:

- Los aviones deben aterrizar dentro del rango entre su hora programada de llegada y su hora límite de aterrizaje.
- No se pueden asignar slots consecutivos en la misma pista por razones de seguridad.
- Cada slot solo puede ser asignado a un avión y debe estar disponible en la pista correspondiente.

La implementación de este problema debe juntarse con las consideraciones de la Parte 1.

## Estructura del proyecto

El proyecto está organizado en las siguientes carpetas y archivos:

### Carpeta Raíz

- **`practica-1-2.pdf`**: Documento PDF con el enunciado completo de la práctica, que describe los problemas de optimización a resolver en ambas partes.
- **`memoria-practica1.docx`**: Documento que contiene la memoria explicativa de la solución desarrollada para la práctica.
- **`autores.txt`**: Archivo que incluye la lista de autores del proyecto.

### Carpeta `p1-495821-495802`

Esta carpeta contiene los archivos relacionados con la **Parte 1** y **Parte 2** del proyecto:

- **`part-1.ods`**: Hoja de cálculo que incluye datos utilizados en la Parte 1 del proyecto, probablemente con información de vuelos y resultados obtenidos del modelo de optimización de tarifas.

Esta carpeta contiene los archivos relacionados con la **Parte 2** del proyecto:

- **`p1.dat`**: Archivo de datos que contiene la información utilizada por el modelo de asignación de pistas de aterrizaje. Esto incluye los datos de llegada de aviones, tiempos disponibles de las pistas, entre otros.
  
- **`p1.mod`**: Archivo que define el modelo de la **Parte 2** en MathProg. Este modelo se encarga de resolver el problema de asignación de pistas de aterrizaje para minimizar los costes por retrasos.

- **`p1.txt`**: Archivo adicional que podría contener información relacionada con el problema o resultados generados por el modelo.

- **`part-2.dat`**: Archivo de datos adicional para la **Parte 2**, posiblemente con una variante o conjunto de datos distinto del archivo `p1.dat`.

- **`part-2.mod`**: Archivo del modelo en MathProg relacionado con la **Parte 2**. Puede ser una variación o extensión del archivo `p1.mod`.

## Instrucciones para la Ejecución

1. **Parte 1**: Abre y utiliza el archivo `part-1.ods` para visualizar los datos y resultados obtenidos en la primera parte del proyecto.
   
2. **Parte 2**: Utiliza los archivos `.dat` y `.mod` de la carpeta `parte-2` para ejecutar el modelo de optimización en GLPK.

   - Para ejecutar el modelo, asegúrate de tener GLPK instalado y ejecuta el siguiente comando:
     ```bash
     glpsol -ml p2.mod -d p2.dat -o p2.txt
     ```

   Este comando resolverá el modelo de asignación de pistas utilizando los datos proporcionados en `p2.dat`. Los resultados se mostrarán en el archivo de salida `p2.txt`.
