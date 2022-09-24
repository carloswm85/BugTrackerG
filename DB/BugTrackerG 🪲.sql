CREATE SCHEMA [bugtracker]
GO

CREATE TABLE [bugtracker].[enterprise_project] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_user_creator] int,
  [id_owner] int,
  [closed_project] bool,
  [locked_project] bool,
  [name] nvarchar(255),
  [description] nvarchar(255),
  [date_creation] datetime,
  [date_start] datetime,
  [date_end_target] datetime,
  [date_end_actual] datetime
)
GO

CREATE TABLE [bugtracker].[owner] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [name] nvarchar(255)
)
GO

CREATE TABLE [bugtracker].[user] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [username] nvarchar(255),
  [password] nvarchar(255)
)
GO

CREATE TABLE [bugtracker].[userdata] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_user] int,
  [enum_role] nvarchar(255) NOT NULL CHECK ([enum_role] IN ('admin', 'manager', 'developer', 'tester', 'visitor', 'submitter', 'demo')),
  [email_notification] bool,
  [dob] date,
  [name] nvarchar(255),
  [surname] nvarchar(255),
  [phone_number] nvarchar(255),
  [email] nvarchar(255),
  [address] nvarchar(255)
)
GO

CREATE TABLE [bugtracker].[ticket] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_project] int,
  [id_user_submitter] int,
  [id_user_assignee] int,
  [id_user_closer] int,
  [type] int,
  [status] int,
  [priority] int,
  [title] nvarchar(255),
  [summary] nvarchar(255),
  [date_creation] datetime,
  [date_update] datetime,
  [date_target_resolution] datetime,
  [date_close] datetime
)
GO

CREATE TABLE [bugtracker].[history] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_ticket] int,
  [occurrence] int,
  [ocurrence_current] int,
  [ocurrence_previous] int,
  [date_update] datetime
)
GO

CREATE TABLE [bugtracker].[resolution] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_history] int,
  [title] nvarchar(255),
  [summary] nvarchar(255)
)
GO

CREATE TABLE [bugtracker].[comment] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_ticket] int,
  [id_user_commenter] int,
  [type] int,
  [content] nvarchar(255),
  [date_creation] datetime
)
GO

CREATE TABLE [bugtracker].[attachment] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [id_ticket] int,
  [id_user_submitter] int,
  [type] int,
  [notes] nvarchar(255),
  [attachment] blob,
  [date_creation] datetime
)
GO

EXEC sp_addextendedproperty
@name = N'Table_Description',
@value = 'Main _table, _project collect all tickers',
@level0type = N'Schema', @level0name = 'bugtracker',
@level1type = N'Table',  @level1name = 'enterprise_project';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'company, person, whatever',
@level0type = N'Schema', @level0name = 'bugtracker',
@level1type = N'Table',  @level1name = 'owner',
@level2type = N'Column', @level2name = 'name';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'bug/error, feature request, other, training request, document request',
@level0type = N'Schema', @level0name = 'bugtracker',
@level1type = N'Table',  @level1name = 'ticket',
@level2type = N'Column', @level2name = 'type';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'new, open, assigned, test, reopened, deferred, rejected, verified, closed/resolved',
@level0type = N'Schema', @level0name = 'bugtracker',
@level1type = N'Table',  @level1name = 'ticket',
@level2type = N'Column', @level2name = 'status';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'low, medium, high, none',
@level0type = N'Schema', @level0name = 'bugtracker',
@level1type = N'Table',  @level1name = 'ticket',
@level2type = N'Column', @level2name = 'priority';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'What happened? Assigned to user, Solved, etc.',
@level0type = N'Schema', @level0name = 'bugtracker',
@level1type = N'Table',  @level1name = 'history',
@level2type = N'Column', @level2name = 'occurrence';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'new what',
@level0type = N'Schema', @level0name = 'bugtracker',
@level1type = N'Table',  @level1name = 'history',
@level2type = N'Column', @level2name = 'ocurrence_current';
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'old what',
@level0type = N'Schema', @level0name = 'bugtracker',
@level1type = N'Table',  @level1name = 'history',
@level2type = N'Column', @level2name = 'ocurrence_previous';
GO

ALTER TABLE [bugtracker].[enterprise_project] ADD FOREIGN KEY ([id_user_creator]) REFERENCES [bugtracker].[user] ([id])
GO

ALTER TABLE [bugtracker].[enterprise_project] ADD FOREIGN KEY ([id_owner]) REFERENCES [bugtracker].[owner] ([id])
GO

CREATE TABLE [enterprise_project_user] (
  [enterprise_project_id] int NOT NULL,
  [user_id] int NOT NULL,
  PRIMARY KEY ([enterprise_project_id], [user_id])
);
GO

ALTER TABLE [enterprise_project_user] ADD FOREIGN KEY ([enterprise_project_id]) REFERENCES [bugtracker].[enterprise_project] ([id]);
GO

ALTER TABLE [enterprise_project_user] ADD FOREIGN KEY ([user_id]) REFERENCES [bugtracker].[user] ([id]);
GO


ALTER TABLE [bugtracker].[userdata] ADD FOREIGN KEY ([id_user]) REFERENCES [bugtracker].[user] ([id])
GO

ALTER TABLE [bugtracker].[ticket] ADD FOREIGN KEY ([id_project]) REFERENCES [bugtracker].[enterprise_project] ([id])
GO

ALTER TABLE [bugtracker].[ticket] ADD FOREIGN KEY ([id_user_submitter]) REFERENCES [bugtracker].[user] ([id])
GO

ALTER TABLE [bugtracker].[ticket] ADD FOREIGN KEY ([id_user_assignee]) REFERENCES [bugtracker].[user] ([id])
GO

ALTER TABLE [bugtracker].[ticket] ADD FOREIGN KEY ([id_user_closer]) REFERENCES [bugtracker].[user] ([id])
GO

ALTER TABLE [bugtracker].[history] ADD FOREIGN KEY ([id_ticket]) REFERENCES [bugtracker].[ticket] ([id])
GO

ALTER TABLE [bugtracker].[resolution] ADD FOREIGN KEY ([id_history]) REFERENCES [bugtracker].[history] ([id])
GO

ALTER TABLE [bugtracker].[comment] ADD FOREIGN KEY ([id_ticket]) REFERENCES [bugtracker].[ticket] ([id])
GO

ALTER TABLE [bugtracker].[comment] ADD FOREIGN KEY ([id_user_commenter]) REFERENCES [bugtracker].[user] ([id])
GO

ALTER TABLE [bugtracker].[attachment] ADD FOREIGN KEY ([id_ticket]) REFERENCES [bugtracker].[ticket] ([id])
GO

ALTER TABLE [bugtracker].[attachment] ADD FOREIGN KEY ([id_user_submitter]) REFERENCES [bugtracker].[user] ([id])
GO
