saints_data <- afl_player_pos_data %>%
  
  filter(team == "St Kilda") %>% 
  
  #filter and try scored vars
  dplyr::mutate(position = as.character(position)) %>% 
  dplyr::mutate(goal_scored = as.factor(ifelse(stats.goals > 0, "Yes", "No")),
                shots = stats.goals + stats.behinds,
                conversion = stats.goals/shots,
                position_line = case_when(position_code %in% c("BP", "FB") ~ "Full Back",
                                          position_code %in% c("HB", "CHB") ~ "Centre Half Back",
                                          position_code %in% c("RCK") ~ "Ruck",
                                          position_code %in% c("RR", "WNG", "ROV", "CEN") ~ "Midfield",
                                          position_code %in% c("FP", "FF") ~ "Full Forward",
                                          position_code %in% c("HF", "CHF") ~ "Centre Half Forward",
                                          position_code %in% c("INT", "EMG")  ~ "Interchange",
                                          
                                          
                                          TRUE ~ "Unknown"),
                
                position_group = case_when(position_code %in% c("BP", "FB") ~ "Back",
                                           position_code %in% c("HB", "CHB") ~ "Back",
                                           position_code %in% c("RCK") ~ "Ruck",
                                           position_code %in% c("RR", "WNG", "ROV", "CEN") ~ "Midfield",
                                           position_code %in% c("FP", "FF") ~ "Forward",
                                           position_code %in% c("HF", "CHF") ~ "Forward",
                                           position_code %in% c("INT", "EMG")  ~ "Interchange",
                                           
                                           
                                           TRUE ~ "Unknown"),
                
                height = case_when(height_cm > 190 ~ "Tall",
                                   height_cm < 182 ~ "Small",
                                   
                                   TRUE ~ "Medium"),
                
                position_line_type = ifelse(position_group == "Ruck", "Ruck - Tall", paste(position_line, "-", height)),
                position_group_type = ifelse(position_group == "Forward", paste(position_group, "-", height), position_group))

saints_data_season <- saints_data %>% 
  dplyr::group_by(season, full_name) %>% 
  dplyr::summarise_at(vars(contains("stats.")), mean)

saints_data %>% 
  dplyr::filter(season == 2020,
                position_line == "Midfield") %>% 
ggplot(aes(x=full_name, y=stats.clearances)) + 
  geom_boxplot(aes(fill=stats.clearances))
bp

