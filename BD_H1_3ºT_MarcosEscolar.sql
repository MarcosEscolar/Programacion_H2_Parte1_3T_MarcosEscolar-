create or replace type tsocio as object (
    nif     varchar2(10),
    nombre  varchar2(50),
    tlf     varchar2(15),

    member function getsocio return varchar2
);
/

create or replace type body tsocio as 
    member function getsocio return varchar2 is
    begin
        return 'nif: ' || nif || ', nombre: ' || nombre || ', telefono: ' || tlf;
    end;
end;
/

create table socio of tsocio (
   nif primary key,
   nombre not null,
   tlf unique
);

-- Aqui use esta funcion desde SYS, ALTER USER MARCOSESCOLAR QUOTA UNLIMITED ON USERS; 
-- Para tener permisos y poder insertar datos

insert into Socio values (
   tSocio('4523223F', 'Antonio Escolar', '672834256')
);

INSERT INTO Socio VALUES (
   tSocio('4125675N', 'Carmen Marcelo', '6723988923')
);


create or replace type tlibro as object (
    Referencia    varchar2(13), 
    titulo        varchar2(100),      
    autor         varchar2(50),     
    fechaprestamo date,              
    miembro       varchar2(10),  
    
    member function getlibro return varchar2,
    member function diasprestamo return number,
    member function diasmulta return number
);
/



create or replace type body tlibro as
    member function getlibro return varchar2 is
    begin
        return 'Referencia: ' || referencia || ', titulo: ' || titulo || ', autor: ' || autor || ', miembro: ' || miembro;
    end;
    
    member function diasprestamo return number is
    begin
        -- obtiene los dias de prestamo restando la fecha actual y la fecha del prestamo
        return sysdate - fechaprestamo;
    end;
    
    member function diasmulta return number is
    begin
        -- calcula los dias de multa 
        if diasprestamo > 7 then
            return diasprestamo - 7;
        else
            return 0;
        end if;
    end;
end;
/
    

create table libro of tlibro (
    Referencia primary key,
    miembro references socio(nif)
);


INSERT INTO Libro VALUES (
    tLibro('ISBN12345678', 'Arbol de la ciencia', 'Pio Baroja', TO_DATE('01-04-2025', 'DD-MM-YYYY'), '4523223F')
);

INSERT INTO Libro VALUES (
    tLibro('ISBN87654321', 'Don Quijote de la Mancha', 'Miguel de Cervantes', TO_DATE('28-03-2025', 'DD-MM-YYYY'), '4125675N')
);

INSERT INTO Libro VALUES (
    tLibro('ISBN45678912', 'Fuente Ovejuna', 'Lope de Vega', TO_DATE('05-04-2025', 'DD-MM-YYYY'), '4523223F')
);

INSERT INTO Libro VALUES (
    tLibro('ISBN98765432', 'Rebelion en la granja', 'George Orwell', TO_DATE('25-02-2025', 'DD-MM-YYYY'), '4125675N')
);



-- SELECTS
-- 1. Objetivo: ver la informacion de todos los libros de la base de datos 
select l.getlibro() from Libro l;

-- 2. Objetivo: ver los prestamos que tienen multa
select titulo, l.diasmulta() as dias_multa 
from Libro l 
where l.diasmulta() > 0;

-- 3. Objetivo: ver el tiempo de préstamo de cada libro 
select titulo, l.diasprestamo() as dias_de_prestamo from Libro l;

-- 4. Objetivo: ver la informacion de los socios que hay en la base de datos
select nif, nombre, tlf from Socio;

-- 5. Objetivo: ver que socio tiene prestado cada libro
select l.titulo, l.autor, s.nombre 
from Libro l
join Socio s on l.miembro = s.nif;

-- 6. Objetivo ver los todos los autores que hay en la biblioteca
select autor from libro;

-- 7. Objetivo: ver todos los libros que hay en la bibliotca
select titulo from libro;


-- 8. Objetivo: ver el historial de prestmos
select titulo, fechaprestamo from libro order by fechaprestamo;




