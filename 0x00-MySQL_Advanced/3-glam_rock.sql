-- 3. Old school band
SELECT
	band_name,
	(COALESCE(split, 2020) - COALESCE(formed, 0)) as lifespan
FROM metal_bands
WHERE style LIKE '%Glam rock%'
ORDER BY lifespan DESC;
