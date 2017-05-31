create table diner (
   id VARCHAR NOT NULL,
   dinername VARCHAR,
   address VARCHAR,
   email VARCHAR,
   phonenum bigint
);

create or replace function newdiner(par_id bigint, par_dinername VARCHAR, par_address VARCHAR,, par_email VARCHAR, par_phonenum bigint) returns text as
$$
  declare
    loc_id text;
    loc_res text;
  begin
     select into loc_id id from diner where id = par_id;
     if loc_id isnull then

       insert into diner (id, dinername, address, email, phonenum) values (par_id, par_dinername, par_address, par_email, par_phonenum);
       loc_res = 'OK';

     else
       loc_res = 'ID EXISTED';  
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

--select newdiner(01, 'Delecta', 'Palao, Iligan City', 'delectadiner@gmail.com', 09105442383); 
--select newdiner(02, 'Downtown', 'Iligan City', 'downtowniligan@gmail.com', 09106553494);

create or replace function getdiner(out bigint, out VARCHAR, out VARCHAR, out VARCHAR, out bigint) returns setof record as
$$
   select id, dinername, address, email, phonenum from diner;

$$
 language 'sql';
 
--select * from getdiner();

create or replace function getdinerid(in par_id bigint, out VARCHAR, out VARCHAR, out VARCHAR, out bigint) returns setof record as
$$
   select dinername, address, email, phonenum from diner where id = par_id;

$$
 language 'sql';
 
--select * from getdinerid(2);

create table userpassD (
    email text primary key,
    password text
);


insert into userpassD (email, password) values ('diner@gmail.com', 'mangaonta');

create or replace function getpassword(par_email text) returns text as
$$
  declare
    loc_password text;
  begin
     select into loc_password password from userpassD where email = par_email;
     if loc_password isnull then
       loc_password = 'null';
     end if;
     return loc_password;
 end;
$$
 language 'plpgsql';

select getpassword('mangaonta');

