//
import { Client } from "pg";
import dotenv from "dotenv";
import { colorize } from "json-colorizer";

async function main() {
  // If not run on docker load env variables from .env file
  if (!process.env.DOCKER_ENV) {
    dotenv.config();
  }

  // Initialize pg connection
  const client = new Client();
  await client.connect();

  // Generate a random workspaceId between 1 and 20
  const workspaceId = Math.floor(Math.random() * 20) + 1;

  // Given a particular workspaceId, this query should return a cart corresponding to the provided workspaceId in the following format:
  // Item Name (Items.name) | Price (Items.price) | Quantity (CartItems.quantity) | Total Price (CartItems.quantity * Items.price) | Diet Tag Names (DietTags.name)

  const query = {
    text: `Select
    i."name" as ItemName,
    
    case when po."workspaceId" > 0 and 
          po."itemId" > 0
      then case when po."price" > 0 then po."price"
            when po."percentage" > 0 then ( po."percentage" * i."price" ) + i."price"
      end
    else i."price"
  
    end as Price,
    ci."quantity",
    case when po."workspaceId" > 0 and 
          po."itemId" > 0
      then case when po."price" > 0 then po."price" * ci."quantity"
            when po."percentage" > 0 then (( po."percentage" * i."price" ) + i."price" ) * ci."quantity" 
           else i."price" * ci."quantity"
      end
    end as totalPrice,
    dt."name"
    
  from 
    public."Carts" c join public."CartItems" as ci on ci."id" = c."id" 
            join public."Items" as i on ci."itemId" = i."id"
            join public."ItemDietTags" as idt on idt."itemId" = i."id"
            join public."DietTags" as dt on idt."dietTagId" = dt."id"
            left join public."PriceOverrides" as po on po."workspaceId" = c."workspaceId"
                                  
  where
    c."workspaceId" = $1 `,
    values: [workspaceId],
  };

  // Your code here
  const result = await client.query(query);

  console.log(colorize(result.rows, { indent: 2 }));

  // Close pg connection
  await client.end();
}

main();
/**Select
      i.name as ItemName,
      
      case when po.workspaceId > 0 and 
            po.itemId > 0
        then 
          case when po.price > 0 then po.price
              when po.percentage > 0 then ( po.percentage * i.price ) + i.price
        end
        else i.price
      end as Price,
      ci.quantity,
      case when po.workspaceId > 0 and 
            po.itemId > 0
        then case when po.price > 0 then po.price * ci.quantity
              when po.percentage > 0 then (( po.percentage * i.price ) + i.price ) * ci.quantity
            else i.price * ci.quantity
        end
      end as totalPrice,
      dt.name
      
    from 
      Carts" c join CartItems as ci on ci.id = c.id
              join Items as i on ci.itemId" = i.id
              join ItemDietTags as idt on idt.itemId = i.id
              join DietTags as dt on idt.dietTagId = dt.id
              left join public.PriceOverrides as po on po.workspaceId = c.workspaceId
                                     */
