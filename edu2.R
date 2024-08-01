install.packages("dplyr")
library(dplyr)

path <- "자료의 경로"
df <- read_xlsx(path)

df %>%
  filter(wave == 5) %>%
  select(acc1, gender)

## 4.1.1 ##
df %>%
  filter(hire1 >= 2016)

df %>%
  filter(hire1 == 2016)

df %>%
  filter(hire1 >= 2016 & gender == 2)

df %>%
  filter(hire1 >= 2016 | gender == 2)

df %>%
  filter(hire1 == 2014 | hire1 == 2015 | hire1 == 2016)

df %>%
  filter(hire1 %in% 2014:2016)
df %>%
  filter(hire1 %in% c(2014, 2015, 2016))

## 4.1.2 ##
df %>%
  arrange(hire1)

df %>%
  arrange(hire1, hire2)

df %>%
  arrange(desc(hire1))

## 4.2.1 ##
ifelse(df$E1042002 >= 10, 1, 0)

na.omit(ifelse(df$E1042002 >= 10, 1, 0))

df %>%
  mutate(return = ifelse(E1042002 >= 10, 1, 0))

df %>%
  mutate(return = ifelse(E1042002 >= 10, 1, 0),
         .before = pid)

df %>%
  mutate(income.idx = case_when(
    H002001 <= 1400 ~ 1,
    H002001 > 1400 & H002001 <= 5000 ~ 2,
    H002001 > 5000 & H002001 <= 8800 ~ 3,
    TRUE ~ 4
  ))

## 4.2.2 ##
df %>%
  select(workperiod14, accident, injurytype)

df %>%
  select(workperiod14:injurytype)

df %>%
  select(-(workperiod14:injurytype))

df %>%
  select(where(is.character))

## 4.2.3 ##
df %>%
  rename(work_p = workperiod14)

## 4.2.4 ##
df %>%
  relocate(wave, nonresponse)

## 4.3.2 ##
df %>%
  summarise(mean = mean(E1042002),
            sd = sd(E1042002),
            max = max(E1042002),
            min = min(E1042002),
  )

df %>%
  summarise(mean = mean(E1042002, na.rm = TRUE),
            sd = sd(E1042002, na.rm = TRUE),
            max = max(E1042002, na.rm = TRUE),
            min = min(E1042002, na.rm = TRUE),
  )

df %>%
  group_by(gender) %>%
  summarise(mean = mean(E1042002, na.rm = TRUE),
            sd = sd(E1042002, na.rm = TRUE),
            max = max(E1042002, na.rm = TRUE),
            min = min(E1042002, na.rm = TRUE),
  )

df %>%
  group_by(gender) %>%
  summarise(count = n())


df %>%
  group_by(gender, age4) %>%
  summarise(count = n())

df %>%
  count(gender, age4)

## 4.4 ##

gender <- data.frame(pid = c(16, 18, 23, 20, 22), gender = c("M", "M", "F", "F", "M"))
disability <- data.frame(pid = c(16, 18, 19, 20, 21), disability = c("지체장애", "뇌병변장애", "시각장애", "지체장애", "시각장애"))

gender %>% 
  inner_join(disability, by = "pid")

## 4.5 ##
library(lubridate)

today()
now()

event1 <- "2014-05-21"
event2 <- "2014-05-30"

typeof(c(event1, event2))

event2 - event1
ymd(event2) - ymd(event1)

ymd("2024-07-22")
mdy("07-22-2024")
dmy("22-July-2024")

ymd("2024년 07월 22일")

ymd_hms("2024-07-22 16:39:22")

data %>% 
  mutate(hire_time = make_date(hire1, hire2)) %>% 
  .$hire_time %>% 
  head()

paste0(hire1, "년", hire2, "월", "01일")

data %>% 
  mutate(hire_time = ymd(paste0(hire1, "년", hire2, "월", "01일"))) %>% 
  .$hire_time %>% 
  head()

date.time <- ymd("2024-07-22")

year(date.time)
month(date.time)
mday(date.time)

yday(date.time)
wday(date.time)

