%Punto 1:
cuchillo(juan, palo).
cuchillo(pedro, palo).
cuchillo(ana, metal).
cuchillo(oscar, metal).

profesion(ana, costurera).
profesion(juan, herrero).
profesion(pedro, carpintero).
profesion(oscar, herrero).

%a)
enCasaDeHerreroCuchilloDePalo(Persona):-
    profesion(Persona, herrero),
    cuchillo(Persona, palo).

%b)
enCasaDeHerreroCuchilloDePaloB:-
    forall(profesion(Persona,herrero), cuchillo(Persona,palo)).
    
    

%c)
enCasaDeHerreroCuchilloDePaloC:-
    cantidadHerreros(Herreros,Cantidad),
    cantidadHerrerosConCuchilloDePalo(HerrerosConPalo, CantidadQueCumple),
    Limite is Cantidad / 2,
    CantidadQueCumple >  Limite.

cantidadHerreros(Personas, Cantidad):-
    findall(Persona, profesion(Persona,herrero), Personas),
    length(Personas, Cantidad).

cantidadHerrerosConCuchilloDePalo(Herreros, Cantidad):-
    findall(HerreroConCuchilloDePalo, enCasaDeHerreroCuchilloDePalo(HerreroConCuchilloDePalo), HerrerosConCuchilloDePalo),
    length(HerrerosConCuchilloDePalo,Cantidad).

%Punto 2:
anda(julia , daniel).
anda(julia , jorge).
anda(julia , raul).
anda(olga , jose).
anda(olga , claudio).
anda(olga , felipe).
anda(olga , carlos).
parece(daniel, buenaGente).
parece(jorge, buenaGente).
parece(raul, malandra).
parece(jose, ingeniero).
parece(claudio, periodista).
parece(felipe, ingeniero).
parece(carlos, contador).

cantCaracteristica(Persona,Caracteristica,Cantidad) :-
	parece(_,Caracteristica),
	anda(Persona,_ ),
	findall(Amigo,(anda(Persona,Amigo),parece(Amigo,Caracteristica)),Amigos),
	length(Amigos,Cantidad).


quienEres(Persona,Caracteristica) :-
	cantCaracteristica(Persona,Caracteristica,Cant1),
	forall(cantCaracteristica(Persona,_,Cant2), Cant1 >= Cant2).

%Punto 3:

%intenta(Persona, Tarea, Resultado, Fecha)
intenta(juan, paradigmas, 2, fecha(20,2,2004)).
intenta(juan, paradigmas, 2, fecha(20,2,2005)).
intenta(juan, paradigmas, 4, fecha(20,12,2005)).

intenta(pedro, romeoYJulieta, risas, fecha(20,2,2010)).
intenta(pedro, romeoYJulieta, llantos, fecha(20,2,2011)).


intenta(cachito, senador, [propuestas,honestidad,apoyoDeLosMedios, equipo, fortuna], fecha(27,10,2013)).

%exito(Tarea, Requisito).
exito( paradigmas, materia(4)).
exito(romeoYJulieta, teatro(drama,llantos)).
exito(laJaulaDeLasLocas, teatro(comedia, risas)).
exito(senador, politico([propuestas, honestidad, equipo])).
exito(diputado, politico([propuestas, apoyoDeLosMedios])).


laTerceraEsLaVencida(Persona, Tarea):-
    intenta(Persona,Tarea,_,_),
    tercerIntento(Persona, Tarea, TercerIntento),
    exitosoIntento(Tarea,TercerIntento).



tercerIntento(Persona, Tarea, TercerIntento):-
    findall(Intento, intentoDeTarea(Persona, Tarea, Intento), Intentos),
    nth0(2, Intentos, TercerIntento).

intentoDeTarea(Persona, Tarea, Resultado):-
    intenta(Persona, Tarea, Resultado, _).

exitosoIntento(Tarea, Resultado):-
    exito(Tarea, Requisito),
    exitoSegunRequisitoDeTarea(Requisito, Resultado).

exitoSegunRequisitoDeTarea(materia(NotaMinima), Resultado):-
    Resultado >= NotaMinima.
exitoSegunRequisitoDeTarea(teatro(_,EmocionEsperado), EmocionEsperado).
exitoSegunRequisitoDeTarea(politico(CaracteristicasEsperadas), CaracteristicasPropias):-
    forall(member(CaracteristicaEsperada, CaracteristicasEsperadas), member(CaracteristicaEsperada, CaracteristicasPropias)).

laTerceraEsLaVencida(Persona,Tarea):-
	tercerIntento(Persona,Tarea,Resultado),
	intentoExitoso(Tarea,Resultado).
% No hace falta verificar que los dos primero intentos no fueron
% exitosos, ya que haberlo sido no habría tercer intento.

intentoExitoso(Tarea,Resultado):-
	exito(Tarea,ResultadoEsperado),
	esExitoso(Resultado,ResultadoEsperado).

esExitoso(Nota1,materia(Nota2)):-
	Nota1 >= Nota2.
esExitoso(Reaccion,teatro(_,Reaccion)).
esExitoso(Propiedades,Requisitos):-
	forall(member(Propiedad,Requisitos),member(Propiedad,Propiedades)).

%Teniendo en cuenta las fechas.
tercerIntento(Persona,Tarea,Resultado):-
	intenta(Persona,Tarea,Resultado,Fecha1),
	intenta(Persona,Tarea,_,Fecha2),
	intenta(Persona,Tarea,_,Fecha3),
	esPosterior(Fecha1,Fecha2),
	esPosterior(Fecha2,Fecha3).

esPosterior(fecha(D1,M,A),fecha(D2,M,A)) :- D1>D2.
esPosterior(fecha(_,M1,A),fecha(_,M2,A)) :- M1>M2.

%Punto 4:
