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
#' @return A data frame that contains the given user's information.
#'
#' @examples
#' geogit_user("abelemlih")
#'
#' @export
geogit_user <- function(github_user, token = '') {
  request_url <- paste("https://api.github.com/users/", github_user, "?access_token=", token, sep = '')
  api_response <- content(GET(request_url), "parsed") %>%
    map(function(x) ifelse(is.null(x), NA, x))
  data.frame(api_response)
}
