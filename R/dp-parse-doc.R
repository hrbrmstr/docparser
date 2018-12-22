#' Parse a document with a predefined parser
#'
#' @md
#' @param file path to a document (this will be [path.expanded()])
#' @param parser a parser id (which can be found via [dp_parsers()])
#' @param remote_id if not `NULL` then an id which will be used to tag the file
#'        on the `docparser` servers (otherwise one will be generated)
#' @param docparser_api_key if not placed in the `DOCPARSER_API_KEY` environment
#'        variable, place it here. Otherwise, API requests fail.
#' @return list of available parsers
#' @export
#' @examples \dontrun{
#' dp_parse_doc()
#' }
dp_parse_doc <- function(file, parser, remote_id =NULL,
                         docparser_api_key=Sys.getenv("DOCPARSER_API_KEY")) {

  file <- path.expand(file)

  stopifnot(file.exists(file))

  ul <- list(file= httr::upload_file(file))

  if (!is.null(remote_id)) ul$remote_id <- remote_id

  httr::POST(
    url = sprintf("https://api.docparser.com/v1/document/upload/%s", parser),
    httr::user_agent("docparser R pkg <https://github.com/hrbrmstr/docparser>"),
    httr::authenticate(
      user = docparser_api_key,
      password = ""
    ),
    body = ul
  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as = "text", encoding = "UTF-8")

  out <- jsonlite::fromJSON(out)

  out

}
