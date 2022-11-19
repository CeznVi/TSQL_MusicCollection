USE	MusicStore

GO

--************************************************************************************************
--****************************************   �������� �2 * ***************************************
--************************************************************************************************

--************************************************************************************************
--������� �������������, �� �����������, ��� ���������
--��������� ��� ����;

CREATE VIEW [vStyle]
AS
SELECT [S].[Name] AS '����'
FROM [Style] AS [S]
GO

-- ���������� ���������
SELECT * FROM [vStyle]

--���������
INSERT INTO[vStyle] VALUES('ճ�-���')
INSERT INTO[vStyle] VALUES('����')
INSERT INTO[vStyle] VALUES('����')

-- ���������� ���������
SELECT * FROM [vStyle]
--************************************************************************************************

--************************************************************************************************
--������� �������������,�� �����������, ��� ���������
--��������� ��� ���;
GO
CREATE VIEW [vSong]
AS
SELECT	[S].[Name] AS '����� ���',
		[S].[IdDisc] AS 'Id �����',
		[S].[Time] AS '��������� ���',
		[S].[IdArtist] AS 'Id �������',
		[S].[IdStyle] AS '�������� �����'
FROM [Song] AS [S]
GO

-- ���������� ���������
SELECT * FROM [vSong]
-- ���������� ��������� � ������� ������������
SELECT [V].[����� ���] AS '����� ���',
		[D].[Name] AS '����',
		[V].[��������� ���] AS '��������� ���',
		[A].[Name] AS '������',
		[S].[Name] AS '�������� �����'
FROM [vSong] AS [V] JOIN [Disc] AS [D] ON [V].[Id �����] = [D].[Id]
	INNER JOIN [Artist] AS [A] ON [A].[Id] = [V].[Id �������]
	INNER JOIN [Style] AS [S] ON [S].[Id] = [V].[Id �����]

--���������
INSERT INTO[vSong] VALUES('���������� ���� 1', 1, '00:03:21', 6, 1)
INSERT INTO[vSong] VALUES('���������� ���� 2', 1, '00:02:21', 4, 1)
--************************************************************************************************
--������� �������������, �� �����������, ��� ���������
--���������� ���������� ��� �������;

GO
CREATE VIEW [vPublisher]
AS
SELECT	[P].[Name] AS '����a',
		[P].[IdCountry] AS 'Id ������'
FROM [Publisher] AS [P]
GO

-- ���������� ���������
SELECT * FROM [vPublisher]
-- ���������� ��������� � ������� ������������
SELECT	[V].[����a] AS '����a',
		[C].[Name] AS '������'
FROM [vPublisher] AS [V] JOIN [Country] AS [C] ON [V].[Id ������] = [C].[Id]

--���������
INSERT INTO[vPublisher] VALUES('����������� �������� 1', 1)
INSERT INTO[vPublisher] VALUES('����������� �������� 2', 2)
INSERT INTO[vPublisher] VALUES('����������� �������� 3', 3)
INSERT INTO[vPublisher] VALUES('����������� �������� 4', 4)
--���������
UPDATE [vPublisher]
SET [����a] = '������ ��������',
	[Id ������] = 1
WHERE [����a] = '����������� �������� 1'

UPDATE [vPublisher]
SET [����a] = 'MetroMusic',
	[Id ������] = 2
WHERE [����a] = '����������� �������� 2'

--************************************************************************************************

--������� �������������,�� �����������, ��� ���������
--�������� ����������;
GO
CREATE VIEW [vArtist]
AS
SELECT	[A].[Name] AS '������'
FROM [Artist] AS [A]
GO

-- ���������� ���������
SELECT * FROM [vArtist]

--���������
INSERT INTO[vArtist] VALUES('���������� 1')
INSERT INTO[vArtist] VALUES('���������� 2')
INSERT INTO[vArtist] VALUES('���������� 3')
INSERT INTO[vArtist] VALUES('���������� 4')

--���������
UPDATE [vArtist]
SET [������] = '����� ǳ����'
WHERE [������] = '���������� 1'
UPDATE [vArtist]
SET [������] = '�����'
WHERE [������] = '���������� 2'
UPDATE [vArtist]
SET [������] = '������� �����'
WHERE [������] = '���������� 3'

--���������
DELETE
FROM [vArtist]
WHERE [������] = '������� �����'
DELETE
FROM [vArtist]
WHERE [������] = '����� ǳ����'

--************************************************************************************************
--������� �������������, �� �����������, ��� ���������
--���������� ���������� ��� ����������� ���������. 
--���������, Muse.

GO
CREATE VIEW [vArtistMuse]
AS
SELECT	[A].[Name] AS '������'
FROM [Artist] AS [A]
WHERE [A].[Name] = 'Muse'
WITH CHECK OPTION
GO

--��������� (��� �� ������ ��������� �� ���� � ���)
INSERT INTO[vArtistMuse] VALUES('Muse')

-- ���������� ���������
SELECT * FROM [vArtistMuse]

--������ �� �������� (��� �� �������� ����� �� �����)
UPDATE [vArtistMuse]
SET [������] = '������� �����'
WHERE [������] = 'Muse'
