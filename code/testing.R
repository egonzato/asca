# libraries
library(multiblock)
library(doParallel)
library(foreach)
library(gtools)
# try parallelization
stat=c()
foreach(i = 1:1000, .combine = 'c') %do% {
  # reproducibillity
  seed=181299+i*10
  set.seed(seed)
  # permutation
  shuff=ymat[permute(1:dim(ymat)[1]),]
  # create dataset that will be used to test
  unl=unlist(shuff, use.names=F)
  baba=data.frame(Y=I(matrix(as.numeric(unl), ncol = dim(ymat)[2])),
                  doe)
  # full model
  mod.full=asca(Y~.,
                data = baba,
                pca.in=5)
  sse.full=as.data.frame(t(mod.full$ssq))$res
  df.full=length(mod.full$effects) -1
  # reduced model
  mod.reduced=asca(Y~ . - h,
                   data = baba,
                   pca.in=5)
  sse.reduced=as.data.frame(t(mod.reduced$ssq))$res
  df.reduced=length(mod.reduced$effects) -1
  # stat. test
  F=abs(((sse.reduced-sse.full)/( df.reduced - df.full))/(sse.full/df.full))
  # distribuzione
  stat=rbind(stat,F)
}

