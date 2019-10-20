# plumber.R

#' Echo the parameter that was sent in
#' @param msg The message to echo back.
#' @get /echo
function(msg=""){
  list(msg = paste0("The message is: '", msg, "'"))
}

#' Plot out data from the iris dataset
#' @param spec If provided, filter the data to only this species (e.g. 'setosa')
#' @serializer contentType list(type="image/png")
#' @get /plot
function(spec){
  myData <- iris
  title <- "All Species"
  
  # Filter if the species was specified
  if (!missing(spec)){
    title <- paste0("Only the '", spec, "' Species")
    myData <- subset(iris, Species == spec)
  }
  
  ## copy current plot to a (large) PNG file
  ##dev.print(png, file = "myplot.png")
  
  ##x11()
  tmpfile <- tempfile()
  png(tmpfile)
  ##png(file = "myplot.png", bg = "transparent", width = 1024, height = 768)
  plot(myData$Sepal.Length, myData$Petal.Length,
       main=title, xlab="Sepal Length", ylab="Petal Length")
  dev.off()
  
  result <- readBin(tmpfile, "raw", n=file.info(tmpfile)$size )
  
  return(result)
}

#' Plot a histogram
#' @png
#' @get /plot2
function(){
  rand <- rnorm(100)
  shist(rand)
}

#' Return the sum of two numbers
#' @param a The first number to add
#' @param b The second number to add
#' @post /sum
function(a, b){
  as.numeric(a) + as.numeric(b)
}