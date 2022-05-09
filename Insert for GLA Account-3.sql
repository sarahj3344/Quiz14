/* 
Sarah Johnson
Assignment: Quiz 14
Class: CISP350 - SP 2022 
*/

CREATE PROCEDURE insert_glaccount
(
    account_number_param         general_ledger_accounts.account_number%TYPE,
    account_description_param    general_ledger_accounts.account_description%TYPE
)

AS
    counter_var    NUMBER;

BEGIN    
 
    SELECT COUNT(*)
    INTO counter_var
    FROM general_ledger_accounts
    WHERE account_number = account_number_param;
    
    IF counter_var > 0 THEN
        RAISE VALUE_ERROR;
    END IF;
    
    -- Insert Statement
    INSERT INTO general_ledger_accounts
    VALUES(account_number_param, account_description_param);  
           EXCEPTION
            WHEN VALUE_ERROR THEN
                DBMS_OUTPUT.PUT_LINE('DUP_VAL_ON_INDEX: A duplicate value on index exists.');
                ROLLBACK;
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('An unknown exception occured.');
                ROLLBACK;

END;
/

BEGIN
    insert_glaccount(
        account_number_param => 705,
        account_description_param => 'Professional Learning Community');
END;
/
    
    