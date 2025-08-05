//Driver Code

*&---------------------------------------------------------------------*
*& REPORT ZINVOICE_SF_PPK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZINVOICE_SF_PPK.

DATA FM_NAME_TYPE TYPE RS38L_FNAM.

DATA: WA_CONTROL_PARA TYPE SSFCTRLOP.
      WA_CONTROL_PARA-GETOTF = 'X'.

DATA WA_JOB_OP_INFO TYPE SSFCRESCL.

DATA ITAB_DOCS TYPE TABLE OF DOCS.

DATA ITAB_PDF TYPE TABLE OF TLINE.

PARAMETERS: LOC_FILE TYPE LOCALFILE.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR LOC_FILE.

CALL FUNCTION 'F4_FILENAME'
 EXPORTING
   PROGRAM_NAME        = SYST-CPROG
   DYNPRO_NUMBER       = SYST-DYNNR
   FIELD_NAME          = ' '
 IMPORTING
   FILE_NAME           = LOC_FILE
          .


CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
  EXPORTING
    FORMNAME           = 'Z_INVOICE_SF_PPK'
*   VARIANT            = ' '
*   DIRECT_CALL        = ' '
  IMPORTING
    FM_NAME            = FM_NAME_TYPE
  EXCEPTIONS
    NO_FORM            = 1
    NO_FUNCTION_MODULE = 2
    OTHERS             = 3.
IF SY-SUBRC <> 0.
* IMPLEMENT SUITABLE ERROR HANDLING HERE
ENDIF.

START-OF-SELECTION.
CALL FUNCTION FM_NAME_TYPE "'/1BCDWB/SF00000128'
  EXPORTING
*   ARCHIVE_INDEX      =
*   ARCHIVE_INDEX_TAB  =
*   ARCHIVE_PARAMETERS =
    CONTROL_PARAMETERS = WA_CONTROL_PARA
*   MAIL_APPL_OBJ      =
*   MAIL_RECIPIENT     =
*   MAIL_SENDER        =
*   OUTPUT_OPTIONS     =
*   USER_SETTINGS      = 'X'
  IMPORTING
*   DOCUMENT_OUTPUT_INFO       =
    JOB_OUTPUT_INFO    = WA_JOB_OP_INFO
*   JOB_OUTPUT_OPTIONS =
  EXCEPTIONS
    FORMATTING_ERROR   = 1
    INTERNAL_ERROR     = 2
    SEND_ERROR         = 3
    USER_CANCELED      = 4
    OTHERS             = 5.
IF SY-SUBRC <> 0.
* IMPLEMENT SUITABLE ERROR HANDLING HERE
ENDIF.

CALL FUNCTION 'CONVERT_OTF_2_PDF'
* EXPORTING
*   USE_OTF_MC_CMD               = 'X'
*   ARCHIVE_INDEX                =
* IMPORTING
*   BIN_FILESIZE                 =
  TABLES
    OTF            = WA_JOB_OP_INFO-OTFDATA
    DOCTAB_ARCHIVE = ITAB_DOCS
    LINES          = ITAB_PDF
 EXCEPTIONS
   ERR_CONV_NOT_POSSIBLE        = 1
   ERR_OTF_MC_NOENDMARKER       = 2
   OTHERS         = 3
  .
IF SY-SUBRC <> 0.
* IMPLEMENT SUITABLE ERROR HANDLING HERE
ENDIF.

DATA: L_FILE_NAME TYPE STRING.
      L_FILE_NAME = LOC_FILE.

CALL FUNCTION 'GUI_DOWNLOAD'
  EXPORTING
*   BIN_FILESIZE                    =
    filename                        = L_FILE_NAME
   FILETYPE                        =  'BIN' "'ASC'
*   APPEND                          = ' '
*   WRITE_FIELD_SEPARATOR           = ' '
*   HEADER                          = '00'
*   TRUNC_TRAILING_BLANKS           = ' '
*   WRITE_LF                        = 'X'
*   COL_SELECT                      = ' '
*   COL_SELECT_MASK                 = ' '
*   DAT_MODE                        = ' '
*   CONFIRM_OVERWRITE               = ' '
*   NO_AUTH_CHECK                   = ' '
*   CODEPAGE                        = ' '
*   IGNORE_CERR                     = ABAP_TRUE
*   REPLACEMENT                     = '#'
*   WRITE_BOM                       = ' '
*   TRUNC_TRAILING_BLANKS_EOL       = 'X'
*   WK1_N_FORMAT                    = ' '
*   WK1_N_SIZE                      = ' '
*   WK1_T_FORMAT                    = ' '
*   WK1_T_SIZE                      = ' '
*   WRITE_LF_AFTER_LAST_LINE        = ABAP_TRUE
*   SHOW_TRANSFER_STATUS            = ABAP_TRUE
*   VIRUS_SCAN_PROFILE              = '/SCET/GUI_DOWNLOAD'
* IMPORTING
*   FILELENGTH                      =
  tables
    data_tab                        = ITAB_PDF
*   FIELDNAMES                      =
* EXCEPTIONS
*   FILE_WRITE_ERROR                = 1
*   NO_BATCH                        = 2
*   GUI_REFUSE_FILETRANSFER         = 3
*   INVALID_TYPE                    = 4
*   NO_AUTHORITY                    = 5
*   UNKNOWN_ERROR                   = 6
*   HEADER_NOT_ALLOWED              = 7
*   SEPARATOR_NOT_ALLOWED           = 8
*   FILESIZE_NOT_ALLOWED            = 9
*   HEADER_TOO_LONG                 = 10
*   DP_ERROR_CREATE                 = 11
*   DP_ERROR_SEND                   = 12
*   DP_ERROR_WRITE                  = 13
*   UNKNOWN_DP_ERROR                = 14
*   ACCESS_DENIED                   = 15
*   DP_OUT_OF_MEMORY                = 16
*   DISK_FULL                       = 17
*   DP_TIMEOUT                      = 18
*   FILE_NOT_FOUND                  = 19
*   DATAPROVIDER_EXCEPTION          = 20
*   CONTROL_FLUSH_ERROR             = 21
*   OTHERS                          = 22
          .
IF sy-subrc <> 0.
* Implement suitable error handling here
ENDIF.



//Smartform Code

-Global datatype
 ITAB TYPE TABLE OF TY_VBRP
 WA TYPE TY_VBRP
 SUBTOTAL TYPE NETWR

-Types
types: begin of ty_vbrp,
       ARKTX TYPE ARKTX,
       FKIMG TYPE FKIMG,
       POSNR TYPE POSNR_VF,
       NETWR TYPE NETWR_FP,
       VBELN TYPE VBELN_VF,
       FKDAT_ANA TYPE FKDAT,
       FBUDA  TYPE FBUDA,
       KUNRG_ANA TYPE KUNRG,
       KUNAG_ANA TYPE KUNAG,
       BUKRS_ANA TYPE BUKRS,
       end of ty_vbrp.

-Initialization
 
SELECT ARKTX
       FKIMG
       POSNR
       NETWR
       VBELN
       FKDAT_ANA
       FBUDA
       KUNRG_ANA
       KUNAG_ANA
       BUKRS_ANA
FROM VBRP
INTO TABLE ITAB.

IF ITAB IS NOT INITIAL.
  LOOP AT ITAB INTO WA.
    WRITE:/ WA-ARKTX, WA-FKIMG, WA-POSNR,WA-NETWR, WA-VBELN, WA-FKDAT_ANA, WA-FBUDA, WA-KUNRG_ANA, WA-KUNAG_ANA,WA-BUKRS_ANA.
  ENDLOOP.
ENDIF.

