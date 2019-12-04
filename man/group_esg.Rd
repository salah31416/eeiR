% 
\name{group_esg}
\alias{group_esg}
\title{Ecological Status Group}
\usage{
group_esg(dta, macroalgae, esg_ref = readRDS(system.file('esg_reference/ESG_BRA.rds', package = 'eeiR')))
}
\arguments{
	\item{dta}{data}
	\item{macroalgae}{name col}
	\item{esg_ref}{data.frame or data.table}
}
\description{
The late-successional group with low growth rates and long life histories (Ecological Status Group I, mostly K-selection) and the opportunistic group with high growth rates and short life histories (ESG II, mostly r-selection).
}
