% 
\name{group_esg}
\alias{group_esg}
\title{Ecological Status Group}
\usage{
group_esg(dta, ColNameDTA = "Taxa", ColNameREF = "Taxa", ColNameESG = "Group", ref = c("gbra", "sgre", "ggre"), genus = TRUE)
}
\arguments{
	\item{dta}{data}
	\item{ColNameDTA}{col name data}
	\item{ColNameREF}{col name species reference}
	\item{ColNameESG}{col name esg reference}
	\item{ref}{data.frame or data.table}
	\item{genus}{select genus or species}
}
\description{
The late-successional group with low growth rates and long life histories (Ecological Status Group I, mostly K-selection) and the opportunistic group with high growth rates and short life histories (ESG II, mostly r-selection).
}
