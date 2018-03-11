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
#  tk <- geogit_token("personal_github_token") #GitHub personal token

## ---- eval=FALSE---------------------------------------------------------
#  geogit_user("abelemlih", tk) %>%
#    select(login, created_at, bio, public_repos, public_gists, followers, following)

## ---- eval=FALSE---------------------------------------------------------
#  geogit_location("Ghana", tk) %>%
#    select(login, html_url) %>%
#    mutate(country = "Ghana") %>%
#    head(10)

## ---- eval=FALSE---------------------------------------------------------
#  Ghana_usernames <- geogit_location("Ghana", tk)$login
#  detailed_Ghana_users <- tibble()
#  for (usr in Ghana_usernames) {
#    usr_info <-
#      geogit_user(usr, tk) %>%
#      select(login, created_at, bio, public_repos, public_gists, followers, following)
#    detailed_Ghana_users <-
#      detailed_Ghana_users %>%
#      rbind(usr_info)
#  }
#  detailed_Ghana_users %>% head(10)

## ---- eval=FALSE---------------------------------------------------------
#  geogit_repos("hadley", tk, sort = "updated") %>%
#    select(name, description, language, watchers, forks, open_issues)

## ---- eval = FALSE-------------------------------------------------------
#  preferred_languages <- c()
#  for (usr in detailed_Ghana_users$login) {
#    usr_lang <-
#      geogit_repos(usr, tk) %>%
#      group_by(language) %>%
#      summarise(total = n()) %>%
#      arrange(desc(total))
#  
#    preferred_languages <- c(preferred_languages, head(usr_lang, 1)$language)
#  }
#  
#  detailed_Ghana_users %>%
#    mutate(pref_lang = preferred_languages) %>%
#    select(login, public_repos, pref_lang)

## ------------------------------------------------------------------------
geogit_remaining_requests(tk)

