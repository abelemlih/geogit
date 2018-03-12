## ----setup, include = FALSE----------------------------------------------
library(tidyverse)
library(ggplot2)
library(geogit)
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- eval = FALSE-------------------------------------------------------
#  tk <- geogit_token(Sys.getenv("GITHUB_TK"))
#  
#  norway_usernames <-
#    geogit_location("Norway", tk, page = 1) %>%
#    rbind(geogit_location("Norway", tk, page = 2)) %>%
#    rbind(geogit_location("Norway", tk, page = 3))
#  
#  norway_usernames <- norway_usernames$login

## ---- eval=FALSE---------------------------------------------------------
#  norway_users <- tibble()
#  for (usr in norway_usernames) {
#    usr_info <-
#      geogit_user(usr, tk) %>%
#      select(login, created_at, public_repos, followers, following)
#    norway_users <-
#      norway_users %>%
#      rbind(usr_info)
#  }
#  norway_users %>% head(10)

## ---- eval=FALSE---------------------------------------------------------
#  norway_users_repos <- tibble()
#  for (usr in norway_users$login) {
#    norway_users_repos <-
#      norway_users_repos %>%
#      rbind(geogit_repos(usr, tk))
#  }

## ---- eval=FALSE---------------------------------------------------------
#  get_top_lang <- function(usr_login) {
#    norway_users_repos %>%
#      filter(owner == usr_login) %>%
#      group_by(language) %>%
#      summarise(total = n()) %>%
#      arrange(desc(total)) %>%
#      pull("language") %>%
#      extract(1)
#  }
#  
#  norway_users$top_lang <-
#    norway_users$login %>%
#    map(get_top_lang) %>%
#    flatten_chr()

## ---- eval=FALSE---------------------------------------------------------
#  get_stars <- function(usr_login) {
#    norway_users_repos %>%
#      filter(owner == usr_login & fork == FALSE) %>%
#      pull("stargazers_count") %>%
#      sum()
#  }
#  
#  norway_users$total_stars <-
#    norway_users$login %>%
#    map(get_stars) %>%
#    flatten_int()

## ---- eval=FALSE---------------------------------------------------------
#  norway_users %>%
#    arrange(desc(total_stars)) %>%
#    head(30) %>%
#    ggplot(aes(x = reorder(login, total_stars), y = total_stars)) +
#      geom_bar(fill = "#228B22", stat = "identity") +
#      labs(title = "Most Starred Users in Norway", x = "Usernames", y = "Number of Stars") +
#      coord_flip()

## ---- eval=FALSE---------------------------------------------------------
#  norway_users %>%
#    arrange(desc(followers)) %>%
#    head(30) %>%
#    ggplot(aes(x = reorder(login, followers), y = followers)) +
#      geom_bar(fill = "#228B22", stat = "identity") +
#      labs(title = "Most Followed Users in Norway", x = "Usernames", y = "Number of Followers") +
#      coord_flip()

## ---- eval=FALSE---------------------------------------------------------
#  norway_users %>%
#    filter(!is.na(top_lang)) %>%
#    group_by(top_lang) %>%
#    summarise(total = n()) %>%
#    arrange(desc(total)) %>%
#    head(30) %>%
#    ggplot(aes(x = reorder(top_lang, total), y = total)) +
#      geom_bar(fill = "#228B22", stat = "identity") +
#      labs(title = "Most Popular Programming Languages in Norway", x = "Programming Languages", y = "Number of Users") +
#      coord_flip()

