create table CONTRACT
(
  CONTRACTNUMBER INTEGER      not null,
  DATE           DATE         not null,
  PLACE          VARCHAR(255) not null
);

create unique index CONTRACT_CONTRACTNUMBER_UINDEX
  on CONTRACT (CONTRACTNUMBER);

alter table CONTRACT
  add constraint CONTRACT_PK
    primary key (CONTRACTNUMBER);

create table ESTATE_AGENT
(
  NAME     VARCHAR(255) not null,
  ADDRES   VARCHAR(255) not null,
  LOGIN    VARCHAR(255) not null
    constraint ESTATE_AGENT_PK
      primary key,
  PASSWORD VARCHAR(255) not null
);

create table ESTATE
(
  ID           INTEGER      not null,
  CITY         VARCHAR(255) not null,
  ZIP          INTEGER      not null,
  STREET       VARCHAR(255) not null,
  STREETNUMBER VARCHAR(255) not null,
  SQUAREAREA   INTEGER      not null,
  LOGIN        VARCHAR(255) not null
    constraint ESTATE_ESTATE_AGENT_FK
      references ESTATE_AGENT
);

create unique index ESTATE_ID_UINDEX
  on ESTATE (ID);

alter table ESTATE
  add constraint ESTATE_PK
    primary key (ID);

create table APARTMENT
(
  FLOOR   INTEGER not null,
  RENT    INTEGER not null,
  ROOMS   INTEGER not null,
  BALCONY INTEGER not null,
  KITCHEN INTEGER not null,
  EID     INTEGER not null
    constraint APARTMENT_PK
      primary key
    constraint APARTMENT_ESTATE_ID_FK
      references ESTATE
);

create table HOUSE
(
  FLOORS INTEGER not null,
  PRICE  INTEGER not null,
  GARDEN INTEGER not null,
  EID    INTEGER not null
    constraint HOUSE_PK
      primary key
    constraint HOUSE_ESTATE_ID_FK
      references ESTATE
);

create table PERSON
(
  SURNAME VARCHAR(255) not null,
  NAME    VARCHAR(255) not null,
  ADDRESS VARCHAR(255) not null,
  constraint PERSON_PK
    primary key (SURNAME, NAME, ADDRESS)
);

create table PURCHASECONTRACT
(
  INSTALLMENTNUMBER INTEGER not null,
  INTRESTRATE       DOUBLE  not null,
  FID               INTEGER not null
    constraint PURCHASECONTRACT_PK
      primary key
    constraint PURCHASECONTRACT_CONTRACT_FK
      references CONTRACT
      on delete cascade
);

create table SELLS
(
  EID        INTEGER     not null
    constraint SELLS_HOUSE_FK
      references HOUSE
      on delete cascade,
  CID        INTEGER     not null
    constraint SELLS_PURCHASECONTRACT_FK
      references PURCHASECONTRACT
      on delete cascade,
  FIRST_NAME VARCHAR(255) not null,
  LAST_NAME  VARCHAR(255) not null,
  ADDRESS    VARCHAR(255) not null,
  constraint SELLS_PERSON_FK
    foreign key (FIRST_NAME, LAST_NAME, ADDRESS) references PERSON
      on delete cascade
);

create table TENANCYCONTRACT
(
  STARTDATE DATE,
  DURATION  INTEGER,
  ACOST     INTEGER,
  FID       INTEGER not null
    constraint TENANCYCONTRACT_PK
      primary key
    constraint TENANCYCONTRACT_CONTRACT_FK
      references CONTRACT
      on delete cascade
);

create table RENTS
(
  EID        INTEGER     not null
    constraint RENTS_APARTMENT_FK
      references APARTMENT
      on delete cascade,
  CID        INTEGER     not null
    constraint RENTS_TENANCYCONTRACT_FK
      references TENANCYCONTRACT
      on delete cascade,
  FIRST_NAME VARCHAR(255) not null,
  LAST_NAME  VARCHAR(255) not null,
  ADDRESS    VARCHAR(255) not null,
  constraint RENTS_PERSON_FK
    foreign key (FIRST_NAME, LAST_NAME, ADDRESS) references PERSON
      on delete cascade
);

