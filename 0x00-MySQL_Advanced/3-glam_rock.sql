-- 3. Old school band
SELECT
	band_name,
	(COALESCE(split, '2020') - formed) as lifespan
FROM metal_bands
WHERE LOCATE('Glam rock', style) > 0
ORDER BY lifespan DESC;
