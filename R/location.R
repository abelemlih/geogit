#' Import Github users from a specific location
#'
#' This function retrieves Github users from a specific location
#'
#' @param location Desired location to explore e.g. Morocco
#' @param token The geogit_token that contains access token information.
#' If not provided, the anonymous user token is used.
#' @param page Page number of search results. Maximum value is 10.
#' @param sort Value to sort followers by. You can sort users by
#' `followers`, `repositories`, or `joined` (account creation timestamp).
#'
#' @details The first 100 users who match the location are returned.
#' By default, the first page of the search is returned and the users are sorted by number of
#' followers. Each search page has a maximum of 100 search results, and
#' you can access the other search pages by changing the page parameter.
#' Github API limits the number of searches that can be retrieved to 1000 (10 pages).
#' Only users with at least 1 repository on Github are retrieved using this function.
#' This function is particulatly useful for retrieving the usernames that match a location.
#' To retrieve more information about a user, you can use `geogit_user`.
#'
#' @return A tibble that contains the users that match the given location.
#'
#' @examples
#' token <- geogit_token()
#' geogit_location("Morocco", token)
#' geogit_location("Morocco", token, page = 2)
#' geogit_location("Morocco", token, sort = "repositories")
#'
#' @export
geogit_location <- function(location, token, page = 1, sort = 'followers') {
  if(typeof(token) != "list" || is.null(token$value)) {
    warning("Invalid token: a valid geogit_token is needed for this operation")
    return(invisible(NULL))
  }
  request_url <- paste("https://api.github.com/search/users?q=type:user+repos:%3E0+location:", as.character(location),
                       "&per_page=100&sort=", sort,
                       "&page=",as.character(page),
                       "&access_token=", token$value,
                       sep = '')
  api_response <- content(GET(request_url), "parsed")
  api_response$items %>%
    bind_rows() %>%
    as_tibble()
}
