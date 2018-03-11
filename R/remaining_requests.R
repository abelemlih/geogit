#' Retrieve the number of remaining Github API requests available
#'
#' @param token The geogit_token used to retrieve data from Github
#'
#' @details There are three types of request categories within the Github API:
#' `core`, `search`, and `graphql`.
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
  api_response$resources %>%
    bind_rows() %>%
    mutate(type = names(api_response$resources), reset = lubridate::as_datetime(reset)) %>%
    select(type, limit, remaining, reset) %>%
    as_tibble()
}
