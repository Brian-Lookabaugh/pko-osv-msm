# Load Libraries
pacman::p_load(
  "ggplot2", # Data Visualization
  "ggdag", # Visualizing DAGs
  "dagitty", # DAGs
  install = FALSE
)

# DAG of Exposure-Outcome Feedback Loop with One Time-Invariant Confounder
loop_dag <- dagitty('dag {
  "Oil" [pos="2.5,2"]
  "PKO[t-1]" [pos="1,1"]
  "OSV[t-1]" [pos="2,1.25"]
  "PKO[t]" [pos="3,1"]
  "OSV[t]" [pos="4,1.25"]
  "Oil" -> "PKO[t-1]"
  "Oil" -> "OSV[t-1]"
  "Oil" -> "PKO[t]"
  "Oil" -> "OSV[t]"
  "PKO[t-1]" -> "OSV[t-1]"
  "OSV[t-1]" -> "PKO[t]"
  "PKO[t]" -> "OSV[t]"
  "PKO[t-1]" -> "PKO[t]"
  "OSV[t-1]" -> "OSV[t]"
}') %>%
  tidy_dagitty()

ggplot(loop_dag, aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_dag_edges() +
  geom_dag_text(color = "black", size = 5, parse = TRUE, family = "serif") +
  theme_dag()

# DAG of Time-Varying Confounding Creating Collider Bias
overadjust_dag <- dagitty('dag {
  "PKO[t-1]" [pos="1,3"]
  "OSV[t-1]" [pos="3,3"]
  "PKO[t]" [pos="1,1"]
  "OSV[t]" [pos="3,1"]
  "Duration[t-1]" [pos="2,4"]
  "Duration[t]" [pos="2,2"]
  "U[t]" [pos="2.5, 2.5"]
  "Duration[t-1]" -> "PKO[t-1]"
  "Duration[t-1]" -> "OSV[t-1]"
  "Duration[t-1]" -> "Duration[t]"
  "PKO[t-1]" -> "OSV[t-1]"
  "PKO[t-1]" -> "Duration[t]"
  "PKO[t-1]" -> "PKO[t]"
  "OSV[t-1]" -> "OSV[t]"
  "Duration[t]" -> "PKO[t]"
  "Duration[t]" -> "OSV[t]"
  "PKO[t]" -> "OSV[t]"
  "U[t]" -> "OSV[t]"
  "U[t]" -> "Duration[t]"
}') %>%
  tidy_dagitty()

ggplot(overadjust_dag, aes(x = x, y = y, xend = xend, yend = yend)) +
  geom_dag_edges() +
  geom_dag_text(color = "black", size = 5, parse = TRUE, family = "serif") +
  theme_dag()
