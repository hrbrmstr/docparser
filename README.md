
# docparser

Tools to Upload/Parse Documents to ‘docparser’ and Retrieve Extracted
Results

## Description

The ‘docparser’ (<https://docparser.com>) service enables users to
visually define extraction regions for documents then use a ‘REST’ ‘API’
endpoint (<https://dev.docparser.com/>) to upload documents and retrieve
parsed results. Tools are provided to query available parsers, upload
documents and retrieved parsed results.

## What’s Inside The Tin

The following functions are implemented:

  - `dp_parsers`: Retrieve avilable parsers
  - `dp_parse_doc`: Parse a document with a predefined parser
  - `dp_ping`: “Ping” the docparser API
  - `dp_results`: Retrieve results from parsed documents

## Installation

``` r
devtools::install_github("hrbrmstr/docparser")
```

## Usage

``` r
library(docparser)

# current verison
packageVersion("docparser")
```

    ## [1] '0.1.0'

``` r
dp_parsers()
```

    ##             id              label
    ## 1 jcpfgqiexwky My Document Parser

``` r
str(
  dp_results("484c4292ab3b324b7f2b60f3f2d3149f", "jcpfgqiexwky")
)
```

    ## 'data.frame':    1 obs. of  11 variables:
    ##  $ id                 : chr "eaf88c208b750bedcdf2dc92c28885a5"
    ##  $ document_id        : chr "484c4292ab3b324b7f2b60f3f2d3149f"
    ##  $ remote_id          : chr ""
    ##  $ file_name          : chr "2017-18-Influenza-Season-Report.pdf"
    ##  $ media_link         : chr "https://api.docparser.com/v1/document/media/b29p0VOVPQ2zgHpXn4jknRnlldYBXtKc7sNXLXxHrRdYF4kA_TZbw2CJQ2fNfJFCzuw"| __truncated__
    ##  $ media_link_original: chr "https://api.docparser.com/v1/document/media/b29p0VOVPQ2zgHpXn4jknRnlldYBXtKc7sNXLXxHrRdYF4kA_TZbw2CJQ2fNfJFCzuw"| __truncated__
    ##  $ media_link_data    : chr "https://api.docparser.com/v1/document/media/b29p0VOVPQ2zgHpXn4jknRnlldYBXtKc7sNXLXxHrRdYF4kA_TZbw2CJQ2fNfJFCzuw"| __truncated__
    ##  $ page_count         : int 13
    ##  $ uploaded_at        : chr "2018-12-22T19:06:06+00:00"
    ##  $ processed_at       : chr "2018-12-22T19:08:45+00:00"
    ##  $ table_data         :List of 1
    ##   ..$ :'data.frame': 6 obs. of  3 variables:
    ##   .. ..$ key_0: chr  "Region" "Central" "Eastern" "Northern" ...
    ##   .. ..$ key_1: chr  "Baseline" "0.62%" "0.63%" "1.36%" ...
    ##   .. ..$ key_2: chr  "Threshold" "1.55%" "1.57%" "3.41%" ...
