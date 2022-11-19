USE	MusicStore

GO

--************************************************************************************************
--****************************************   ЗАВДАННЯ №1 * ***************************************
--************************************************************************************************
--Представлення відображає назви всіх виконавців;


CREATE VIEW [vAllArtist]
AS
SELECT [A].[Name] AS 'Виконaвець'
FROM [Artist] AS [A]
GO
-- ПОДИВИТИСЯ РЕЗУЛЬТАТ
SELECT * FROM [vAllArtist]

--************************************************************************************************

----Представлення відображає повну інформацію про всі піс-
--ні: назва пісні, назва диска, тривалість пісні, музичний
--стиль пісні, виконавець;

GO
CREATE VIEW [vAllSong]
AS
SELECT [S].[Name] AS 'Назва пісні',
		[D].[Name] AS 'Назва диска',
		[S].[Time] AS 'Тривалість пісні',
		[St].[Name] AS 'Музичний стиль',
		[A].[Name] AS 'Виконавець'
FROM [Song] AS [S] JOIN [Disc] AS [D] ON [S].[IdDisc] = [D].[Id]
	INNER JOIN [Style] AS [St] ON [S].[IdStyle] = [St].[Id]
	INNER JOIN [Artist] AS [A] ON [S].[IdArtist] = [A].[Id]
GO

-- ПОДИВИТИСЯ РЕЗУЛЬТАТ
SELECT * FROM [vAllSong]
--************************************************************************************************
--представлення відображає інформацію про музичні дис-
--ки певної групи. Наприклад, The Beatles;

GO
CREATE VIEW [vAllBeatlesDisc]
AS
SELECT [D].[Name] AS 'Назва диску',
		[D].[DatePublish] AS 'Дата випуску',
		[St].[Name] AS 'Стиль',
		[P].[Name] AS 'Видавець диску',
		[C].[Name] AS 'Країна видавець'
FROM [Disc] AS [D] JOIN [Style] AS [St] ON [D].[IdStyle] = [St].[Id]
	INNER JOIN [Artist] AS [A] ON [D].[IdArtist] = [A].[Id]
	INNER JOIN [Publisher] AS [P] ON [D].[IdPublisher] = [P].[Id]
	INNER JOIN [Country] AS [C] ON [P].[IdCountry] = [C].[Id]
WHERE [A].[Name] = 'The Beatles';
GO

-- ПОДИВИТИСЯ РЕЗУЛЬТАТ
SELECT * FROM [vAllBeatlesDisc]

--************************************************************************************************
--Представлення відображає назву найпопулярнішого в ко-
--лекції виконавця. Популярність визначається за кількі-
--стю дисків у колекції;

GO
CREATE VIEW [TopArtist]
AS
SELECT [A].[Name] AS 'Топ виконавець'
FROM [Disc] AS [D] JOIN [Artist] AS [A] ON [D].[IdArtist] = [A].[Id]
GROUP BY [A].[Name]
HAVING COUNT([D].[NAME]) = (SELECT MAX([TEMP].[Count])
							FROM (SELECT COUNT([D].[NAME]) AS 'Count'
									FROM [Disc] AS [D] JOIN [Artist] AS [A] ON [D].[IdArtist] = [A].[Id]
									GROUP BY [A].[Name])AS [TEMP])
GO

-- ПОДИВИТИСЯ РЕЗУЛЬТАТ
SELECT * FROM [TopArtist]

--************************************************************************************************
--Представлення відображає топ-3 найпопулярніших у ко-
--лекції виконавців. Популярність визначається за кількі-
--стю дисків у колекції;
GO
CREATE VIEW [Top3Artist]
AS
SELECT TOP(3)*
FROM
	(SELECT [A].[Name] AS 'Топ 3 виконавців',
			COUNT([D].[NAME]) AS 'Кількість дисків'
	FROM [Disc] AS [D] JOIN [Artist] AS [A] ON [D].[IdArtist] = [A].[Id]
	GROUP BY [A].[Name]) AS [TOP] 
GO

-- ПОДИВИТИСЯ РЕЗУЛЬТАТ
SELECT * FROM [Top3Artist]

--************************************************************************************************
--Представлення відображає найдовший за тривалістю му-
--зичний альбом.

----- !!! нерозібрався як просумувати поле тайм, так як SUM не може працювати із полем типу time, і поле цього типу не можливо привести до інта.
GO
CREATE VIEW [TopLenghtAlbum]
AS
SELECT [D].[Name] AS 'Найдовший за тривалістю альбом'
FROM
	[Disc] AS [D] JOIN [Song] AS [S] ON [S].[IdDisc] = [D].[Id]
GROUP BY [D].[Name]
HAVING SUM([S].[Time]) = (SELECT MAX([TEMP].[Count])
							FROM (SELECT SUM(CONVERT(INT,[S].[Time])) AS 'Count'
									FROM [Disc] AS [D] JOIN [Song] AS [S] ON [S].[IdDisc] = [D].[Id]
									GROUP BY [D].[Name])AS [TEMP])
GO

-- ПОДИВИТИСЯ РЕЗУЛЬТАТ
SELECT * FROM [TopLenghtAlbum]

