CREATE TABLE users (
	user_id varchar(50) NOT NULL UNIQUE,
	name_first varchar(25) NOT NULL,
	name_last varchar(50) NOT NULL,
	street_address varchar(100),
	city varchar(50),	
	country varchar(50),
	postcode varchar(25),
	phone_primary varchar(50),
	phone_secondary varchar(50),
	encrypted_password varchar(50) NOT NULL,
	email varchar(50) NOT NULL UNIQUE,
	birthdate DATE,
	credit_card varchar(16),
	feedback_rating FLOAT(1)
);



CREATE TABLE item_category (
	type varchar(50) NOT NULL UNIQUE
);



CREATE TABLE item_condition (
	condition varchar(50) NOT NULL UNIQUE
);



CREATE TABLE interest_history (
	key varchar(50) NOT NULL UNIQUE,
	item_id varchar(25) NOT NULL,
	lender_id varchar(50) NOT NULL REFERENCES users(user_id),
	inquirer_id varchar(50) NOT NULL REFERENCES users(user_id),
	deposit FLOAT(5) NOT NULL,
	rental_rate FLOAT(5) NOT NULL,
	loan_start_date DATE NOT NULL,
	loan_end_date DATE NOT NULL,
	meeting_location varchar(50)
);



CREATE TABLE contracts_history (
	contract_id varchar(50) NOT NULL UNIQUE,
	created_at DATE NOT NULL,
	key varchar(50) NOT NULL REFERENCES interest_history(key),
	returned DATE
);






CREATE TABLE item_list (
	item_id varchar(50) NOT NULL UNIQUE,
	type varchar(50) NOT NULL REFERENCES item_category(type),
	model varchar(50),
	age FLOAT(1),
	condition varchar(50) NOT NULL REFERENCES item_condition(condition),
	date_entered DATE NOT NULL,
	user_id varchar(50) NOT NULL REFERENCES users(user_id),
	location varchar(50) NOT NULL,
	is_loaned BOOLEAN NOT NULL,
	current_contract varchar(50) REFERENCES contracts_history(contract_id),
	available_from DATE,
	min_loan_period FLOAT(1),
	max_loan_period FLOAT(1),
	deposit FLOAT(5) NOT NULL,
	rental_rate FLOAT(5) NOT NULL
);



