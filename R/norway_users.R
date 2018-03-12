#' Norway Github users data retrieved using `geogit` (03/12/2018)
#'
#'
#' @docType data
#' @name norway_users
#' @usage norway_users
#'
#' @keywords datasets
#'
#' @format
#'   A data frame with 300 cases, each of which is a GitHub user, with observations on the following variables.
#'   \itemize{
#'     \item{\code{login}} {User's GitHub username}
#'     \item{\code{created_at}} {The date the user's GitHub account was created}
#'     \item{\code{public_repos}} {The number of public repositories owned by the user}
#'     \item{\code{followers}} {The number of users who follow the current user on GitHub}
#'     \item{\code{following}} {The number of users the current user follows on GitHub}
#'     \item{\code{top_lang}} {The most used programming language across the last 100 repositories created by the current user}
#'     \item{\code{total_stars}} {The total number of stars across the repositories tied to the user (maximum of 100 repositories sorted by creation data)}
#'   }
#'
#' @source Data retrieved from the Github API (03/12/2018)
#'
#' @examples
#' norway_users
NA
