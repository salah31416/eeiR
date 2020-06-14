% 
\name{index}
\alias{index}
\title{Indices EEIc - EQR - ESC}
\usage{
index(data, id_names = c("FG", "Taxa"), fg_name = "FG", variable_name = "variable", by = NULL, k = NULL, na.rm = FALSE)
}
\arguments{
	\item{data}{data.table or data.frame.}
	\item{id_names}{vector of id variables. Can be integer (corresponding id column numbers) or character (id column names).}
	\item{fg_name}{name colunm of functional group.}
	\item{variable_name}{name for the measured variable names column. The default name is "'variable'"}
	\item{by}{vector group by}
	\item{k}{constant for EEI}
	\item{na.rm}{remove NA}
}
\description{
calculates the EEIc, EQR and ESC indices.
}
