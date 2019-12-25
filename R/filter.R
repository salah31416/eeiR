##-------------------------------------------------------------
## 
##-------------------------------------------------------------
.firstup = function(x) 
{
	x = tolower(x)
	x = gsub("(?<=[\\s])\\s*|^\\s+|\\s+$", "", x, perl=TRUE)
	substr(x, 1, 1) <- toupper(substr(x, 1, 1))

	return(x)
}#end firstup

##-------------------------------------------------------------
## 
##-------------------------------------------------------------
.nword = function(x) lengths(strsplit(x, "\\W+"))#end nword

##-------------------------------------------------------------
## 
##-------------------------------------------------------------
.cut_taxa = function(x, n = 2) 
{
	x = .firstup(x)

	if(n < 1) {n = 1; warning("do n >= 1", call. = FALSE)}

	sapply(x, 
	   function(x, n) {
		   x = .firstup(x)
		   if(.nword(x) > n - 1) 
			   x = strsplit(x, "\\s")[[1]][n] else x = ""
	   }, n)#end sapply
}#end cut_taxa

##-------------------------------------------------------------
## 
##-------------------------------------------------------------
.shorten = function(x, sep = "-", from = 1, n = 3, up = TRUE)
{
	if(up) x = toupper(x)

	sapply(x, 
	   function(x = x, sep, i = from, f = n) {
		   y = unlist(strsplit(x, " "))
		   z = substring(y, i, f)
		   w = paste(z, collapse = sep)
		   return(w)
	   }, sep)#end sapply
}#end shorten

