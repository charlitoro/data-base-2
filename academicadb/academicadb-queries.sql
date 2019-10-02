------------------------------------------
-- DATA BASE II --------------------------
------------------------------------------
-- Clase 1: 4/sep/2019
-----
-- Agregar infomacion faltante a la base de datos
alter table decanos alter column nomdecano type varchar(40);
copy decanos from 'D:\postgresql\data-base-2\decanos.csv' with(delimiter ',', header, format 'csv', encoding 'UTF-8');
---------------
-- CONDICIONALES MULTIPLES DEN SQL: case WHEN ... END
-- Permite obtener nuevos atributos basados en otros que cumple unas condiciones determinadas.
-- Permite el manejo de mltiples operaciones
-- Clasificar los estudiantes del departamento de nariño en los estratos BAJO(1,2), MEDIO(3,4), Alto(5,6).
select nomestudiante,estbarrio,nomdepto,case
	when estbarrio in ('1','2') then 'BAJO'
	when estbarrio in ('3','4') then 'MEDIO'
	else 'ALTO'
	end as tipo_estrato
from estudiantes join ciudades on ciudad=codciudad 
	join departamentos on departamento=coddepto
	join barrios on barrio=codbarrio
where lower(nomdepto) like '%ari_o%'
order by tipo_estrato;
----------
-- Visualizar las mujeres de estratos MEDIO del depratamento de nariño
-- que reprobaron lamateria bases de datos, ordenados por nota final desendente.
select nomestudiante, sexestudiante, nommateria, nfinal,case
	when estbarrio in ('1','2') then 'BAJO'
	when estbarrio in ('3','4') then 'MEDIO'
	else 'ALTO'
	end as tipo_estrato, nomdepto
from estudiantes join ciudades on ciudad=codciudad 
	join departamentos on departamento=coddepto
	join barrios on barrio=codbarrio
	join regnotas on codestudiante=estudiante
	join materias on materia=codmateria
where 
	sexestudiante='F' and 
	nommateria like ('%ase%ato%') and
	estado='R'
order by nfinal desc;
--
-- Para realizar esta onsulta de necesita que el tipo_estrato se convierta en atributo.
select * from (t1)
where tipo_estrato='BAJO'
order by ti.nfinal;
-- remplazamos ti por la consulta que genera los tipos de estratos
select * from (select nomestudiante, sexestudiante, nommateria, nfinal,case
		when estbarrio in ('1','2') then 'BAJO'
		when estbarrio in ('3','4') then 'MEDIO'
		else 'ALTO'
		end as tipo_estrato, nomdepto
	from estudiantes join ciudades on ciudad=codciudad 
		join departamentos on departamento=coddepto
		join barrios on barrio=codbarrio
		join regnotas on codestudiante=estudiante
		join materias on materia=codmateria
	where 
		sexestudiante='F' and 
		nommateria like ('%ase%ato%') and
		estado='R') as t1
where tipo_estrato='BAJO'
order by t1.nfinal;
--------------
-- Visualizar los estudiantes de bases de datos que obtuvieron
-- una nota buena, ordenados por nota final descendente.
-- la notas son:
-- 5-      EXCELENTE
-- 4 - 4.9 BUENA
-- 3 - 3.9 REGULAR
-- 2 - 2.9 MALA
-- < 2     PESIMA
-------
-- Obtenemos el select interno con la clasificacion de notas.
select nomestudiante,nommateria,nfinal,case 
	when nfinal=5.0 then 'EXCELENTE'
	when nfinal between 4.0 and 4.9 then 'BUENO'
	when nfinal between 3.0 and 3.9 then 'REGULAR'
	when nfinal between 2.0 and 2.9 then 'MALA'
	else 'PESIMA'
	end as nota_cuali
from estudiantes join regnotas on codestudiante=estudiante
	join materias on materia=codmateria
