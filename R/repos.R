#' Retrieve information about a Github user's repositories.
#'
#' This function retrieves information about a user's public repositories on GitHub.
#'
#' @param github_username The Github user's username on the platform.
#' @param token The geogit_token that contains access token information.
#' @param page The page number of the repository results returned by the API
#' @param sort The parameter to sort the repositories by. You can sort repositories
#' by date created `created`, date updated `updated`, or date pushed `pushed`.
#'
#' @details All pieces of information provided by the Github API about the repositories are returned.
#' Only the first 100 repositories from the API response will be returned. Use the page parameter
#' to access different pages of the repositories API response. Each page can have a maximum
#' of 100 results. Iterate through multiple pages to retrieve all repositories.
#'
#' @return A tibble that contains the given user's repository information.
#'
#' @examples
#' token <- geogit_token()
#' geogit_repos("abelemlih", token)
#'
#' @export
geogit_repos <- function(github_username, token, page = 1, sort = "created") {
  if(typeof(token) != "list" || is.null(token$value)) {
    warning("Invalid token: a valid geogit_token is needed for this operation")
    return(invisible(NULL))
  }
  request_url <- paste("https://api.github.com/users/", github_username,
                       "/repos?sort=", sort,
                       "&page=", as.character(page),
                       "&per_page=100&access_token=", token$value,
                       sep = '')
  api_response <- content(GET(request_url), "parsed")
  api_response %>%
    map(format_repo) %>%
    bind_rows() %>%
    as_tibble()
}

format_repo <- function(repo) {
  repo %>%
    map(function(x) ifelse(is.null(x), NA, x))
}
