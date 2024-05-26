# Hampr SQL Challange

## Story

We have an e-commerce platform and we want to show the user the contents of their cart. Currently we store the cart data in our database; everytime an action is taken, the cart is updated and then re-fetched and rendered. We would like the process of fetching the cart to be smooth and fast; in order to do so we want a PostgreSQL query to do the heavy lifting and try to only retrieve necessary data.

## Important Notes

- Standard Postgres features including json are allowed
- User environments are represented as Workspaces. Each Workspace only has one active Cart. The request will ask for some particular Workspace's Cart.
- Items within the system have their own prices, however some items may have their prices overridden per-workspace. This is currently implemented using the PriceOverrides table. PricePverrides represent rules that should be applied to change the price of the Items by either replacing the price with a fixed value (e.g. from $20 to $18) or adjusting the original price by some percentage amount (e.g. 120% of the original).

## The Data Required

The desired resulting cart view should contain the following data per row:

```
Item Name (Items.name) | Price (Items.price) | Quantity (CartItems.quantity) | Total Price (CartItems.quantity * Items.price) | Diet Tag Names (DietTags.name)

```

## How to run

# To initialize db and run on docker (node):

```
make build
make run
make logs
```

# To build and run on local for development (nodemon):
Copy .env.example to .env

```
npm run build:watch
npm run dev
```

# To build and run once for local (node):
Copy .env.example to .env

```
npm run build
npm run prod
```

# To clear db data:

```
make clean
```