where nommateria like('%ase%ato%')
order by nfinal;
-------
-- Creamos la tabla virtual utilizando select anidados, donde en el select interno
-- insertamos la consulta categorizada anteriormente.
select * from (select nomestudiante,nommateria,nfinal,case 
		when nfinal=5.0 then 'EXCELENTE'
		when nfinal between 4.0 and 4.9 then 'BUENO'
		when nfinal between 3.0 and 3.9 then 'REGULAR'
		when nfinal between 2.0 and 2.9 then 'MALA'
		else 'PESIMA'
		end as nota_cuali
	from estudiantes join regnotas on codestudiante=estudiante
		join materias on materia=codmateria
	where nommateria like('%ase%ato%')) as t1
where t1.nota_cuali='BUENO'
order by t1.nfinal;
---------------
-- Taller clase
---------------
-- Visualizar los estudiantes de la region pasifica que matricularon a la vez
-- las materias ingenieria de software y programacion orientada a objetos
-- ordenados por ciudad.
-- Las regiones pasificas son:
--   ATLANTICA: Atl�ntico, Bolivar, Cesar, Cordoba, Guajira, Magdalena, San Andr�s y Sucre.
--   ORINOQUIA: Amazonas, Arauca, Casanare, Guainia, Guaviare, Putumayo, Vaupes, y Vichada
--   ORIENTE: Boyac�, Cundinamarca, Norete de Santander, Santander, y Meta
--   CENTRAL: Caldaas, Risaralda, Quindio, Huila, Tolima y Caqueta
--   PACIFICA: Cauca, Choco, Nari�o, y Valle del Cauca
--   BOGOTA: Bogot�
--   ANTIOQUIA: Antioquia

--Solucion Charlie
select *
from (
	select t1.nomestudiante,t1.nomciudad,case
		when lower (t1.nomdepto) like('%tl_ntico%') or 
			 lower (t1.nomdepto) like('%olivar%') or   
			 lower (t1.nomdepto) like('%esar%') or
			 lower (t1.nomdepto) like('%ordoba%') or 
			 lower (t1.nomdepto) like('%uajira%') or
			 lower (t1.nomdepto) like('%agdalena%') or 
			 lower (t1.nomdepto) like('%an%ndr_s%') or
			 lower (t1.nomdepto) like('%ucre%') then 'ATLANTICA'
		when lower (t1.nomdepto) like('%mazonas%') or 
			 lower (t1.nomdepto) like('%rauca%') or   
			 lower (t1.nomdepto) like('%asanare%') or
			 lower (t1.nomdepto) like('%uainia%') or 
			 lower (t1.nomdepto) like('%uaviare%') or
			 lower (t1.nomdepto)like('%utumayo%') or 
			 lower (t1.nomdepto) like('%aupes%') or
			 lower (t1.nomdepto) like('%ichada%') then 'ORINOQUIA'
		when lower (t1.nomdepto) like('%oyac_%') or 
			 lower (t1.nomdepto) like('%undinamarca%') or   
			 lower (t1.nomdepto) like('%orte%antander%') or
			 lower (t1.nomdepto) like('%antander%') or 
			 lower (t1.nomdepto) like('%eta%') then 'ORIENTE'
		when lower (t1.nomdepto) like('%aldas%') or 
			 lower (t1.nomdepto) like('%isaralda%') or   
			 lower (t1.nomdepto) like('%uindio%') or
			 lower (t1.nomdepto) like('%uila%') or 
			 lower (t1.nomdepto) like('%olima%') or 
			 lower (t1.nomdepto) like('%aqueta%') then 'CENTRAL'
		when lower (t1.nomdepto) like('%auca%') or 
			 lower (t1.nomdepto) like('%hoco%') or   
			 lower (t1.nomdepto) like('%ari_o%') or
			 lower (t1.nomdepto) like('%alle%auca%') then 'PASIFICA'
		when lower (t1.nomdepto) like('%ogot_%') then 'BOGOTA'
		when lower (t1.nomdepto) like('%ntioquia%') then 'ANTIOQUIA'
		else 'OTHER'
		end as region
	from (estudiantes join ciudades on ciudad=codciudad
			join departamentos on departamento=coddepto
			join regnotas on codestudiante=estudiante
			join materias on materia=codmateria) as t1
		join (estudiantes join ciudades on ciudad=codciudad
			join departamentos on departamento=coddepto
			join regnotas on codestudiante=estudiante
			join materias on materia=codmateria) as t2
		on t1.codestudiante = t2.codestudiante
	where t1.nommateria like '%rogramaci_n%O_O%' and 
			t2.nommateria like '%oftware%'
) as t3
where region='PASIFICA'
order by t3.nomciudad;
--============================================
-- FUNCIONES AGREGADAS
-- ===========================================
--------------------
-- COUNT(<attribute>)
--------------------
-- Visualizar el numero total de estudiantes
select count(*) as numest
from estudiantes;
------
-- visualizar el numero total de estudiantes del programa de ingenieria de sistemas.
select count(*) as estsistemas
from estudiantes join programas on programa=codprograma
where nomprograma like('%istem%');
------
-- visualizar el numero de estudiantes que reprobaron bases de datos
select 'Reprobados db' as detalle, count(*) as numero
from estudiantes join regnotas on codestudiante=estudiante join materias on materia=codmateria
where nommateria like('%ase%ato%') and estado='R';

