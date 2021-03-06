#' Import user information from Github
#'
#' This function retrieves a Github user's public information
#'
#' @param github_username Github user's username on the platform.
#' @param token geogit_token that contains access token information.
#' If not provided, the anonymous user token is used.
#'
#' @details All pieces of information provided by the Github API about the user are returned.
#'
#' @return A tibble that contains the given user's information.
#'
#' @examples
#' token <- geogit_token()
#' geogit_user("abelemlih", token)
#'
#' @export
geogit_user <- function(github_username, token) {
  if(typeof(token) != "list" || is.null(token$value)) {
    warning("Invalid token: a valid geogit_token is needed for this operation")
    return(invisible(NULL))
  }
  request_url <- paste("https://api.github.com/users/", github_username, "?access_token=", token$value, sep = '')
  api_response <- content(GET(request_url), "parsed") %>%
    map(function(x) ifelse(is.null(x), NA, x))
  as_tibble(api_response)
}
