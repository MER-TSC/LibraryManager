create table libraries(
library_id number(8) constraint library_id_pk primary key,
library_name VARCHAR2(100) constraint library_name_nn not null,
library_address varchar2(25) constraint library_address_nn not null);

create table users(
username varchar2(25) constraint user_username_pk primary key,
password varchar2(60) constraint user_pwd_chk check(length(password)>=8),
recovery_question varchar2(50) constraint user_recquest_nn not null,
recovery_answer varchar2(50) constraint user_recanswr_nn not null);

create table authors(
author_id number(8) constraint author_id_pk primary key,
last_name varchar2(20) constraint author_ln_nn NOT NULL,
first_name varchar2(20) constraint author_fn_nn NOT NULL,
nationality varchar2(20));

create table books(
ISBN number(8) constraint book_ISBN_pk primary key,
title varchar2(30) constraint book_title_nn not null,
theme varchar2(25) constraint book_theme_nn not null);

create table accounts(
account_id number(8) constraint account_id_pk primary key,
state  number(1) default '0' constraint account_state_chk check(state in('0','1')),
copies_no number(8) constraint account_copiesno_chk check (copies_no <=3));

create table publications(
ISBN number(8),
author_id number(8),
constraint publications_id_pk primary key (isbn,author_id),
constraint publications_isbn_fk foreign key(isbn) references books(isbn),
constraint publications_authorid_fk foreign key (author_id) references authors(author_id));

create table librarians(
librarian_id number(8) constraint librarian_id_pk primary key,
last_name varchar2(25) constraint librarian_ln_nn not null,
first_name varchar2(25) constraint librarian_fn_nn not null,
library_id number(8), 
constraint librarian_libraryid_fk foreign key (library_id) references libraries (library_id),
username varchar2(25),
constraint librarian_username_fk foreign key (username) references users(username));

create table adherents(
adherent_id number(8) constraint adherent_id_pk primary key,
last_name varchar2(20) constraint adherent_ln_nn not null,
first_name varchar2(20) constraint adherent_fn_nn not null,
address varchar2(20) constraint adherent_address_nn not null,
account_id number(8),
constraint adherent_accountid_fk foreign key(account_id) references account(account_id),
librarian_id number(8),
constraint adherent_librarianid_fk foreign key(librarian_id) references librarians(librarian_id));

create table copies(
copy_id number (8) constraint copy_id_pk primary key ,
ISBN number(8) ,
constraint copy_isbn_fk foreign key(isbn) references book(isbn),
disponibility number(1) default '0' constraint copy_disponibility_chk check(disponibility in('0','1')),
librarian_id number(8),
constraint copy_librarianid_fk foreign key(librarian_id) references librarians(librarian_id));

create table borrows( 
library_id number (8) constraint borrow_id_pk primary key,
borrow_date date constraint borrow_dateemp_nn not null,
estimated_return_date date constraint borrow_estimatedreturndate_nn not null,
return_date date,
copy_id number(8),
constraint borrow_copyid_fk foreign key (copy_id) references copies(copy_id),
adherent_id number(8),
constraint borrow_adherentid_fk foreign key(adherent_id) references adherents(adherent_id),
librarian_id number(8),
constraint borrow_librarianid_fk foreign key(librarian_id) references libraries(librarian_id));
