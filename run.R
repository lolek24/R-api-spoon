port <- Sys.getenv('PORT')
print(as.numeric(port))

.libPaths()
capabilities()
print(getwd())

pr <- plumber::plumb("plumber.R")

pr$run(host="0.0.0.0", port=8080)