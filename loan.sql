USE nibin;

SELECT * FROM loan;

# Count of loan which have been approvd and rejected 
SELECT loan_status, COUNT(*) AS 'loan count'
FROM loan
GROUP BY loan_status;


# Average income for approved loans 
SELECT AVG(income_annum) AS 'Average Income'
FROM Loan
WHERE loan_status = 'Approved';


# Average income for rejected loans 
SELECT AVG(income_annum) AS 'Average Income'
FROM Loan
WHERE loan_status = 'Rejected';


# Distribution of loan term in the dataset 
SELECT loan_term, COUNT(*) AS 'Term count'
FROM loan
GROUP BY loan_term;


# Minimum, Maximum, Average Cibil Score 
SELECT MIN(cibil_score) AS 'Min cibil',
       MAX(cibil_score) AS 'Max cibil',
       AVG(cibil_score) AS 'Avg cibil'
FROM loan;


# Comparison of all assets for approved and rejected loans 
SELECT loan_status,
       AVG(residential_assets_value) AS 'Avg residential',
	   AVG(commercial_assets_value) AS 'Avg commercial',
	   AVG(luxury_assets_value) AS 'Avg luxury',
	   AVG(bank_asset_value) AS 'Avg bank'
FROM loan
GROUP BY loan_status;


# Loan ID where annual income > 500000
SELECT * FROM loan
WHERE loan_id IN(SELECT loan_id
                 FROM loan
                 WHERE income_annum > 500000);
        
        
        
# Find average income by education level
SELECT education, AVG(income_annum) AS 'Avg income'
FROM loan
GROUP BY education;


# Total loan amount for approved loans
SELECT SUM(loan_amount) AS 'Total approved loan amount'
FROM loan 
WHERE loan_status = 'Approved';


# Top 5 Cibil score 
SELECT cibil_score
FROM loan
ORDER BY cibil_score DESC
LIMIT 5;


# Debt to income ratio for each loan 
SELECT loan_id, loan_amount / income_annum AS 'Debt to income ratio'
FROM loan;


# Loan with highest total asset value
SELECT loan_id
FROM loan
ORDER BY residential_assets_value + commercial_assets_value + 
		 luxury_assets_value + bank_asset_value DESC
LIMIT 1;


# Loans with high cibil score and high loan amounts
SELECT loan_id, cibil_score, loan_amount
FROM loan
WHERE cibil_score > 750 AND loan_amount > 500000;


# Average loan term for self employed individual 
SELECT AVG(loan_term) AS 'Avg loan term'
FROM loan
WHERE self_employed = 'Yes';


# Education level with avg income greater then 50000 
SELECT education, AVG(income_annum) AS 'AVG income'
FROM loan
GROUP BY education
HAVING AVG(income_annum) > 50000;


# Loan term with avg cibil score less than 700 
SELECT loan_term, AVG(cibil_score) AS 'Avg cibil score'
FROM loan
GROUP BY loan_term
HAVING 'Avg cibil score' < 700;


# Loan status with count greater than 50 
SELECT loan_status, COUNT(*) AS 'Loan count'
FROM loan 
GROUP BY loan_status
HAVING 'Loan count' > 50;


# Self employed indiviual with total assets value > 100000 
SELECT self_employed, SUM(residential_assets_value + commercial_assets_value + 
	   luxury_assets_value + bank_asset_value) AS 'Total assets value'
FROM loan
GROUP BY self_employed
HAVING 'Total assets value' > 100000;


# Loans with income greater than the avg. income
SELECT * 
FROM loan
WHERE income_annum > (SELECT AVG(income_annum)
                      FROM loan);
                      
                      
# Loans with cibil score > than max cibil score for rejected loans
SELECT * 
FROM loan
WHERE cibil_score > (SELECT MAX(cibil_score)
                     FROM loan
                     WHERE loan_status = 'Rejected');
                     
                     
# Loans with residential asset value > avg. residential assets value for self-employed indiviuals
SELECT * 
FROM loan
WHERE residential_assets_value > (SELECT AVG(residential_assets_value)
                                  FROM loan
                                  WHERE self_employed = 'Yes');
                                  
						

# Loans with no dependants and above avg. cibil score
SELECT *
FROM loan
WHERE no_of_dependents = 0 
AND cibil_score > (SELECT AVG(cibil_score) 
                   FROM loan);
                   
                   
# Self employed individuals with highest commercial assets values
SELECT * 
FROM loan
WHERE self_employed = 'Yes'
AND commercial_assets_value = (SELECT MAX(commercial_assets_value)
                               FROM loan
                               WHERE self_employed = 'Yes');

