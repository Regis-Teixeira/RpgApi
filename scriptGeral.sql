﻿IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [Personagens] (
    [Id] int NOT NULL IDENTITY,
    [Nome] nvarchar(max) NULL,
    [PontosVida] int NOT NULL,
    [Forca] int NOT NULL,
    [Defesa] int NOT NULL,
    [Inteligencia] int NOT NULL,
    [Classe] int NOT NULL,
    CONSTRAINT [PK_Personagens] PRIMARY KEY ([Id])
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Classe', N'Defesa', N'Forca', N'Inteligencia', N'Nome', N'PontosVida') AND [object_id] = OBJECT_ID(N'[Personagens]'))
    SET IDENTITY_INSERT [Personagens] ON;
INSERT INTO [Personagens] ([Id], [Classe], [Defesa], [Forca], [Inteligencia], [Nome], [PontosVida])
VALUES (1, 1, 23, 17, 33, N'Frodo', 100),
(2, 1, 25, 15, 30, N'Sam', 100),
(3, 3, 21, 18, 35, N'Galadriel', 100),
(4, 2, 18, 18, 37, N'Gandalf', 100),
(5, 1, 17, 20, 31, N'Hobbit', 100),
(6, 3, 13, 21, 34, N'Celeborn', 100),
(7, 2, 11, 25, 35, N'Radagast', 100);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Classe', N'Defesa', N'Forca', N'Inteligencia', N'Nome', N'PontosVida') AND [object_id] = OBJECT_ID(N'[Personagens]'))
    SET IDENTITY_INSERT [Personagens] OFF;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220324222245_PrimeiraMigracao', N'5.0.15');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Personagens] ADD [FotoPersonagem] varbinary(max) NULL;
GO

ALTER TABLE [Personagens] ADD [UsuarioId] int NULL;
GO

CREATE TABLE [Armas] (
    [Id] int NOT NULL IDENTITY,
    [Nome] nvarchar(max) NULL,
    [Dano] int NOT NULL,
    CONSTRAINT [PK_Armas] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Usuarios] (
    [Id] int NOT NULL IDENTITY,
    [Username] nvarchar(max) NULL,
    [PasswordHash] varbinary(max) NULL,
    [PasswordSalt] varbinary(max) NULL,
    [Foto] varbinary(max) NULL,
    [Latitude] nvarchar(max) NULL,
    [Longitude] nvarchar(max) NULL,
    [DataAcesso] datetime2 NULL,
    CONSTRAINT [PK_Usuarios] PRIMARY KEY ([Id])
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'DataAcesso', N'Foto', N'Latitude', N'Longitude', N'PasswordHash', N'PasswordSalt', N'Username') AND [object_id] = OBJECT_ID(N'[Usuarios]'))
    SET IDENTITY_INSERT [Usuarios] ON;
INSERT INTO [Usuarios] ([Id], [DataAcesso], [Foto], [Latitude], [Longitude], [PasswordHash], [PasswordSalt], [Username])
VALUES (1, NULL, NULL, NULL, NULL, 0x1309CA870760A97460D80A802F54EBA56A63FFE0B020C43865CB42F8DC0D3A9B97B12B3E4514829B3A292724EF344E19F9791C75570180E8DEDC184909FBEC46, 0xECD03ACD7E6F66521EDB17338E0272646FE5ADB46615D50BC96E2352D83013BA550D35D27B34BD5E0A9ED204A22B68B6AED723FE86C016D29870BC25A5971A1C152544EA9140F4837BA6CD971A4DCAEC9DDF8E36C5876A434C4A01E4203EF25686EAA1BEE82244ACC8482069DF41637F04D60B3C5BA0E8AD96C4BA1E96C1323A, N'UsuarioAdmin');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'DataAcesso', N'Foto', N'Latitude', N'Longitude', N'PasswordHash', N'PasswordSalt', N'Username') AND [object_id] = OBJECT_ID(N'[Usuarios]'))
    SET IDENTITY_INSERT [Usuarios] OFF;
GO

CREATE INDEX [IX_Personagens_UsuarioId] ON [Personagens] ([UsuarioId]);
GO

ALTER TABLE [Personagens] ADD CONSTRAINT [FK_Personagens_Usuarios_UsuarioId] FOREIGN KEY ([UsuarioId]) REFERENCES [Usuarios] ([Id]) ON DELETE NO ACTION;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220408002917_MigracaoUsuario', N'5.0.15');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

ALTER TABLE [Armas] ADD [PersonagemId] int NOT NULL DEFAULT 0;
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Dano', N'Nome', N'PersonagemId') AND [object_id] = OBJECT_ID(N'[Armas]'))
    SET IDENTITY_INSERT [Armas] ON;
