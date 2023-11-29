SELECT RemaxListings.Id, RemaxListings.Beds, RemaxListings.Baths, RemaxListings.CityName, RemaxListings.Area,
RemaxListingsWalkscore.WalkScore, RemaxListingsWalkscore.TransitScore
RemaxListings.ListingType, AVG(RemaxListingsAssociations.Price) AS Price,
CASE
    WHEN AVG(RemaxListingsAssociations.Price) > Overall_Avg.AvgPrice THEN 'Above Average'
    WHEN AVG(RemaxListingsAssociations.Price) < Overall_Avg.AvgPrice THEN 'Below Average'
    ELSE 'Equal to Average'
END AS value_comparison
FROM RemaxListingsAssociations 
INNER JOIN RemaxListings ON 
RemaxListingsAssociations.Id = RemaxListings.Id
INNER JOIN RemaxListingsWalkscore ON 
RemaxListings.Id = RemaxListingsWalkscore.Id
INNER JOIN (SELECT AVG(RemaxListingsAssociations.Price) AS AvgPrice FROM RemaxListingsAssociations) AS Overall_Avg
ON 1=1
WHERE RemaxListings.ListingType IN 
('Single Family', 'Multi-Family', 'Condo', 'Townhome', 'Condo/Townhome')
AND RemaxListings.Area IS NOT NULL 
AND RemaxListings.Area > 100
AND Price > 
AND RemaxListingsWalkscore.WalkScore IS NOT NULL
GROUP BY RemaxListings.Id, RemaxListings.Beds, RemaxListings.Baths, RemaxListings.CityName, RemaxListings.Area,
RemaxListings.ListingType, Overall_Avg.AvgPrice