# simulate four categorical variables
# set obs for each var
n=300
# create sort of doe matrix
set.seed(181299)
h=sample(rep(seq(1,3,1),100))
w=sample(rep(seq(1,5,1),60))
z=sample(rep(seq(1,6,1),50))
doe=as.data.frame(cbind(h,w,z))
doe=as.data.frame(lapply(doe,as.factor))
# now suppose we are in the omics context, let's simulate 100 y variables
ys=c()
# I will concatenate all 100 variables to the 
# same vector and then reorder it in a matrix
for (j in 1:100){
  set.seed(181299+j*10)
  mu=round(ceiling(runif(1,15,25)))
  sigma=round(ceiling(runif(1,0,5)))
  y=abs(rnorm(n,mu,sigma))
  ys=c(ys,y)
}
# add factors to the same matrix, asIs fundamental to keep ys in the same col
ymat=matrix(ys,ncol=100)
baba=data.frame(Y=I(matrix(ys,ncol=100)),doe)
