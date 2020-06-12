% 
\name{esg}
\alias{esg}
\title{Ecological Status Group}
\usage{
esg(type = c("1", "2"), a = 0, b = 0, c = 0, k = NULL)
}
\arguments{
	\item{type}{predefined categories of 1 = ESG I and 2 = ESG II}
	\item{a}{value of the ESG}
	\item{b}{value of the ESG}
	\item{c}{value of the ESG}
	\item{k}{constant of the ESG. For ESG I k = c(1, 0.8, 1) 
		and ESG II k = c(0.8, 1, 1)}
}
\description{
The late-successional group with low growth rates and long life histories (Ecological Status Group I, mostly K-selection) and the opportunistic group with high growth rates and short life histories (ESG II, mostly r-selection).
}
