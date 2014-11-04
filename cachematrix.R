##Following method is used for caching the inverse of a matrix rather than copute it repeatly

## This function creates a special "matrix" object that can cache its inverse.
makeCacheMatrix <- function(x = matrix()) {
        if(!is.matrix(x)){
                stop("Only matrix parameter is accepted")
        }
        cache<-NULL
        set<-function(y){
                if(!is.matrix(y)){
                        stop("Only matrix parameter is accepted")
                }
                ##if y is same as x, don't reset the cahce. 
                if(!identical(x,y)){
                        x<<-y
                        cache<<-NULL                        
                }
        }
        get<-function() x
        setinverse<-function(inverse){
                cache<<-inverse
        }
        getinverse<-function(){
                cache
        }
        list(set=set,get=get,
             setinverse=setinverse,
             getinverse=getinverse)
}


## This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. 
## If the inverse has already been calculated (and the matrix has not changed), 
## then the cachesolve should retrieve the inverse from the cache.
cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        ##check the type of the parameter
        if(!is.CacheMatrix(x)){
                if(is.matrix(x)){
                     warning("Parameter is a matrix,the inverse of this matrix cannot be cached")   
                     x<-makeCacheMatrix(x)
                }
                else{
                        stop("Invalid CacheMatrix")
                }
        }
        inverse<-x$getinverse()
        if(!is.null(inverse)){
                message("return cached inverse result")
                inverse
        }
        else{
                ## assume that the matrix supplied is always invertible.
                inverse<-solve(x$get(),...)
                x$setinverse(inverse)
                inverse
        }
}

##check if the object is CacheMatrix
is.CacheMatrix<-function(cm){
        namelist<-c("get","set","getinverse","setinverse")
        if(!is.list(cm)){
                return(FALSE)
        }
        for(name in namelist){
                if(!exists(name,cm)){
                        return(FALSE)
                }
        }
        return(TRUE)
}
