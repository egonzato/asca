# libraries
library(multiblock)
library(ggplot2)
library(dplyr)
# model
model=asca(data=baba,
           Y ~ .,
           pca.in = 5)
# function where k stands for the index of the considered variable
plotscoreasca=function(model=NULL,k=NULL){
  # select scores
  projected=model[[3]]
  proj.obs=as.data.frame(projected[k])[,1:2]
  scores=as.data.frame(model[[1]][k])[,1:2]
  # select var to be used for testing
  var.col=doe[[k]]
  # cbind comp var
  df.plot=as.data.frame(cbind(proj.obs,var.col,scores))
  names(df.plot)=c('P1','P2','Group','S1','S2')
  # plot
  df.plot %>%
    ggplot()+
    geom_point(aes(x=P1,y=P2,color=Group))+
    geom_point(aes(x=S1,y=S2,color=Group,size=1.5))+
    stat_ellipse(aes(x=P1,y=P2,color=Group))+
    guides(size='none')+
    labs(x=paste('Component 1 (',round(attr(projected[[1]],'explvar')[1]),'%)',sep=''),
         y=paste('Component 1 (',round(attr(projected[[1]],'explvar')[2]),'%)',sep=''),
         title='Score plot')+
    theme_bw()
}

plotscoreasca(model,k=2)
