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

##-------------------------------------------------------------
## Generate Sequence Number - gsn
##-------------------------------------------------------------
gsn = function(rv = TRUE, from = 0, to = 100, by = .5)
{
	z=NULL

	x = y = seq(from, to, by)
	sq = expand.grid(x = x, y = y)
	SEQ = data.table(sq)


	if(isTRUE(rv) | is.data.table(rv))
	{
		if(isTRUE(rv))
		{
			  R = c(
				"x <= 30 & y > 60",
				"x <= 30 & (y > 30 & y <= 60)",
				"(x > 30 & x <= 60) & y > 60",
				"x > 60 & y > 60",
				"(x > 30 & x <= 60) & (y > 30 & y <= 60)",
				"x <= 30 & y <= 30",
				"x > 60 & (y > 30 & y <= 60)",
				"(x > 30 & x <= 60) & y <= 30",
				"x > 60 & y <= 30")
		
			  V = c(2, 4, 4, 6, 6, 6, 8, 8, 10 )

			  ESC = c("Bad", "Poor", "Poor", "Moderate", "Moderate",
					  "Moderate", "Good", "Good", "High") 

			  RV = data.table(R, V, ESC)
		}#end if

		message("Classification of intervals")
		cat(paste(V, ESC, R), sep="\n")

		for(i in 1:nrow(RV)) {
			rela = parse(text=RV[i,1])
			SEQ[eval(rela), z := RV[i,2]]
		}#end for
	}#end if

	return(SEQ[])
}#end generate_seq
