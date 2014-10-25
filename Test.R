source("cachematrix.R")
myMatrix<-matrix(1:4,2,2)
nonMatrix<-c(1,2,3,4)
##test the makeCacheMatrix function with nonMatrix parameter
cacheMatrix<-makeCacheMatrix(nonMatrix)
cacheMatrix<-makeCacheMatrix()
##test the set function with nonMatrix parameter
cacheMatrix$set(nonMatrix)
cacheMatrix<-makeCacheMatrix(myMatrix)
##caclulate the inverse for the first time
cacheSolve(cacheMatrix)
##get cached data
cacheSolve(cacheMatrix)

##if the parameter is matrix,result cannot be cached.
cacheSolve(myMatrix)
cacheSolve(myMatrix)