# Data Base II

* ***Email curso:*** sisbd2udenar@gmail.com
* ***Email Profe:*** siritimar@gmail.com

## Proceso de Normalización

La normalizacion es un proceso de refinamiento por anomalias de diseño por la no deteccion en el momento de diseño, que puede ser por insercion, modificacion,
el __Objetivo__ es eliminar estas anomalis que se presentan, para esto necesitamos saber los atributos de esa relacion, de quien estan dependiendo.

___Dependencia funcional___, todos los atributos de una realacion deben depender funcionalmente de la llave primaria.

>* __Ejemplo:__ si conosco el codigo de un estudiante con este puedo conoser a todos los campos o atributos de dicho estudiante, pero si existen mas de un registro entonces estos datos no dependen del codigo del estudiante.
> __Entonces__: cedula -> nombre, que nos dice que nombre depende funcionalmente de cedula, donde cedula es un determinante.

## ___Anomalias en una relacion___

Es una falla que puede ser de 3 tipos:

* Insercion
* Modiifcacion
* Eliminacion

### __Anomalia de inserciion__

para poder conocer el valor de un atributo se debe insertar una tupla o un registro.

### __Anomalia de Modificacion__

Si se modifica el valor de un atributo es posible que no se modifique o actulicen en otras tuplas con similares caracteristicas. En otras palabras, si un valor de un atributo esta presente en varios registros pero no por medio de un identificador, en ese caso cuando se intente modificar un valor de esos comunes, no se va a editar en los demas registros.

### __Anomalias de Eliminacion__

Cuando al eliminar una tupla referente a los valores de ciertos atributos. 

## ___Solucion de Anomalias___

Se utiliz el pricipio __divide y venceras__, que consiste en dividir de acuerdo a las dependencias funcionales, que atributo determina a quien, y si hay un atributo que no es determinado por el __id__ es señal que sebe salir a ser una llave primaria por medio de una realcion.

### __Formas normales__

Son reglas o estado en la cual debe tener una realcion para que se encuentre en una forma normal. Existen las siguentes formas normales:

* __1FN__: Una relacion esta en primera forma normal si es una relación y atributos atomicos, y para cumplir esta forma se debe eliminar la no atomisidad o convertir ese atributo no atomico como llave compuesta con le primary key.
* __2FN__: Para que una relacion debe estan en _1FN_ y que todos los atributos deben depender totalmente de la llave primaria. Toda relacion que tiene una llave primaria sencilla ya se encuentra en _2FN_, pero cunado hay llaves primarias compuestas puede que la dependencia sea parcial
* __3FN__:  Debe etar en segunda forma normal, ademas no tiene __dependencias transitivas__, si a=b y b=c entones a=c, y para solucionar eliminamos la dependencias transitiva.
* __BCFN (Boyce-Codd Forma Normal)__: En algunos casos llamada 4FN, una realacion esta en esta forma si esta en 3FN y todos los determinante son llave primaria o llave candidata
* __4FN__:
* __5FN__:

> NOTA: Proyecto final normalización base de datos icfes pruebas saber pro. grupos de maximo 3 personas, Revisar documentos almacenados en la nube.

## Condicionales multiples: WHEN ... END

Permite obtener nuevos atributos basados en otros que cumple unas condiciones determinadas. Permite el manejo de mltiples operaciones.
En el momento de realizar una condicion __WHERE__, no podemos utilizar el atributo generado por medio del __WHEN ... END__ puesto que este atributo creado no esta materializado en la base de dato. Para solucionar este tipo de inconvenientes debemos crear una tabla virtual, en pocas palabras realizar selects internos renombrandolo con __AS__, de esta forma podremos acceder a este atributo creado.

## Funciones Agregadas

Son funciones muy utilizadas para la estadistica, que nos permite realizar conteos, promedio, maximos, minimos  a partir de la base de datos. Estas funciones van solas en la claudaula SELECT, no la acompaña ningun atributo.

* __count(*)__: Cuenta el numero de regiatros de tuplas que cumplen una condicion determinada, incluyendo los valores NULL.
* __count(\<attribute>)__: Es similar al count anterior pero no cuenta los valores NULL.
* __sum(\<attribute>)__: totaliza los valore numericos de un atributo.
* __avg(\<attribute>)__: Obtiene el valor promedio del atributo numerico.
* __max(\<attribute>)__: Obtiene el valor maximo del atributo numerico.
* __min(\<attribute>)__: Obtiene el valor minimo del atributo numerico.

## Restricciones en funciones agregadas

Son restricciones sobre las funciones agregadas y esta ba en la clausula HAVING \<restriction\>

## Vistas

Rs una consulta que se mantiene como ojeto de la base de datos y que se comporta como si fuera una tabla.
Una vista permite realizar consultas deacuerdo al codigo con la que se la definio, pero no permite ni insercion, actualizacion
Puede estar compuesta por una o varias tablas.
Una vista entonces es realente una tabla virtual.
Los valores de una vista se actializan cuando se actualizan los datos en las tablas que la generaron

## Reglas (Rules)

Permiten realizar operaciones de insercion, eliminacion o atualizacion de dato, inmediatamente se produsca el evento que las llame. Las reglas son codigo sql ejecutable mediante los evetos:

* on insert \<tabla>
* on update \<tabla>
* on delete \<tabla>

Si la regla y el evento se ejecuta sobre una misma tabla entonces el evento deben ser diferente a la operacion que realiza la regla.
Si la regla o el evento se ejecuta sobre diferentes \<tablas>
entonces el evento y la operacion de la regla pueen ser iguales

### Reglas sobre vistas

Sobre la vista no es posible insertar in nuevo atrobutos, para solucionar este problema creamos una regla donde primero insertamos en la tabla de la cual se deriva la vista y esta se ejecutara entes de hacer el incert en la vista lo cual implic que ese valor ya existe y por tanto ya es posible insertar en la vista.
