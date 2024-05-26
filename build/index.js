"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
//
const pg_1 = require("pg");
const dotenv_1 = __importDefault(require("dotenv"));
const json_colorizer_1 = require("json-colorizer");
function main() {
    return __awaiter(this, void 0, void 0, function* () {
        // If not run on docker load env variables from .env file
        if (!process.env.DOCKER_ENV) {
            dotenv_1.default.config();
        }
        // Initialize pg connection
        const client = new pg_1.Client();
        yield client.connect();
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
        const result = yield client.query(query);
        console.log((0, json_colorizer_1.colorize)(result.rows, { indent: 2 }));
        // Close pg connection
        yield client.end();
    });
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
