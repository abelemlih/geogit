#' Create a token to access GitHub API
#'
#' You need a token because ...
#' This can be as long as needed.
#'
#' @param github_access_token The string from your github settings ... blah blah
#' If not provided, an anonymous token is generated.
#'
#' @details With an anonymous token, your access is limited to ...
#' To get a token, you need a github account: See vignette.
#'
#' @return A token object for use in other geogit_ functions.
#'
#' @examples
#' geogit_token("Something that looks right.")
#'
#' @export
geogit_token <- function(github_access_token) {
  say_hello("Ayoub")
}

# Just to show.
say_hello <- function(name) {
  paste("Hello,", name)
}
