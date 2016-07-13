CREATE TABLE user (
	user_id varchar(25) NOT NULL,
	name_first varchar(25) NOT NULL,
	name_last varchar(50) NOT NULL,
	street_address varchar(100),
	city varchar(50) NOT NULL,
	country varchar(50) NOT NULL,
	postcode varchar(25) NOT NULL,
	phone_primary varchar(50),
	phone_secondary varchar(50),
	encrypted_password varchar(50) NOT NULL,
	email varchar(50) NOT NULL UNIQUE,
	birthdate DATE,
	credit_card varchar(16),
	feedback_rating FLOAT(1),
	CONSTRAINT user_pk PRIMARY KEY (user_id)
) WITH (
  OIDS=FALSE
);



CREATE TABLE item_list (
	item_id serial NOT NULL,
	type varchar(50) NOT NULL,
	model varchar(50),
	age varchar(50),
	condition varchar(50) NOT NULL,
	date_entered DATE NOT NULL,
	user_id varchar(50) NOT NULL,
	location varchar(50) NOT NULL,
	is_loaned BOOLEAN NOT NULL,
	loaned_from DATE,
	loaned_until DATE,
	min_loan_period integer,
	max_loan_period integer,
	deposit FLOAT(5) NOT NULL,
	rental_rate FLOAT(5) NOT NULL,
	CONSTRAINT item_list_pk PRIMARY KEY (item_id)
) WITH (
  OIDS=FALSE
);

CREATE TABLE age (
	age varchar(50) NOT NULL,
	CONSTRAINT age_pk PRIMARY KEY (age)
) WITH (
  OIDS=FALSE
);


CREATE TABLE category (
	category varchar(50) NOT NULL,
	CONSTRAINT category_pk PRIMARY KEY (category)
) WITH (
  OIDS=FALSE
);



CREATE TABLE condition (
	condition varchar(50) NOT NULL,
	CONSTRAINT condition_pk PRIMARY KEY (condition)
) WITH (
  OIDS=FALSE
);



CREATE TABLE contracts (
	contract_id varchar(50) NOT NULL,
	created_at DATE NOT NULL,
	item_id serial NOT NULL,
	lender_id varchar(25) NOT NULL,
	inquirer_id varchar(25) NOT NULL,
	key varchar(25) NOT NULL,
	loaned_out DATE NOT NULL,
	returned DATE NOT NULL,
	deposit FLOAT(5) NOT NULL,
	rental_rate FLOAT(5) NOT NULL,
	CONSTRAINT contracts_pk PRIMARY KEY (contract_id)
) WITH (
  OIDS=FALSE
);

ALTER TABLE item_list ADD CONSTRAINT item_list_fk0 FOREIGN KEY (user_id) REFERENCES user(user_id);

ALTER TABLE item_list ADD CONSTRAINT item_list_fk0 FOREIGN KEY (age) REFERENCES age(age);
ALTER TABLE item_list ADD CONSTRAINT item_list_fk1 FOREIGN KEY (type) REFERENCES category(type);
ALTER TABLE item_list ADD CONSTRAINT item_list_fk2 FOREIGN KEY (condition) REFERENCES condition(condition);

ALTER TABLE contracts ADD CONSTRAINT contracts_fk0 FOREIGN KEY (item_id) REFERENCES item_list(item_id);
ALTER TABLE contracts ADD CONSTRAINT contracts_fk1 FOREIGN KEY (lender_id) REFERENCES user(user_id);
ALTER TABLE contracts ADD CONSTRAINT contracts_fk2 FOREIGN KEY (inquirer_id) REFERENCES user(user_id);

