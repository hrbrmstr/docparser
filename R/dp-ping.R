#' "Ping" the docparser API
#'
#' @md
#' @param docparser_api_key if not placed in the `DOCPARSER_API_KEY` environment
#'        variable, place it here. Otherwise, API requests fail.
#' @return `TRUE` (invisibly) if successful
#' @export
#' @examples \dontrun{
#' dp_ping()
#' }
dp_ping <- function(docparser_api_key=Sys.getenv("DOCPARSER_API_KEY")) {

  httr::GET(
    url = "https://api.docparser.com/v1/ping",
    httr::user_agent("docparser R pkg <https://github.com/hrbrmstr/docparser>"),
    httr::authenticate(
      user = docparser_api_key,
      password = ""
    )
  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as = "text", encoding = "UTF-8")

  out <- jsonlite::fromJSON(out)

  if (length(out$msg)) {
    return(invisible(out$msg == "pong"))
  } else {
    return(invisible(FALSE))
  }

}
