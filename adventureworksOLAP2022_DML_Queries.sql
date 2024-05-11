SELECT table_name FROM INFORMATION_SCHEMA.TABLES WHERE table_type = 'BASE TABLE'

/* Dimension Tables */
SELECT * FROM DimAccount
SELECT * FROM DimCurrency
SELECT * FROM DimCustomer
SELECT * FROM DimDate
SELECT * FROM DimDepartmentGroup
SELECT * FROM DimEmployee
SELECT * FROM DimGeography
SELECT * FROM DimOrganization
SELECT * FROM DimProduct
SELECT * FROM DimProductCategory
SELECT * FROM DimProductSubCategory
SELECT * FROM DimPromotion
SELECT * FROM DimReseller
SELECT * FROM DimSalesReason
SELECT * FROM DimSalesTerritory
SELECT * FROM DimScenario

/* Fact Tables */
SELECT * FROM FactAdditionalInternationalProductDescription
SELECT * FROM FactCallCenter
SELECT * FROM FactCurrencyRate
SELECT * FROM FactFinance
SELECT * FROM FactInternetSales
SELECT * FROM FactInternetSalesReason
SELECT * FROM FactProductInventory
SELECT * FROM FactResellerSales
SELECT * FROM FactSalesQuota
SELECT * FROM FactSurveyResponse
SELECT * FROM NewFactCurrencyRate
SELECT * FROM ProspectiveBuyer
SELECT * FROM sysdiagrams
