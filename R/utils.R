
##-------------------------------------------
## Author  : Izi
## Project : 
## Created : dom 24 mai 2020 18:50:08 -03
## License : MIT
## Updated :
##-------------------------------------------

##===========================================
## 
##===========================================
.ver_add_ref = function(DT)
{
	setDT(DT)
	on = names(DT)
	msg_erro = "The table should contain 2 columns: [1] = Taxa and [2] = Functional Group"
	if(ncol(DT)>2) stop(msg_erro, call. = FALSE)
	DT[, eval(on[1]) := .cut_taxa(eval(parse(text=on[1])), 1) ]
	DT[, eval(on[2]) := toupper(.cut_taxa(eval(parse(text=on[2])), 1)) ]

	rgx = "\\<IA\\>|\\<IB\\>|\\<IC\\>|\\<IIA\\>|\\<IIB\\>|\\<IIC\\|"
	r = grep(rgx, DT[, as.character(eval(parse(text=on[2])))])
	if(!length(r)) stop(msg_erro, call. = FALSE)

	return(DT)
}#end ver_add_ref

##===========================================
## 
##===========================================
.firstup = function(x) 
{
	x = tolower(x)
	x = gsub("(?<=[\\s])\\s*|^\\s+|\\s+$", "", x, perl=TRUE)
	substr(x, 1, 1) <- toupper(substr(x, 1, 1))

	return(x)
}#end firstup

##===========================================
## 
##===========================================
.nword = function(x) lengths(strsplit(x, "\\W+"))#end nword

##===========================================
## 
##===========================================
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

##===========================================
## 
##===========================================
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

##===========================================
## Generate Sequence Number - gsn
##===========================================
gsn = function(rel = NULL, num = NULL, status = NULL, from = 0, to = 100, by = .1) 
{
	z=NULL

	x = y = seq(from, to, by)
	sq = expand.grid(x = x, y = y)
	SEQ = data.table(sq)


	if(is.null(rel)){
		rel = c("x <= 30 & y > 60",
			  "x <= 30 & (y > 30 & y <= 60)",
			  "(x > 30 & x <= 60) & y > 60",
			  "x > 60 & y > 60",
			  "(x > 30 & x <= 60) & (y > 30 & y <= 60)",
			  "x <= 30 & y <= 30",
			  "x > 60 & (y > 30 & y <= 60)",
			  "(x > 30 & x <= 60) & y <= 30",
			  "x > 60 & y <= 30")
	}#end if

	if(is.null(num)) num = c(2, 4, 4, 6, 6, 6, 8, 8, 10 )

	if(is.null(status)) 
		status = c("Bad", "Poor", "Poor", "Moderate", "Moderate", "Moderate", "Good", "Good", "High")

	RV = data.table(rel, num, status)

	message("Classification of intervals")
	message(paste(num, status, rel), sep="\n")

	for(i in 1:nrow(RV)) {
		rela = parse(text=RV[i,1])
		SEQ[eval(rela), z := RV[i,2]]
	}#end for

	return(SEQ[])
}#end gsn


