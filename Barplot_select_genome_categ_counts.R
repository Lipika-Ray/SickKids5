library(ggplot2)
library(gridExtra)
library(cowplot)

filenames <- Sys.glob("select_stackbar*.out"); ## List the files with a specific name

plots = list()

for(i in 1:length(filenames)) {
    data <- read.table(file=filenames[i], header = TRUE, sep = "\t")
    plots[[i]] <- ggplot(data, aes(x=category, y=counts, fill = ID)) + geom_bar(position = "stack", stat = "identity") + ccord_flip() + theme(axis.text = element_text(size=8), axis.title.x = element_blank(), axis.title.y = element_blank(), plot.margin = unit(c(0.05,0.05,0.05,0.05),"cm"), legend.position = "none") + background_grid(major = "xy", minor = "none") + panel_border() )
}

dleg <- get_legend(plots[[1]] + theme(legend.position = "bottom"))  ## Get legend

pdf("zplots_select_stack_all.pdf")
do.call(grid.arrange,c(plots, ncol = 4, nrow = 6))
dev.off()
