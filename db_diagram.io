// Fact Table
Table sales_fact {
  customer_id integer [PRIMARY KEY]
  store_id integer
  product_id integer
  sale_date date
  sales_person_id integer
  price decimal
  quantity integer
  total_cost decimal
  additional_column varchar(255)  // Adjust data type as needed
     // Composite primary key
}

// Customer Dimension Table
Table customer_dim {
  customer_id integer [PRIMARY KEY]
  first_name varchar(255)
  last_name varchar(255)
  address varchar(255)
  pincode varchar(10)
  phone_number varchar(20)
  customer_join_date date
}

// Store Dimension Table
Table store_dim {
  id integer [PRIMARY KEY]
  address varchar(255)
  store_pincode varchar(10)
  store_opening_date date
}

// Product Dimension Table
Table product_dim {
  id integer [PRIMARY KEY]
  name varchar(255)
  current_price decimal
  old_price decimal
  created_date date
  updated_date date
}

// Employee Dimension Table
Table employee_dim {
  id integer [PRIMARY KEY]
  first_name varchar(255)
  last_name varchar(255)
  manager_id integer
  is_manager boolean  // Boolean data type for true/false values
  address varchar(255)
  pincode varchar(10)
  joining_date date
}

// Customer Data Mart (Star Schema)
Table customer_data_mart {
  customer_id integer [PRIMARY KEY]
  full_name varchar(255) // Concatenate first and last name from customer_dim
  address varchar(255)
  phone_number varchar(20)
  sales_date_month date
  total_sales decimal
}

// Sales Team Data Mart (Snowflake Schema)
Table sales_team_data_mart {
  store_id integer
  sales_person_id integer
  full_name varchar(255) // Concatenate first and last name from employee_dim
  sales_month date
  total_sales decimal
  incentive decimal
}

Ref: sales_fact.customer_id > customer_dim.customer_id
Ref: sales_fact.store_id > store_dim.id
Ref: sales_fact.product_id > product_dim.id
Ref: sales_fact.sales_person_id > employee_dim.id
Ref: store_dim.id < sales_team_data_mart.store_id
Ref: employee_dim.id < sales_team_data_mart.sales_person_id
Ref: customer_dim.customer_id < customer_data_mart.customer_id
