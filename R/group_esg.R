#######################################################
## Projeto:
##
## Data: 20-11-2019
## Hora: 13:00
##
## ## Autor: izi
##
## Encoding: UTF-8
#######################################################

##-------------------------------------------------------------
## 
##-------------------------------------------------------------
.firstup = function(x)
{
  substr(x, 1, 1) <- toupper(substr(x, 1, 1))
  x
}#end function

##-------------------------------------------------------------
## 
##-------------------------------------------------------------
.genus = function(x) gsub(" .*", "", x) #end function

##-------------------------------------------------------------
## 
##-------------------------------------------------------------
group_esg = function(file_dta,
					 rows, 
					 sheet,
					 template = NULL, 
					 xlsx = FALSE, 
					 open.xlsx = FALSE, 
					 out.dir = NULL)
{

	TEMP = data.table::fread(template)

	DTA = openxlsx::read.xlsx(file_dta, sheet = sheet, rows=rows)

	setDT(DTA)

	nn = names(DTA)[-1]
	setnames(DTA, nn, toupper(nn))

	nameDTA = names(DTA)[1]
	nameDTA = parse(text=nameDTA)
	DTA[, Algae := genus(eval(nameDTA))]

	nameTEMP = names(TEMP)[1]
	nameTEMP = parse(text=nameTEMP)
	TEMP[, Algae := genus(eval(nameTEMP))]

	OUT = TEMP[DTA, on="Algae"]
	OUT[, Algae:=NULL][]

	nmc = OUT[, length(which(unlist(lapply(.SD, is.character))))]

	for(i in 1:nmc) 
	{
		nesg = names(OUT)[i]
		nesg1 = parse(text=nesg)
		OUT[is.na(eval(nesg1)), eval(nesg):="ND"]
		OUT[eval(nesg1)=="", eval(nesg):="ND"][]
	}#end for

	OUTm = data.table::melt(OUT, id=1:nmc)

	## planilha xlsx
	if(xlsx)
	{
		wb = openxlsx::createWorkbook()
		## estilo cabeçalho
		headSty = openxlsx::createStyle(fgFill = "#DCE6F1", 
							  halign = "center", 
							  textDecoration = "Bold")
		styNum2 = openxlsx::createStyle(numFmt = "0.00")
		## ESG
		plan_dados = "ESG"
		openxlsx::addWorksheet(wb, plan_dados, tabColour = "green")
		## número de linhas e colunas
		nr = nrow(OUT) + 2
		nc = ncol(OUT)
		#addStyle(wb, sheet = plan_dados, styNum2,
		#     cols = c(nmc+1):nc, rows = 1:nr, gridExpand = TRUE)
		openxlsx::setColWidths(wb, sheet = plan_dados, cols = 1:nc, widths = "auto")
		openxlsx::writeData(wb, sheet = plan_dados, startRow = 1,
				  headerStyle = headSty, x = OUT)
		## SOMA
		for(i in 1:c(nmc-1))
		{
		    nesg = names(OUTm)[i]
			SM = OUTm[, .(.N, Soma = sum(value, na.rm=T)), by=c(nesg, "variable")]
			SOMA = dcast(SM, paste(nesg, "+N~variable"), value.var="Soma")
			openxlsx::writeData(wb, sheet = plan_dados, startRow = nr+2,
				  headerStyle = headSty, x = SOMA)
			nr = nr+nrow(SOMA)+2
		}#end for
		
		## nome do arquivo
		at = format(Sys.Date(), "%d%b%Y")
		if(is.null(out.dir))
		{
			narq = tools::file_path_sans_ext(file_dta)
			nome_arq = paste0(paste(narq, at, "ESG", sep="_"), ".xlsx")
		} else {
			narq = tools::file_path_sans_ext(basename(file_dta))
			nome_arq = file.path(out.dir, paste0(narq, "_", at, "_ESG", ".xlsx"))
		}#end if
		openxlsx::saveWorkbook(wb, nome_arq, overwrite = TRUE)
		if(open.xlsx)browseURL(nome_arq)
	}#end if
	
	return(list(OUT, OUTm))

}#end function

