% 
\name{group_esg}
\alias{group_esg}
\title{ESG - Ecological Status Group}
\usage{
group_esg(data, col_data = "Taxa", ref = NULL, add = NULL)
}
\arguments{
	\item{data}{data.table or data.frame}
	\item{col_data}{name of the column containing the names of the taxa}
	\item{ref}{data.tabel or data.frame with reference data for esg}
	\item{add}{append functional group default}
}
\description{
Using morphological (external morphology, internal anatomy and texture), physiological (surface area/volume ratio, photosynthetic/non-photosynthetic ratio, photosynthetic performance, growth and light adaptation) and life history (longevity and succession) traits along with distributional data across eutrophication gradients, different benthic macrophyte ESG's relevant to nutrient and light responses in transitional waters were determined (Orfanidis et al., 2014)

ESG I (slow-growing, late-successional species) and ESG II (fast-growing, opportunistic species) are both divided hierarchically into three sub-groups, as follows: ESG IA, ESG IB, ESG IC, ESG IIA, ESG IIB and ESG IIC.
}
