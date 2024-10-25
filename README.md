
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

## Instrucciones para la Ejecución

2. **Parte 2**: Utiliza los archivos `.dat` y `.mod` de la carpeta `parte-2` para ejecutar el modelo de optimización en GLPK.

   - Para ejecutar el modelo, asegúrate de tener GLPK instalado y ejecuta el siguiente comando:
     ```bash
     glpsol -ml part-2.mod -d part-2.dat -o part-2.txt
     ```

   Este comando resolverá el modelo de asignación de pistas utilizando los datos proporcionados en `part-2.dat`. Los resultados se mostrarán en el archivo de salida `part-2.txt`.