## 5 ##
table(df$age4)
table(df$age4, df$gender)

xtabs( ~ age4, df)
xtabs( ~ age4 + gender, df)

table1 <- table(df$age4, df$gender)
table1

colnames(table1) <- c("male", "female")
rownames(table1) <- c("~30", "40", "50", "~60")

table1

prop.table(table1)
prop.table(table1, margin = 1)
prop.table(table1, margin = 2)

margin.table(table1, margin = 1)
margin.table(table1, margin = 2)

r.table <- rbind(table1, margin.table(table1, margin = 2))

install.packages("flextable")
library(flextable)

flextable(head(df), col_keys = c("wave", "workperiod14", "accident"))

flextable(head(df), col_keys = c("wave", "workperiod14", "accident")) %>% 
  set_header_labels(wave = "조사차수",
                    workperiod14 = "근로기간",
                    accident = "산업재해유형")

flextable(head(df), col_keys = c("wave", "workperiod14", "accident")) %>% 
  set_header_labels(wave = "조사차수",
                    workperiod14 = "근로기간",
                    accident = "산업재해유형") %>% 
  width(width = 1.1) 

flextable(head(df), col_keys = c("wave", "workperiod14", "accident")) %>% 
  set_header_labels(wave = "조사차수",
                    workperiod14 = "근로기간",
                    accident = "산업재해유형") %>% 
  width(width = 1.1) %>% 
  bold(j = 1)

flextable(head(df), col_keys = c("wave", "workperiod14", "accident")) %>% 
  set_header_labels(wave = "조사차수",
                    workperiod14 = "근로기간",
                    accident = "산업재해유형") %>% 
  width(width = 1.1) %>% 
  color(i = 1, color = "red")

table1 <- xtabs(~ age4 + disa6, data = df %>% 
                  filter(gender == 1))

table1 <- cbind(table1, margin.table(table1, margin = 1))
table1 <- rbind(table1, margin.table(table1, margin = 2))

flextable(table1)

table1 <- as.data.frame.matrix(table1)

man.table <- data.frame(성별 = "남성",
                        연령대 = c("30대 이하", "40대", "50대", "60대 이상", "소계"),
                        table1)

flextable(man.table) %>% 
  set_header_labels(성별 = "성별",
                    연령대 = "연령대",
                    X1 = "1~3급", X2 = "4~7급", X3 = "8~9급", X4 = "10~12급",
                    X5 = "13~14급", X6  = "무상해", V7 = "합계")

flextable(man.table) %>% 
  set_header_labels(성별 = "성별",
                    연령대 = "연령대",
                    X1 = "1~3급", X2 = "4~7급", X3 = "8~9급", X4 = "10~12급",
                    X5 = "13~14급", X6  = "무상해", V7 = "합계") %>% 
  merge_at(i = 1:5, j = 1)

flextable(man.table) %>% 
  set_header_labels(성별 = "성별",
                    연령대 = "연령대",
                    X1 = "1~3급", X2 = "4~7급", X3 = "8~9급", X4 = "10~12급",
                    X5 = "13~14급", X6  = "무상해", V7 = "합계") %>% 
  merge_at(i = 1:5, j = 1) %>% 
  add_header_row(values = c("", "장해등급", ""),
                 colwidths = c(2, 6, 1)) %>% 
  theme_vanilla() %>% 
  align(align = "center", part = "header") %>%
  autofit()

flextable(man.table) %>% 
  set_header_labels(성별 = "성별",
                    연령대 = "연령대",
                    X1 = "1~3급", X2 = "4~7급", X3 = "8~9급", X4 = "10~12급",
                    X5 = "13~14급", X6  = "무상해", V7 = "합계") %>% 
  merge_at(i = 1:5, j = 1) %>% 
  add_header_row(values = c("", "장해등급", ""),
                 colwidths = c(2, 6, 1)) %>% 
  theme_vanilla() %>% 
  align(align = "center", part = "header") %>%
  vline(j = c(1, 2, 8), part = "body") %>% 
  autofit()