-- Visualizar el porcentaje de estudiantes de la ciudad de pasto.
-- 1- calcular el numero total de estudiantes
select count(*) as pastusos
from estudiantes join ciudades on ciudad=codciudad;
-- 2- Calcular el numero de estudiantes pastusos.
select count(*) as pastusos
from estudiantes join ciudades on ciudad=codciudad
where nomciudad like('%asto%');
-- 3- calcular el porcentaje 
select (select count(*)
	from estudiantes join ciudades on ciudad=codciudad
	where nomciudad like('%asto%'))*100/
	(select count(*)
	from estudiantes join ciudades on ciudad=codciudad) 
as porcentaje_pastusos;
------
-- visualizar el numero de hombres y el numero de mujeres de la facultad de ingenieria.
select 'Hombres' as sexo, count(*) as numero
from estudiantes join programas on programa=codprograma
	join facultades on facultad=codfacultad
where nomfacultad like '%genier%' and
	sexestudiante='M'
union
select 'Mujeres' as sexo, count(*) as numero
from estudiantes join programas on programa=codprograma
	join facultades on facultad=codfacultad
where nomfacultad like '%genier%' and
	sexestudiante='F'
order by 1 desc;
-- vosualizar el numero de mujeres y el numero de hombres que 
-- matricularon bases de datos con su respectivo porcentaje
-- ordenado por el mayor porcentaje
select 'Hombres' as sexo, count(*) as numero, (select (select count(*)
	from estudiantes join regnotas on codestudiante=estudiante join materias on materia=codmateria
	where nommateria like('%ase%atos%') and sexestudiante='M')*100/
	(select count(*)
	from estudiantes join regnotas on codestudiante=estudiante join materias on materia=codmateria
	where nommateria like('%ase%atos%')) 
as porcentaje)
from estudiantes join regnotas on codestudiante=estudiante join materias on materia=codmateria
where nommateria like('%ase%atos%') and
	sexestudiante='M'
union
select 'Mujeres' as sexo, count(*) as numero, (select (select count(*)
	from estudiantes join regnotas on codestudiante=estudiante join materias on materia=codmateria
	where nommateria like('%ase%atos%') and sexestudiante='F')*100/
	(select count(*)
	from estudiantes join regnotas on codestudiante=estudiante join materias on materia=codmateria
	where nommateria like('%ase%atos%')) 
as porcentaje)
from estudiantes join regnotas on codestudiante=estudiante join materias on materia=codmateria
where nommateria like('%ase%atos%') and
	sexestudiante='F'
order by 3 desc;
-----
-- count(<att>): no cuenta los valores nulos del atributo
insert into estudiantes (codestudiante,nomestudiante,barrio,ciudad,programa)
	values('4000','Alejandro Useche','101','52001','01');
-----
-- VIsualizar cuantos estudiantes de la ciudad de Pasto hay
 select count(sexestudiante) as men_pasto 
 from estudiantes join ciudades on ciudad=codciudad
 where nomciudad like('%asto%');