INSERT INTO [Armas] ([Id], [Dano], [Nome], [PersonagemId])
VALUES (1, 35, N'Arco e Flecha', 1),
(2, 33, N'Espada', 2),
(3, 31, N'Machado', 3);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Dano', N'Nome', N'PersonagemId') AND [object_id] = OBJECT_ID(N'[Armas]'))
    SET IDENTITY_INSERT [Armas] OFF;
GO

UPDATE [Usuarios] SET [PasswordHash] = 0x942088928C2DD2DBCAD5B6BB94C37CCDC74976BA45155C7FCAD0F9C5B7204A0F7285013C0A868125BFE143A1EAC1762BFAD42B2C8B10C33FFCC535222161ADEB, [PasswordSalt] = 0x5B80F590EFE6FA49E37D35384F85A41AFBB615D9514AC484E0CE16F809ED00E48810FDC6CA2B89DFFB0B89024F08816973F99262A2091879BD9DF148792AC88A995EAB6490E3CBD4F082AB47EBA1DC163C883FD546A734A44F70C88F72B35FF63038A024F9FE50DCE5EFAF713ABF4C283A0B992FD37C004A7878D2C7654A2636
WHERE [Id] = 1;
SELECT @@ROWCOUNT;

GO

CREATE INDEX [IX_Armas_PersonagemId] ON [Armas] ([PersonagemId]);
GO

ALTER TABLE [Armas] ADD CONSTRAINT [FK_Armas_Personagens_PersonagemId] FOREIGN KEY ([PersonagemId]) REFERENCES [Personagens] ([Id]) ON DELETE CASCADE;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220408010833_MigracaoUmParaUm', N'5.0.15');
GO

COMMIT;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [Habilidades] (
    [Id] int NOT NULL IDENTITY,
    [Nome] nvarchar(max) NULL,
    [Dano] int NOT NULL,
    CONSTRAINT [PK_Habilidades] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [PersonagemHabilidades] (
    [PersonagemId] int NOT NULL,
    [HabilidadeId] int NOT NULL,
    CONSTRAINT [PK_PersonagemHabilidades] PRIMARY KEY ([PersonagemId], [HabilidadeId]),
    CONSTRAINT [FK_PersonagemHabilidades_Habilidades_HabilidadeId] FOREIGN KEY ([HabilidadeId]) REFERENCES [Habilidades] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_PersonagemHabilidades_Personagens_PersonagemId] FOREIGN KEY ([PersonagemId]) REFERENCES [Personagens] ([Id]) ON DELETE CASCADE
);
GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Dano', N'Nome') AND [object_id] = OBJECT_ID(N'[Habilidades]'))
    SET IDENTITY_INSERT [Habilidades] ON;
INSERT INTO [Habilidades] ([Id], [Dano], [Nome])
VALUES (1, 39, N'Adormecer'),
(2, 41, N'Congelar'),
(3, 37, N'Hipnotizar');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'Id', N'Dano', N'Nome') AND [object_id] = OBJECT_ID(N'[Habilidades]'))
    SET IDENTITY_INSERT [Habilidades] OFF;
GO

UPDATE [Usuarios] SET [PasswordHash] = 0xBA8ACA1EDAAED41727318979DBB830F4557CD3F7E80120200C85B2458E68AC88EB4A248C50EED3C3FF5FD5B30365B2424D582DEB1BF5DB8DFC6980C6F908AC02, [PasswordSalt] = 0xC9719DFE15C625C46EE15786C293B5567CA1F04477AEDFF98E94574B11035715C4FCA962A1390EDF3E56FCC0660EA36BCD8BB5B20A37EFA77B614AFD1E42866A1B40364116590542F25BFECA431C9B4D6C4A34B49228DDC4410EF22CD6F1ECC2E68E627D929A5E3C0F3AF915E28D5AEB8C2B54EE4866006CE61571618D5DFE29
WHERE [Id] = 1;
SELECT @@ROWCOUNT;

GO

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'HabilidadeId', N'PersonagemId') AND [object_id] = OBJECT_ID(N'[PersonagemHabilidades]'))
    SET IDENTITY_INSERT [PersonagemHabilidades] ON;
INSERT INTO [PersonagemHabilidades] ([HabilidadeId], [PersonagemId])
VALUES (1, 1),
(1, 5),
(2, 1),
(2, 2),
(2, 3),
(2, 6),
(3, 3),
(3, 4),
(3, 7);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'HabilidadeId', N'PersonagemId') AND [object_id] = OBJECT_ID(N'[PersonagemHabilidades]'))
    SET IDENTITY_INSERT [PersonagemHabilidades] OFF;
GO

CREATE INDEX [IX_PersonagemHabilidades_HabilidadeId] ON [PersonagemHabilidades] ([HabilidadeId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20220408013031_MigracaoMuitosParaMuitos', N'5.0.15');
GO

COMMIT;
GO

