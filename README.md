 Customer Invoice Smartform (ZINVOICE_SF_PPK)
Project Overview
This SAP ABAP project demonstrates how to generate a Customer Invoice PDF using a Smartform with data fetched only from the VBRP (Billing Document Item) table.  

The Smartform:
- Populates invoice header with invoice number and dates  
- Displays line-item billing details,
  Invoice Number (VBELN)
  Invoice Date (FKDAT_ANA)
  Due Date (FBUDA)
  Billing Item (POSNR)
  Description (ARKTX)
  Quantity (FKIMG)

Total Amount (NETWR)
- Calculates the subtotal in the footer  
- Exports the final invoice as a PDF file

SAP Table Used
VBRP  Billing Document Item (Invoice line items with quantity, net value, and description) 

Fields Used (from VBRP)
Header Section
- Invoice Number (`VBELN`)  
- Invoice Date (`FKDAT_ANA`)  
- Due Date (`FBUDA`)  

Item Table Section
- Billing Item (`POSNR`)  
- Description (`ARKTX`)  
- Quantity (`FKIMG`)  
- Total Amount (`NETWR`)

Footer Section
- Subtotal (Sum of `NETWR`)  
- Dummy Terms & Conditions text block
- Seal & Signature

 Features
- Generates PDF invoices using Smartforms  
- Fetches billing item data from VBRP  
- Subtotal calculation in the Smartform footer  
- Terms & Conditions section in PDF  
- PDF download via `GUI_DOWNLOAD`

Driver Program (ZINVOICE_SF_PPK)
Key steps in the program:
1. Get Smartform FM dynamically via `SSF_FUNCTION_MODULE_NAME`  
2. Execute Smartform with GETOTF = 'X' to capture PDF stream  
3. Convert Smartform OTF output to PDF using `CONVERT_OTF_2_PDF`  
4. Prompt user for local file path using `F4_FILENAME`  
5. Save PDF using `GUI_DOWNLOAD`

Sample Output
The generated PDF includes:  
- Invoice number, date, and due date  
- Itemized billing table (POSNR, Description, Quantity, Total)  
- Subtotal, Seal & Signature and Terms & Conditions in the footer

Learning Outcomes
By implementing this project, you will learn:  
- Smartform design with Header, Main Area, and Footer
- Fetching invoice item data from VBRP
- Creating PDF output with Smartforms  
- Using `GUI_DOWNLOAD` to save Smartform output locally




 
