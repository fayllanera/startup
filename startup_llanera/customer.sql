create table customer (
   id VARCHAR NOT NULL,
   name VARCHAR,
   surname VARCHAR,
   email VARCHAR,
   phonenum bigint
);

create or replace function newcustomer(par_id bigint, par_name VARCHAR, par_surname VARCHAR, par_email VARCHAR, par_phonenum bigint) returns text as
$$
  declare
    loc_id text;
    loc_res text;
  begin
     select into loc_id id from customer where id = par_id;
     if loc_id isnull then

       insert into customer(id, name, surname, email, phonenum) values (par_id, par_name, par_surname, par_email, par_phonenum);
       loc_res = 'OK';

     else
       loc_res = 'ID EXISTED';  
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

--select newcustomer(1, 'Avery','Juan', 'averyjuan@gmail.com', 09105442383); 
--select newcustomer(2, 'Tom','Sawyer', 'tomsawyer@gmail.com', 09106553494);

create or replace function getcustomer(out bigint, out VARCHAR, out VARCHAR, out VARCHAR, out bigint) returns setof record as
$$
   select id, name, surname, email, phonenum from customer;

$$
 language 'sql';
 
--select * from getcustomer();

create or replace function getcustomerid(in par_id bigint, out VARCHAR, out VARCHAR, out VARCHAR, out bigint) returns setof record as
$$
   select name, surname, email, phonenum from customer where id = par_id;

$$
 language 'sql';
 
--select * from getcustomerid(2);

create table userpassC (
    email VARCHAR PRIMARY KEY,
    password VARCHAR
);


insert into userpassC (email, password) values ('customer@gmail.com', 'customerlagiko');

create or replace function getpassword(par_email text) returns text as
$$
  declare
    loc_password text;
  begin
     select into loc_password password from userpassC where email = par_email;
     if loc_password isnull then
       loc_password = 'null';
     end if;
     return loc_password;
 end;
$$
 language 'plpgsql';

select getpassword('customerlagiko');

