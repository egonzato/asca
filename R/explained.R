# libraries
library(multiblock)
library(ggplot2)
library(dplyr)
library(stringr)
# model
model=asca(data=baba,
           Y ~ .,
           pca.in = 5)
# plot for explained variance
explained=function(model=NULL){
  bp=data.frame(model$explvar*100,str_to_title(names(model$explvar)))
  bp$str_to_title.names.model.explvar..[4]='Residual'
  names(bp)=c('Variance','Name')
  ggplot(aes(x=reorder(Name,Variance,decreasing=T),
             y=Variance,
             fill=Variance),
         data=bp)+
    geom_bar(stat="identity", colour='black')+
    scale_fill_gradient2(low="orange", high="red") +
    labs(x="\nDesign Effects", y="Explained variance\n", title = 'Variance explained by each factor') +
    theme_bw()
  
}
explained(model)
