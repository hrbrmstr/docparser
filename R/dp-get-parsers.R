#' Retrieve avilable parsers
#'
#' @md
#' @param docparser_api_key if not placed in the `DOCPARSER_API_KEY` environment
#'        variable, place it here. Otherwise, API requests fail.
#' @return data frame of available parsers
#' @export
#' @examples \dontrun{
#' dp_parsers()
#' }
dp_parsers <- function(docparser_api_key=Sys.getenv("DOCPARSER_API_KEY")) {

  httr::GET(
    url = "https://api.docparser.com/v1/parsers",
    httr::user_agent("docparser R pkg <https://github.com/hrbrmstr/docparser>"),
    httr::authenticate(
      user = docparser_api_key,
      password = ""
    )
  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as = "text", encoding = "UTF-8")

  out <- jsonlite::fromJSON(out)

  out

}
