DECLARE
  table_names SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('PRODUCT','CUSTOMER',
  'SALES_REPRESENTATIVE','INVENTORY','WAREHOUSE','EXTERNAL_TRANSACTION','INTERNAL_TRANSACTION','DRIVER_DETAILS', 
  'VEHICLE_DETAILS','SALES_REP_ACTIVITY');
  table_names1 SYS.ODCIVARCHAR2LIST := SYS.ODCIVARCHAR2LIST('CUSTOMER','CUSTOMER_CONTACT',
  'CUSTOMER_ADDRESS','SALES_REPRESENTATIVE','INVENTORY','EXTERNAL_TRANSACTION','INTERNAL_TRANSACTION','DRIVER_DETAILS', 
  'SALES_REP_ACTIVITY');
  table_exists NUMBER;
  j Number :=0;
BEGIN
	WHILE j<3
	loop
        j:=j+1;
		if j=1 THEN
            FOR i IN 1..table_names.COUNT LOOP
			SELECT COUNT(*) INTO table_exists FROM user_tables WHERE table_name = table_names(i);
			IF table_exists = 1 and table_names(i)='PRODUCT' THEN
				EXECUTE IMMEDIATE 'ALTER TABLE PRODUCT ADD CONSTRAINT PRODUCT_ID_PK PRIMARY KEY (PRODUCT_ID)';
				DBMS_OUTPUT.PUT_LINE('PRIMARY KEY CREATED ON PRODUCT TABLE');
			ELSIF table_exists=1 and table_names(i)='CUSTOMER' THEN
				EXECUTE IMMEDIATE 'ALTER TABLE CUSTOMER ADD CONSTRAINT CUSTOMER_ID_PK PRIMARY KEY (CUSTOMER_ID)';
				DBMS_OUTPUT.PUT_LINE('PRIMARY KEY CREATED ON CUSTOMER TABLE');
			ELSIF table_exists=1 and table_names(i)='SALES_REPRESENTATIVE' THEN
				EXECUTE IMMEDIATE 'ALTER TABLE SALES_REPRESENTATIVE ADD CONSTRAINT SALESREP_ID_PK PRIMARY KEY (SALESREP_ID)'; 
				DBMS_OUTPUT.PUT_LINE('PRIMARY KEY CREATED ON SALES_REPRESENTATIVE TABLE');
			ELSIF table_exists=1 and table_names(i)='EXTERNAL_TRANSACTION' THEN
				EXECUTE IMMEDIATE  'ALTER TABLE EXTERNAL_TRANSACTION ADD CONSTRAINT TRANSACTION_ID_PK PRIMARY KEY (TRANSACTION_ID)';  
				DBMS_OUTPUT.PUT_LINE('PRIMARY KEY CREATED ON EXTERNAL_TRANSACTION TABLE');
			ELSIF table_exists=1 and table_names(i)='INTERNAL_TRANSACTION' THEN
				EXECUTE IMMEDIATE  'ALTER TABLE INTERNAL_TRANSACTION ADD CONSTRAINT TRANSACTION_ID1_PK PRIMARY KEY (TRANSACTION_ID)';
				DBMS_OUTPUT.PUT_LINE('PRIMARY KEY CREATED ON INTERNAL_TRANSACTION TABLE');
			ELSIF table_exists=1 and table_names(i)='SALES_REP_ACTIVITY' THEN
				EXECUTE IMMEDIATE  'ALTER TABLE SALES_REP_ACTIVITY ADD CONSTRAINT MEETING_ID_PK PRIMARY KEY (MEETING_ID)';
				DBMS_OUTPUT.PUT_LINE('PRIMARY KEY CREATED ON SALES_REP_ACTIVITY TABLE');
			ELSIF table_exists=1 and table_names(i)='INVENTORY' THEN
				EXECUTE IMMEDIATE  'ALTER TABLE INVENTORY ADD CONSTRAINT INVENTORY_ID_PK PRIMARY KEY (INVENTORY_ID)';	
				DBMS_OUTPUT.PUT_LINE('PRIMARY KEY CREATED ON INVENTORY TABLE');
			ELSIF table_exists=1 and table_names(i)='WAREHOUSE' THEN
				EXECUTE IMMEDIATE  'ALTER TABLE WAREHOUSE ADD CONSTRAINT WAREHOUSE_ID_PK PRIMARY KEY (WAREHOUSE_ID)';
				DBMS_OUTPUT.PUT_LINE('PRIMARY KEY CREATED ON WAREHOUSE TABLE');
			ELSIF table_exists=1 and table_names(i)='DRIVER_DETAILS' THEN
				EXECUTE IMMEDIATE  'ALTER TABLE DRIVER_DETAILS ADD CONSTRAINT DRIVER_ID_PK PRIMARY KEY (DRIVER_ID)';
				DBMS_OUTPUT.PUT_LINE('PRIMARY KEY CREATED ON DRIVER_DETAILS TABLE');
			ELSIF table_exists=1 and table_names(i)='VEHICLE_DETAILS' THEN
				EXECUTE IMMEDIATE  'ALTER TABLE VEHICLE_DETAILS ADD CONSTRAINT VEHICLE_ID_PK PRIMARY KEY (VEHICLE_ID)';
				DBMS_OUTPUT.PUT_LINE('PRIMARY KEY CREATED ON VEHICLE_DETAILS TABLE');
		ELSE
				DBMS_OUTPUT.PUT_LINE(table_names(i)||' PRIMARY KEY EXISTS IN DATABASE');
    END IF;
