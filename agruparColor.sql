SELECT COUNT (dbo.Automovil.FolioAuto), Marca, Modelo
FROM dbo.Automovil
WHERE (dbo.Automovil.Color='Blanco') GROUP BY Marca, Modelo ORDER BY COUNT (dbo.Automovil.FolioAuto) DESC