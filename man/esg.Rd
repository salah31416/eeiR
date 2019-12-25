% 
\name{esg}
\alias{esg}
\title{Ecological Status Group}
\usage{
esg(ia = 0, ib = 0, ic = 0, k = NULL, type = c("esg1", "esg2"))
}
\arguments{
	\item{ia}{coefficients of the ESG}
	\item{ib}{coefficients of the ESG}
	\item{ic}{coefficients of the ESG}
	\item{k}{constant of the ESG. For "esg1" k = c(1, 0.8, 1) 
		and "esg2" k = c(0.8, 1, 1)}
	\item{type}{predefined categories of ESG I and ESG II}
}
\description{
The late-successional group with low growth rates and long life histories (Ecological Status Group I, mostly K-selection) and the opportunistic group with high growth rates and short life histories (ESG II, mostly r-selection).
}