END LOOP;

		ELSIF j=2 THEN
			FOR i IN 1..table_names1.COUNT LOOP
				SELECT COUNT(*) INTO table_exists FROM user_tables WHERE table_name = table_names1(i);
				IF 	table_exists=1 and table_names1(i)='CUSTOMER' THEN
					EXECUTE IMMEDIATE 'ALTER TABLE CUSTOMER ADD CONSTRAINT "CUSTOMER_MEETING_ID_FK" FOREIGN KEY ("CUSTOMER_MEETING_ID") REFERENCES "SALES_REP_ACTIVITY" ("MEETING_ID")';
					EXECUTE IMMEDIATE 'ALTER TABLE CUSTOMER ADD CONSTRAINT "REF_WAREHOUSE_ID_FK" FOREIGN KEY ("REF_WAREHOUSE_ID") REFERENCES "WAREHOUSE" ("WAREHOUSE_ID")';
					DBMS_OUTPUT.PUT_LINE('FOREIGN KEY CREATED ON CUSTOMER TABLE');
				ELSIF table_exists=1 and table_names1(i)='CUSTOMER_ADDRESS' THEN
					EXECUTE IMMEDIATE 'ALTER TABLE CUSTOMER_ADDRESS ADD CONSTRAINT "CUSTOMER_ID_FK" FOREIGN KEY ("CUSTOMER_ID") REFERENCES "CUSTOMER" ("CUSTOMER_ID")'; 
					DBMS_OUTPUT.PUT_LINE('FOREIGN KEY CREATED ON CUSTOMER_ADDRESS TABLE'); 
				ELSIF table_exists=1 and table_names1(i)='CUSTOMER_CONTACT' THEN	
					EXECUTE IMMEDIATE  'ALTER TABLE CUSTOMER_CONTACT ADD CONSTRAINT "CUSTOMER_ID1_FK" FOREIGN KEY ("CUSTOMER_ID") REFERENCES "CUSTOMER" ("CUSTOMER_ID")'; 
					DBMS_OUTPUT.PUT_LINE('FOREIGN KEY CREATED ON CUSTOMER_CONTACT TABLE'); 	
				ELSIF table_exists=1 and table_names1(i)='SALES_REPRESENTATIVE' THEN
					EXECUTE IMMEDIATE  'ALTER TABLE SALES_REPRESENTATIVE ADD CONSTRAINT "REF_WAREHOUSE_ID1_FK" FOREIGN KEY ("REF_WAREHOUSE_ID") REFERENCES "WAREHOUSE" ("WAREHOUSE_ID")';
					DBMS_OUTPUT.PUT_LINE('FOREIGN KEY CREATED ON INTERNAL_TRANSACTION TABLE');
				ELSIF table_exists=1 and table_names1(i)='EXTERNAL_TRANSACTION' THEN
					EXECUTE IMMEDIATE  'ALTER TABLE EXTERNAL_TRANSACTION ADD CONSTRAINT "PRODUCT_ID_FK" FOREIGN KEY ("PRODUCT_ID") REFERENCES "PRODUCT" ("PRODUCT_ID")';
					EXECUTE IMMEDIATE  'ALTER TABLE EXTERNAL_TRANSACTION ADD CONSTRAINT "CUSTOMER_ID2_FK" FOREIGN KEY ("CUSTOMER_ID") REFERENCES "CUSTOMER" ("CUSTOMER_ID")';
					EXECUTE IMMEDIATE  'ALTER TABLE EXTERNAL_TRANSACTION ADD CONSTRAINT "REF_WAREHOUSE_ID2_FK" FOREIGN KEY ("REF_WAREHOUSE_ID") REFERENCES "WAREHOUSE" ("WAREHOUSE_ID")';
					EXECUTE IMMEDIATE  'ALTER TABLE EXTERNAL_TRANSACTION ADD CONSTRAINT "SALESREP_ID_FK" FOREIGN KEY ("SALESREP_ID") REFERENCES "SALES_REPRESENTATIVE" ("SALESREP_ID")';
					DBMS_OUTPUT.PUT_LINE('FOREIGN KEY CREATED ON EXTERNAL_TRANSACTION TABLE');
				ELSIF table_exists=1 and table_names1(i)='INTERNAL_TRANSACTION' THEN
					EXECUTE IMMEDIATE  'ALTER TABLE INTERNAL_TRANSACTION ADD CONSTRAINT "PRODUCT_ID_FK1" FOREIGN KEY ("PRODUCT_ID") REFERENCES "PRODUCT" ("PRODUCT_ID")';	
					EXECUTE IMMEDIATE  'ALTER TABLE INTERNAL_TRANSACTION ADD CONSTRAINT "SALESREP_ID_FK1" FOREIGN KEY ("SALESREP_ID") REFERENCES "SALES_REPRESENTATIVE" ("SALESREP_ID")';
					DBMS_OUTPUT.PUT_LINE('FOREIGN KEY CREATED ON INTERNAL_TRANSACTION TABLE');
				ELSIF table_exists=1 and table_names1(i)='SALES_REP_ACTIVITY' THEN
					EXECUTE IMMEDIATE  'ALTER TABLE SALES_REP_ACTIVITY ADD CONSTRAINT "SALESREP_ID_FK2" FOREIGN KEY ("SALESREP_ID") REFERENCES "SALES_REPRESENTATIVE" ("SALESREP_ID")';
					DBMS_OUTPUT.PUT_LINE('FOREIGN KEY KEY CREATED ON SALES_REP_ACTIVITY TABLE');
				ELSIF table_exists=1 and table_names1(i)='INVENTORY' THEN
					EXECUTE IMMEDIATE  'ALTER TABLE INVENTORY ADD CONSTRAINT "PRODUCT_ID2_FK" FOREIGN KEY ("PRODUCT_ID") REFERENCES "PRODUCT" ("PRODUCT_ID")';
					EXECUTE IMMEDIATE  'ALTER TABLE INVENTORY ADD CONSTRAINT "WAREHOUSE_ID_FK" FOREIGN KEY ("WAREHOUSE_ID") REFERENCES "WAREHOUSE" ("WAREHOUSE_ID")';
					DBMS_OUTPUT.PUT_LINE('FOREIGN KEY KEY CREATED ON INVENTORY TABLE');
				ELSIF table_exists=1 and table_names1(i)='DRIVER_DETAILS' THEN
					EXECUTE IMMEDIATE  'ALTER TABLE VEHICLE_DETAILS ADD CONSTRAINT "DRIVER_ID_FK" FOREIGN KEY ("DRIVER_ID") REFERENCES "DRIVER_DETAILS" ("DRIVER_ID")';
					DBMS_OUTPUT.PUT_LINE('FOREIGN KEY CREATED ON DRIVER_DETAILS TABLE');
			ELSE
				DBMS_OUTPUT.PUT_LINE(table_names1(i)||' FOREIGN KEY EXISTS IN DATABASE');
			END IF;
			END LOOP;
		END IF;
	END LOOP;
END;

