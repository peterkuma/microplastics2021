
suppressMessages(source("create_lsa_script.r"))

args <- commandArgs(TRUE)

index <- as.integer(args[1])


script <- create_sie_script(index=index)

tmpfile <- tempfile("lsa_input_", tmpdir = ".", fileext = ".m")
writeLines(script, tmpfile)
cat(sprintf("%s\n", tmpfile))
