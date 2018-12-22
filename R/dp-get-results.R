#' Retrieve results from parsed documents
#'
#' @md
#' @param doc_id a document ID from the web interface or as returned by
#'        [dp_parse_doc()]
#' @param parser a parser id (which can be found via [dp_parsers()])
#' @param format one of "`object`" or "`flat`". By default, parsed document
#'        data is returned as nested JSON objects. Setting this parameter to
#'        "`flat`" will return a simplified version of the parsed data which does
#'        not contain flat key/value pairs instead of nested objects. Default
#'        is "`object`".
#' @param include_children If child documents were created during preprocessing
#'        (e.g. when splitting documents), setting this parameter to `TRUE`
#'        (the default)
#'        ensures that the parsed data of all child documents is returned.
#' @param docparser_api_key if not placed in the `DOCPARSER_API_KEY` environment
#'        variable, place it here. Otherwise, API requests fail.
#' @return list
#' @export
#' @examples \dontrun{
#' dp_results("484c4292ab3b324b7f2b60f3f2d3149f", "jcpfgqiexwky")
#' }
dp_results <- function(doc_id, parser,
                       format = c("object", "flat"),
                       include_children = TRUE,
                       docparser_api_key=Sys.getenv("DOCPARSER_API_KEY")) {

  format <- match.arg(format[1], c("object", "flat"))

  httr::GET(
    url = sprintf("https://api.docparser.com/v1/results/%s/%s", parser, doc_id),
    httr::user_agent("docparser R pkg <https://github.com/hrbrmstr/docparser>"),
    httr::authenticate(
      user = docparser_api_key,
      password = ""
    ),
    query = list(
      format = format,
      include_children = include_children
    )
  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as = "text", encoding = "UTF-8")

  out <- jsonlite::fromJSON(out)

  out

}
