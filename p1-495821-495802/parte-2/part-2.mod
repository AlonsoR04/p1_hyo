
#########################################################################################################
# SETS
#########################################################################################################

set AVIONES;

set PISTAS_ATERRIZAJE;

set SLOTS_ATERRIZAJE;

set SLOTS_CONSECUTIVOS;

#########################################################################################################
# VARIABLES
#########################################################################################################

################################################# PARTE 1 #################################################


# Devuelve el número de billetes de cada tipo para cada avión
# Billetes estandar
var x{AVIONES} integer, >= 0;
# Billetes leisure+
var y{AVIONES} integer, >= 0;
# Billetes business+
var z{AVIONES} integer, >= 0;

################################################# PARTE 2 #################################################

# Devuelve 1 si el avión i está asignado para la pista j en el slot k; 0 si no lo está
var asignar_avion_slot_pista{i in AVIONES, j in PISTAS_ATERRIZAJE, k in SLOTS_ATERRIZAJE}, binary;

#########################################################################################################
# PARÁMETROS
#########################################################################################################

################################################# PARTE 1 #################################################

# Precios de los billetes
param precio_estandar;
param precio_leisure;
param precio_business;

# Número de asientos por avión
param max_asientos{AVIONES};

# Capacidad máxima por avión
param capacidad_maxima{AVIONES};

# Peso de cada equipaje
param equipaje_estandar;
param equipaje_leisure;
param equipaje_business;

# Mínimo de billetes leisure+ vendidos
param min_leisure;

# Mínimo de billeres business+ vendidos
param min_business;

# Porcentaje de billetes estandar respecto al total
param porcentaje_billetes_estandar;

################################################# PARTE 2 #################################################

# Tiempos de aterrizaje para cada slot
param TIEMPOS_ATERRIZAJE{i in PISTAS_ATERRIZAJE, j in SLOTS_ATERRIZAJE};
# Slots válidos
param SLOTS_ATERRIZAJE_VALIDOS{i in PISTAS_ATERRIZAJE, j in SLOTS_ATERRIZAJE};
# Hora de aterrizaje programada para cada avión
param HORA_ATERRIZAJE_PROGRAMADA{i in AVIONES};
# Hora límite para cada avión
param HORA_ATERRIZAJE_LIMITE{i in AVIONES};
# Coste de llegada para cada avión
param LLEGADAS_AVION_COSTE{i in AVIONES};
# Slots consecutivos
param CONSECUTIVOS{i in SLOTS_CONSECUTIVOS, j in SLOTS_ATERRIZAJE};

#########################################################################################################
# FUNCIÓN OBJETIVO
#########################################################################################################

maximize BENEFICIO:
    (sum{i in AVIONES} (precio_estandar * x[i] + precio_leisure * y[i] + precio_business * z[i])) - (sum {i in AVIONES, j in PISTAS_ATERRIZAJE, k in SLOTS_ATERRIZAJE} ((asignar_avion_slot_pista[i,j,k] * (TIEMPOS_ATERRIZAJE[j,k] - HORA_ATERRIZAJE_PROGRAMADA[i])) * LLEGADAS_AVION_COSTE[i]));

#########################################################################################################
# RESTRICCIONES
#########################################################################################################

################################################# PARTE 1 #################################################

# No se pueden vender más billetes que el número de asientos disponibles en el avión
s.t. max_asientos_avion{i in AVIONES}:
    (x[i] + y[i] + z[i]) - max_asientos[i] <= 0;

# No se puede superar en ningún caso la capacidad máxima de cada avión.
s.t. max_capacidad_avion{i in AVIONES}:
    (equipaje_estandar * x[i] + equipaje_leisure * y[i] + equipaje_business * z[i]) - capacidad_maxima[i] <= 0;

# Para cada avión se deben ofertar mínimo 20 billetes leisure+
s.t. min_leisure_avion{i in AVIONES}:
    y[i] - min_leisure >= 0;

# Para cada avión se deben ofertar mínimo 10 billetes business+
s.t. min_business_avion{i in AVIONES}:
    z[i] - min_business >= 0;

# El número de billetes estándar total debe ser al menos un 60% de todos los billetes que se ofertan
s.t. porcentaje_estandar:
    (sum{i in AVIONES} x[i]) - (porcentaje_billetes_estandar * sum{i in AVIONES} (x[i] + y[i] + z[i])) >= 0;

