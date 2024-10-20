
#########################################################################################################
# SETS
#########################################################################################################

set AVIONES;

#########################################################################################################
# VARIABLES
#########################################################################################################

# Billetes estándar por avión
var x{AVIONES} integer, >= 0;
# Billetes leisure+ por avión
var y{AVIONES} integer, >= 0;
# Billetes business+ por avión
var z{AVIONES} integer, >= 0;

#########################################################################################################
# PARÁMETROS
#########################################################################################################

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

#########################################################################################################
# FUNCIÓN OBJETIVO
#########################################################################################################

maximize PROFIT:
    sum{i in AVIONES} (precio_estandar * x[i] + precio_leisure * y[i] + precio_business * z[i]);

#########################################################################################################
# RESTRICCIONES
#########################################################################################################

# Restricción de asientos por avión
s.t. max_asientos_avion{i in AVIONES}:
    x[i] + y[i] + z[i] <= max_asientos[i];

# Restricción de capacidad por avión
s.t. max_capacidad_avion{i in AVIONES}:
    equipaje_estandar * x[i] + equipaje_leisure * y[i] + equipaje_business * z[i] <= capacidad_maxima[i];

# Mínimo de billetes leisure+ por avión
s.t. min_leisure_avion{i in AVIONES}:
    y[i] >= min_leisure;

# Mínimo de billetes business+ por avión
s.t. min_business_avion{i in AVIONES}:
    z[i] >= min_business;

# Porcentaje mínimo de billetes estándar con respecto al total
s.t. porcentaje_estandar:
    sum{i in AVIONES} x[i] >= 0.6 * sum{i in AVIONES} (x[i] + y[i] + z[i]);

solve;

end;

# glpsol -m p1.mod -d p1.dat -o p1.txt