CREATE TABLE card_holder (
  id INT NOT NULL,
  name VARCHAR(50),
  PRIMARY KEY (id)
);
CREATE TABLE credit_card (
  card VARCHAR(20) NOT NULL,
  -- We use VARCHAR(20) instead of BIGINT for card as these
  -- numbers are strings and won't be mathematically aggregated
  id_card_holder INT,
  FOREIGN KEY (id_card_holder) REFERENCES card_holder (id),
  PRIMARY KEY (card)
);
CREATE TABLE merchant_category (
  id INT NOT NULL,
  name VARCHAR(15),
  PRIMARY KEY (id)
);
CREATE TABLE merchant (
  id INT NOT NULL,
  name VARCHAR(50),
  id_merchant_category INT NOT NULL,
  FOREIGN KEY (id_merchant_category) REFERENCES merchant_category (id),
  PRIMARY KEY (id)
);
CREATE TABLE transaction (
  id INT NOT NULL,
  date timestamp NOT NULL,
  amount float,
  card VARCHAR(20),
  id_merchant INT,
  FOREIGN KEY (card) REFERENCES credit_card (card),
  FOREIGN KEY (id_merchant) REFERENCES merchant (id),
  PRIMARY KEY (id)
);













