context("tokens")

test_that("valid anonymous token", {
  token <- geogit_token()
  expect_equal(token$authenticaded, FALSE)
  expect_equal(token$rate_limit, 60)
  api_response <- GET(paste("https://api.github.com/users/abelemlih?access_token=", token$value, sep = ''))
  expect_equal(api_response$status_code, 200)
})

test_that("invalid token", {
  token <- geogit_token("invalid_token")
  expect_equal(token, NULL)
})
