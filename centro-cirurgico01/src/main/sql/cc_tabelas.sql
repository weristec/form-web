create table cc_usuario(
us_id serial,
us_nome varchar(30),
us_email varchar,
us_senha varchar(12));

create table cc_painel(
pa_id serial,
pa_nm_paciente varchar(30),
pa_status varchar(20),
pa_local varchar,
pa_in_previsto varchar(10),
pa_in_cirurgia varchar(10),
pa_fi_cirurgia varchar(10),
pa_sa_prevista varchar(10));

insert into cc_usuario(us_nome, us_email, us_senha) values('Welton Ribas', 'ribas@gmail.com','2020'); 

insert into cc_painel(pa_nm_paciente, pa_status, pa_local, pa_in_previsto, pa_in_cirurgia, pa_fi_cirurgia,
pa_sa_prevista) values('Malcon Leal', 'Pré-operatório','DF-Star','10:30','10:30','18:30','00:30');