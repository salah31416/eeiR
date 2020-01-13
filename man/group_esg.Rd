% 
\name{group_esg}
\alias{group_esg}
\title{ESG - Ecological Status Group}
\usage{
group_esg(data, NameTaxaDATA = "Taxa", NameTaxaREF = "Taxa", 
		  NameGroupESG = "Group", ref = c("gbra", "sgre", "ggre"), genus = TRUE)
}
\description{
Using morphological (external morphology, internal anatomy and texture), physiological (surface area/volume ratio, photosynthetic/non-photosynthetic ratio, photosynthetic performance, growth and light adaptation) and life history (longevity and succession) traits along with distributional data across eutrophication gradients, different benthic macrophyte ESG's relevant to nutrient and light responses in transitional waters were determined (Orfanidis et al., 2014)

ESG I (slow-growing, late-successional species) and ESG II (fast-growing, opportunistic species) are both divided hierarchically into three sub-groups, as follows: ESG IA, ESG IB, ESG IC, ESG IIA, ESG IIB and ESG IIC.
}
\arguments{
	\item{data}{data.table or data.frame}
	\item{NameTaxaDATA}{name of the column containing the names of the taxa}
	\item{NameTaxaREF}{name of the column containing the names of the taxa}
	\item{NameGroupESG}{name of the column containing the ecological group classifications}
	\item{ref}{data.tabel or data.frame with reference data for esg}
	\item{genus}{select genus or species for esg analysis}
}

