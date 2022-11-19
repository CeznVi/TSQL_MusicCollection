USE master
go

CREATE DATABASE [MusicStore]
go

USE [MusicStore]
go

CREATE TABLE [Style]
(
	[Id] int not null identity(1,1) primary key,
	[Name] nvarchar(50) not null unique check([Name] <> N'')
)
go

CREATE TABLE [Artist]
(
	[Id] int not null identity(1,1) primary key,
	[Name] nvarchar(100) not null unique check([Name] <> N'')
)
go

CREATE TABLE [Country] 
(
	[Id] int not null identity(1,1) primary key,
	[Name] nvarchar(50) not null unique check([Name] <> N'')
)
go

CREATE TABLE [Publisher] 
(
	[Id] int not null identity(1,1) primary key,
	[Name] nvarchar(100) not null unique check([Name] <> N''),
	[IdCountry] int not null
)
go

CREATE TABLE [Disc] 
(
	[Id] int not null identity(1,1) primary key,
	[Name] nvarchar(50) not null unique check([Name] <> N''),
	[IdArtist] int not null,
	[DatePublish] date not null check([DatePublish] <= GETDATE()),
	[IdPublisher] int not null,
	[IdStyle] int not null
)
go

CREATE TABLE [Song] 
(
	[Id] int not null identity(1,1) primary key,
	[Name] nvarchar(100) not null unique check([Name] <> N''),
	[IdDisc] int not null,
	[Time] time not null,
	[IdArtist] int not null,
	[IdStyle] int not null
)
go