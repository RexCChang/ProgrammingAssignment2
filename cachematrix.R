## cachmatrix.R
## Provides functions that create the special matrix object that can cache its inverse

## Function: makeCacheMatrix
## Input: (Optional) theMatrix: a matrix
## This function creates a special matrix object (CacheMatrix) that contains:
##  - a matrix
##  - the inverse (initially set to null but can be set when computed)
##  - set(matrixData): sets the matrix to be matrixData, and reset the inverse to null
##  - get(): returns the matrix
##  - setinverse(inverseValue): sets the inverse to be inverseValue
##  - getinverse(): returns the inverse

makeCacheMatrix <- function(theMatrix = matrix()) {
  theInverse <- NULL
  set <- function(matrixData) {
    theMatrix <<- matrixData
    theInverse <<- NULL
  }
  get <- function() theMatrix
  setinverse <- function(inverseValue) theInverse <<- inverseValue
  getinverse <- function() theInverse
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


## Function: cacheSolve
## Input: a CacheMatrix object created by makeCacheMatrix
## This function takes a CacheMatrix and returns the inverse of the matrix in the data.
## (a) if the inverse is already computed (is not null), return the value
## (b) otherwise, get the matrix, compute the inverse with solve(), and set the inverse
##     value into the CacheMatrix
## Assumption:
## (a) The CacheMatrix object contains valid matrix data.
## (b) The matrix contained in CacheMatrix's inverse can be computed.

cacheSolve <- function(cacheMatrix, ...) {
  theInverse <- cacheMatrix$getinverse()
  if(!is.null(theInverse)) {
    message("getting cached inverse matrix")
    return(theInverse)
  }
  theMatrix <- cacheMatrix$get()
  theInverse <- solve(theMatrix)
  cacheMatrix$setinverse(theInverse)
  theInverse
  ## Return a matrix that is the inverse of 'theMatrix'
}
