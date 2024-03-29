create table CUSTOMERS (
    id number primary key,
    name varchar2(50) not null,
    address varchar2(255),
    phone varchar2(255) not null,
    gender varchar2(50) not null,
    age number not null,
    img varchar2(255),
    point number not null,
    grade varchar2(255) not null
);

DROP SEQUENCE customer_seq;

create sequence customer_seq
       increment by 1
       start with 1
       minvalue 1
       maxvalue 9999
       nocycle
       nocache
       noorder;

insert into CUSTOMERS values(customer_seq.nextval, '신사임당', '서울시 종로구 청와대로', '010-2222-2222', '여', 30, '/img/person1.jpg', 150, 'silver');
insert into CUSTOMERS values(customer_seq.nextval, '이율곡', '경기 김포시 고촌읍 아라육로 152', '010-2222-2223', '남', 35, '/img/person2.jpg', 900, 'vip');
insert into CUSTOMERS values(customer_seq.nextval, '정약용', '서울시 강남구 강남대로 122', '010-2222-2224', '남', 40, '/img/person3.jpg', 300, 'gold');

commit;

select * from CUSTOMERS ORDER BY ID;