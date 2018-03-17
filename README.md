# geogit
Explore Open Source Development on GitHub within a Location

`geogit` is a package that facilitates retrieving tidy Github data to explore open source development within a specific location. The functions within this package are designed to facilitate importing information about users and repositories using the GitHub API.

### Installation

```r
devtools::install_github("abelemlih/geogit")
```

### Setup

All the functions within `geogit` require a token to retrieve information from GitHub. A GitHub account is not needed to generate a token. However, tokens tied to a GitHub account can process a larger number of requests (5000 requests per hour, compared to 60 for unauthenticated users). To set the token:

```r
tk <- geogit_token('') #unauthenticated token
```

```r
tk <- geogit_token(Sys.getenv("GITHUB_TK")) #GitHub personal token
```

`eval` is set to `FALSE` for all the chunks below to avoid running the API requests at each testing phase of this project. It is preferred to get a GitHub personal token and create an authenticated token before running the commands shown below.

### Retrieve Users

`geogit_user` retrieves specific information about a user, like the number of public repositories or the the number of followers. To retrieve a single user by username:

```r
geogit_user("abelemlih", tk) %>% 
  select(login, created_at, bio, public_repos, public_gists, followers, following)
```

`geogit_location` retrieves basic information about the users that match best the search by location query. GitHub API only allows access to the first 1000 search results, and the results are divided into pages. Each page can have a maximum of 1000 search results. To retrieve the first 100 users from a location, sorted by followers:

```r
geogit_location("Ghana", tk) %>% 
  select(login, html_url) %>%
  mutate(country = "Ghana") %>%
  head(10)
```

The two functions can be used together to create a table that contains users that match best a location, with additional descriptive information like the number of followers or the number of public gists posted by the user:

```r
ghana_usernames <- geogit_location("Ghana", tk)$login
ghana_users <- tibble()
for (usr in ghana_usernames) {
  usr_info <- 
    geogit_user(usr, tk) %>% 
    select(login, created_at, bio, public_repos, public_gists, followers, following)
  ghana_users <- 
    ghana_users %>% 
    rbind(usr_info)
}
ghana_users %>% head(10)
```

### Retrieve repositories

`geogit_repos` facilitates retrieving information about a user's repositories. This is a core function that enables analyzing easily the type of projects a user creates or contributes to, their preferred programming language, the popularity of their repositories, etc. Repositories are also accessed using the same page system established for search results, and only 100 repositories can be accessed at the time. To retrieve a user's repositories by username, sorted by the last time they were updated:

```r
geogit_repos("hadley", tk, sort = "updated") %>%
  select(name, description, language, watchers, forks, open_issues)
```

The functionality of `geogit_repos` can be combined with the results from `geogit_user` and `geogit_location` to create a table of users within a location and their "most used programming language" for instance. We could set the "most programming language" as the language that is tied to the highest number of projects within the last 100 projects a user created. Let's explore the most used programming languages of the 100 most followed GitHub users who are based in Ghana:

```r
get_top_lang <- function(usr_login) {
  geogit_repos(usr_login, tk) %>%
    filter(owner == usr_login) %>%
    group_by(language) %>%
    summarise(total = n()) %>%
    arrange(desc(total)) %>%
    pull("language") %>%
    extract(1)
}

ghana_users$top_lang <- 
  ghana_users$login %>% 
  map(get_top_lang) %>%
  flatten_chr()

ghana_users %>% 
  select(login, public_repos, top_lang)
```

### API Rate Limit

`geogit` has a built-in functionality to easily retrieve the number of requests left per request category within the GitHub API structure: core, search, and graphql. To retrieve the rate limit table:

```r
geogit_remaining_requests(tk)
```

### Future Work

I am prioritizing the following:

* Implementing better error handling and testing for the package

* Implementing new features to facilitate exploring data about users and respositories on GitHub

### Contributing

Feel free to submit a pull request if you have any features/improvements to add to the package. You can also open an issue if you ecountered a problem while using the current core functionalities of the package.
