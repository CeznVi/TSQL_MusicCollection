USE	MusicStore

GO

--************************************************************************************************
--****************************************   �������� �1 * ***************************************
--************************************************************************************************
--������������� �������� ����� ��� ����������;


CREATE VIEW [vAllArtist]
AS
SELECT [A].[Name] AS '�����a����'
FROM [Artist] AS [A]
GO
-- ���������� ���������
SELECT * FROM [vAllArtist]

--************************************************************************************************

----������������� �������� ����� ���������� ��� �� ��-
--�: ����� ���, ����� �����, ��������� ���, ��������
--����� ���, ����������;

GO
CREATE VIEW [vAllSong]
AS
SELECT [S].[Name] AS '����� ���',
		[D].[Name] AS '����� �����',
		[S].[Time] AS '��������� ���',
		[St].[Name] AS '�������� �����',
		[A].[Name] AS '����������'
FROM [Song] AS [S] JOIN [Disc] AS [D] ON [S].[IdDisc] = [D].[Id]
	INNER JOIN [Style] AS [St] ON [S].[IdStyle] = [St].[Id]
	INNER JOIN [Artist] AS [A] ON [S].[IdArtist] = [A].[Id]
GO

-- ���������� ���������
SELECT * FROM [vAllSong]
--************************************************************************************************
--������������� �������� ���������� ��� ������ ���-
--�� ����� �����. ���������, The Beatles;

GO
CREATE VIEW [vAllBeatlesDisc]
AS
SELECT [D].[Name] AS '����� �����',
		[D].[DatePublish] AS '���� �������',
		[St].[Name] AS '�����',
		[P].[Name] AS '�������� �����',
		[C].[Name] AS '����� ��������'
FROM [Disc] AS [D] JOIN [Style] AS [St] ON [D].[IdStyle] = [St].[Id]
	INNER JOIN [Artist] AS [A] ON [D].[IdArtist] = [A].[Id]
	INNER JOIN [Publisher] AS [P] ON [D].[IdPublisher] = [P].[Id]
	INNER JOIN [Country] AS [C] ON [P].[IdCountry] = [C].[Id]
WHERE [A].[Name] = 'The Beatles';
GO

-- ���������� ���������
SELECT * FROM [vAllBeatlesDisc]

--************************************************************************************************
--������������� �������� ����� ��������������� � ��-
--������ ���������. ����������� ����������� �� ����-
--��� ����� � ��������;

GO
CREATE VIEW [TopArtist]
AS
SELECT [A].[Name] AS '��� ����������'
FROM [Disc] AS [D] JOIN [Artist] AS [A] ON [D].[IdArtist] = [A].[Id]
GROUP BY [A].[Name]
HAVING COUNT([D].[NAME]) = (SELECT MAX([TEMP].[Count])
							FROM (SELECT COUNT([D].[NAME]) AS 'Count'
									FROM [Disc] AS [D] JOIN [Artist] AS [A] ON [D].[IdArtist] = [A].[Id]
									GROUP BY [A].[Name])AS [TEMP])
GO

-- ���������� ���������
SELECT * FROM [TopArtist]

--************************************************************************************************
--������������� �������� ���-3 �������������� � ��-
--������ ����������. ����������� ����������� �� ����-
--��� ����� � ��������;
GO
CREATE VIEW [Top3Artist]
AS
SELECT TOP(3)*
FROM
	(SELECT [A].[Name] AS '��� 3 ����������',
			COUNT([D].[NAME]) AS 'ʳ������ �����'
	FROM [Disc] AS [D] JOIN [Artist] AS [A] ON [D].[IdArtist] = [A].[Id]
	GROUP BY [A].[Name]) AS [TOP] 
GO

-- ���������� ���������
SELECT * FROM [Top3Artist]

--************************************************************************************************
--������������� �������� ��������� �� ��������� ��-
--������ ������.

----- !!! ����������� �� ����������� ���� ����, ��� �� SUM �� ���� ��������� �� ����� ���� time, � ���� ����� ���� �� ������� �������� �� ����.
GO
CREATE VIEW [TopLenghtAlbum]
AS
SELECT [D].[Name] AS '��������� �� ��������� ������'
FROM
	[Disc] AS [D] JOIN [Song] AS [S] ON [S].[IdDisc] = [D].[Id]
GROUP BY [D].[Name]
HAVING SUM([S].[Time]) = (SELECT MAX([TEMP].[Count])
							FROM (SELECT SUM(CONVERT(INT,[S].[Time])) AS 'Count'
									FROM [Disc] AS [D] JOIN [Song] AS [S] ON [S].[IdDisc] = [D].[Id]
									GROUP BY [D].[Name])AS [TEMP])
GO

-- ���������� ���������
SELECT * FROM [TopLenghtAlbum]

