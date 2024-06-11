library(dplyr)

ucbdf <- UCBAdmissions %>%
  as.data.frame() %>%
  slice(rep(1:n(), Freq)) %>%
  select(-Freq)

ucbdf %>%
  group_by(Admit, Gender, Dept) %>%
  count() %>%
  ungroup() %>%
  left_join(UCBAdmissions %>% 
              as.data.frame(), by = c("Admit", "Gender", "Dept")) %>%
  mutate(eq = n == Freq) %>%
  pull(eq) %>%
  all()

ucbdf <- ucbdf %>% rename(Sex = Gender)

write.csv(ucbdf, "data/UCBAdmission2.csv", row.names = FALSE, quote = TRUE)
