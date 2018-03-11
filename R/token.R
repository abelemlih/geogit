#' Create a token to access GitHub API
#'
#' You need a token to authenticate and access the Github API
#' through your Github account.
#'
#' @param github_access_token The personal access token from your Github
#' account's developer settings. If not provided, an unauthenticated token is generated.
#'
#' @details Authenticated account can process up to 5000 requests per hour
#' and 30 search requests per minute, instead of 60 requests per hour and 10 search
#' request per minute without authentication. For more information,
#' see https://developer.github.com/v3/#rate-limiting. To get a token,
#' you need a github account (See vignette).
#'
#' @return A token `list` for use in other geogit_ functions.
#'
#' @examples
#' geogit_token("personal_acess_token")
#'
#' @export
geogit_token <- function(github_access_token = '') {
  request_url <- paste("https://api.github.com/rate_limit", "?access_token=", github_access_token, sep = '')
  api_response <- GET(request_url)
  if (api_response$status_code != 200) {
    message("Bad credentials: invalid Github personal access token")
    return(invisible(NULL))
  }
  list("value" = github_access_token,
       "authenticaded" = ifelse(nchar(github_access_token)==0, FALSE, TRUE),
       "rate_limit" = content(api_response, "parsed")$rate$limit)
}
