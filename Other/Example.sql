CREATE SCHEMA [ecommerce]
GO

CREATE TABLE [ecommerce].[merchants] (
  [id] int,
  [country_code] int,
  [merchant_name] nvarchar(255),
  [created at] nvarchar(255),
  [admin_id] int,
  PRIMARY KEY ([id], [country_code])
)
GO

CREATE TABLE [ecommerce].[order_items] (
  [order_id] int,
  [product_id] int,
  [quantity] int DEFAULT (1)
)
GO

CREATE TABLE [ecommerce].[orders] (
  [id] int PRIMARY KEY,
  [user_id] int UNIQUE NOT NULL,
  [status] nvarchar(255),
  [created_at] nvarchar(255)
)
GO

CREATE TABLE [ecommerce].[products] (
  [id] int PRIMARY KEY,
  [name] nvarchar(255),
  [merchant_id] int NOT NULL,
  [price] int,
  [status] nvarchar(255) NOT NULL CHECK ([status] IN ('out_of_stock', 'in_stock', 'running_low')),
  [created_at] datetime DEFAULT (now())
)
GO

CREATE TABLE [ecommerce].[product_tags] (
  [id] int PRIMARY KEY,
  [name] nvarchar(255)
)
GO

CREATE TABLE [ecommerce].[merchant_periods] (
  [id] int PRIMARY KEY,
  [merchant_id] int,
  [country_code] int,
  [start_date] datetime,
  [end_date] datetime
)
GO

CREATE TABLE [users] (
  [id] int PRIMARY KEY IDENTITY(1, 1),
  [full_name] nvarchar(255),
  [created_at] timestamp,
  [country_code] int
)
GO

CREATE TABLE [countries] (
  [code] int PRIMARY KEY,
  [name] nvarchar(255),
  [continent_name] nvarchar(255)
)
GO

CREATE INDEX [product_status] ON [ecommerce].[products] ("merchant_id", "status")
GO

CREATE UNIQUE INDEX [ecommerce].[products_index_1] ON [ecommerce].[products] ("id")
GO

EXEC sp_addextendedproperty
@name = N'Column_Description',
@value = 'When order created',
@level0type = N'Schema', @level0name = 'ecommerce',
@level1type = N'Table',  @level1name = 'orders',
@level2type = N'Column', @level2name = 'created_at';
GO

ALTER TABLE [ecommerce].[merchants] ADD FOREIGN KEY ([admin_id]) REFERENCES [users] ([id])
GO

ALTER TABLE [ecommerce].[merchants] ADD FOREIGN KEY ([country_code]) REFERENCES [countries] ([code])
GO

ALTER TABLE [ecommerce].[order_items] ADD FOREIGN KEY ([order_id]) REFERENCES [ecommerce].[orders] ([id])
GO

ALTER TABLE [ecommerce].[order_items] ADD FOREIGN KEY ([product_id]) REFERENCES [ecommerce].[products] ([id])
GO

ALTER TABLE [ecommerce].[products] ADD FOREIGN KEY ([merchant_id]) REFERENCES [ecommerce].[merchants] ([id])
GO

CREATE TABLE [product_tags_products] (
  [product_tags_id] int NOT NULL,
  [products_id] int NOT NULL,
  PRIMARY KEY ([product_tags_id], [products_id])
);
GO

ALTER TABLE [product_tags_products] ADD FOREIGN KEY ([product_tags_id]) REFERENCES [ecommerce].[product_tags] ([id]);
GO

ALTER TABLE [product_tags_products] ADD FOREIGN KEY ([products_id]) REFERENCES [ecommerce].[products] ([id]);
GO


ALTER TABLE [ecommerce].[merchant_periods] ADD FOREIGN KEY ([merchant_id], [country_code]) REFERENCES [ecommerce].[merchants] ([id], [country_code])
GO

ALTER TABLE [users] ADD FOREIGN KEY ([country_code]) REFERENCES [countries] ([code])
GO
