CREATE SCHEMA [bugtracker]
GO

CREATE TABLE [bugtracker].[user] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_userdata] int,
  [username] nvarchar(255),
  [password] nvarchar(255)
)
GO

CREATE TABLE [bugtracker].[userdata] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255),
  [surname] nvarchar(255),
  [email] nvarchar(255),
  [user_role] int
)
GO

CREATE TABLE [bugtracker].[project] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255),
  [description] nvarchar(255)
)
GO

CREATE TABLE [bugtracker].[ticket] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_project] int,
  [id_submitter] int,
  [id_assignee] int,
  [id_history] int,
  [title] nvarchar(255),
  [description] nvarchar(255),
  [creation] datetime,
  [update] datetime,
  [priority_level] int,
  [status] int,
  [type] int
)
GO

CREATE TABLE [bugtracker].[history] (
  [id] int,
  [occurrence] int,
  [status_current] int,
  [status_previous] int,
  [change] datetime
)
GO

CREATE TABLE [bugtracker].[comments] (
  [id] int,
  [id_commenter] int,
  [type] int,
  [content] nvarchar(255),
  [creation] datetime
)
GO

CREATE TABLE [bugtracker].[attachment] (
  [id] int,
  [id_user_submitter] int,
  [type] int,
  [attachment] blob,
  [creation] datetime
)
GO

ALTER TABLE [bugtracker].[userdata] ADD FOREIGN KEY ([id]) REFERENCES [bugtracker].[user] ([id_userdata])
GO

CREATE TABLE [user_project] (
  [user_id] int NOT NULL,
  [project_id] int NOT NULL,
  PRIMARY KEY ([user_id], [project_id])
);
GO

ALTER TABLE [user_project] ADD FOREIGN KEY ([user_id]) REFERENCES [bugtracker].[user] ([id]);
GO

ALTER TABLE [user_project] ADD FOREIGN KEY ([project_id]) REFERENCES [bugtracker].[project] ([id]);
GO


ALTER TABLE [bugtracker].[ticket] ADD FOREIGN KEY ([id]) REFERENCES [bugtracker].[project] ([id])
GO

CREATE TABLE [ticket_userdata] (
  [ticket_id] int NOT NULL,
  [userdata_id] int NOT NULL,
  PRIMARY KEY ([ticket_id], [userdata_id])
);
GO

ALTER TABLE [ticket_userdata] ADD FOREIGN KEY ([ticket_id]) REFERENCES [bugtracker].[ticket] ([id]);
GO

ALTER TABLE [ticket_userdata] ADD FOREIGN KEY ([userdata_id]) REFERENCES [bugtracker].[userdata] ([id]);
GO


ALTER TABLE [bugtracker].[user] ADD FOREIGN KEY ([username]) REFERENCES [bugtracker].[user] ([id])
GO