/*
 * Anterior a este ejemplo de inserto un estudiante sin su sexo, y al realizar el count(*) cuanta todos los estudiantes
 * en este caso 57 estudiantes de pasto, pero al realizar count(<attribute>) no cuenta los valores nulos encontrados en esa
 * columna, que para este ejemplo de busco por sexo del estudiante y se obtubo 56.
 */
----
-- count(distinct <attribute>) cuantos valores distintos hay en ese atrobuto
-- visualizar de cuantas doferentes ciudades provienen los estudiantes
select count(distinct codciudad) 
from ciudades join estudiantes on codciudad=ciudad;
-- visualizar los valores distintos de sexo
select count(distinct sexestudiante)
from estudiantes;
-- visualizar los valores distintos en la edad
select count(distinct edaestudiante)
from estudiantes;
-- 
------------
-- SUM(attibute): obtener totales
------------
-- visualizar la suma de las edades de las mujeres de pasto 
-- y de los hombres por separado
select 'Women' as sexo, sum(edaestudiante) as sum_age 
from estudiantes join ciudades on ciudad=codciudad
where sexestudiante='F' and nomciudad like('%asto%')
union
select 'Men' as sexo, sum(edaestudiante) as sum_age 
from estudiantes join ciudades on ciudad=codciudad
where sexestudiante='M' and nomciudad like('%asto%')
union
select 'All' as sexo, sum(edaestudiante) as sum_age 
from estudiantes join ciudades on ciudad=codciudad
where nomciudad like('%asto%')
order by sum_age;
--- 2 forma
select 'Women' as sexo, sum(edaestudiante) as sum_age 
from estudiantes join ciudades on ciudad=codciudad
where sexestudiante='F' and nomciudad like('%asto%')
	union
select 'Men' as sexo, sum(edaestudiante) as sum_age 
from estudiantes join ciudades on ciudad=codciudad
where sexestudiante='M' and nomciudad like('%asto%')
	union
select 'All' as sexo, sum(t1.sum_age)
from (select 'Women' as sexo, sum(edaestudiante) as sum_age 
	from estudiantes join ciudades on ciudad=codciudad
	where sexestudiante='F' and nomciudad like('%asto%')
	union
	select 'Men' as sexo, sum(edaestudiante) as sum_age 
	from estudiantes join ciudades on ciudad=codciudad
	where sexestudiante='M' and nomciudad like('%asto%')) as t1
order by sum_age;
----
-- visualizar el numero de estudiantes del programa de 
-- ingenieria de sistemas  y el numero de estudiantes
-- de ingenieria Agroforestal que matricularon based de datos y totalizar
select 'Ing Sistemas' as programa, count(nomestudiante) as num
from estudiantes join regnotas on codestudiante=estudiante 
	join materias on materia=codmateria
	join programas on programa=codprograma
where nomprograma like('%istemas%') and nommateria like('%ase%atos%')
union
select 'Ing Electronica' as programa, count(nomestudiante) as num
from estudiantes join regnotas on codestudiante=estudiante 
	join materias on materia=codmateria
	join programas on programa=codprograma
where nomprograma like('%groforest%') and nommateria like('%ase%atos%')
union
select 'All' as programa, sum(t1.num)
from (select 'Ing Sistemas' as programa, count(nomestudiante) as num
	from estudiantes join regnotas on codestudiante=estudiante 
		join materias on materia=codmateria
		join programas on programa=codprograma
	where nomprograma like('%istemas%') and nommateria like('%ase%atos%')
	union
	select 'Ing Agroforestal' as programa, count(nomestudiante) as num
	from estudiantes join regnotas on codestudiante=estudiante 
		join materias on materia=codmateria
		join programas on programa=codprograma
	where nomprograma like('%groforest%') and nommateria like('%ase%atos%')) as t1
order by 2;
----------------------------------
--
-- visualizar la nota promedio en la materia de bases de datos de los estudiantes
-- de los estudiantes de ingenieria de sistemas
select round(sum(nfinal)/count(*), 2) as npromedio
from estudiantes join regnotas on codestudiante=estudiante
		join materias on materia=codmateria 
		join programas on programa=codprograma