################################################# PARTE 2 #################################################

# Todos los aviones deben tener asignado solamente un slot de aterrizaje
s.t. un_solo_slot_por_avion {i in AVIONES}:
    sum{j in PISTAS_ATERRIZAJE, k in SLOTS_ATERRIZAJE} asignar_avion_slot_pista[i,j,k] = 1;
    # Comprobamos los slots que se pueden asignar para cada avión
    # Si da 0: el avión no tiene ningún slot asignado -> Incorrecto
    # Si da 1: el avión tiene un slot asignado -> Correcto

# Cada slot de aterrizaje debe estar asignado como máximo para un avión
s.t. un_solo_avion_por_slot {j in PISTAS_ATERRIZAJE, k in SLOTS_ATERRIZAJE}:
    sum{i in AVIONES} asignar_avion_slot_pista[i,j,k] <= 1;
    # Comprobamos los aviones que se pueden asignar para cada slot
    # Si da 0: ningún avión asignado -> Correcto
    # Si da 1: hay un avión asignado -> Correcto
    # Si da más de 1: hay más de un avión -> Incorrecto
    
# El slot que se asigna a un avión debe estar disponible
s.t. solo_un_slot_valido{i in AVIONES, j in PISTAS_ATERRIZAJE, k in SLOTS_ATERRIZAJE}:
    asignar_avion_slot_pista[i,j,k] - SLOTS_ATERRIZAJE_VALIDOS[j,k] <= 0;
    # Si da -1: el avión no está asignado a un slot de aterrizaje válido -> Correcto
    # Si da 0: el avión está asignado a un slot de aterrizaje válido -> Correcto
    # Si da 1: el avión está asignado a un slot de aterrizaje no válido -> Incorrecto

# El inicio de slot de aterrizaje debe ser igual o posterior a la hora de llegada de aterrizaje
s.t. inicio_slot_aterrizaje_respecto_llegada{i in AVIONES, j in PISTAS_ATERRIZAJE, k in SLOTS_ATERRIZAJE}:
    asignar_avion_slot_pista[i,j,k] * (TIEMPOS_ATERRIZAJE[j,k] - HORA_ATERRIZAJE_PROGRAMADA[i]) >= 0;
    # Para cada asignación de aterrizaje restamos el tiempo de inicio del slot y el tiempo de llegada programada
    # Si la resta es >= 0: la hora de inicio del slot es igual o superior a la hora de llegada programada -> Correcto    
    # Si la resta es < 0: la hora de llegada será más tarde que la hora de inicio del slot -> Incorrecto

# El inicio del slot de aterrizaje debe ser igual o anterior a la hora límite de aterrizaje del avion.
s.t. inicio_slot_aterrizaje_respecto_limite{i in AVIONES, j in PISTAS_ATERRIZAJE, k in SLOTS_ATERRIZAJE}:
    asignar_avion_slot_pista[i,j,k] * (TIEMPOS_ATERRIZAJE[j,k] - HORA_ATERRIZAJE_LIMITE[i]) <= 0;
    # Para cada asignación de aterrizaje restamos el tiempo de finalización del slot y el tiempo límite de llegada del avión
    # Si la resta es >= 0: la hora de inicio del slot es igual o inferior al tiempo límite de la llegada del avión -> Correcto
    # Si la resta es < 0: la hora de inicio del slot es superior al tiempo límite de la llegada del avión -> Incorrecto

# Por cuestiones de seguridad, no se pueden asignar dos slots consecutivos en la misma pista.
s.t. slots_consecutivos_misma_pista{j in PISTAS_ATERRIZAJE, h in SLOTS_CONSECUTIVOS}:
    sum{i in AVIONES, k in SLOTS_ATERRIZAJE} asignar_avion_slot_pista[i,j,k] * CONSECUTIVOS[h,k] <= 1;
    # Para cada asignación de aterrizaje, comprobamos que el slot no sea consecutivo a otro asignado
    # Si la resta <= 1: los slots de aterrizaje asignados no son consecutivos -> Correcto
    # Si la resta > 1: los slots de aterrizaje asignados son consecutivos -> Incorrecto

solve;

end;

# Comando ejecución --> glpsol -m part-2.mod -d part-2.dat -o part-2.txt