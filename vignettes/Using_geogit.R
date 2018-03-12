## ----setup, include = FALSE----------------------------------------------
library(tidyverse)
library(ggplot2)
library(geogit)
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
tk <- geogit_token('') #unauthenticated token

## ---- eval=FALSE---------------------------------------------------------
#  tk <- geogit_token(Sys.getenv("GITHUB_TK")) #GitHub personal token

## ---- eval=FALSE---------------------------------------------------------
#  geogit_user("abelemlih", tk) %>%
#    select(login, created_at, bio, public_repos, public_gists, followers, following)

## ---- eval=FALSE---------------------------------------------------------
#  geogit_location("Ghana", tk) %>%
#    select(login, html_url) %>%
#    mutate(country = "Ghana") %>%
#    head(10)

## ---- eval=FALSE---------------------------------------------------------
#  ghana_usernames <- geogit_location("Ghana", tk)$login
#  ghana_users <- tibble()
#  for (usr in ghana_usernames) {
#    usr_info <-
#      geogit_user(usr, tk) %>%
#      select(login, created_at, bio, public_repos, public_gists, followers, following)
#    ghana_users <-
#      ghana_users %>%
#      rbind(usr_info)
#  }
#  ghana_users %>% head(10)

## ---- eval=FALSE---------------------------------------------------------
#  geogit_repos("hadley", tk, sort = "updated") %>%
#    select(name, description, language, watchers, forks, open_issues)

## ---- eval = FALSE-------------------------------------------------------
#  get_top_lang <- function(usr_login) {
#    geogit_repos(usr_login, tk) %>%
#      filter(owner == usr_login) %>%
#      group_by(language) %>%
#      summarise(total = n()) %>%
#      arrange(desc(total)) %>%
#      pull("language") %>%
#      extract(1)
#  }
#  
#  ghana_users$top_lang <-
#    ghana_users$login %>%
#    map(get_top_lang) %>%
#    flatten_chr()
#  
#  ghana_users %>%
#    select(login, public_repos, top_lang)

## ------------------------------------------------------------------------
geogit_remaining_requests(tk)