where nomprograma like '%istem%' and 
	nommateria like '%ase%atos%';
----------
-- AVG(<attri>): Funcion que calcula el promedio de el valor del atrobuto
----------
-- visualizar la nota promedio en la materia de bases de datos de los estudiantes
-- de los estudiantes de ingenieria de sistemas
select round(avg(nfinal), 2) as npromedio
from estudiantes join regnotas on codestudiante=estudiante
		join materias on materia=codmateria 
		join programas on programa=codprograma
where nomprograma like '%istem%' and 
	nommateria like '%ase%atos%';
----
-- visualizar el numero de mujeres y su edad promedio y de  igual manera
-- el numero de honbres y su edad promedio de todos los estudiantes
-- de la ciudad de Pasto y totalizar
select 'Mujeres' as sexo, round(avg(edaestudiante)) as nedad
from estudiantes join ciudades on ciudad=codciudad
where nomciudad like '%asto%' and sexestudiante='F'
union 
select 'Hombres' as sexo, round(avg(edaestudiante)) as nedad
from estudiantes join ciudades on ciudad=codciudad
where nomciudad like '%asto%' and sexestudiante='M'
union
select 'Total' as sexo, round(avg(edaestudiante)) as nedad
from estudiantes join ciudades on ciudad=codciudad
where nomciudad like '%asto%';
---------------
-- MAX(<attri>) y min(<attri>): Permiten obtener el valor maximo y el valor minimo
-- de un atributo numerico.
---------------
-- Visualizar cual fue la nota maxima y la nota minima de los estudiantes de ing de sistemas 
-- en la materia bases de datos.
select 'Maximo' as category, max(nfinal) as value 
from estudiantes join regnotas on codestudiante=estudiante
	join materias on materia=codmateria join programas on programa=codprograma
where nommateria like '%ase%atos%' and nomprograma like '%istem%'
union
select 'Minimo' as category, min(nfinal) as value 
from estudiantes join regnotas on codestudiante=estudiante
	join materias on materia=codmateria join programas on programa=codprograma
where nommateria like '%ase%atos%' and nomprograma like '%istem%';
----
-- visalizar el numero de estudiantes , la nota promedio, la nota maxima y la nota minima
-- del programa de ing sistemas
select count(distinct estudiante) as num_estu, round(avg(nfinal), 2) as nfinal, max(nfinal) as maximo, min(nfinal) as minimo
from estudiantes join programas on programa=codprograma 
	join regnotas on codestudiante=estudiante
where nomprograma like '%istem%';
-------------------------
-- Agrupamiento con funciones agregadas
-------------------------
/*
 * GROUP BY(<attr>) permite obtener 
 * Todo atributo que este acompa�ado de una funciona agregada debe ir 
 * en la clausula group by y no viceversa, es decir, todo atributo 
 * que va en el group by no necesariamente debe estar en selest
 */
-- 
select nomprograma, round(avg(nfinal), 2)
from estudiantes join programas on programa=codprograma
	join regnotas on codestudiante=estudiante
group by nomprograma;
--
--visualizar el numero de estudiantes, la nota promedio, la nota maxima y la nota minima por programa
-- ordenados por nota promedio dese
select nomprograma, count(distinct codestudiante) as num_estu, round(avg(nfinal), 2) as n_promedio, max(nfinal) as maximo, min(nfinal) as minimo
from estudiantes join programas on programa=codprograma 
	join regnotas on codestudiante=estudiante
group by nomprograma
order by 1 desc;
----
--visualizar el numero de estudiantes, la nota promedio, la nota maxima y la nota minima por programa y sexo
-- ordenados por nota promedio dese
select nomprograma, sexestudiante as sexo, count(distinct codestudiante) as num_estu, round(avg(nfinal), 2) as n_promedio, max(nfinal) as maximo, min(nfinal) as minimo
from estudiantes join programas on programa=codprograma 
	join regnotas on codestudiante=estudiante
group by nomprograma, sexo
order by 1,2 desc;