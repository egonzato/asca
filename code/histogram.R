# libraries
library(multiblock)
library(ggplot2)
library(dplyr)
library(stringr)
# calculate observed statistic
# full
mod.fin.full=asca(Y~.,
                  data = baba,
                  pca.in=2)
sse.full=as.data.frame(t(mod.fin.full$ssq))$res
df.full=length(mod.fin.full$effects) -1
# reduced
mod.fin.red=asca(Y~.-h,
                 data = baba,
                 pca.in=2)
sse.red=as.data.frame(t(mod.fin.red$ssq))$res
df.red=length(mod.fin.red$effects) -1
# statistic
F.fin=abs(((sse.red-sse.full)/( df.red - df.full))/(sse.full/df.full))
F.fin
# after the testing loop has been computed (see testing.R),
# using the stat vector as input, it is possible to
# plot an histogram 
stat=as.data.frame(stat)
names(stat)='stat'
abline=as.data.frame(cbind(F.fin,quantile(stat$stat,0.95)))
ggplot(data=stat,aes(x=stat))+
  geom_histogram(color='black', fill='red', alpha=0.62, bins=30)+
  labs(y='Count',
       x='Permutation statistics',
       title='Distribution of the test statistic')+
  annotate(geom='text',x=c(quantile(stat$stat,0.95)+0.001,F.fin-0.001),y=c(125),
           label=c('95-th percentile','Observed F'),color='black', size=2.7)+
  geom_vline(xintercept=c(quantile(stat$stat,0.95),F.fin),
             color=c('red','blue'), linetype='dashed', linewidth=1, show.legend=T)+
  theme_bw()
