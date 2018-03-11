#' Retrieve the number of remaining Github API requests available
#'
#' @param geogit_token The geogit_token used to retrieve data from Github
#'
#' @details
#'
#' @return A dataframe with information about the number of requests available
#' for each component of the Github API.
#'
#' @examples
#' token <- geogit_token()
#' geogit_remaining_requests(token)
#'
#' @export
geogit_remaining_requests <- function(token) {
  if(typeof(token) != "list" || is.null(token$value)) {
    warning("Invalid token: a valid geogit_token is needed for this operation")
    return(invisible(NULL))
  }
  request_url <- paste("https://api.github.com/rate_limit", "?access_token=", token$value, sep = '')
  api_response <- content(GET(request_url), "parsed")
  data.frame(api_response$resources %>%
               bind_rows() %>%
               mutate(type = names(api_response$resources),
                      reset = lubridate::as_datetime(reset)) %>%
               select(type, limit, remaining, reset))
}
