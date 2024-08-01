library(dplyr)
library(readxl)
library(lubridate)
library(flextable)
##
df <- read_xlsx("")
dim(df)

##
df1 <- df %>%
  filter(wave == 1)
df2 <- df %>%
  filter(wave == 2)

##
df1 <- df1 %>%
  mutate(start1 = make_date(E1001001, E1001002),
         end1 = make_date(F001002, F001003))
df2 <- df2 %>%
  mutate(start2 = make_date(E1001001, E1001002),
         end2 = make_date(F001002, F001003))

##
df1 <- df1 %>% 
  dplyr::select(pid, start1, end1, industry1 = E1001005, jobs1 = E1004002, status1 = E1005001, wage1 = E1017001)

df2 <- df2 %>% 
  dplyr::select(pid, start2, end2, industry2 = E1001005, jobs2 = E1004002, status2 = E1005001, wage2 = E1017001)

##
df %>% 
  mutate(start = make_date(E1001001, E1001002),
         end = make_date(F001002, F001003)) %>% 
  group_by(pid) %>% 
  filter(wave %in% c(1, 2) & sum(is.na(start)) == 0) %>% 
  tally()

df %>% 
  mutate(start = make_date(E1001001, E1001002),
         end = make_date(F001002, F001003)) %>% 
  group_by(pid) %>% 
  filter(wave %in% c(1, 2) & sum(is.na(end)) == 0) %>% 
  dplyr::select(pid, start, end) %>% 
  head()

##
joined.df <- df1 %>% 
  inner_join(df2, by = "pid") %>% 
  filter(!is.na(start1))

##
joined.df <- joined.df %>% 
  mutate(start = start1,
         end = coalesce(end2, end1),
         jobs = coalesce(jobs2, jobs1),
         status = coalesce(status2, status1),
         industry = coalesce(industry2, industry1),
         wage = coalesce(wage2, wage1)) %>% 
  dplyr::select(-(start1:wage2))

##
joined.df <- joined.df %>% 
  mutate(end = if_else(is.na(end), ymd("2019-11-01"), end))

##
a1 <- joined.df %>% 
  mutate(interval = interval(start, end) %/% months(1)) %>% 
  filter(interval > 0)

a2 <- joined.df %>% 
  mutate(interval = interval(start, end) %/% months(1)) %>% 
  filter(interval < 0) %>% 
  mutate(end = ymd("2019-11-01"),
         interval = interval(start, end) %/% months(1))

##
final.df <- rbind(a1, a2)

##
final.df <- final.df %>% 
  mutate(keep = factor(ifelse(year(start) <= 2018 & end == ymd("2019-11-01"), 1, 0), levels = c(1, 0)))

## 3 ##
head(final.df)
str(final.df)

table(final.df$keep)

hist(final.df$interval, breaks = 30)

final.df %>% 
  summarise(mean = mean(interval),
            max = max(interval),
            min = min(interval))

## 4 ##
jobs.table <- xtabs(~ keep + jobs, data = final.df)
jobs.table

status.table <- xtabs(~ keep + status, data = final.df)
status.table

industry.table <- xtabs(~ keep + industry, data = final.df)
industry.table

prop.table(jobs.table, margin = 1) %>% 
  round(2)

prop.table(status.table, margin = 1) %>% 
  round(2)

prop.table(industry.table, margin = 1) %>% 
  round(2)

final.df %>% 
  group_by(keep) %>% 
  summarise(mean = mean(wage),
            sd = sd(wage),
            median = median(wage),
            min = min(wage),
            max = max(wage))

table1 <- prop.table(status.table, margin = 1) %>% 
  round(2)

table1 <- data.frame(고용유지여부 = c("예", "아니요"),
                     as.data.frame.matrix(table1))

flextable(table1) %>% 
  set_header_labels(X1 = "상용직",
                    X2 = "임시직",
                    X3 = "일용직") %>% 
  theme_vanilla() %>% 
  add_header_row(values = "고용유지여부와 종사상지위에 따른 교차표",
                 colwidths = 4) %>% 
  align(align = "center", part = "header") %>% 
  width(width = 1.2, j = 1)

table2 <- final.df %>% 
  group_by(keep) %>% 
  summarise(mean = mean(wage),
            sd = sd(wage),
            median = median(wage),
            min = min(wage),
            max = max(wage))

table2 <- data.frame(고용유지여부 = c("예", "아니요"),
                     table2[, 2:6])

flextable(table2) %>% 
  set_header_labels(mean = "평균",
                    sd = "표준편차",
                    median = "중위수",
                    min = "최소값",
                    max = "최대값") %>% 
  width(width = 1.2, j = 1) %>% 
  theme_vanilla() %>% 
  add_header_row(values = "고용유지여부에 따른 한달 임금 기초통계량",
                 colwidths = 6) %>% 
  align(align = "center", part = "header") %>% 
  colformat_double()